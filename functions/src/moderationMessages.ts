// Push texts for photo moderation. Server only, so they are not in the app's .arb files.

export type ModerationMessageKey =
  | "reviewTitle"
  | "reviewBody"
  | "hiddenTitle"
  | "hiddenBody"
  | "removedTitle"
  | "removedBody"
  | "restoredTitle"
  | "restoredBody";

export const MODERATION_MESSAGES: Record<string, Record<ModerationMessageKey, string>> = {
  en: {
    reviewTitle: "Photos to review",
    reviewBody: "{count} photos need a moderator's decision.",
    hiddenTitle: "Your photo is being checked",
    hiddenBody: "One of your photos is hidden until our team has checked it.",
    removedTitle: "Photo removed",
    removedBody: "One of your photos was removed because it breaks the CodaMi rules.",
    restoredTitle: "Your photo is back",
    restoredBody: "Our team checked your photo and it is visible again.",
  },
  it: {
    reviewTitle: "Foto da controllare",
    reviewBody: "{count} foto aspettano la decisione di un moderatore.",
    hiddenTitle: "Stiamo controllando la tua foto",
    hiddenBody: "Una delle tue foto è nascosta finché il nostro team non l'avrà controllata.",
    removedTitle: "Foto rimossa",
    removedBody: "Una delle tue foto è stata rimossa perché non rispetta le regole di CodaMi.",
    restoredTitle: "La tua foto è di nuovo visibile",
    restoredBody: "Il nostro team ha controllato la tua foto ed è di nuovo visibile.",
  },
  es: {
    reviewTitle: "Fotos por revisar",
    reviewBody: "{count} fotos esperan la decisión de un moderador.",
    hiddenTitle: "Estamos revisando tu foto",
    hiddenBody: "Una de tus fotos está oculta hasta que nuestro equipo la revise.",
    removedTitle: "Foto eliminada",
    removedBody: "Una de tus fotos se ha eliminado porque no cumple las normas de CodaMi.",
    restoredTitle: "Tu foto vuelve a estar visible",
    restoredBody: "Nuestro equipo ha revisado tu foto y vuelve a estar visible.",
  },
  fr: {
    reviewTitle: "Photos à vérifier",
    reviewBody: "{count} photos attendent la décision d'un modérateur.",
    hiddenTitle: "Votre photo est en cours de vérification",
    hiddenBody: "Une de vos photos est masquée jusqu'à ce que notre équipe l'ait vérifiée.",
    removedTitle: "Photo supprimée",
    removedBody: "Une de vos photos a été supprimée car elle ne respecte pas les règles de CodaMi.",
    restoredTitle: "Votre photo est de nouveau visible",
    restoredBody: "Notre équipe a vérifié votre photo et elle est de nouveau visible.",
  },
  de: {
    reviewTitle: "Fotos zu prüfen",
    reviewBody: "{count} Fotos warten auf die Entscheidung eines Moderators.",
    hiddenTitle: "Dein Foto wird geprüft",
    hiddenBody: "Eines deiner Fotos ist ausgeblendet, bis unser Team es geprüft hat.",
    removedTitle: "Foto entfernt",
    removedBody: "Eines deiner Fotos wurde entfernt, weil es gegen die Regeln von CodaMi verstößt.",
    restoredTitle: "Dein Foto ist wieder sichtbar",
    restoredBody: "Unser Team hat dein Foto geprüft und es ist wieder sichtbar.",
  },
  pt: {
    reviewTitle: "Fotos para rever",
    reviewBody: "{count} fotos aguardam a decisão de um moderador.",
    hiddenTitle: "A tua foto está a ser verificada",
    hiddenBody: "Uma das tuas fotos está oculta até a nossa equipa a verificar.",
    removedTitle: "Foto removida",
    removedBody: "Uma das tuas fotos foi removida porque não cumpre as regras do CodaMi.",
    restoredTitle: "A tua foto está de volta",
    restoredBody: "A nossa equipa verificou a tua foto e ela está visível novamente.",
  },
  ru: {
    reviewTitle: "Фото на проверку",
    reviewBody: "Фото, ожидающих решения модератора: {count}.",
    hiddenTitle: "Ваше фото проверяется",
    hiddenBody: "Одно из ваших фото скрыто, пока наша команда его не проверит.",
    removedTitle: "Фото удалено",
    removedBody: "Одно из ваших фото удалено, так как оно нарушает правила CodaMi.",
    restoredTitle: "Ваше фото снова видно",
    restoredBody: "Наша команда проверила ваше фото, и оно снова видно.",
  },
  ar: {
    reviewTitle: "صور بحاجة إلى مراجعة",
    reviewBody: "{count} صور بانتظار قرار المشرف.",
    hiddenTitle: "يجري التحقق من صورتك",
    hiddenBody: "إحدى صورك مخفية حتى يتحقق منها فريقنا.",
    removedTitle: "تمت إزالة الصورة",
    removedBody: "تمت إزالة إحدى صورك لأنها تخالف قواعد CodaMi.",
    restoredTitle: "صورتك ظاهرة من جديد",
    restoredBody: "تحقق فريقنا من صورتك وأصبحت ظاهرة من جديد.",
  },
  zh: {
    reviewTitle: "待审核的照片",
    reviewBody: "有 {count} 张照片等待管理员处理。",
    hiddenTitle: "你的照片正在审核",
    hiddenBody: "你的一张照片已被暂时隐藏，等待我们的团队审核。",
    removedTitle: "照片已移除",
    removedBody: "你的一张照片因违反 CodaMi 规则已被移除。",
    restoredTitle: "你的照片已恢复",
    restoredBody: "我们的团队已审核你的照片，现在可以再次显示。",
  },
  hi: {
    reviewTitle: "जाँच के लिए फ़ोटो",
    reviewBody: "{count} फ़ोटो मॉडरेटर के फ़ैसले का इंतज़ार कर रही हैं।",
    hiddenTitle: "आपकी फ़ोटो की जाँच हो रही है",
    hiddenBody: "आपकी एक फ़ोटो तब तक छिपी रहेगी जब तक हमारी टीम उसकी जाँच नहीं कर लेती।",
    removedTitle: "फ़ोटो हटाई गई",
    removedBody: "आपकी एक फ़ोटो हटा दी गई क्योंकि वह CodaMi के नियमों के ख़िलाफ़ है।",
    restoredTitle: "आपकी फ़ोटो फिर से दिख रही है",
    restoredBody: "हमारी टीम ने आपकी फ़ोटो की जाँच की और अब वह फिर से दिख रही है।",
  },
};

export function moderationText(
  lang: string,
  key: ModerationMessageKey,
  vars: Record<string, string> = {},
): string {
  const messages = MODERATION_MESSAGES[lang] ?? MODERATION_MESSAGES.en;
  return messages[key].replace(/\{(\w+)\}/g, (match, name: string) => vars[name] ?? match);
}
