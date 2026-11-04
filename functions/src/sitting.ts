type Json = Record<string, unknown>;

export interface SittingConfig {
  enabled: boolean;
  // A new account waits this long before it can leave a review.
  minAccountDays: number;
}

export function sittingConfigOf(data: Json | undefined): SittingConfig {
  const days = data?.minAccountDays;
  return {
    enabled: data?.enabled === true,
    minAccountDays: typeof days === "number" && Number.isInteger(days) && days >= 0 && days <= 60 ? days : 3,
  };
}

export const chatIdOf = (a: string, b: string) => (a < b ? `${a}_${b}` : `${b}_${a}`);
export const offerIdOf = (requestId: string, sitterId: string) => `${requestId}_${sitterId}`;

export interface ReviewInput {
  requestId: string;
  stars: number;
  text: string;
}

export function reviewInputOf(data: unknown): ReviewInput | null {
  const d = (typeof data === "object" && data !== null ? data : {}) as Json;
  const {requestId, stars, text} = d;
  if (typeof requestId !== "string" || !/^[A-Za-z0-9_-]{1,128}$/.test(requestId)) return null;
  if (typeof stars !== "number" || !Number.isInteger(stars) || stars < 1 || stars > 5) return null;
  const clean = typeof text === "string" ? text.replace(/\s+/g, " ").trim() : "";
  if (clean.length > 800) return null;
  return {requestId, stars, text: clean};
}

export type ReviewBlock = "not_done" | "not_owner" | "too_new" | "self";

// Only the owner of a service both sides confirmed can review its sitter.
export function reviewBlockOf(
  request: Json | undefined,
  uid: string,
  accountAgeDays: number,
  minAccountDays: number,
): ReviewBlock | null {
  if (!request || request.status !== "done") return "not_done";
  if (request.ownerId !== uid) return "not_owner";
  if (request.sitterId === uid) return "self";
  if (accountAgeDays < minAccountDays) return "too_new";
  return null;
}

export interface Rating {
  ratingSum: number;
  reviewCount: number;
}

export function ratingOf(reviews: Json[]): Rating {
  const shown = reviews.filter((r) => r.hidden !== true && typeof r.stars === "number");
  return {
    ratingSum: shown.reduce((sum, r) => sum + (r.stars as number), 0),
    reviewCount: shown.length,
  };
}

// Both sides confirm, and only once the service has started.
export function confirmStep(
  request: Json | undefined,
  uid: string,
  today: string,
): {field: "ownerConfirmed" | "sitterConfirmed"; done: boolean} | null {
  if (!request || request.status !== "booked") return null;
  if (typeof request.start !== "string" || request.start > today) return null;
  const field = request.ownerId === uid ? "ownerConfirmed" : request.sitterId === uid ? "sitterConfirmed" : null;
  if (!field || request[field] === true) return null;
  const other = field === "ownerConfirmed" ? "sitterConfirmed" : "ownerConfirmed";
  return {field, done: request[other] === true};
}

type SittingKey =
  | "offerTitle" | "offerBody"
  | "acceptedTitle" | "acceptedBody"
  | "confirmTitle" | "confirmBody";

const SITTING_MESSAGES: Record<string, Record<SittingKey, string>> = {
  en: {
    offerTitle: "New pet sitting offer",
    offerBody: "{name} offered to look after your pet. Open CodaMi to see the offer.",
    acceptedTitle: "Your offer was accepted",
    acceptedBody: "{name} chose you as pet sitter. Say hello in the chat.",
    confirmTitle: "Please confirm the pet sitting",
    confirmBody: "{name} confirmed the service was done. Confirm it too to complete it.",
  },
  it: {
    offerTitle: "Nuova offerta di pet sitting",
    offerBody: "{name} si è offerto di occuparsi del tuo animale. Apri CodaMi per vedere l'offerta.",
    acceptedTitle: "La tua offerta è stata accettata",
    acceptedBody: "{name} ti ha scelto come pet sitter. Saluta nella chat.",
    confirmTitle: "Conferma il pet sitting",
    confirmBody: "{name} ha confermato che il servizio è stato svolto. Confermalo anche tu per completarlo.",
  },
  de: {
    offerTitle: "Neues Tiersitting-Angebot",
    offerBody: "{name} möchte auf dein Tier aufpassen. Öffne CodaMi, um das Angebot zu sehen.",
    acceptedTitle: "Dein Angebot wurde angenommen",
    acceptedBody: "{name} hat dich als Tiersitter gewählt. Sag hallo im Chat.",
    confirmTitle: "Bitte bestätige das Tiersitting",
    confirmBody: "{name} hat bestätigt, dass der Service erledigt ist. Bestätige ihn auch, um ihn abzuschließen.",
  },
  fr: {
    offerTitle: "Nouvelle offre de garde",
    offerBody: "{name} propose de s'occuper de votre animal. Ouvrez CodaMi pour voir l'offre.",
    acceptedTitle: "Votre offre a été acceptée",
    acceptedBody: "{name} vous a choisi comme pet-sitter. Dites bonjour dans le chat.",
    confirmTitle: "Confirmez la garde",
    confirmBody: "{name} a confirmé que la garde a eu lieu. Confirmez-la aussi pour la terminer.",
  },
  es: {
    offerTitle: "Nueva oferta de cuidado",
    offerBody: "{name} se ofreció a cuidar de tu mascota. Abre CodaMi para ver la oferta.",
    acceptedTitle: "Han aceptado tu oferta",
    acceptedBody: "{name} te ha elegido como cuidador. Saluda en el chat.",
    confirmTitle: "Confirma el cuidado",
    confirmBody: "{name} confirmó que el servicio se realizó. Confírmalo tú también para completarlo.",
  },
  pt: {
    offerTitle: "Nova oferta de pet sitting",
    offerBody: "{name} ofereceu-se para cuidar do seu animal. Abra a CodaMi para ver a oferta.",
    acceptedTitle: "A sua oferta foi aceite",
    acceptedBody: "{name} escolheu-o como pet sitter. Diga olá no chat.",
    confirmTitle: "Confirme o pet sitting",
    confirmBody: "{name} confirmou que o serviço foi feito. Confirme também para o concluir.",
  },
  ru: {
    offerTitle: "Новое предложение передержки",
    offerBody: "{name} предлагает присмотреть за вашим питомцем. Откройте CodaMi, чтобы посмотреть.",
    acceptedTitle: "Ваше предложение принято",
    acceptedBody: "{name} выбрал(а) вас ситтером. Поздоровайтесь в чате.",
    confirmTitle: "Подтвердите передержку",
    confirmBody: "{name} подтвердил(а), что услуга оказана. Подтвердите тоже, чтобы завершить.",
  },
  zh: {
    offerTitle: "新的宠物照看报价",
    offerBody: "{name} 愿意照看您的宠物。打开 CodaMi 查看报价。",
    acceptedTitle: "您的报价已被接受",
    acceptedBody: "{name} 选择您作为宠物照看者。在聊天中打个招呼吧。",
    confirmTitle: "请确认宠物照看",
    confirmBody: "{name} 已确认服务完成。请您也确认以完成服务。",
  },
  ar: {
    offerTitle: "عرض جديد لرعاية الحيوان",
    offerBody: "عرض {name} رعاية حيوانك الأليف. افتح CodaMi لرؤية العرض.",
    acceptedTitle: "تم قبول عرضك",
    acceptedBody: "اختارك {name} لرعاية حيوانه. ألقِ التحية في الدردشة.",
    confirmTitle: "يرجى تأكيد الرعاية",
    confirmBody: "أكّد {name} أن الخدمة تمت. أكّدها أنت أيضًا لإكمالها.",
  },
  hi: {
    offerTitle: "पेट सिटिंग का नया ऑफ़र",
    offerBody: "{name} ने आपके पालतू की देखभाल का ऑफ़र दिया है। ऑफ़र देखने के लिए CodaMi खोलें।",
    acceptedTitle: "आपका ऑफ़र स्वीकार हो गया",
    acceptedBody: "{name} ने आपको पेट सिटर चुना है। चैट में नमस्ते कहें।",
    confirmTitle: "कृपया पेट सिटिंग की पुष्टि करें",
    confirmBody: "{name} ने पुष्टि की है कि सेवा पूरी हुई। पूरा करने के लिए आप भी पुष्टि करें।",
  },
};

export function sittingText(lang: string, key: SittingKey, name: string): string {
  return (SITTING_MESSAGES[lang] ?? SITTING_MESSAGES.en)[key].replace(/\{name\}/g, name);
}

export const messagePreview = (text: unknown) =>
  typeof text === "string" ? (text.length > 140 ? `${text.slice(0, 139)}…` : text) : "";
