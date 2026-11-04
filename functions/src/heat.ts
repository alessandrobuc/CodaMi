import {isDayKey, shiftDay} from "./points";

type Json = Record<string, unknown>;

export const REMINDER_DAYS = [1, 3, 7, 14];

export interface HeatReminder {
  ownerId: string;
  petId: string;
  petName: string;
  nextStart: string;
  cycleDays: number;
  daysBefore: number;
}

export function heatReminderOf(data: Json | undefined): HeatReminder | null {
  if (!data) return null;
  const {ownerId, petId, petName, nextStart, cycleDays, daysBefore} = data;
  if (typeof ownerId !== "string" || typeof petId !== "string" || !isDayKey(nextStart)) return null;
  if (typeof cycleDays !== "number" || !Number.isInteger(cycleDays) || cycleDays < 7 || cycleDays > 400) return null;
  if (!REMINDER_DAYS.includes(daysBefore as number)) return null;
  return {
    ownerId,
    petId,
    petName: typeof petName === "string" ? petName.slice(0, 60) : "",
    nextStart,
    cycleDays,
    daysBefore: daysBefore as number,
  };
}

export interface ReminderStep {
  // The expected start the owner is reminded of today, if any.
  remindFor: string | null;
  nextStart: string;
  remindOn: string;
}

// Missed days are skipped, never sent late; after a reminder the next cycle is planned.
export function stepReminder(r: HeatReminder, today: string): ReminderStep {
  let nextStart = r.nextStart;
  const remindOf = (start: string) => shiftDay(start, -r.daysBefore);
  while (remindOf(nextStart) < today) nextStart = shiftDay(nextStart, r.cycleDays);
  const remindFor = remindOf(nextStart) === today ? nextStart : null;
  if (remindFor) nextStart = shiftDay(nextStart, r.cycleDays);
  return {remindFor, nextStart, remindOn: remindOf(nextStart)};
}

type HeatKey = "title" | "body";

const HEAT_MESSAGES: Record<string, Record<HeatKey, string>> = {
  en: {title: "{pet}: heat expected soon", body: "{pet}'s next heat may start around {date}. This is an estimate based on past cycles."},
  it: {title: "{pet}: calore in arrivo", body: "Il prossimo calore di {pet} potrebbe iniziare intorno al {date}. È una stima basata sui cicli precedenti."},
  de: {title: "{pet}: Läufigkeit bald erwartet", body: "Die nächste Läufigkeit von {pet} könnte um den {date} beginnen. Das ist eine Schätzung aus den bisherigen Zyklen."},
  fr: {title: "{pet} : chaleurs bientôt attendues", body: "Les prochaines chaleurs de {pet} pourraient commencer vers le {date}. C'est une estimation basée sur les cycles précédents."},
  es: {title: "{pet}: celo previsto pronto", body: "El próximo celo de {pet} podría empezar hacia el {date}. Es una estimación basada en los ciclos anteriores."},
  pt: {title: "{pet}: cio previsto em breve", body: "O próximo cio de {pet} pode começar por volta de {date}. É uma estimativa baseada nos ciclos anteriores."},
  ru: {title: "{pet}: скоро ожидается течка", body: "Следующая течка у {pet} может начаться около {date}. Это оценка по прошлым циклам."},
  zh: {title: "{pet}：发情期即将到来", body: "{pet} 的下一次发情期可能在 {date} 左右开始。这是根据以往周期的估计。"},
  ar: {title: "{pet}: الشياع متوقع قريبًا", body: "قد يبدأ الشياع التالي لـ {pet} في حوالي {date}. هذا تقدير بناءً على الدورات السابقة."},
  hi: {title: "{pet}: हीट जल्द आने की उम्मीद", body: "{pet} की अगली हीट लगभग {date} के आसपास शुरू हो सकती है। यह पिछले चक्रों पर आधारित अनुमान है।"},
};

export function heatText(lang: string, key: HeatKey, pet: string, day: string): string {
  const messages = HEAT_MESSAGES[lang] ?? HEAT_MESSAGES.en;
  const date = new Intl.DateTimeFormat(HEAT_MESSAGES[lang] ? lang : "en", {
    day: "numeric",
    month: "long",
    timeZone: "UTC",
  }).format(new Date(`${day}T12:00:00Z`));
  return messages[key].replace(/\{pet\}/g, pet).replace(/\{date\}/g, date);
}
