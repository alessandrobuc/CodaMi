type Json = Record<string, unknown>;

// Must match TitleId in lib/features/titles/domain/titles.dart.
export const COUNTED_IDS = ["contributor", "rescuer", "volunteer", "advocate", "helper", "trusted", "sitter"] as const;
export type CountedId = (typeof COUNTED_IDS)[number];
export const TITLE_IDS = [...COUNTED_IDS, "ambassador", "donor", "team", "partner"] as const;
export type TitleId = (typeof TITLE_IDS)[number];
// Given only by the team.
export const MANUAL_IDS: TitleId[] = ["team", "partner"];

export const DEFAULT_LEVELS: Record<CountedId, number[]> = {
  contributor: [1, 5, 15],
  rescuer: [1, 3, 10],
  volunteer: [1, 5, 15],
  advocate: [5, 25, 100],
  helper: [1, 3, 10],
  trusted: [30, 100, 365],
  sitter: [1, 5, 15],
};
export const DEFAULT_BONUS = [10, 25, 50];
// Bronze, Silver, Gold, Platinum, Lifetime; any donation makes a Supporter.
export const DEFAULT_DONOR_CENTS = [1000, 2500, 5000, 10000, 25000];
export const DONOR_LEVELS = 6;
export const SHARES_PER_DAY = 3;
export const CLEAN_DAYS = 90;
export const SITTER_MIN_RATING = 4;

export interface TitlesConfig {
  enabled: boolean;
  off: TitleId[];
  levels: Record<CountedId, number[]>;
  bonus: number[];
  donorCents: number[];
}

const isId = (v: unknown): v is TitleId => typeof v === "string" && (TITLE_IDS as readonly string[]).includes(v);

// A list of whole numbers in range, each larger than the one before.
function rising(value: unknown, size: number, min: number, max: number): number[] | null {
  if (!Array.isArray(value) || value.length !== size) return null;
  const ok = value.every((v, i) => typeof v === "number" && Number.isInteger(v) && v >= min && v <= max &&
    (i === 0 || v > (value[i - 1] as number)));
  return ok ? value as number[] : null;
}

export function titlesConfigOf(data: Json | undefined): TitlesConfig {
  const levels = (typeof data?.levels === "object" && data.levels !== null ? data.levels : {}) as Json;
  const bonus = data?.bonus;
  return {
    enabled: data?.enabled === true,
    off: Array.isArray(data?.off) ? [...new Set(data.off.filter(isId))] : [],
    levels: Object.fromEntries(COUNTED_IDS.map((id) =>
      [id, rising(levels[id], 3, 1, 100_000) ?? DEFAULT_LEVELS[id]])) as Record<CountedId, number[]>,
    bonus: Array.isArray(bonus) && bonus.length === 3 &&
      bonus.every((v) => typeof v === "number" && Number.isInteger(v) && v >= 0 && v <= 10_000) ?
      bonus as number[] : DEFAULT_BONUS,
    donorCents: rising(data?.donorCents, 5, 100, 10_000_000) ?? DEFAULT_DONOR_CENTS,
  };
}

export interface Counts {
  reports: number;
  rescues: number;
  helps: number;
  shares: number;
  feedbackDone: number;
  activeDays: number;
  sittings: number;
  invites: number;
  donorCents: number;
}

export const METRIC: Record<CountedId, keyof Counts> = {
  contributor: "reports",
  rescuer: "rescues",
  volunteer: "helps",
  advocate: "shares",
  helper: "feedbackDone",
  trusted: "activeDays",
  sitter: "sittings",
};

export interface Standing {
  // Nothing removed by moderators in the last CLEAN_DAYS days, and not disabled.
  clean: boolean;
  // Average stars, or null before the first review.
  sitterRating: number | null;
}

export type Levels = Partial<Record<TitleId, number>>;

export const levelFor = (count: number, thresholds: number[]): number =>
  thresholds.filter((t) => count >= t).length;

export const donorLevel = (cents: number, tiers: number[]): number =>
  cents <= 0 ? 0 : 1 + tiers.filter((t) => cents >= t).length;

export function maxLevel(id: TitleId, ambassadorLevels: number): number {
  if (id === "donor") return DONOR_LEVELS;
  if (id === "ambassador") return ambassadorLevels;
  return MANUAL_IDS.includes(id) ? 1 : 3;
}

// Activity titles are kept once reached. Trusted Member and Verified Pet Sitter
// follow the current record, and donor titles the current total.
export function earnedLevels(
  counts: Counts,
  standing: Standing,
  config: TitlesConfig,
  ambassadorMins: number[],
  before: Levels,
): Levels {
  const out: Levels = {};
  const set = (id: TitleId, level: number) => {
    if (level > 0) out[id] = level;
  };
  for (const id of COUNTED_IDS) {
    const level = levelFor(counts[METRIC[id]], config.levels[id]);
    if (id === "trusted") set(id, standing.clean ? level : 0);
    else if (id === "sitter") {
      set(id, standing.sitterRating !== null && standing.sitterRating < SITTER_MIN_RATING ? 0 : level);
    } else set(id, Math.max(level, before[id] ?? 0));
  }
  set("ambassador", Math.max(levelFor(counts.invites, ambassadorMins), before.ambassador ?? 0));
  set("donor", donorLevel(counts.donorCents, config.donorCents));
  return out;
}

// What shows: the higher of earned and given by the team, minus removed or switched-off titles.
export function effectiveLevels(
  earned: Levels,
  granted: Levels,
  revoked: TitleId[],
  config: TitlesConfig,
  ambassadorLevels: number,
): Levels {
  const out: Levels = {};
  for (const id of TITLE_IDS) {
    if (revoked.includes(id) || config.off.includes(id)) continue;
    const level = Math.min(Math.max(earned[id] ?? 0, granted[id] ?? 0), maxLevel(id, ambassadorLevels));
    if (level > 0) out[id] = level;
  }
  return out;
}

export function levelsOf(value: unknown): Levels {
  const out: Levels = {};
  if (typeof value !== "object" || value === null) return out;
  for (const [id, level] of Object.entries(value as Json)) {
    if (isId(id) && typeof level === "number" && Number.isInteger(level) && level > 0) out[id] = level;
  }
  return out;
}

export const idsOf = (value: unknown): TitleId[] => Array.isArray(value) ? value.filter(isId) : [];

export interface Unlock {
  id: TitleId;
  level: number;
}

export function newUnlocks(before: Levels, after: Levels): Unlock[] {
  return TITLE_IDS.filter((id) => (after[id] ?? 0) > (before[id] ?? 0)).map((id) => ({id, level: after[id]!}));
}

// Bonus points for every counted level reached, never for donor or invite titles.
export function bonusAwards(before: Levels, after: Levels, config: TitlesConfig): {key: string; points: number}[] {
  const out: {key: string; points: number}[] = [];
  for (const id of COUNTED_IDS) {
    for (let level = (before[id] ?? 0) + 1; level <= (after[id] ?? 0); level++) {
      const points = config.bonus[level - 1] ?? 0;
      if (points > 0) out.push({key: `${id}_${level}`, points});
    }
  }
  return out;
}

// Special titles first, then the hardest to earn.
export const ORDER: TitleId[] = [
  "team", "partner", "sitter", "rescuer", "volunteer", "contributor", "helper", "advocate", "ambassador", "trusted", "donor",
];

export interface PublicTitles {
  title: Unlock | null;
  tags: Unlock[];
}

export function publicTitles(
  levels: Levels,
  main: TitleId | null,
  hideDonor: boolean,
  ambassadorLevels: number,
): PublicTitles {
  const shown = ORDER
    .filter((id) => (levels[id] ?? 0) > 0 && !(id === "donor" && hideDonor))
    .map((id) => ({id, level: levels[id]!}));
  const score = (t: Unlock) => t.level / maxLevel(t.id, ambassadorLevels);
  const ranked = [...shown].sort((a, b) =>
    (MANUAL_IDS.includes(b.id) ? 1 : 0) - (MANUAL_IDS.includes(a.id) ? 1 : 0) ||
    score(b) - score(a) ||
    ORDER.indexOf(a.id) - ORDER.indexOf(b.id));
  const chosen = ranked.find((t) => t.id === main) ?? ranked[0] ?? null;
  const tags = chosen ? [chosen, ...ranked.filter((t) => t.id !== chosen.id)].slice(0, 3) : [];
  return {title: chosen, tags};
}

// A share counts at most SHARES_PER_DAY times a day.
export function nextShareCount(day: unknown, count: unknown, today: string): number | null {
  if (day !== today) return 1;
  const done = typeof count === "number" ? count : 0;
  return done >= SHARES_PER_DAY ? null : done + 1;
}

type Names = Record<TitleId, string> & {
  donorTiers: string[];
  ambassadorLevels: string[];
  newOne: string;
  newMany: string;
  body: string;
  donorBody: string;
};

const NAMES: Record<string, Names> = {
  en: {
    contributor: "Community Contributor", rescuer: "Animal Rescuer", volunteer: "Active Volunteer",
    advocate: "Animal Advocate", helper: "Community Helper", trusted: "Trusted Member", sitter: "Verified Pet Sitter",
    ambassador: "Ambassador", donor: "Supporter", team: "CodaMi Team", partner: "Partner Shelter",
    donorTiers: ["Supporter", "Bronze Donor", "Silver Donor", "Gold Donor", "Platinum Donor", "Lifetime Supporter"],
    ambassadorLevels: ["Friend of CodaMi", "Ambassador", "Super Ambassador", "Champion"],
    newOne: "🏆 New title: {name}", newMany: "🏆 {count} new titles!",
    body: "Well done! It now shows on your profile. Open CodaMi to see all your titles.",
    donorBody: "Thank you for supporting CodaMi! 💚 Your new title shows on your profile.",
  },
  it: {
    contributor: "Contributore della community", rescuer: "Soccorritore di animali", volunteer: "Volontario attivo",
    advocate: "Difensore degli animali", helper: "Aiutante della community", trusted: "Membro di fiducia",
    sitter: "Pet sitter verificato", ambassador: "Ambasciatore", donor: "Sostenitore", team: "Team CodaMi",
    partner: "Rifugio partner",
    donorTiers: ["Sostenitore", "Donatore Bronzo", "Donatore Argento", "Donatore Oro", "Donatore Platino", "Sostenitore a vita"],
    ambassadorLevels: ["Amico di CodaMi", "Ambasciatore", "Super Ambasciatore", "Campione"],
    newOne: "🏆 Nuovo titolo: {name}", newMany: "🏆 {count} nuovi titoli!",
    body: "Complimenti! Ora si vede sul tuo profilo. Apri CodaMi per vedere tutti i tuoi titoli.",
    donorBody: "Grazie per sostenere CodaMi! 💚 Il tuo nuovo titolo si vede sul profilo.",
  },
  de: {
    contributor: "Community-Unterstützer", rescuer: "Tierretter", volunteer: "Aktiver Helfer",
    advocate: "Tierfürsprecher", helper: "Community-Helfer", trusted: "Vertrauenswürdiges Mitglied",
    sitter: "Verifizierter Tiersitter", ambassador: "Botschafter", donor: "Unterstützer", team: "CodaMi-Team",
    partner: "Partner-Tierheim",
    donorTiers: ["Unterstützer", "Bronze-Spender", "Silber-Spender", "Gold-Spender", "Platin-Spender", "Unterstützer auf Lebenszeit"],
    ambassadorLevels: ["Freund von CodaMi", "Botschafter", "Super-Botschafter", "Champion"],
    newOne: "🏆 Neuer Titel: {name}", newMany: "🏆 {count} neue Titel!",
    body: "Gut gemacht! Er steht jetzt in deinem Profil. Öffne CodaMi, um alle deine Titel zu sehen.",
    donorBody: "Danke, dass du CodaMi unterstützt! 💚 Dein neuer Titel steht in deinem Profil.",
  },
  fr: {
    contributor: "Contributeur de la communauté", rescuer: "Sauveteur d'animaux", volunteer: "Bénévole actif",
    advocate: "Défenseur des animaux", helper: "Aide de la communauté", trusted: "Membre de confiance",
    sitter: "Pet-sitter vérifié", ambassador: "Ambassadeur", donor: "Soutien", team: "Équipe CodaMi",
    partner: "Refuge partenaire",
    donorTiers: ["Soutien", "Donateur Bronze", "Donateur Argent", "Donateur Or", "Donateur Platine", "Soutien à vie"],
    ambassadorLevels: ["Ami de CodaMi", "Ambassadeur", "Super Ambassadeur", "Champion"],
    newOne: "🏆 Nouveau titre : {name}", newMany: "🏆 {count} nouveaux titres !",
    body: "Bravo ! Il s'affiche maintenant sur votre profil. Ouvrez CodaMi pour voir tous vos titres.",
    donorBody: "Merci de soutenir CodaMi ! 💚 Votre nouveau titre s'affiche sur votre profil.",
  },
  es: {
    contributor: "Colaborador de la comunidad", rescuer: "Rescatador de animales", volunteer: "Voluntario activo",
    advocate: "Defensor de los animales", helper: "Ayudante de la comunidad", trusted: "Miembro de confianza",
    sitter: "Cuidador verificado", ambassador: "Embajador", donor: "Colaborador", team: "Equipo CodaMi",
    partner: "Refugio colaborador",
    donorTiers: ["Colaborador", "Donante Bronce", "Donante Plata", "Donante Oro", "Donante Platino", "Colaborador de por vida"],
    ambassadorLevels: ["Amigo de CodaMi", "Embajador", "Súper Embajador", "Campeón"],
    newOne: "🏆 Nuevo título: {name}", newMany: "🏆 ¡{count} títulos nuevos!",
    body: "¡Bien hecho! Ya se ve en tu perfil. Abre CodaMi para ver todos tus títulos.",
    donorBody: "¡Gracias por apoyar a CodaMi! 💚 Tu nuevo título se ve en tu perfil.",
  },
  pt: {
    contributor: "Colaborador da comunidade", rescuer: "Resgatador de animais", volunteer: "Voluntário ativo",
    advocate: "Defensor dos animais", helper: "Ajudante da comunidade", trusted: "Membro de confiança",
    sitter: "Pet sitter verificado", ambassador: "Embaixador", donor: "Apoiador", team: "Equipe CodaMi",
    partner: "Abrigo parceiro",
    donorTiers: ["Apoiador", "Doador Bronze", "Doador Prata", "Doador Ouro", "Doador Platina", "Apoiador vitalício"],
    ambassadorLevels: ["Amigo da CodaMi", "Embaixador", "Super Embaixador", "Campeão"],
    newOne: "🏆 Novo título: {name}", newMany: "🏆 {count} novos títulos!",
    body: "Muito bem! Ele já aparece no seu perfil. Abra a CodaMi para ver todos os seus títulos.",
    donorBody: "Obrigado por apoiar a CodaMi! 💚 Seu novo título aparece no seu perfil.",
  },
  ru: {
    contributor: "Участник сообщества", rescuer: "Спасатель животных", volunteer: "Активный волонтёр",
    advocate: "Защитник животных", helper: "Помощник сообщества", trusted: "Надёжный участник",
    sitter: "Проверенный ситтер", ambassador: "Посол", donor: "Сторонник", team: "Команда CodaMi",
    partner: "Приют-партнёр",
    donorTiers: ["Сторонник", "Бронзовый донор", "Серебряный донор", "Золотой донор", "Платиновый донор", "Сторонник навсегда"],
    ambassadorLevels: ["Друг CodaMi", "Посол", "Супер-посол", "Чемпион"],
    newOne: "🏆 Новый титул: {name}", newMany: "🏆 Новых титулов: {count}!",
    body: "Отлично! Он уже виден в вашем профиле. Откройте CodaMi, чтобы увидеть все титулы.",
    donorBody: "Спасибо за поддержку CodaMi! 💚 Новый титул виден в вашем профиле.",
  },
  zh: {
    contributor: "社区贡献者", rescuer: "动物救助者", volunteer: "积极志愿者", advocate: "动物守护者",
    helper: "社区帮手", trusted: "可信成员", sitter: "认证宠物看护", ambassador: "大使", donor: "支持者",
    team: "CodaMi 团队", partner: "合作救助站",
    donorTiers: ["支持者", "铜牌捐助者", "银牌捐助者", "金牌捐助者", "白金捐助者", "终身支持者"],
    ambassadorLevels: ["CodaMi 之友", "大使", "超级大使", "冠军"],
    newOne: "🏆 新称号：{name}", newMany: "🏆 获得 {count} 个新称号！",
    body: "太棒了！它已显示在你的个人资料上。打开 CodaMi 查看你的所有称号。",
    donorBody: "感谢你支持 CodaMi！💚 你的新称号已显示在个人资料上。",
  },
  ar: {
    contributor: "مساهم في المجتمع", rescuer: "منقذ الحيوانات", volunteer: "متطوع نشط", advocate: "مدافع عن الحيوانات",
    helper: "مساعد المجتمع", trusted: "عضو موثوق", sitter: "مُرافق حيوانات موثّق", ambassador: "سفير", donor: "داعم",
    team: "فريق CodaMi", partner: "ملجأ شريك",
    donorTiers: ["داعم", "متبرع برونزي", "متبرع فضي", "متبرع ذهبي", "متبرع بلاتيني", "داعم مدى الحياة"],
    ambassadorLevels: ["صديق CodaMi", "سفير", "سفير مميز", "بطل"],
    newOne: "🏆 لقب جديد: {name}", newMany: "🏆 {count} ألقاب جديدة!",
    body: "أحسنت! يظهر الآن في ملفك الشخصي. افتح CodaMi لرؤية كل ألقابك.",
    donorBody: "شكرًا لدعمك CodaMi! 💚 يظهر لقبك الجديد في ملفك الشخصي.",
  },
  hi: {
    contributor: "कम्युनिटी योगदानकर्ता", rescuer: "पशु बचावकर्ता", volunteer: "सक्रिय स्वयंसेवक",
    advocate: "पशु हितैषी", helper: "कम्युनिटी सहायक", trusted: "भरोसेमंद सदस्य", sitter: "सत्यापित पेट सिटर",
    ambassador: "एंबेसडर", donor: "समर्थक", team: "CodaMi टीम", partner: "पार्टनर शेल्टर",
    donorTiers: ["समर्थक", "कांस्य दाता", "रजत दाता", "स्वर्ण दाता", "प्लेटिनम दाता", "आजीवन समर्थक"],
    ambassadorLevels: ["CodaMi का दोस्त", "एंबेसडर", "सुपर एंबेसडर", "चैंपियन"],
    newOne: "🏆 नया टाइटल: {name}", newMany: "🏆 {count} नए टाइटल!",
    body: "बहुत बढ़िया! यह अब आपकी प्रोफ़ाइल पर दिखता है। अपने सभी टाइटल देखने के लिए CodaMi खोलें।",
    donorBody: "CodaMi का साथ देने के लिए धन्यवाद! 💚 आपका नया टाइटल आपकी प्रोफ़ाइल पर दिखता है।",
  },
};

export function titleName(lang: string, t: Unlock): string {
  const n = NAMES[lang] ?? NAMES.en;
  if (t.id === "donor") return n.donorTiers[t.level - 1] ?? n.donorTiers[0];
  if (t.id === "ambassador") return n.ambassadorLevels[t.level - 1] ?? n.ambassador;
  if (MANUAL_IDS.includes(t.id)) return n[t.id];
  return `${n[t.id]} ${"★".repeat(t.level)}`;
}

export function unlockText(lang: string, unlocks: Unlock[]): {title: string; body: string} {
  const n = NAMES[lang] ?? NAMES.en;
  const title = unlocks.length === 1 ?
    n.newOne.replace("{name}", titleName(lang, unlocks[0])) :
    n.newMany.replace("{count}", String(unlocks.length));
  return {title, body: unlocks.some((u) => u.id === "donor") ? n.donorBody : n.body};
}

export interface DonationInput {
  uid: string;
  cents: number;
  note: string;
}

export function donationOf(data: unknown): DonationInput | null {
  const input = typeof data === "object" && data !== null ? data as Json : {};
  const {uid, cents, note} = input;
  if (typeof uid !== "string" || !/^[A-Za-z0-9_-]{1,128}$/.test(uid)) return null;
  if (typeof cents !== "number" || !Number.isInteger(cents) || cents < 1 || cents > 10_000_000) return null;
  return {uid, cents, note: typeof note === "string" ? note.trim().slice(0, 200) : ""};
}

export interface GrantInput {
  uid: string;
  id: TitleId;
  // 0 takes the title away; null gives it back after it was taken away.
  level: number | null;
}

export function grantOf(data: unknown, ambassadorLevels: number): GrantInput | null {
  const input = typeof data === "object" && data !== null ? data as Json : {};
  const {uid, id, level} = input;
  if (typeof uid !== "string" || !/^[A-Za-z0-9_-]{1,128}$/.test(uid) || !isId(id)) return null;
  if (level === null) return {uid, id, level: null};
  if (typeof level !== "number" || !Number.isInteger(level) || level < 0 || level > maxLevel(id, ambassadorLevels)) {
    return null;
  }
  return {uid, id, level};
}

// The app always sends both: the chosen main title (null for automatic) and the donor switch.
export function prefsOf(data: unknown): {main: TitleId | null; hideDonor: boolean} | null {
  const input = typeof data === "object" && data !== null ? data as Json : {};
  if (input.main != null && !isId(input.main)) return null;
  if (typeof input.hideDonor !== "boolean") return null;
  return {main: isId(input.main) ? input.main : null, hideDonor: input.hideDonor};
}
