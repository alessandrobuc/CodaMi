import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../location/data/datasources/places_service.dart';
import '../../../location/data/models/city_place.dart';
import '../../../location/presentation/providers/location_provider.dart';
import '../../../location/presentation/widgets/city_search_widgets.dart';
import '../../../pets/domain/entities/pets_entity.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../pets/presentation/screens/pet_form_screen.dart';
import '../../../pets/presentation/widgets/pet_form_widgets.dart';
import '../../../pets/presentation/widgets/pets_widget.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../data/models/reports_model.dart';
import '../../domain/entities/reports_entity.dart';
import '../../domain/repositories/reports_repository.dart';
import '../providers/reports_provider.dart';
import '../widgets/reports_widget.dart';
import 'report_detail_screen.dart';

enum _Step { type, pet, where, when, details, review }

class CreateReportScreen extends ConsumerStatefulWidget {
  final Pet? pet;

  const CreateReportScreen({super.key, this.pet});

  @override
  ConsumerState<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends ConsumerState<CreateReportScreen> {
  late final int _firstStep = widget.pet == null ? 0 : _Step.where.index;
  late final _pageController = PageController(initialPage: _firstStep);
  late int _step = _firstStep;
  final _showErrors = <_Step>{};

  late ReportType? _type = widget.pet == null ? null : ReportType.lost;
  late Pet? _pet = widget.pet;
  String? _pendingPetName;

  PetSpecies? _foundSpecies;
  List<PetPhoto> _foundPhotos = const [];
  final _foundName = TextEditingController();

  ReportPlace? _place;
  final _placeDetail = TextEditingController();
  StreetPlace? _street;

  DateTime _eventAt = DateTime.now();
  String _timeChoice = 'now';

  final _description = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  bool _whatsapp = true;
  bool _prefilled = false;

  bool _publishing = false;
  double? _progress;
  Report? _published;

  @override
  void dispose() {
    _pageController.dispose();
    for (final c in [_foundName, _placeDetail, _description, _phone, _email]) {
      c.dispose();
    }
    super.dispose();
  }

  void _prefillFromProfile() {
    if (_prefilled) return;
    if (_email.text.isEmpty) {
      _email.text = ref.read(currentUserInfoProvider).email;
    }
    final profile = ref.watch(userProfileProvider).value;
    if (profile == null) return;
    _prefilled = true;
    if (_phone.text.isEmpty) _phone.text = profile.phone ?? '';
    if (_place == null &&
        profile.hasCity &&
        profile.homeLat != null &&
        profile.homeLng != null) {
      _place = ReportPlace(
        city: profile.city ?? '',
        cityKey: profile.cityKey!,
        country: profile.country ?? '',
        lat: profile.homeLat!,
        lng: profile.homeLng!,
        label: profile.city ?? '',
      );
    }
  }

  String get _petName => switch (_type) {
    ReportType.lost => _pet?.name ?? 'your pet',
    _ =>
      _foundName.text.trim().isEmpty
          ? 'Unknown ${(_foundSpecies ?? PetSpecies.other).label.toLowerCase()}'
          : _foundName.text.trim(),
  };

  String get _publicPlaceDetail =>
      ReportModel.withoutHouseNumber(_placeDetail.text);

  bool get _isDirty =>
      (_type != null && widget.pet == null) ||
      _foundPhotos.isNotEmpty ||
      _description.text.trim().isNotEmpty;

  String? _errorFor(_Step step) {
    switch (step) {
      case _Step.type:
        return _type == null ? 'Choose whether you lost or found a pet.' : null;
      case _Step.pet:
        if (_type == ReportType.lost) {
          return _pet == null ? 'Pick the pet that is missing.' : null;
        }
        if (_foundPhotos.isEmpty) return 'Add at least one photo of the pet.';
        if (_foundSpecies == null) return 'Is it a dog, a cat or other?';
        return null;
      case _Step.where:
        return _place == null ? 'Choose the city where it happened.' : null;
      case _Step.when:
        return _eventAt.isAfter(DateTime.now().add(const Duration(minutes: 5)))
            ? 'The date can\'t be in the future.'
            : null;
      case _Step.details:
        if (_description.text.trim().length < 10) {
          return 'Add a short description (at least 10 characters).';
        }
        final phone = _phone.text.trim();
        final email = _email.text.trim();
        if (phone.isEmpty && email.isEmpty) {
          return 'Add a phone number or email so people can reach you.';
        }
        if (phone.isNotEmpty && _phoneError(phone) != null) {
          return _phoneError(phone);
        }
        if (email.isNotEmpty && Validators.email(email) != null) {
          return Validators.email(email);
        }
        return null;
      case _Step.review:
        return null;
    }
  }

  static String? _phoneError(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (!RegExp(r'^\+?[0-9 ()\-]+$').hasMatch(phone) ||
        digits.length < 6 ||
        digits.length > 15) {
      return 'Please enter a valid phone number.';
    }
    return null;
  }

  void _goTo(int step) {
    FocusScope.of(context).unfocus();
    setState(() => _step = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  void _next() {
    final step = _Step.values[_step];
    final error = _errorFor(step);
    if (error != null) {
      HapticFeedback.mediumImpact();
      setState(() => _showErrors.add(step));
      SnackbarUtils.showError(context, error);
      return;
    }
    if (step == _Step.review) {
      _publish();
    } else {
      _goTo(_step + 1);
    }
  }

  Future<void> _back() async {
    if (_publishing) return;
    if (_published != null || _step <= _firstStep) {
      if (_published == null && _isDirty && !await _confirmDiscard()) return;
      if (mounted) Navigator.of(context).pop();
      return;
    }
    _goTo(_step - 1);
  }

  Future<bool> _confirmDiscard() async {
    final discard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard this report?'),
        content: const Text('What you\'ve entered so far will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep editing'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    return discard ?? false;
  }

  ReportDraft _draft() {
    final lost = _type == ReportType.lost;
    return ReportDraft(
      type: _type!,
      ownerName: ref.read(currentUserInfoProvider).name,
      petId: lost ? _pet!.id : null,
      petName: _petName,
      species: lost ? _pet!.species : _foundSpecies!,
      description: _description.text,
      photos: lost
          ? [for (final url in _pet!.photoUrls) PetPhoto.remote(url)]
          : _foundPhotos,
      place: _place!,
      placeDetail: _placeDetail.text,
      areaLat: _street?.lat,
      areaLng: _street?.lng,
      areaRadius: _street?.radius,
      eventAt: _eventAt,
      contactPhone: _phone.text,
      contactEmail: _email.text,
      whatsapp: _whatsapp,
    );
  }

  Future<void> _publish() async {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) {
      SnackbarUtils.showError(context, 'Please sign in again to publish.');
      return;
    }
    final draft = _draft();

    setState(() {
      _publishing = true;
      _progress = draft.photos.any((p) => p.isLocal) ? 0 : null;
    });
    try {
      final id = await ref
          .read(reportsRepositoryProvider)
          .createReport(
            ownerId: uid,
            draft: draft,
            onUploadProgress: (p) {
              if (mounted) setState(() => _progress = p);
            },
          );
      HapticFeedback.heavyImpact();
      if (!mounted) return;
      setState(() {
        _publishing = false;
        _published = Report(
          id: id,
          ownerId: uid,
          ownerName: draft.ownerName,
          type: draft.type,
          petId: draft.petId,
          petName: draft.petName,
          species: draft.species,
          description: draft.description.trim(),
          photoUrls: [
            for (final p in draft.photos)
              if (!p.isLocal) p.url!,
          ],
          country: draft.place.country,
          city: draft.place.city,
          cityKey: draft.place.cityKey,
          placeDetail: _publicPlaceDetail.isEmpty ? null : _publicPlaceDetail,
          areaRadius: draft.areaRadius,
          lat: draft.areaLat ?? draft.place.lat,
          lng: draft.areaLng ?? draft.place.lng,
          eventAt: draft.eventAt,
          status: ReportStatus.open,
        );
      });
    } on ReportsException catch (e) {
      if (!mounted) return;
      setState(() {
        _publishing = false;
        _progress = null;
      });
      SnackbarUtils.showError(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authStateProvider);
    _prefillFromProfile();
    final title = switch (_type) {
      ReportType.lost => 'Report a lost pet',
      ReportType.found => 'Report a found pet',
      null => 'New report',
    };
    final total = _Step.values.length - _firstStep;
    final current = _step - _firstStep + 1;
    final accent = _type == null ? AppColors.primary : reportColor(_type!);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 450),
              child: _published != null
                  ? _SuccessView(
                      key: const ValueKey('success'),
                      report: _published!,
                    )
                  : Column(
                      key: const ValueKey('flow'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 20, 0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: _publishing ? null : _back,
                                icon: Icon(
                                  _step <= _firstStep
                                      ? Icons.close_rounded
                                      : Icons.arrow_back_rounded,
                                ),
                                color: AppColors.text,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  child: Text(
                                    title,
                                    key: ValueKey(title),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.text,
                                        ),
                                  ),
                                ),
                              ),
                              Text(
                                '$current of $total',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                          child: _ProgressBar(
                            value: current / total,
                            color: accent,
                          ),
                        ),
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _typeStep(),
                              _petStep(),
                              _whereStep(),
                              _whenStep(),
                              _detailsStep(),
                              _reviewStep(),
                            ],
                          ),
                        ),
                        ProgressSaveButton(
                          label: _step == _Step.review.index
                              ? 'Publish report'
                              : 'Continue',
                          saving: _publishing,
                          progress: _progress,
                          onPressed: _next,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _stepScaffold({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.text,
            height: 1.2,
          ),
        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(color: AppColors.textMuted, height: 1.45),
        ).animate().fadeIn(delay: 80.ms, duration: 300.ms),
        const SizedBox(height: 22),
        ...children,
      ],
    );
  }

  Widget _typeStep() {
    return _stepScaffold(
      title: 'What happened?',
      subtitle: 'Let\'s get the word out to people nearby, fast.',
      children: [
        for (final (i, type) in ReportType.values.indexed) ...[
          if (i > 0) const SizedBox(height: 14),
          _TypeCard(
                type: type,
                selected: _type == type,
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() {
                    if (_type != type) _pet = null;
                    _type = type;
                  });
                  Future.delayed(const Duration(milliseconds: 280), () {
                    if (mounted && _step == _Step.type.index) _next();
                  });
                },
              )
              .animate()
              .fadeIn(delay: (120 + 80 * i).ms, duration: 350.ms)
              .slideY(begin: 0.15, end: 0, curve: Curves.easeOutCubic),
        ],
      ],
    );
  }

  Widget _petStep() {
    if (_type == ReportType.found) {
      return _stepScaffold(
        title: 'Tell us about the pet',
        subtitle:
            'A clear photo is the fastest way for the owner to recognise them.',
        children: [
          PhotoPickerField(
            photos: _foundPhotos,
            showError: _showErrors.contains(_Step.pet) && _foundPhotos.isEmpty,
            enabled: !_publishing,
            emptyTitle: 'Add photos of the pet',
            emptySubtitle: 'Take one now, or pick from your gallery',
            onAdd: () async {
              if (_foundPhotos.length >= 4) return;
              final path = await pickPhoto(context);
              if (path != null && mounted) {
                setState(
                  () => _foundPhotos = [..._foundPhotos, PetPhoto.local(path)],
                );
              }
            },
            onRemove: (i) =>
                setState(() => _foundPhotos = [..._foundPhotos]..removeAt(i)),
            onMakeCover: (i) => setState(() {
              final photo = _foundPhotos[i];
              _foundPhotos = [photo, ..._foundPhotos.where((p) => p != photo)];
            }),
          ),
          const SizedBox(height: 24),
          const SectionLabel('What kind of animal?'),
          const SizedBox(height: 10),
          SpeciesSelector(
            selected: _foundSpecies,
            showError: _showErrors.contains(_Step.pet) && _foundSpecies == null,
            onChanged: (s) => setState(() => _foundSpecies = s),
          ),
          const SizedBox(height: 22),
          const SectionLabel('Name on collar or tag', optional: true),
          const SizedBox(height: 8),
          AppFormField(
            controller: _foundName,
            hint: 'Leave empty if you don\'t know',
            icon: Icons.sell_outlined,
            textCapitalization: TextCapitalization.words,
            maxLength: 40,
          ),
        ],
      );
    }

    final petsState = ref.watch(myPetsProvider);
    final pets = petsState.value ?? const <Pet>[];
    if (_pendingPetName != null) {
      for (final p in pets) {
        if (p.name == _pendingPetName) {
          _pet = p;
          _pendingPetName = null;
          break;
        }
      }
    }

    return _stepScaffold(
      title: 'Which pet is missing?',
      subtitle:
          'We\'ll use their profile and photos so you don\'t have to retype anything.',
      children: [
        if (petsState.isLoading && !petsState.hasValue)
          const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          )
        else
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.92,
            children: [
              for (final pet in pets)
                _PetChoice(
                  pet: pet,
                  selected: _pet?.id == pet.id,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _pet = pet);
                  },
                ),
              _AddPetChoice(
                onTap: () async {
                  final name = await Navigator.of(context).push<String>(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (_) => const PetFormScreen(),
                    ),
                  );
                  if (name != null && mounted) {
                    setState(() => _pendingPetName = name);
                  }
                },
              ),
            ],
          ),
      ],
    );
  }

  Widget _whereStep() {
    return _stepScaffold(
      title: _type == ReportType.found
          ? 'Where did you find it?'
          : 'Where was $_petName last seen?',
      subtitle:
          'Choose the city, then a street or landmark nearby. People will only see an area of about 100 m, never the exact address.',
      children: [
        _CityPicker(
          selected: _place,
          showError: _showErrors.contains(_Step.where) && _place == null,
          onChanged: (place) => setState(() {
            _place = place;
            _street = null;
            _placeDetail.clear();
          }),
        ),
        const SizedBox(height: 22),
        const SectionLabel('Street, area or landmark', optional: true),
        const SizedBox(height: 8),
        _StreetPicker(
          controller: _placeDetail,
          city: _place,
          selected: _street,
          onChanged: (street) => setState(() => _street = street),
        ),
      ],
    );
  }

  Widget _whenStep() {
    final now = DateTime.now();
    final choices = <String, (String, DateTime)>{
      'now': ('Just now', now),
      'hour': ('1 hour ago', now.subtract(const Duration(hours: 1))),
      'morning': ('This morning', DateTime(now.year, now.month, now.day, 9)),
      'yesterday': ('Yesterday', now.subtract(const Duration(days: 1))),
    };

    return _stepScaffold(
      title: _type == ReportType.found
          ? 'When did you find it?'
          : 'When did you last see $_petName?',
      subtitle: 'An approximate time is fine.',
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final e in choices.entries)
              if (!(e.key == 'morning' && now.hour < 10))
                _Chip(
                  label: e.value.$1,
                  selected: _timeChoice == e.key,
                  onTap: () => setState(() {
                    _timeChoice = e.key;
                    _eventAt = e.value.$2;
                  }),
                ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _timeChoice == 'custom'
                  ? AppColors.primary
                  : AppColors.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.event_rounded,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        dateTimeLabel(_eventAt),
                        key: ValueKey(_eventAt),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today_rounded, size: 18),
                      label: const Text('Change date'),
                      style: _outlinedStyle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickTime,
                      icon: const Icon(Icons.access_time_rounded, size: 18),
                      label: const Text('Change time'),
                      style: _outlinedStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  ButtonStyle get _outlinedStyle => OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    minimumSize: const Size.fromHeight(46),
    side: const BorderSide(color: AppColors.border),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    textStyle: const TextStyle(fontWeight: FontWeight.w600),
  );

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _eventAt.isAfter(now) ? now : _eventAt,
      firstDate: now.subtract(const Duration(days: 90)),
      lastDate: now,
    );
    if (date == null) return;
    setState(() {
      _timeChoice = 'custom';
      _eventAt = DateTime(
        date.year,
        date.month,
        date.day,
        _eventAt.hour,
        _eventAt.minute,
      );
      if (_eventAt.isAfter(now)) _eventAt = now;
    });
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_eventAt),
    );
    if (time == null) return;
    setState(() {
      _timeChoice = 'custom';
      _eventAt = DateTime(
        _eventAt.year,
        _eventAt.month,
        _eventAt.day,
        time.hour,
        time.minute,
      );
    });
  }

  Widget _detailsStep() {
    final lost = _type == ReportType.lost;
    return _stepScaffold(
      title: 'Anything else we should know?',
      subtitle:
          'Details help neighbours recognise the pet and reach you quickly.',
      children: [
        const SectionLabel('Description'),
        const SizedBox(height: 8),
        AppFormField(
          controller: _description,
          hint: lost
              ? 'Collar colour, behaviour, how $_petName went missing…'
              : 'Condition, collar, behaviour, where exactly you found it…',
          icon: Icons.notes_rounded,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 5,
          maxLength: 1000,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 22),
        const SectionLabel('How can people reach you?'),
        const SizedBox(height: 4),
        const Text(
          'Shown only on the report page, never in lists.',
          style: TextStyle(fontSize: 12, color: AppColors.textMuted),
        ),
        const SizedBox(height: 10),
        AppFormField(
          controller: _phone,
          hint: 'Phone, e.g. +39 333 123 4567',
          icon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
          maxLength: 20,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 10),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: _phone.text.trim().isEmpty
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ToggleTile(
                    title: 'Reachable on WhatsApp',
                    subtitle: 'People can message you on this number',
                    value: _whatsapp,
                    onChanged: (v) => setState(() => _whatsapp = v),
                  ),
                ),
        ),
        AppFormField(
          controller: _email,
          hint: 'Email',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          maxLength: 100,
        ),
      ],
    );
  }

  Widget _reviewStep() {
    if (_type == null ||
        _place == null ||
        (_type == ReportType.lost && _pet == null) ||
        (_type == ReportType.found && _foundPhotos.isEmpty)) {
      return const SizedBox.shrink();
    }
    final lost = _type == ReportType.lost;
    final cover = lost
        ? (_pet!.coverUrl == null ? null : PetPhoto.remote(_pet!.coverUrl!))
        : _foundPhotos.first;
    final placeDetail = _publicPlaceDetail;
    final contact = [
      _phone.text.trim(),
      _email.text.trim(),
    ].where((c) => c.isNotEmpty).join(' · ');

    return _stepScaffold(
      title: 'Ready to publish?',
      subtitle: 'This is how your report will look to people nearby.',
      children: [
        Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDark.withValues(alpha: 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 210,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        PetImage(photo: cover),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: ReportTypeBadge(type: _type!, large: true),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _petName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _ReviewRow(
                          icon: Icons.location_on_rounded,
                          color: reportColor(_type!),
                          text: placeDetail.isEmpty
                              ? _place!.label
                              : '$placeDetail, ${_place!.city}',
                        ),
                        _ReviewRow(
                          icon: Icons.schedule_rounded,
                          color: AppColors.accent,
                          text: dateTimeLabel(_eventAt),
                        ),
                        if (contact.isNotEmpty)
                          _ReviewRow(
                            icon: Icons.contact_phone_rounded,
                            color: AppColors.primary,
                            text: contact,
                          ),
                        const SizedBox(height: 6),
                        Text(
                          _description.text.trim(),
                          style: const TextStyle(
                            color: AppColors.text,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms)
            .scale(begin: const Offset(0.96, 0.96), curve: Curves.easeOutBack),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double value;
  final Color color;

  const _ProgressBar({required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 6,
        child: Stack(
          children: [
            Container(color: AppColors.border),
            TweenAnimationBuilder<double>(
              tween: Tween(end: value),
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              builder: (_, v, _) => FractionallySizedBox(
                widthFactor: v.clamp(0.0, 1.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, Color.lerp(color, Colors.black, 0.2)!],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final ReportType type;
  final bool selected;
  final VoidCallback onTap;

  const _TypeCard({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = reportColor(type);
    final lost = type == ReportType.lost;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: selected ? 1 : 0.98,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: selected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color, Color.lerp(color, Colors.black, 0.25)!],
                  )
                : null,
            color: selected ? null : AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: selected ? Colors.transparent : AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: (selected ? color : AppColors.primaryDark).withValues(
                  alpha: selected ? 0.35 : 0.06,
                ),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: selected
                      ? Colors.white.withValues(alpha: 0.2)
                      : color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  lost
                      ? Icons.campaign_rounded
                      : Icons.volunteer_activism_rounded,
                  size: 30,
                  color: selected ? Colors.white : color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lost ? 'I lost my pet' : 'I found a pet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: selected ? Colors.white : AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lost
                          ? 'Alert people nearby and get help searching.'
                          : 'Help a lost pet find its way back home.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: selected
                            ? Colors.white.withValues(alpha: 0.85)
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: selected ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PetChoice extends StatelessWidget {
  final Pet pet;
  final bool selected;
  final VoidCallback onTap;

  const _PetChoice({
    required this.pet,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected ? AppColors.lostPin : Colors.transparent,
            width: 3,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              PetImage.url(pet.coverUrl),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 1],
                    colors: [Colors.transparent, Color(0xCC0B1F19)],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 10,
                child: Text(
                  pet.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              if (selected)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: AppColors.lostPin,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 17,
                      color: Colors.white,
                    ),
                  ).animate().scale(duration: 300.ms, curve: Curves.elasticOut),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddPetChoice extends StatelessWidget {
  final VoidCallback onTap;

  const _AddPetChoice({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: const DashedBorderPainter(radius: 22),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_rounded, size: 40, color: AppColors.primary),
            SizedBox(height: 8),
            Text(
              'Add a pet',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CityPicker extends ConsumerStatefulWidget {
  final ReportPlace? selected;
  final bool showError;
  final ValueChanged<ReportPlace?> onChanged;

  const _CityPicker({
    required this.selected,
    required this.showError,
    required this.onChanged,
  });

  @override
  ConsumerState<_CityPicker> createState() => _CityPickerState();
}

class _CityPickerState extends ConsumerState<_CityPicker> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  Timer? _debounce;
  int _requestId = 0;
  List<PlaceSuggestion> _suggestions = const [];
  String? _error;
  bool _loading = false;

  PlacesService get _places => ref.read(placesServiceProvider);

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    setState(() => _error = null);
    if (value.trim().length < 2) {
      setState(() => _suggestions = const []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      final id = ++_requestId;
      setState(() => _loading = true);
      try {
        final results = await _places.searchCities(value);
        if (!mounted || id != _requestId) return;
        setState(() {
          _suggestions = results;
          _error = results.isEmpty ? 'No cities found for "$value".' : null;
        });
      } on PlacesException catch (e) {
        if (mounted && id == _requestId) setState(() => _error = e.message);
      } finally {
        if (mounted && id == _requestId) setState(() => _loading = false);
      }
    });
  }

  Future<void> _select(PlaceSuggestion suggestion) async {
    _focus.unfocus();
    _requestId++;
    setState(() {
      _loading = true;
      _suggestions = const [];
    });
    try {
      final city = await _places.cityDetails(suggestion);
      if (!mounted) return;
      _controller.clear();
      widget.onChanged(
        ReportPlace(
          city: city.city,
          cityKey: city.cityKey,
          country: city.country,
          lat: city.lat,
          lng: city.lng,
          label: city.label,
        ),
      );
    } on PlacesException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: selected == null
              ? const SizedBox(width: double.infinity)
              : Container(
                  key: ValueKey(selected.cityKey),
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                        ),
                      ).animate().scale(
                        duration: 450.ms,
                        curve: Curves.elasticOut,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          selected.label,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        CitySearchInput(
          controller: _controller,
          focusNode: _focus,
          loading: _loading,
          confirmed: false,
          onChanged: _onChanged,
          onClear: () {
            _controller.clear();
            _onChanged('');
          },
        ),
        if (widget.showError && selected == null) ...[
          const SizedBox(height: 6),
          const Text(
            'Please choose a city',
            style: TextStyle(color: AppColors.danger, fontSize: 12),
          ),
        ],
        const SizedBox(height: 10),
        if (_suggestions.isNotEmpty)
          CitySuggestionList(
            suggestions: _suggestions,
            query: _controller.text,
            onSelect: _select,
          )
        else if (_error != null)
          CityMessageCard(message: _error!),
      ],
    );
  }
}

class _StreetPicker extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final ReportPlace? city;
  final StreetPlace? selected;
  final ValueChanged<StreetPlace?> onChanged;

  const _StreetPicker({
    required this.controller,
    required this.city,
    required this.selected,
    required this.onChanged,
  });

  @override
  ConsumerState<_StreetPicker> createState() => _StreetPickerState();
}

class _StreetPickerState extends ConsumerState<_StreetPicker> {
  final _focus = FocusNode();
  Timer? _debounce;
  int _requestId = 0;
  List<PlaceSuggestion> _suggestions = const [];
  String? _error;
  bool _loading = false;

  PlacesService get _places => ref.read(placesServiceProvider);

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _focus.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    if (widget.selected != null) widget.onChanged(null);
    setState(() => _error = null);
    final city = widget.city;
    if (city == null || value.trim().length < 2) {
      _requestId++;
      setState(() {
        _suggestions = const [];
        _loading = false;
      });
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      final id = ++_requestId;
      setState(() => _loading = true);
      try {
        final results = await _places.searchStreets(
          value,
          city: city.city,
          country: city.country,
          lat: city.lat,
          lng: city.lng,
        );
        if (!mounted || id != _requestId) return;
        setState(() {
          _suggestions = results;
          _error = results.isEmpty
              ? 'No places found in ${city.city} for "${value.trim()}".'
              : null;
        });
      } on PlacesException catch (e) {
        if (mounted && id == _requestId) setState(() => _error = e.message);
      } finally {
        if (mounted && id == _requestId) setState(() => _loading = false);
      }
    });
  }

  Future<void> _select(PlaceSuggestion suggestion) async {
    _focus.unfocus();
    final city = widget.city;
    if (city == null) return;
    final id = ++_requestId;
    setState(() {
      _loading = true;
      _suggestions = const [];
    });
    try {
      final street = await _places.streetDetails(suggestion, city: city.city);
      if (!mounted || id != _requestId) return;
      widget.controller.text = street.label;
      widget.onChanged(street);
    } on PlacesException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted && id == _requestId) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CitySearchInput(
          controller: widget.controller,
          focusNode: _focus,
          loading: _loading,
          confirmed: selected != null,
          hint: widget.city == null
              ? 'Choose a city first'
              : 'Search in ${widget.city!.city}, e.g. Via Dante',
          icon: Icons.signpost_outlined,
          textCapitalization: TextCapitalization.sentences,
          onChanged: _onChanged,
          onClear: () {
            widget.controller.clear();
            _onChanged('');
          },
        ),
        const SizedBox(height: 10),
        if (_suggestions.isNotEmpty)
          CitySuggestionList(
            suggestions: _suggestions,
            query: widget.controller.text,
            onSelect: _select,
            icon: Icons.signpost_rounded,
          )
        else if (_error != null)
          CityMessageCard(message: _error!)
        else
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Row(
              key: ValueKey(selected != null),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  selected != null
                      ? Icons.radar_rounded
                      : Icons.lock_outline_rounded,
                  size: 16,
                  color: selected != null
                      ? AppColors.primary
                      : AppColors.textMuted,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selected != null
                        ? 'People will see an area of about ${selected.radius} m around ${selected.label}.'
                        : 'House numbers are never shown. Pick a suggestion so people can see the right area.',
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.4,
                      color: selected != null
                          ? AppColors.primary
                          : AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.text,
          ),
        ),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: SwitchListTile.adaptive(
        value: value,
        onChanged: onChanged,
        activeTrackColor: const Color(0xFF25D366),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
        ),
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _ReviewRow({
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 17, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: AppColors.text, fontSize: 13.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final Report report;

  const _SuccessView({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final color = reportColor(report.type);
    final lost = report.type == ReportType.lost;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),
          Stack(
            alignment: Alignment.center,
            children: [
              for (var i = 0; i < 3; i++)
                Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: color.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat())
                    .scale(
                      delay: (i * 600).ms,
                      duration: 1800.ms,
                      begin: const Offset(1, 1),
                      end: const Offset(2.1, 2.1),
                      curve: Curves.easeOut,
                    )
                    .fadeOut(delay: (i * 600).ms, duration: 1800.ms),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color, Color.lerp(color, Colors.black, 0.25)!],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 64,
                ),
              ).animate().scale(
                duration: 700.ms,
                curve: Curves.elasticOut,
                begin: const Offset(0.3, 0.3),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            'Report published!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 10),
          Text(
            lost
                ? 'People around ${report.city} can now see ${report.petName}. We really hope they\'re home soon.'
                : 'Thank you for helping! The owner can now find ${report.petName} and contact you.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textMuted, height: 1.5),
          ).animate().fadeIn(delay: 400.ms),
          const Spacer(),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => ReportDetailScreen(report: report),
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            child: const Text('View report'),
          ).animate().fadeIn(delay: 550.ms),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back to home'),
          ),
        ],
      ),
    );
  }
}
