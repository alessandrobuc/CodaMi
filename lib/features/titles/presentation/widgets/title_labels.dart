import '../../../../l10n/app_localizations.dart';
import '../../domain/titles.dart';

const _donorEmoji = ['💚', '🥉', '🥈', '🥇', '💎', '👑'];

extension TitleIdLabels on TitleId {
  String name(AppLocalizations l10n) => switch (this) {
    TitleId.contributor => l10n.ttlContributor,
    TitleId.rescuer => l10n.ttlRescuer,
    TitleId.volunteer => l10n.ttlVolunteer,
    TitleId.advocate => l10n.ttlAdvocate,
    TitleId.helper => l10n.ttlHelper,
    TitleId.trusted => l10n.ttlTrusted,
    TitleId.sitter => l10n.ttlSitter,
    TitleId.ambassador => l10n.ttlAmbassador,
    TitleId.donor => l10n.ttlDonor1,
    TitleId.team => l10n.ttlTeam,
    TitleId.partner => l10n.ttlPartner,
  };

  String how(AppLocalizations l10n) => switch (this) {
    TitleId.contributor => l10n.ttlHowContributor,
    TitleId.rescuer => l10n.ttlHowRescuer,
    TitleId.volunteer => l10n.ttlHowVolunteer,
    TitleId.advocate => l10n.ttlHowAdvocate,
    TitleId.helper => l10n.ttlHowHelper,
    TitleId.trusted => l10n.ttlHowTrusted,
    TitleId.sitter => l10n.ttlHowSitter,
    TitleId.ambassador => l10n.ttlHowAmbassador,
    TitleId.donor => l10n.ttlDonorIntro,
    TitleId.team || TitleId.partner => l10n.ttlHowManual,
  };

  String emoji([int level = 1]) => switch (this) {
    TitleId.contributor => '🐾',
    TitleId.rescuer => '🏡',
    TitleId.volunteer => '🚑',
    TitleId.advocate => '📣',
    TitleId.helper => '💡',
    TitleId.trusted => '🤝',
    TitleId.sitter => '✅',
    TitleId.ambassador => '🌟',
    TitleId.donor => _donorEmoji[(level - 1).clamp(0, _donorEmoji.length - 1)],
    TitleId.team => '🛡️',
    TitleId.partner => '🧡',
  };
}

String donorTierName(AppLocalizations l10n, int level) => switch (level) {
  <= 1 => l10n.ttlDonor1,
  2 => l10n.ttlDonor2,
  3 => l10n.ttlDonor3,
  4 => l10n.ttlDonor4,
  5 => l10n.ttlDonor5,
  _ => l10n.ttlDonor6,
};

String ambassadorLevelName(AppLocalizations l10n, int level) => switch (level) {
  <= 1 => l10n.levelSupporter,
  2 => l10n.levelAmbassador,
  3 => l10n.levelSuperAmbassador,
  _ => l10n.levelChampion,
};

// Stars for activity titles; donor and invite titles have their own names.
String stars(int level) => '★' * level;

extension TitleLevelLabels on TitleLevel {
  String name(AppLocalizations l10n) => switch (id) {
    TitleId.donor => donorTierName(l10n, level),
    TitleId.ambassador => ambassadorLevelName(l10n, level),
    TitleId.team || TitleId.partner => id.name(l10n),
    _ => '${id.name(l10n)} ${stars(level)}',
  };

  String get emoji => id.emoji(level);
}
