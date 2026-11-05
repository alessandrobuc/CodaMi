type Json = Record<string, unknown>;

// Must match ShareTarget in lib/features/sharing/domain/sharing.dart.
export const SHARE_TARGETS = ["whatsapp", "facebook", "instagram", "tiktok", "more", "save", "copy", "qr"];
export const SHARE_KINDS = ["announce", "reunited"];
export const LANGS = ["en", "it", "de", "fr", "es", "pt", "ru", "zh", "ar", "hi"];
export const SITE = "https://codami-cd91e.web.app";
export const PLAY_URL = "https://play.google.com/store/apps/details?id=com.codami.app";
const ID = /^[A-Za-z0-9_-]{1,128}$/;

export function shareInputOf(data: unknown): {reportId: string; target: string; kind: string} | null {
  const d = (typeof data === "object" && data !== null ? data : {}) as Json;
  const {reportId, target, kind} = d;
  if (typeof reportId !== "string" || !ID.test(reportId)) return null;
  if (typeof target !== "string" || !SHARE_TARGETS.includes(target)) return null;
  if (typeof kind !== "string" || !SHARE_KINDS.includes(kind)) return null;
  return {reportId, target, kind};
}

export function reportIdOfPath(path: string): string | null {
  const id = /^\/r\/([^/?#]+)\/?$/.exec(path)?.[1] ?? null;
  return id && ID.test(id) ? id : null;
}

// The sharer's language travels in the link (?l=it), so previews match the post.
export function pageLangOf(query: unknown, acceptLanguage: unknown): string {
  if (typeof query === "string" && LANGS.includes(query)) return query;
  if (typeof acceptLanguage === "string") {
    for (const part of acceptLanguage.split(",")) {
      const code = part.trim().slice(0, 2).toLowerCase();
      if (LANGS.includes(code)) return code;
    }
  }
  return "en";
}

export function viewSourceOf(s: unknown): string {
  return typeof s === "string" && SHARE_TARGETS.includes(s) ? s : "direct";
}

// Link previews fetch the page too; they aren't visitors.
export function isBot(userAgent: unknown): boolean {
  return typeof userAgent !== "string" ||
    /bot|crawl|spider|facebookexternalhit|whatsapp|telegram|slack|discord|preview|embed/i.test(userAgent);
}

export interface PageReport {
  id: string;
  type: "lost" | "found";
  status: "open" | "resolved" | "closed";
  petName: string;
  species: "dog" | "cat" | "other";
  description: string;
  city: string;
  placeDetail: string | null;
  near: boolean;
  eventAt: string;
  reward: number | null;
  photos: string[];
}

// Only what the public may see: no phone, email, owner or exact position.
export function pageReportOf(id: string, data: Json | undefined, photos: string[]): PageReport | null {
  if (!data || data.status === "hidden") return null;
  const status = data.status === "resolved" || data.status === "closed" ? data.status : "open";
  const species = data.species === "dog" || data.species === "cat" ? data.species : "other";
  const reward = typeof data.reward === "number" && data.reward > 0 && data.type !== "found" && status === "open" ?
    Math.round(data.reward) : null;
  return {
    id,
    type: data.type === "found" ? "found" : "lost",
    status,
    petName: typeof data.petName === "string" ? data.petName.trim().slice(0, 60) : "",
    species,
    description: typeof data.description === "string" ? data.description.trim().slice(0, 1500) : "",
    city: typeof data.city === "string" ? data.city.slice(0, 80) : "",
    placeDetail: typeof data.placeDetail === "string" && data.placeDetail.trim() ? data.placeDetail.trim().slice(0, 80) : null,
    near: typeof data.areaRadius === "number",
    eventAt: typeof data.eventAt === "string" ? data.eventAt : "",
    reward,
    photos: photos.slice(0, 5),
  };
}

type Key =
  | "lost" | "found" | "home" | "reunited" | "lostOn" | "foundOn" | "near"
  | "dog" | "cat" | "other" | "reward"
  | "helpLost" | "helpFound" | "homeTitle" | "homeText" | "closed"
  | "open" | "play" | "appStore" | "soon" | "share" | "copied"
  | "goneTitle" | "goneText" | "tagline" | "privacy"
  | "ogLost" | "ogFound" | "ogDescLost" | "ogDescFound" | "ogHome";

const T: Record<string, Record<Key, string>> = {
  en: {
    lost: "LOST", found: "FOUND", home: "BACK HOME", reunited: "REUNITED", lostOn: "Lost on {date}", foundOn: "Found on {date}", near: "near {place}, {city}",
    dog: "Dog", cat: "Cat", other: "Pet", reward: "Reward {amount}",
    helpLost: "Seen {name}? Open CodaMi to message the owner. Your phone number stays private.",
    helpFound: "Is this your pet? Open CodaMi to message the person who found it.",
    homeTitle: "{name} is back home! 🎉", homeText: "Thank you to everyone who shared and helped.", closed: "This report is closed.",
    open: "Open in CodaMi", play: "Get it on Google Play", appStore: "Download on the App Store", soon: "Coming soon on the App Store",
    share: "Share this page", copied: "Link copied",
    goneTitle: "This report is no longer available", goneText: "It may have been resolved or removed. CodaMi helps lost pets find their way home.",
    tagline: "Helping lost pets find their way home", privacy: "Contact happens in the CodaMi app. No phone numbers or exact addresses are shown here.",
    ogLost: "LOST: {name} · {species} · {city}", ogFound: "FOUND: {species} · {city}", ogDescLost: "Lost on {date}, {place}. Please share and help {name} get home.",
    ogDescFound: "Found on {date}, {place}. Do you know the owner? Please share.", ogHome: "{name} is back home thanks to CodaMi! 🎉",
  },
  it: {
    lost: "SMARRITO", found: "TROVATO", home: "A CASA", reunited: "RIUNITI", lostOn: "Smarrito il {date}", foundOn: "Trovato il {date}", near: "vicino a {place}, {city}",
    dog: "Cane", cat: "Gatto", other: "Animale", reward: "Ricompensa {amount}",
    helpLost: "Hai visto {name}? Apri CodaMi per scrivere al proprietario. Il tuo numero resta privato.",
    helpFound: "È il tuo animale? Apri CodaMi per scrivere a chi l'ha trovato.",
    homeTitle: "{name} è tornato a casa! 🎉", homeText: "Grazie a tutti quelli che hanno condiviso e aiutato.", closed: "Questa segnalazione è chiusa.",
    open: "Apri in CodaMi", play: "Scarica su Google Play", appStore: "Scarica su App Store", soon: "Presto su App Store",
    share: "Condividi questa pagina", copied: "Link copiato",
    goneTitle: "Questa segnalazione non è più disponibile", goneText: "Potrebbe essere stata risolta o rimossa. CodaMi aiuta gli animali smarriti a tornare a casa.",
    tagline: "Aiutiamo gli animali smarriti a tornare a casa", privacy: "Il contatto avviene nell'app CodaMi. Qui non compaiono numeri di telefono né indirizzi esatti.",
    ogLost: "SMARRITO: {name} · {species} · {city}", ogFound: "TROVATO: {species} · {city}", ogDescLost: "Smarrito il {date}, {place}. Condividi e aiuta {name} a tornare a casa.",
    ogDescFound: "Trovato il {date}, {place}. Conosci il proprietario? Condividi.", ogHome: "{name} è tornato a casa grazie a CodaMi! 🎉",
  },
  de: {
    lost: "VERMISST", found: "GEFUNDEN", home: "WIEDER ZU HAUSE", reunited: "WIEDERVEREINT", lostOn: "Vermisst seit {date}", foundOn: "Gefunden am {date}", near: "bei {place}, {city}",
    dog: "Hund", cat: "Katze", other: "Tier", reward: "Belohnung {amount}",
    helpLost: "{name} gesehen? Öffne CodaMi, um dem Besitzer zu schreiben. Deine Nummer bleibt privat.",
    helpFound: "Ist das dein Tier? Öffne CodaMi, um dem Finder zu schreiben.",
    homeTitle: "{name} ist wieder zu Hause! 🎉", homeText: "Danke an alle, die geteilt und geholfen haben.", closed: "Diese Meldung ist geschlossen.",
    open: "In CodaMi öffnen", play: "Bei Google Play laden", appStore: "Im App Store laden", soon: "Bald im App Store",
    share: "Seite teilen", copied: "Link kopiert",
    goneTitle: "Diese Meldung ist nicht mehr verfügbar", goneText: "Sie wurde vielleicht gelöst oder entfernt. CodaMi hilft vermissten Tieren nach Hause.",
    tagline: "Wir helfen vermissten Tieren nach Hause", privacy: "Der Kontakt läuft über die CodaMi-App. Hier stehen keine Telefonnummern oder genauen Adressen.",
    ogLost: "VERMISST: {name} · {species} · {city}", ogFound: "GEFUNDEN: {species} · {city}", ogDescLost: "Vermisst seit {date}, {place}. Bitte teilen und {name} nach Hause helfen.",
    ogDescFound: "Gefunden am {date}, {place}. Kennst du den Besitzer? Bitte teilen.", ogHome: "{name} ist dank CodaMi wieder zu Hause! 🎉",
  },
  fr: {
    lost: "PERDU", found: "TROUVÉ", home: "DE RETOUR", reunited: "RÉUNIS", lostOn: "Perdu le {date}", foundOn: "Trouvé le {date}", near: "près de {place}, {city}",
    dog: "Chien", cat: "Chat", other: "Animal", reward: "Récompense {amount}",
    helpLost: "Vu {name} ? Ouvrez CodaMi pour écrire au propriétaire. Votre numéro reste privé.",
    helpFound: "C'est votre animal ? Ouvrez CodaMi pour écrire à la personne qui l'a trouvé.",
    homeTitle: "{name} est rentré à la maison ! 🎉", homeText: "Merci à tous ceux qui ont partagé et aidé.", closed: "Ce signalement est clos.",
    open: "Ouvrir dans CodaMi", play: "Disponible sur Google Play", appStore: "Télécharger dans l'App Store", soon: "Bientôt sur l'App Store",
    share: "Partager cette page", copied: "Lien copié",
    goneTitle: "Ce signalement n'est plus disponible", goneText: "Il a peut-être été résolu ou supprimé. CodaMi aide les animaux perdus à rentrer chez eux.",
    tagline: "Aider les animaux perdus à rentrer chez eux", privacy: "Le contact se fait dans l'appli CodaMi. Aucun numéro ni adresse exacte n'apparaît ici.",
    ogLost: "PERDU : {name} · {species} · {city}", ogFound: "TROUVÉ : {species} · {city}", ogDescLost: "Perdu le {date}, {place}. Partagez et aidez {name} à rentrer.",
    ogDescFound: "Trouvé le {date}, {place}. Vous connaissez le propriétaire ? Partagez.", ogHome: "{name} est rentré grâce à CodaMi ! 🎉",
  },
  es: {
    lost: "PERDIDO", found: "ENCONTRADO", home: "EN CASA", reunited: "REUNIDOS", lostOn: "Perdido el {date}", foundOn: "Encontrado el {date}", near: "cerca de {place}, {city}",
    dog: "Perro", cat: "Gato", other: "Mascota", reward: "Recompensa {amount}",
    helpLost: "¿Has visto a {name}? Abre CodaMi para escribir al dueño. Tu número queda privado.",
    helpFound: "¿Es tu mascota? Abre CodaMi para escribir a quien la encontró.",
    homeTitle: "¡{name} ha vuelto a casa! 🎉", homeText: "Gracias a todos los que compartieron y ayudaron.", closed: "Este aviso está cerrado.",
    open: "Abrir en CodaMi", play: "Disponible en Google Play", appStore: "Descargar en App Store", soon: "Próximamente en App Store",
    share: "Compartir esta página", copied: "Enlace copiado",
    goneTitle: "Este aviso ya no está disponible", goneText: "Puede que se haya resuelto o eliminado. CodaMi ayuda a las mascotas perdidas a volver a casa.",
    tagline: "Ayudamos a las mascotas perdidas a volver a casa", privacy: "El contacto se hace en la app CodaMi. Aquí no aparecen teléfonos ni direcciones exactas.",
    ogLost: "PERDIDO: {name} · {species} · {city}", ogFound: "ENCONTRADO: {species} · {city}", ogDescLost: "Perdido el {date}, {place}. Comparte y ayuda a {name} a volver a casa.",
    ogDescFound: "Encontrado el {date}, {place}. ¿Conoces al dueño? Comparte.", ogHome: "¡{name} ha vuelto a casa gracias a CodaMi! 🎉",
  },
  pt: {
    lost: "PERDIDO", found: "ENCONTRADO", home: "EM CASA", reunited: "REUNIDOS", lostOn: "Perdido em {date}", foundOn: "Encontrado em {date}", near: "perto de {place}, {city}",
    dog: "Cão", cat: "Gato", other: "Pet", reward: "Recompensa {amount}",
    helpLost: "Viu {name}? Abra a CodaMi para falar com o dono. O seu número fica privado.",
    helpFound: "É o seu pet? Abra a CodaMi para falar com quem o encontrou.",
    homeTitle: "{name} voltou para casa! 🎉", homeText: "Obrigado a todos que compartilharam e ajudaram.", closed: "Este aviso está encerrado.",
    open: "Abrir na CodaMi", play: "Disponível no Google Play", appStore: "Baixar na App Store", soon: "Em breve na App Store",
    share: "Compartilhar esta página", copied: "Link copiado",
    goneTitle: "Este aviso já não está disponível", goneText: "Pode ter sido resolvido ou removido. A CodaMi ajuda pets perdidos a voltar para casa.",
    tagline: "Ajudamos pets perdidos a voltar para casa", privacy: "O contato acontece no app CodaMi. Aqui não aparecem telefones nem endereços exatos.",
    ogLost: "PERDIDO: {name} · {species} · {city}", ogFound: "ENCONTRADO: {species} · {city}", ogDescLost: "Perdido em {date}, {place}. Compartilhe e ajude {name} a voltar para casa.",
    ogDescFound: "Encontrado em {date}, {place}. Conhece o dono? Compartilhe.", ogHome: "{name} voltou para casa graças à CodaMi! 🎉",
  },
  ru: {
    lost: "ПОТЕРЯН", found: "НАЙДЕН", home: "СНОВА ДОМА", reunited: "ВМЕСТЕ", lostOn: "Потерян {date}", foundOn: "Найден {date}", near: "рядом: {place}, {city}",
    dog: "Собака", cat: "Кошка", other: "Питомец", reward: "Вознаграждение {amount}",
    helpLost: "Видели {name}? Откройте CodaMi, чтобы написать хозяину. Ваш номер останется скрытым.",
    helpFound: "Это ваш питомец? Откройте CodaMi, чтобы написать тому, кто его нашёл.",
    homeTitle: "{name} снова дома! 🎉", homeText: "Спасибо всем, кто делился и помогал.", closed: "Это объявление закрыто.",
    open: "Открыть в CodaMi", play: "Доступно в Google Play", appStore: "Загрузить в App Store", soon: "Скоро в App Store",
    share: "Поделиться страницей", copied: "Ссылка скопирована",
    goneTitle: "Это объявление больше недоступно", goneText: "Возможно, оно решено или удалено. CodaMi помогает потерявшимся питомцам вернуться домой.",
    tagline: "Помогаем потерявшимся питомцам вернуться домой", privacy: "Связь — в приложении CodaMi. Здесь нет номеров телефонов и точных адресов.",
    ogLost: "ПОТЕРЯН: {name} · {species} · {city}", ogFound: "НАЙДЕН: {species} · {city}", ogDescLost: "Потерян {date}, {place}. Поделитесь и помогите {name} вернуться домой.",
    ogDescFound: "Найден {date}, {place}. Знаете хозяина? Поделитесь.", ogHome: "{name} снова дома благодаря CodaMi! 🎉",
  },
  zh: {
    lost: "走失", found: "捡到", home: "已回家", reunited: "已团聚", lostOn: "{date} 走失", foundOn: "{date} 捡到", near: "{city} {place} 附近",
    dog: "狗", cat: "猫", other: "宠物", reward: "酬谢 {amount}",
    helpLost: "见过 {name} 吗？打开 CodaMi 给主人发消息，你的电话号码不会公开。",
    helpFound: "这是你的宠物吗？打开 CodaMi 给捡到它的人发消息。",
    homeTitle: "{name} 回家了！🎉", homeText: "感谢所有帮忙转发和帮助的人。", closed: "此报告已关闭。",
    open: "在 CodaMi 中打开", play: "在 Google Play 下载", appStore: "在 App Store 下载", soon: "即将登陆 App Store",
    share: "分享此页面", copied: "链接已复制",
    goneTitle: "此报告已不可用", goneText: "它可能已经解决或被删除。CodaMi 帮助走失的宠物回家。",
    tagline: "帮助走失的宠物回家", privacy: "联系在 CodaMi 应用内进行。这里不会显示电话号码或详细地址。",
    ogLost: "走失：{name} · {species} · {city}", ogFound: "捡到：{species} · {city}", ogDescLost: "{date} 在 {place} 走失。请帮忙转发，帮助 {name} 回家。",
    ogDescFound: "{date} 在 {place} 捡到。认识主人吗？请帮忙转发。", ogHome: "{name} 在 CodaMi 的帮助下回家了！🎉",
  },
  ar: {
    lost: "مفقود", found: "تم العثور عليه", home: "عاد إلى البيت", reunited: "اجتمع شمله", lostOn: "فُقد في {date}", foundOn: "عُثر عليه في {date}", near: "قرب {place}، {city}",
    dog: "كلب", cat: "قطة", other: "حيوان أليف", reward: "مكافأة {amount}",
    helpLost: "هل رأيت {name}؟ افتح CodaMi لمراسلة صاحبه. يبقى رقمك خاصًا.",
    helpFound: "هل هذا حيوانك؟ افتح CodaMi لمراسلة من عثر عليه.",
    homeTitle: "عاد {name} إلى البيت! 🎉", homeText: "شكرًا لكل من شارك وساعد.", closed: "هذا البلاغ مغلق.",
    open: "افتح في CodaMi", play: "احصل عليه من Google Play", appStore: "نزّله من App Store", soon: "قريبًا على App Store",
    share: "شارك هذه الصفحة", copied: "تم نسخ الرابط",
    goneTitle: "هذا البلاغ لم يعد متاحًا", goneText: "ربما تم حله أو حذفه. يساعد CodaMi الحيوانات الضائعة على العودة إلى البيت.",
    tagline: "نساعد الحيوانات الضائعة على العودة إلى البيت", privacy: "التواصل يتم داخل تطبيق CodaMi. لا تظهر هنا أرقام هواتف أو عناوين دقيقة.",
    ogLost: "مفقود: {name} · {species} · {city}", ogFound: "تم العثور على: {species} · {city}", ogDescLost: "فُقد في {date}، {place}. شارك وساعد {name} على العودة إلى البيت.",
    ogDescFound: "عُثر عليه في {date}، {place}. هل تعرف صاحبه؟ شارك من فضلك.", ogHome: "عاد {name} إلى البيت بفضل CodaMi! 🎉",
  },
  hi: {
    lost: "खोया", found: "मिला", home: "घर लौटा", reunited: "फिर साथ", lostOn: "{date} को खोया", foundOn: "{date} को मिला", near: "{place}, {city} के पास",
    dog: "कुत्ता", cat: "बिल्ली", other: "पालतू", reward: "इनाम {amount}",
    helpLost: "{name} को देखा? मालिक को मैसेज करने के लिए CodaMi खोलें। आपका नंबर निजी रहता है।",
    helpFound: "क्या यह आपका पालतू है? जिसने इसे पाया उसे मैसेज करने के लिए CodaMi खोलें।",
    homeTitle: "{name} घर लौट आया! 🎉", homeText: "शेयर और मदद करने वाले सभी लोगों का धन्यवाद।", closed: "यह रिपोर्ट बंद है।",
    open: "CodaMi में खोलें", play: "Google Play पर पाएं", appStore: "App Store से डाउनलोड करें", soon: "जल्द ही App Store पर",
    share: "यह पेज शेयर करें", copied: "लिंक कॉपी हो गया",
    goneTitle: "यह रिपोर्ट अब उपलब्ध नहीं है", goneText: "शायद यह सुलझ गई या हटा दी गई। CodaMi खोए पालतू जानवरों को घर पहुँचाने में मदद करता है।",
    tagline: "खोए पालतू जानवरों को घर पहुँचाने में मदद", privacy: "संपर्क CodaMi ऐप में होता है। यहाँ कोई फ़ोन नंबर या सटीक पता नहीं दिखता।",
    ogLost: "खोया: {name} · {species} · {city}", ogFound: "मिला: {species} · {city}", ogDescLost: "{date} को {place} में खोया। कृपया शेयर करें और {name} को घर लाने में मदद करें।",
    ogDescFound: "{date} को {place} में मिला। क्या आप मालिक को जानते हैं? कृपया शेयर करें।", ogHome: "CodaMi की मदद से {name} घर लौट आया! 🎉",
  },
};

export function esc(text: string): string {
  return text.replace(/[&<>"']/g, (c) => ({"&": "&amp;", "<": "&lt;", ">": "&gt;", "\"": "&quot;", "'": "&#39;"})[c]!);
}

function fill(text: string, values: Record<string, string>): string {
  return text.replace(/\{(\w+)\}/g, (m, k: string) => values[k] ?? m);
}

export function pageTexts(lang: string): Record<Key, string> {
  return T[lang] ?? T.en;
}

function dateOf(iso: string, lang: string): string {
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return "";
  return new Intl.DateTimeFormat(lang, {day: "numeric", month: "long", timeZone: "Europe/Rome"}).format(d);
}

function placeOf(r: PageReport, t: Record<Key, string>): string {
  if (!r.placeDetail) return r.city;
  return r.near ? fill(t.near, {place: r.placeDetail, city: r.city}) : `${r.placeDetail}, ${r.city}`;
}

export interface PageMeta {
  title: string;
  description: string;
  badge: string;
}

export function pageMetaOf(r: PageReport, lang: string): PageMeta {
  const t = pageTexts(lang);
  const species = t[r.species];
  const name = r.petName || species;
  const values = {name, species, city: r.city, date: dateOf(r.eventAt, lang), place: placeOf(r, t)};
  if (r.status === "resolved") {
    return {title: fill(t.ogHome, values), description: t.homeText, badge: r.type === "lost" ? t.home : t.reunited};
  }
  const lost = r.type === "lost";
  let description = fill(lost ? t.ogDescLost : t.ogDescFound, values);
  if (r.reward) description = `${description} ${fill(t.reward, {amount: euro(r.reward, lang)})}.`;
  return {title: fill(lost ? t.ogLost : t.ogFound, values), description, badge: lost ? t.lost : t.found};
}

function euro(amount: number, lang: string): string {
  return new Intl.NumberFormat(lang, {style: "currency", currency: "EUR", maximumFractionDigits: 0}).format(amount);
}

const STYLE = `
  :root { --primary: #1F6F5B; --dark: #145244; --accent: #F4A261; --reward: #9A4A0C; --lost: #C2410C; --text: #102A23; --muted: #5C736C; --bg: #F6F8F7; --border: #D7E3DE; }
  * { box-sizing: border-box; }
  body { margin: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; background: var(--bg); color: var(--text); }
  main { max-width: 480px; margin: 0 auto; padding: 16px 16px 40px; }
  header { display: flex; align-items: center; gap: 10px; margin: 4px 0 16px; }
  header img { width: 40px; height: 40px; border-radius: 12px; }
  header b { font-size: 18px; color: var(--dark); display: block; }
  header small { color: var(--muted); font-size: 12px; }
  .card { background: #fff; border: 1px solid var(--border); border-radius: 24px; overflow: hidden; }
  .photos { position: relative; display: flex; overflow-x: auto; scroll-snap-type: x mandatory; aspect-ratio: 1; background: linear-gradient(135deg, var(--primary), var(--dark)); }
  .slide { position: relative; flex: 0 0 100%; overflow: hidden; scroll-snap-align: start; }
  .slide img { position: absolute; inset: 0; width: 100%; height: 100%; }
  .slide .fill { object-fit: cover; filter: blur(22px) brightness(.85); transform: scale(1.15); }
  .slide .pet { object-fit: contain; }
  .paw { flex: 0 0 100%; display: flex; align-items: center; justify-content: center; font-size: 96px; opacity: .35; }
  .badge { position: absolute; top: 14px; inset-inline-start: 14px; padding: 6px 14px; border-radius: 20px; border: 2px solid #fff; color: #fff; font-weight: 900; letter-spacing: 1px; font-size: 15px; }
  .count { position: absolute; bottom: 12px; inset-inline-end: 12px; background: rgba(0,0,0,.55); color: #fff; padding: 3px 10px; border-radius: 12px; font-size: 12px; }
  .body { padding: 18px; }
  h1 { font-size: 28px; margin: 0 0 10px; line-height: 1.15; }
  .chips { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 12px; }
  .chip { background: var(--bg); border: 1px solid var(--border); border-radius: 14px; padding: 6px 10px; font-size: 13.5px; }
  .chip.reward { background: rgba(244,162,97,.2); border-color: transparent; color: var(--reward); font-weight: 800; }
  p { line-height: 1.55; margin: 0 0 12px; white-space: pre-line; }
  .help { margin-top: 14px; padding: 14px; border-radius: 18px; background: rgba(31,111,91,.08); color: var(--dark); font-weight: 600; line-height: 1.45; }
  .home { margin-top: 14px; padding: 18px; border-radius: 18px; background: var(--primary); color: #fff; text-align: center; }
  .home b { font-size: 20px; display: block; margin-bottom: 4px; }
  .button { display: block; width: 100%; padding: 15px; border-radius: 16px; font-weight: 700; font-size: 16px; text-decoration: none; text-align: center; margin-top: 12px; border: 0; font-family: inherit; cursor: pointer; }
  .primary { background: var(--primary); color: #fff; }
  .secondary { background: #fff; color: var(--text); border: 1px solid var(--border); }
  .disabled { opacity: .5; pointer-events: none; }
  .note { color: var(--muted); font-size: 12.5px; text-align: center; margin-top: 16px; line-height: 1.45; }
  .gone { text-align: center; padding: 28px 18px; }
  .gone div { font-size: 64px; }
  footer { text-align: center; color: var(--muted); font-size: 12px; margin-top: 22px; }
`;

export interface PageOptions {
  lang: string;
  appStoreId: string | null;
  url: string;
}

function buttons(r: PageReport | null, t: Record<Key, string>, o: PageOptions): string {
  const appStore = o.appStoreId ?
    `<a class="button secondary" id="ios" href="https://apps.apple.com/app/id${esc(o.appStoreId)}">${esc(t.appStore)}</a>` :
    `<a class="button secondary disabled" id="ios" href="#">${esc(t.soon)}</a>`;
  const intent = r ?
    `intent://report/${r.id}#Intent;scheme=codami;package=com.codami.app;S.browser_fallback_url=${encodeURIComponent(PLAY_URL)};end` : "";
  return [
    r ? `<a class="button primary" id="open" href="${esc(intent)}" data-scheme="codami://report/${esc(r.id)}">${esc(t.open)}</a>` : "",
    `<a class="button secondary" id="play" href="${PLAY_URL}">${esc(t.play)}</a>`,
    appStore,
    r ? `<button class="button secondary" id="share" type="button">${esc(t.share)}</button>` : "",
  ].join("\n");
}

// One small script: show the right store, open the app, share the page.
function script(t: Record<Key, string>, o: PageOptions): string {
  return `<script>
  const ua = navigator.userAgent || "";
  const android = /Android/i.test(ua);
  const ios = /iPhone|iPad|iPod/i.test(ua) || (navigator.platform === "MacIntel" && navigator.maxTouchPoints > 1);
  const hide = (id) => { const el = document.getElementById(id); if (el) el.style.display = "none"; };
  if (ios) hide("play");
  if (android) hide("ios");
  const open = document.getElementById("open");
  if (open && !android && !ios) hide("open");
  if (open && ios) open.addEventListener("click", (e) => {
    e.preventDefault();
    location.href = open.dataset.scheme;
    const store = document.getElementById("ios").href;
    setTimeout(() => { if (!document.hidden && store && store !== "#") location.href = store; }, 1500);
  });
  const share = document.getElementById("share");
  if (share) share.addEventListener("click", async () => {
    const url = ${JSON.stringify(o.url)};
    try {
      if (navigator.share) await navigator.share({title: document.title, url});
      else { await navigator.clipboard.writeText(url); share.textContent = ${JSON.stringify(t.copied)}; }
    } catch (_) {}
  });
</script>`;
}

export function renderReportPage(r: PageReport | null, o: PageOptions): string {
  const t = pageTexts(o.lang);
  const dir = o.lang === "ar" ? " dir=\"rtl\"" : "";
  const head = (title: string, description: string, image: string) => `<!doctype html>
<html lang="${o.lang}"${dir}>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${esc(title)}</title>
<meta name="description" content="${esc(description)}">
<meta property="og:type" content="website">
<meta property="og:site_name" content="CodaMi">
<meta property="og:title" content="${esc(title)}">
<meta property="og:description" content="${esc(description)}">
<meta property="og:image" content="${esc(image)}">
<meta property="og:url" content="${esc(o.url)}">
<meta name="twitter:card" content="summary_large_image">
<meta name="theme-color" content="#1F6F5B">
<link rel="icon" href="/icon.png">
<style>${STYLE}</style>
</head>
<body>
<main>
<header><img src="/icon.png" alt=""><div><b>CodaMi</b><small>${esc(t.tagline)}</small></div></header>`;
  const foot = `<p class="note">${esc(t.privacy)}</p>
<footer>© CodaMi</footer>
</main>
${script(t, o)}
</body>
</html>`;

  if (!r) {
    return `${head(t.goneTitle, t.goneText, `${SITE}/icon.png`)}
<div class="card gone"><div>🐾</div><h1>${esc(t.goneTitle)}</h1><p>${esc(t.goneText)}</p></div>
${buttons(null, t, o)}
${foot}`;
  }

  const meta = pageMetaOf(r, o.lang);
  const name = r.petName || t[r.species];
  const values = {name, date: dateOf(r.eventAt, o.lang)};
  const home = r.status === "resolved";
  const color = home || r.type === "found" ? "var(--primary)" : "var(--lost)";
  const photos = r.photos.length > 0 ?
    r.photos.map((p, i) => {
      const lazy = i > 0 ? " loading=\"lazy\"" : "";
      return `<div class="slide"><img class="fill" src="${esc(p)}" alt=""${lazy}><img class="pet" src="${esc(p)}" alt="${esc(name)}"${lazy}></div>`;
    }).join("") :
    "<div class=\"paw\">🐾</div>";
  const chips = [
    `<span class="chip">🐾 ${esc(t[r.species])}</span>`,
    `<span class="chip">📍 ${esc(placeOf(r, t))}</span>`,
    values.date ? `<span class="chip">📅 ${esc(fill(r.type === "lost" ? t.lostOn : t.foundOn, values))}</span>` : "",
    r.reward ? `<span class="chip reward">🎁 ${esc(fill(t.reward, {amount: euro(r.reward, o.lang)}))}</span>` : "",
  ].join("");
  const status = home ?
    `<div class="home"><b>${esc(fill(t.homeTitle, values))}</b>${esc(t.homeText)}</div>` :
    r.status === "closed" ? `<div class="help">${esc(t.closed)}</div>` :
    `<div class="help">${esc(fill(r.type === "lost" ? t.helpLost : t.helpFound, values))}</div>`;

  return `${head(meta.title, meta.description, r.photos[0] ?? `${SITE}/icon.png`)}
<div class="card">
  <div class="photos">${photos}<span class="badge" style="background:${color}">${home ? "🎉 " : ""}${esc(meta.badge)}</span>${r.photos.length > 1 ? `<span class="count">1 / ${r.photos.length}</span>` : ""}</div>
  <div class="body">
    <h1>${esc(name)}</h1>
    <div class="chips">${chips}</div>
    ${r.description ? `<p>${esc(r.description)}</p>` : ""}
    ${status}
  </div>
</div>
${buttons(r, t, o)}
${foot}`;
}
