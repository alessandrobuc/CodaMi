type Json = Record<string, unknown>;

// Must match FeedbackType, FeedbackArea and FeedbackStatus in lib/features/feedback/domain/feedback.dart.
export const FEEDBACK_TYPES = ["suggestion", "bug", "problem", "improvement", "general"] as const;
export const FEEDBACK_AREAS = [
  "general", "reports", "map", "walks", "sitting", "schedule", "heat", "scanner", "shop", "sharing",
] as const;
export const FEEDBACK_STATUSES = ["new", "in_progress", "done"] as const;
export type FeedbackType = (typeof FEEDBACK_TYPES)[number];
export type FeedbackArea = (typeof FEEDBACK_AREAS)[number];
export type FeedbackStatus = (typeof FEEDBACK_STATUSES)[number];

export const FEEDBACK_COMMENT_MAX = 1000;
export const FEEDBACK_NOTE_MAX = 500;
export const FEEDBACK_PER_DAY = 5;

export interface Feedback {
  type: FeedbackType;
  area: FeedbackArea;
  // 0 when the user gave no stars.
  rating: number;
  comment: string;
  asked: boolean;
  screenshotPath: string | null;
}

const pick = <T extends string>(list: readonly T[], value: unknown, fallback: T): T =>
  typeof value === "string" && (list as readonly string[]).includes(value) ? value as T : fallback;

// Stars or a few words are needed; a screenshot must be in the sender's own folder.
export function feedbackOf(data: unknown, uid: string): Feedback | null {
  const input = typeof data === "object" && data !== null ? data as Json : {};
  const raw = input.rating ?? 0;
  if (typeof raw !== "number" || !Number.isInteger(raw) || raw < 0 || raw > 5) return null;
  const comment = typeof input.comment === "string" ? input.comment.trim() : "";
  if (comment.length > FEEDBACK_COMMENT_MAX) return null;
  if (raw === 0 && comment.length < 3) return null;
  const path = input.screenshotPath;
  const screenshotPath = typeof path === "string" &&
    path.startsWith(`feedback/${uid}/`) && /^feedback\/[^/]+\/[0-9]{1,16}\.(jpg|png)$/.test(path) ?
    path : null;
  if (path != null && path !== "" && screenshotPath === null) return null;
  return {
    type: pick(FEEDBACK_TYPES, input.type, "general"),
    area: pick(FEEDBACK_AREAS, input.area, "general"),
    rating: raw,
    comment,
    asked: input.asked === true,
    screenshotPath,
  };
}

// How many were sent today, counting the one being sent; null once the daily limit is reached.
export function nextDayCount(lastDay: unknown, lastCount: unknown, today: string): number | null {
  if (lastDay !== today) return 1;
  const sent = typeof lastCount === "number" && lastCount > 0 ? lastCount : 1;
  return sent >= FEEDBACK_PER_DAY ? null : sent + 1;
}

export interface FeedbackUpdate {
  id: string;
  status: FeedbackStatus | null;
  note: string | null;
  notify: boolean;
}

export function feedbackUpdateOf(data: unknown): FeedbackUpdate | null {
  const input = typeof data === "object" && data !== null ? data as Json : {};
  const id = input.id;
  if (typeof id !== "string" || !/^[A-Za-z0-9_-]{1,64}$/.test(id)) return null;
  const status = input.status == null ? null : pick(FEEDBACK_STATUSES, input.status, "new");
  if (input.status != null && status !== input.status) return null;
  const note = typeof input.note === "string" ? input.note.trim().slice(0, FEEDBACK_NOTE_MAX) : null;
  if (status === null && note === null) return null;
  return {id, status, note, notify: input.notify === true};
}

export type ThanksKind = "fixed" | "idea";

// Bugs and problems are "fixed"; suggestions and the rest are "ideas" that made it in.
export const thanksKindOf = (type: unknown): ThanksKind =>
  type === "bug" || type === "problem" ? "fixed" : "idea";

const THANKS: Record<string, Record<ThanksKind, [string, string]>> = {
  en: {
    fixed: ["Thanks, we fixed it! 🛠️", "The problem you told us about in CodaMi has been fixed. Thank you for helping us make the app better! 🐾"],
    idea: ["Your idea is in CodaMi! 💡", "We worked on the feedback you sent us. Thank you for helping us make CodaMi better! 🐾"],
  },
  it: {
    fixed: ["Grazie, l'abbiamo risolto! 🛠️", "Il problema che ci hai segnalato su CodaMi è stato risolto. Grazie per aiutarci a migliorare l'app! 🐾"],
    idea: ["La tua idea è su CodaMi! 💡", "Abbiamo lavorato sul suggerimento che ci hai mandato. Grazie per aiutarci a migliorare CodaMi! 🐾"],
  },
  de: {
    fixed: ["Danke, wir haben es behoben! 🛠️", "Das Problem, das du uns in CodaMi gemeldet hast, ist behoben. Danke, dass du hilfst, die App besser zu machen! 🐾"],
    idea: ["Deine Idee ist in CodaMi! 💡", "Wir haben an deinem Feedback gearbeitet. Danke, dass du hilfst, CodaMi besser zu machen! 🐾"],
  },
  fr: {
    fixed: ["Merci, c'est corrigé ! 🛠️", "Le problème que vous nous avez signalé dans CodaMi a été corrigé. Merci de nous aider à améliorer l'appli ! 🐾"],
    idea: ["Votre idée est dans CodaMi ! 💡", "Nous avons travaillé sur votre avis. Merci de nous aider à améliorer CodaMi ! 🐾"],
  },
  es: {
    fixed: ["¡Gracias, ya está arreglado! 🛠️", "El problema que nos contaste en CodaMi ya está solucionado. ¡Gracias por ayudarnos a mejorar la app! 🐾"],
    idea: ["¡Tu idea está en CodaMi! 💡", "Trabajamos en la opinión que nos enviaste. ¡Gracias por ayudarnos a mejorar CodaMi! 🐾"],
  },
  pt: {
    fixed: ["Obrigado, já corrigimos! 🛠️", "O problema que você nos contou na CodaMi foi corrigido. Obrigado por nos ajudar a melhorar o app! 🐾"],
    idea: ["Sua ideia está na CodaMi! 💡", "Trabalhamos na opinião que você nos enviou. Obrigado por nos ajudar a melhorar a CodaMi! 🐾"],
  },
  ru: {
    fixed: ["Спасибо, мы это исправили! 🛠️", "Проблема, о которой вы сообщили в CodaMi, исправлена. Спасибо, что помогаете делать приложение лучше! 🐾"],
    idea: ["Ваша идея теперь в CodaMi! 💡", "Мы поработали над вашим отзывом. Спасибо, что помогаете делать CodaMi лучше! 🐾"],
  },
  zh: {
    fixed: ["谢谢，我们已经修好了！🛠️", "你在 CodaMi 中反馈的问题已经修复。感谢你帮助我们把应用做得更好！🐾"],
    idea: ["你的想法已加入 CodaMi！💡", "我们已经根据你的反馈做了改进。感谢你帮助我们把 CodaMi 做得更好！🐾"],
  },
  ar: {
    fixed: ["شكرًا، أصلحنا المشكلة! 🛠️", "تم إصلاح المشكلة التي أخبرتنا عنها في CodaMi. شكرًا لمساعدتنا على تحسين التطبيق! 🐾"],
    idea: ["فكرتك أصبحت في CodaMi! 💡", "عملنا على الملاحظات التي أرسلتها. شكرًا لمساعدتنا على تحسين CodaMi! 🐾"],
  },
  hi: {
    fixed: ["धन्यवाद, हमने इसे ठीक कर दिया! 🛠️", "CodaMi में आपने जो समस्या बताई थी, वह ठीक हो गई है। ऐप को बेहतर बनाने में मदद के लिए धन्यवाद! 🐾"],
    idea: ["आपका आइडिया CodaMi में है! 💡", "आपकी भेजी राय पर हमने काम किया है। CodaMi को बेहतर बनाने में मदद के लिए धन्यवाद! 🐾"],
  },
};

export function thanksText(lang: string, kind: ThanksKind): {title: string; body: string} {
  const [title, body] = (THANKS[lang] ?? THANKS.en)[kind];
  return {title, body};
}
