import 'package:CodaMi/features/auth/data/models/user_model.dart';
import 'package:CodaMi/features/auth/presentation/providers/auth_provider.dart';
import 'package:CodaMi/features/moderation/data/moderation_repository.dart';
import 'package:CodaMi/features/pets/domain/entities/pets_entity.dart';
import 'package:CodaMi/features/pets/presentation/providers/pets_provider.dart';
import 'package:CodaMi/features/profile/presentation/providers/profile_provider.dart';
import 'package:CodaMi/features/sitting/data/sitting_repository.dart';
import 'package:CodaMi/features/sitting/domain/sitting.dart';
import 'package:CodaMi/features/sitting/presentation/providers/sitting_provider.dart';
import 'package:CodaMi/features/sitting/presentation/screens/admin_sitting_screen.dart';
import 'package:CodaMi/features/sitting/presentation/screens/chat_screens.dart';
import 'package:CodaMi/features/sitting/presentation/screens/request_screens.dart';
import 'package:CodaMi/features/sitting/presentation/screens/sitter_screens.dart';
import 'package:CodaMi/features/sitting/presentation/screens/sitting_screen.dart';
import 'package:CodaMi/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeUser implements User {
  @override
  String get uid => 'me';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeRepository implements SittingRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => Future<void>.value();
}

DateTime day(int fromToday) {
  final now = DateTime.now();
  return DateTime.utc(now.year, now.month, now.day + fromToday);
}

SittingRequest request(
  String id, {
  String owner = 'me',
  SittingStatus status = SittingStatus.open,
  int start = 3,
  String? sitter,
  bool ownerConfirmed = false,
}) => SittingRequest(
  id: id,
  ownerId: owner,
  ownerName: owner == 'me' ? 'Marta Rossi' : 'Giovanni Bianchi-Ferraris',
  petIds: const ['p1', 'p2'],
  petNames: const ['Luna', 'Principessa della Valle'],
  species: const [PetSpecies.dog, PetSpecies.cat],
  service: SittingService.overnight,
  start: day(start),
  end: day(start + 6),
  city: 'Milano',
  lat: 45.46,
  lng: 9.19,
  notes: 'Luna takes a pill every morning with food. ' * 4,
  budget: '€25 a day',
  status: status,
  sitterId: sitter,
  sitterName: sitter == null ? '' : 'Alessandra Maria Conti',
  ownerConfirmed: ownerConfirmed,
);

const sitter = SitterProfile(
  uid: 's1',
  name: 'Alessandra Maria Conti',
  about:
      'I grew up with dogs and cats and work from home, so your pet is never alone.',
  experience: 'Volunteer at the shelter for 6 years.',
  species: [PetSpecies.dog, PetSpecies.cat, PetSpecies.other],
  services: SittingService.values,
  availability: 'Weekends and August',
  city: 'Milano',
  lat: 45.47,
  lng: 9.2,
  areaKm: 25,
  ratingSum: 23,
  reviewCount: 5,
  completedCount: 7,
);

void main() {
  test('who can confirm a service, and when', () {
    final booked = request(
      'b',
      status: SittingStatus.booked,
      start: -2,
      sitter: 's1',
    );
    expect(roleIn(booked, 'me'), RequestRole.owner);
    expect(roleIn(booked, 's1'), RequestRole.bookedSitter);
    expect(roleIn(booked, 'x'), RequestRole.other);
    expect(canConfirm(booked, 'me'), isTrue);
    expect(canConfirm(booked, 's1'), isTrue);
    expect(canConfirm(booked, 'x'), isFalse);
    final confirmed = request(
      'b',
      status: SittingStatus.booked,
      start: -2,
      sitter: 's1',
      ownerConfirmed: true,
    );
    expect(canConfirm(confirmed, 'me'), isFalse, reason: 'no confirming twice');
    expect(
      canConfirm(
        request('f', status: SittingStatus.booked, start: 2, sitter: 's1'),
        'me',
      ),
      isFalse,
      reason: 'not before the start',
    );
  });

  test(
    'nearby: inside the distance, nearest first; chat ID from both sides',
    () {
      final far = request('far');
      final list = nearby(
        [
          (id: 'b', lat: 45.50, lng: 9.19),
          (id: 'a', lat: 45.461, lng: 9.191),
          (id: 'x', lat: 41.9, lng: 12.5),
        ],
        lat: 45.46,
        lng: 9.19,
        km: 25,
        latOf: (p) => p.lat,
        lngOf: (p) => p.lng,
      );
      expect(list.map((p) => p.id), ['a', 'b']);
      expect(far.id, 'far');
      expect(sittingChatId('b', 'a'), 'a_b');
      expect(sittingChatId('a', 'b'), 'a_b');
      expect(roundPlace(45.46789), 45.47);
    },
  );

  test('chat unread for me only when the other person wrote last', () {
    final t = DateTime(2026, 11, 4, 10);
    final chat = SittingChat(
      id: 'a_b',
      members: const ['a', 'b'],
      lastAt: t,
      lastSender: 'b',
    );
    expect(chat.unreadFor('a'), isTrue);
    expect(chat.unreadFor('b'), isFalse);
    expect(
      SittingChat(
        id: 'a_b',
        members: const ['a', 'b'],
        lastAt: t,
        lastSender: 'b',
        readAt: {'a': t},
      ).unreadFor('a'),
      isFalse,
    );
    expect(chat.otherOf('a'), 'b');
  });

  test(
    'requests from the database: bad dates are skipped, unknown values safe',
    () {
      expect(
        SittingRequest.fromMap('x', {
          'start': '2026-13-01',
          'end': '2026-12-01',
        }),
        isNull,
      );
      final r = SittingRequest.fromMap('x', {
        'start': '2026-12-01',
        'end': '2026-12-03',
        'service': 'spaceTravel',
        'status': 'weird',
        'species': ['dog', 'dragon'],
      })!;
      expect(r.service, SittingService.visits);
      expect(r.status, SittingStatus.closed);
      expect(r.species, [PetSpecies.dog]);
      expect(sitter.rating, 4.6);
    },
  );

  final me = UserModel(
    uid: 'me',
    name: 'Marta Rossi',
    email: 'm@x.it',
    createdAt: DateTime(2026, 1, 1),
    city: 'Milano',
    homeLat: 45.46,
    homeLng: 9.19,
    role: UserRole.admin,
  );
  final open = request('r1');
  final visit = request('r2', owner: 'o2');
  final booked = request(
    'r3',
    status: SittingStatus.booked,
    start: -2,
    sitter: 's1',
  );
  final offers = [
    const SittingOffer(
      requestId: 'r1',
      ownerId: 'me',
      sitterId: 's1',
      sitterName: 'Alessandra Maria Conti',
      message: 'I would love to look after Luna and her friend!',
      price: '€20 a day',
    ),
    const SittingOffer(
      requestId: 'r1',
      ownerId: 'me',
      sitterId: 's2',
      sitterName: 'Bo',
      message: 'Hi',
      status: OfferStatus.declined,
    ),
  ];
  final messages = [
    ChatMessage(
      id: 'm2',
      senderId: 'me',
      text: 'Perfect, see you on Saturday!',
      at: DateTime(2026, 11, 4, 9),
    ),
    ChatMessage(
      id: 'm1',
      senderId: 's1',
      text: 'Hello! ' * 30,
      at: DateTime(2026, 11, 4, 8),
    ),
  ];

  for (final locale in const [Locale('en'), Locale('de'), Locale('ar')]) {
    Widget app(Widget home) => ProviderScope(
      overrides: [
        authStateProvider.overrideWith((ref) => Stream.value(_FakeUser())),
        userProfileProvider.overrideWith((ref) => Stream.value(me)),
        sittingRepositoryProvider.overrideWithValue(_FakeRepository()),
        sittingConfigProvider.overrideWith(
          (ref) => Stream.value(const SittingConfig(enabled: true)),
        ),
        mySitterProfileProvider.overrideWith((ref) => Stream.value(null)),
        sitterProfileProvider.overrideWith((ref, uid) => Stream.value(sitter)),
        openRequestsProvider.overrideWith((ref) => Stream.value([visit])),
        sittersProvider.overrideWith((ref) => Stream.value([sitter])),
        myRequestsProvider.overrideWith((ref) => Stream.value([open, booked])),
        sittingRequestProvider.overrideWith(
          (ref, id) =>
              Stream.value({'r1': open, 'r2': visit, 'r3': booked}[id]),
        ),
        offersOnProvider.overrideWith((ref, id) => Stream.value(offers)),
        myOffersProvider.overrideWith((ref) => Stream.value([offers.first])),
        sitterReviewsProvider.overrideWith(
          (ref, uid) => Stream.value([
            SittingReview(
              id: 'v1',
              sitterId: 's1',
              reviewerName: 'Giovanni Bianchi-Ferraris',
              stars: 5,
              text: 'Wonderful with our old dog. ' * 5,
              createdAt: DateTime(2026, 10, 1),
            ),
          ]),
        ),
        reviewedProvider.overrideWith((ref, id) => Stream.value(false)),
        myChatsProvider.overrideWith(
          (ref) => Stream.value([
            SittingChat(
              id: 'me_s1',
              members: const ['me', 's1'],
              names: const {'s1': 'Alessandra Maria Conti'},
              lastMessage: 'See you!',
              lastAt: DateTime(2026, 11, 4),
              lastSender: 's1',
            ),
          ]),
        ),
        chatMessagesProvider.overrideWith((ref, id) => Stream.value(messages)),
        sittingFlagsProvider.overrideWith(
          (ref) => Stream.value([
            SittingFlag(
              id: 'f1',
              kind: SittingFlagKind.review,
              targetId: 'v1',
              targetOwnerId: 's1',
              reason: FlagReason.scam,
              note: 'Fake review from a friend',
              createdAt: DateTime(2026, 11, 3),
            ),
            const SittingFlag(
              id: 'f2',
              kind: SittingFlagKind.chat,
              targetId: 'me_s1',
              targetOwnerId: 's1',
              reason: FlagReason.inappropriate,
            ),
          ]),
        ),
        latestRequestsProvider.overrideWith(
          (ref) => Stream.value([open, visit, booked]),
        ),
        latestSittersProvider.overrideWith((ref) => Stream.value([sitter])),
        latestReviewsProvider.overrideWith((ref) => Stream.value(const [])),
        myPetsProvider.overrideWith(
          (ref) => Stream.value(const [
            Pet(id: 'p1', ownerId: 'me', name: 'Luna', species: PetSpecies.dog),
            Pet(
              id: 'p2',
              ownerId: 'me',
              name: 'Principessa della Valle',
              species: PetSpecies.cat,
            ),
          ]),
        ),
      ],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );

    Future<void> show(
      WidgetTester tester,
      Widget screen, {
      bool scroll = true,
    }) async {
      await tester.pumpWidget(app(screen));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      if (scroll && find.byType(Scrollable).evaluate().isNotEmpty) {
        await tester.drag(
          find.byType(Scrollable).first,
          const Offset(0, -3000),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
    }

    testWidgets('pet sitting screens fit on a small phone ($locale)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await show(tester, const SittingScreen(), scroll: false);
      for (final tab in find.byType(Tab).evaluate().toList()) {
        await tester.ensureVisible(find.byWidget(tab.widget));
        await tester.pumpAndSettle();
        await tester.tap(find.byWidget(tab.widget));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }

      await show(tester, const RequestDetailScreen(requestId: 'r1'));
      await show(tester, const RequestDetailScreen(requestId: 'r2'));
      await show(tester, const RequestDetailScreen(requestId: 'r3'));
      await show(tester, const SitterProfileScreen(uid: 's1'));
      await show(tester, const ChatsScreen());
      await show(
        tester,
        const ChatScreen(
          chatId: 'me_s1',
          otherId: 's1',
          otherName: 'Alessandra Maria Conti',
        ),
        scroll: false,
      );
      await show(tester, const RequestFormScreen());
      await show(tester, const SitterFormScreen());

      await show(tester, const AdminSittingScreen(), scroll: false);
      for (final tab in find.byType(Tab).evaluate().toList()) {
        await tester.ensureVisible(find.byWidget(tab.widget));
        await tester.pumpAndSettle();
        await tester.tap(find.byWidget(tab.widget));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
    });
  }
}
