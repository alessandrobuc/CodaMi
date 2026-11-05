import {shiftDay} from "./points";

type Json = Record<string, unknown>;

export const NEVER = "9999-12-31";
// Users who shared this recently, or haven't opened the app for this long, are skipped.
export const RECENT_SHARE_DAYS = 14;
export const INACTIVE_DAYS = 60;

export interface ShareReminderConfig {
  enabled: boolean;
  firstDays: number;
  everyDays: number;
  maxCount: number;
}

const intIn = (v: unknown, min: number, max: number, fallback: number) =>
  typeof v === "number" && Number.isInteger(v) && v >= min && v <= max ? v : fallback;

export function shareReminderConfigOf(data: Json | undefined): ShareReminderConfig {
  return {
    enabled: data?.enabled === true,
    firstDays: intIn(data?.firstDays, 1, 60, 3),
    everyDays: intIn(data?.everyDays, 3, 60, 7),
    maxCount: intIn(data?.maxCount, 1, 52, 8),
  };
}

// The first reminder, a few days after sign-up; never in the past.
export function firstReminderDay(signupDay: string, today: string, c: ShareReminderConfig): string {
  const day = shiftDay(signupDay, c.firstDays);
  return day < today ? today : day;
}

export interface ReminderState {
  next: string;
  count: number;
  lastSharedDay: string | null;
}

export interface UserFacts {
  exists: boolean;
  disabled: boolean;
  optedOut: boolean;
  lastActiveDay: string | null;
}

export type ReminderDecision =
  | {action: "delete"}
  | {action: "stop"}
  | {action: "skip"; next: string; reason: "opted_out" | "inactive" | "shared"}
  | {action: "send"; variant: number; next: string; count: number};

export function decideReminder(r: ReminderState, u: UserFacts, today: string, c: ShareReminderConfig): ReminderDecision {
  if (!u.exists || u.disabled) return {action: "delete"};
  if (r.count >= c.maxCount) return {action: "stop"};
  const later = shiftDay(today, c.everyDays);
  if (u.optedOut) return {action: "skip", next: later, reason: "opted_out"};
  if (!u.lastActiveDay || u.lastActiveDay < shiftDay(today, -INACTIVE_DAYS)) {
    return {action: "skip", next: later, reason: "inactive"};
  }
  if (r.lastSharedDay && r.lastSharedDay > shiftDay(today, -RECENT_SHARE_DAYS)) {
    return {action: "skip", next: later, reason: "shared"};
  }
  return {action: "send", variant: r.count % VARIANTS, next: later, count: r.count + 1};
}

const VARIANTS = 4;

// Variant 0 is the client's own text.
const TEXTS: Record<string, [string, string][]> = {
  en: [
    ["Help CodaMi make a difference! 🐾", "Sharing our app costs you nothing, but your support can have an enormous impact on our community and help more animals find their way home. Share CodaMi with your friends and on your social networks!"],
    ["More neighbours, more pets back home 🏡", "Every new neighbour on CodaMi means more eyes looking for lost pets. Invite a friend today!"],
    ["A 10-second favour for the animals 🐶🐱", "Send CodaMi to one friend or share it in a group. It's free and it really helps lost pets."],
    ["You can help a pet get home ❤️", "The more people use CodaMi in your area, the faster lost pets are found. Share it with your friends!"],
  ],
  it: [
    ["Aiuta CodaMi a fare la differenza! 🐾", "Condividere la nostra app non ti costa nulla, ma il tuo aiuto può avere un impatto enorme sulla nostra comunità e aiutare più animali a tornare a casa. Condividi CodaMi con i tuoi amici e sui tuoi social!"],
    ["Più vicini, più animali a casa 🏡", "Ogni nuovo vicino su CodaMi significa più occhi che cercano gli animali smarriti. Invita un amico oggi!"],
    ["Un favore di 10 secondi per gli animali 🐶🐱", "Manda CodaMi a un amico o condividila in un gruppo. È gratis e aiuta davvero gli animali smarriti."],
    ["Puoi aiutare un animale a tornare a casa ❤️", "Più persone usano CodaMi nella tua zona, più in fretta si ritrovano gli animali smarriti. Condividila con i tuoi amici!"],
  ],
  de: [
    ["Hilf CodaMi, etwas zu bewirken! 🐾", "Unsere App zu teilen kostet dich nichts, aber deine Unterstützung kann viel für unsere Gemeinschaft bewirken und mehr Tieren helfen, nach Hause zu finden. Teile CodaMi mit deinen Freunden und in deinen sozialen Netzwerken!"],
    ["Mehr Nachbarn, mehr Tiere zu Hause 🏡", "Jeder neue Nachbar bei CodaMi bedeutet mehr Augen, die nach vermissten Tieren suchen. Lade heute einen Freund ein!"],
    ["Ein 10-Sekunden-Gefallen für die Tiere 🐶🐱", "Schick CodaMi an einen Freund oder teile es in einer Gruppe. Es ist kostenlos und hilft vermissten Tieren wirklich."],
    ["Du kannst einem Tier nach Hause helfen ❤️", "Je mehr Menschen in deiner Gegend CodaMi nutzen, desto schneller werden vermisste Tiere gefunden. Teile es mit deinen Freunden!"],
  ],
  fr: [
    ["Aidez CodaMi à faire la différence ! 🐾", "Partager notre appli ne vous coûte rien, mais votre soutien peut avoir un impact énorme sur notre communauté et aider plus d'animaux à rentrer chez eux. Partagez CodaMi avec vos amis et sur vos réseaux sociaux !"],
    ["Plus de voisins, plus d'animaux à la maison 🏡", "Chaque nouveau voisin sur CodaMi, ce sont plus d'yeux pour retrouver les animaux perdus. Invitez un ami aujourd'hui !"],
    ["Un service de 10 secondes pour les animaux 🐶🐱", "Envoyez CodaMi à un ami ou partagez-la dans un groupe. C'est gratuit et ça aide vraiment les animaux perdus."],
    ["Vous pouvez aider un animal à rentrer ❤️", "Plus il y a de monde sur CodaMi près de chez vous, plus vite les animaux perdus sont retrouvés. Partagez-la avec vos amis !"],
  ],
  es: [
    ["¡Ayuda a CodaMi a marcar la diferencia! 🐾", "Compartir nuestra app no te cuesta nada, pero tu apoyo puede tener un impacto enorme en nuestra comunidad y ayudar a más animales a volver a casa. ¡Comparte CodaMi con tus amigos y en tus redes sociales!"],
    ["Más vecinos, más mascotas en casa 🏡", "Cada nuevo vecino en CodaMi son más ojos buscando mascotas perdidas. ¡Invita a un amigo hoy!"],
    ["Un favor de 10 segundos para los animales 🐶🐱", "Envía CodaMi a un amigo o compártela en un grupo. Es gratis y de verdad ayuda a las mascotas perdidas."],
    ["Puedes ayudar a una mascota a volver a casa ❤️", "Cuanta más gente usa CodaMi en tu zona, antes aparecen las mascotas perdidas. ¡Compártela con tus amigos!"],
  ],
  pt: [
    ["Ajude a CodaMi a fazer a diferença! 🐾", "Compartilhar o nosso app não custa nada, mas o seu apoio pode ter um impacto enorme na nossa comunidade e ajudar mais animais a voltar para casa. Compartilhe a CodaMi com seus amigos e nas suas redes sociais!"],
    ["Mais vizinhos, mais pets em casa 🏡", "Cada novo vizinho na CodaMi são mais olhos procurando pets perdidos. Convide um amigo hoje!"],
    ["Um favor de 10 segundos para os animais 🐶🐱", "Envie a CodaMi para um amigo ou compartilhe num grupo. É grátis e ajuda de verdade os pets perdidos."],
    ["Você pode ajudar um pet a voltar para casa ❤️", "Quanto mais pessoas usam a CodaMi na sua região, mais rápido os pets perdidos são encontrados. Compartilhe com seus amigos!"],
  ],
  ru: [
    ["Помогите CodaMi изменить мир к лучшему! 🐾", "Поделиться нашим приложением вам ничего не стоит, а ваша поддержка может очень помочь нашему сообществу и вернуть домой больше животных. Поделитесь CodaMi с друзьями и в соцсетях!"],
    ["Больше соседей — больше питомцев дома 🏡", "Каждый новый сосед в CodaMi — это ещё одни глаза, которые ищут потерявшихся питомцев. Пригласите друга сегодня!"],
    ["10 секунд доброго дела для животных 🐶🐱", "Отправьте CodaMi другу или поделитесь в группе. Это бесплатно и правда помогает потерявшимся питомцам."],
    ["Вы можете помочь питомцу вернуться домой ❤️", "Чем больше людей в вашем районе пользуются CodaMi, тем быстрее находят потерявшихся питомцев. Поделитесь с друзьями!"],
  ],
  zh: [
    ["帮助 CodaMi 带来改变！🐾", "分享我们的应用不花你一分钱，但你的支持能给我们的社区带来巨大的影响，帮助更多动物回家。把 CodaMi 分享给朋友和你的社交网络吧！"],
    ["邻居越多，回家的宠物越多 🏡", "CodaMi 上每多一位邻居，就多一双寻找走失宠物的眼睛。今天就邀请一位朋友吧！"],
    ["为动物们花 10 秒钟 🐶🐱", "把 CodaMi 发给一位朋友或分享到群里。它是免费的，真的能帮助走失的宠物。"],
    ["你可以帮助一只宠物回家 ❤️", "你所在地区使用 CodaMi 的人越多，走失的宠物就越快被找到。分享给你的朋友吧！"],
  ],
  ar: [
    ["ساعد CodaMi على إحداث فرق! 🐾", "مشاركة تطبيقنا لا تكلفك شيئًا، لكن دعمك قد يُحدث أثرًا كبيرًا في مجتمعنا ويساعد المزيد من الحيوانات على العودة إلى البيت. شارك CodaMi مع أصدقائك وعلى شبكاتك الاجتماعية!"],
    ["جيران أكثر، حيوانات أكثر في البيت 🏡", "كل جار جديد على CodaMi يعني عيونًا أكثر تبحث عن الحيوانات الضائعة. ادعُ صديقًا اليوم!"],
    ["معروف من 10 ثوانٍ للحيوانات 🐶🐱", "أرسل CodaMi إلى صديق أو شاركه في مجموعة. إنه مجاني ويساعد الحيوانات الضائعة حقًا."],
    ["يمكنك مساعدة حيوان على العودة إلى البيت ❤️", "كلما زاد عدد مستخدمي CodaMi في منطقتك، عُثر على الحيوانات الضائعة أسرع. شاركه مع أصدقائك!"],
  ],
  hi: [
    ["CodaMi को बदलाव लाने में मदद करें! 🐾", "हमारा ऐप शेयर करने में आपका कुछ खर्च नहीं होता, लेकिन आपका साथ हमारी कम्युनिटी पर बड़ा असर डाल सकता है और ज़्यादा जानवरों को घर लौटने में मदद कर सकता है। CodaMi को अपने दोस्तों और सोशल नेटवर्क पर शेयर करें!"],
    ["ज़्यादा पड़ोसी, ज़्यादा पालतू घर पर 🏡", "CodaMi पर हर नया पड़ोसी मतलब खोए पालतू जानवरों को ढूँढने वाली और आँखें। आज ही किसी दोस्त को बुलाएँ!"],
    ["जानवरों के लिए 10 सेकंड की मदद 🐶🐱", "CodaMi किसी दोस्त को भेजें या किसी ग्रुप में शेयर करें। यह मुफ़्त है और सच में खोए पालतू जानवरों की मदद करता है।"],
    ["आप किसी पालतू को घर पहुँचाने में मदद कर सकते हैं ❤️", "आपके इलाके में जितने ज़्यादा लोग CodaMi इस्तेमाल करेंगे, खोए पालतू उतनी जल्दी मिलेंगे। अपने दोस्तों के साथ शेयर करें!"],
  ],
};

export function reminderText(lang: string, variant: number): {title: string; body: string} {
  const list = TEXTS[lang] ?? TEXTS.en;
  const [title, body] = list[variant % list.length];
  return {title, body};
}

export const SHARE_EVENTS = ["opened", "shared"];
