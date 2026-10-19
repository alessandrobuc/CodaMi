import '../../../../l10n/l10n.dart';
import '../../domain/entities/video_entity.dart';

extension VideoCategoryLabel on VideoCategory {
  String label(AppLocalizations l10n) => switch (this) {
    VideoCategory.motivational => l10n.videoMotivational,
    VideoCategory.educational => l10n.videoEducational,
  };
}

String videoTagLabel(String tag, AppLocalizations l10n) => switch (tag) {
  'dog' => l10n.speciesDog,
  'cat' => l10n.speciesCat,
  'other' => l10n.speciesOther,
  _ => l10n.videoTagGeneral,
};
