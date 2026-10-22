// Push texts for points and invites. Server only, so they are not in the app's .arb files.

export type PointsMessageKey =
  | "referralTitle"
  | "referralBody"
  | "levelTitle"
  | "levelBody"
  | "reviewTitle"
  | "reviewBody"
  | "level_supporter"
  | "level_ambassador"
  | "level_super_ambassador"
  | "level_champion";

export const POINTS_MESSAGES: Record<string, Record<PointsMessageKey, string>> = {
  en: {
    referralTitle: "Your friend is now active on CodaMi",
    referralBody: "+{points} points. Thank you for helping CodaMi grow!",
    levelTitle: "New level: {level}",
    levelBody: "+{points} bonus points.",
    reviewTitle: "Invites to review",
    reviewBody: "{count} invites need an admin check.",
    level_supporter: "Supporter",
    level_ambassador: "Ambassador",
    level_super_ambassador: "Super Ambassador",
    level_champion: "CodaMi Champion",
  },
  it: {
    referralTitle: "Il tuo amico ora è attivo su CodaMi",
    referralBody: "+{points} punti. Grazie per aiutare CodaMi a crescere!",
    levelTitle: "Nuovo livello: {level}",
    levelBody: "+{points} punti bonus.",
    reviewTitle: "Inviti da controllare",
    reviewBody: "{count} inviti richiedono un controllo dell'amministratore.",
    level_supporter: "Sostenitore",
    level_ambassador: "Ambasciatore",
    level_super_ambassador: "Super Ambasciatore",
    level_champion: "Campione CodaMi",
  },
  es: {
    referralTitle: "Tu amigo ya está activo en CodaMi",
    referralBody: "+{points} puntos. ¡Gracias por ayudar a CodaMi a crecer!",
    levelTitle: "Nuevo nivel: {level}",
    levelBody: "+{points} puntos extra.",
    reviewTitle: "Invitaciones por revisar",
    reviewBody: "{count} invitaciones necesitan una revisión del administrador.",
    level_supporter: "Colaborador",
    level_ambassador: "Embajador",
    level_super_ambassador: "Superembajador",
    level_champion: "Campeón de CodaMi",
  },
  fr: {
    referralTitle: "Votre ami est maintenant actif sur CodaMi",
    referralBody: "+{points} points. Merci d'aider CodaMi à grandir !",
    levelTitle: "Nouveau niveau : {level}",
    levelBody: "+{points} points bonus.",
    reviewTitle: "Invitations à vérifier",
    reviewBody: "{count} invitations doivent être vérifiées par un administrateur.",
    level_supporter: "Soutien",
    level_ambassador: "Ambassadeur",
    level_super_ambassador: "Super Ambassadeur",
    level_champion: "Champion CodaMi",
  },
  de: {
    referralTitle: "Dein Freund ist jetzt aktiv auf CodaMi",
    referralBody: "+{points} Punkte. Danke, dass du CodaMi beim Wachsen hilfst!",
    levelTitle: "Neue Stufe: {level}",
    levelBody: "+{points} Bonuspunkte.",
    reviewTitle: "Einladungen zu prüfen",
    reviewBody: "{count} Einladungen müssen von einem Admin geprüft werden.",
    level_supporter: "Unterstützer",
    level_ambassador: "Botschafter",
    level_super_ambassador: "Super-Botschafter",
    level_champion: "CodaMi-Champion",
  },
  pt: {
    referralTitle: "O teu amigo já está ativo no CodaMi",
    referralBody: "+{points} pontos. Obrigado por ajudares o CodaMi a crescer!",
    levelTitle: "Novo nível: {level}",
    levelBody: "+{points} pontos de bónus.",
    reviewTitle: "Convites para rever",
    reviewBody: "{count} convites precisam de ser verificados por um administrador.",
    level_supporter: "Apoiante",
    level_ambassador: "Embaixador",
    level_super_ambassador: "Super Embaixador",
    level_champion: "Campeão CodaMi",
  },
  ru: {
    referralTitle: "Ваш друг теперь активен в CodaMi",
    referralBody: "+{points} баллов. Спасибо, что помогаете CodaMi расти!",
    levelTitle: "Новый уровень: {level}",
    levelBody: "+{points} бонусных баллов.",
    reviewTitle: "Приглашения на проверку",
    reviewBody: "Приглашений, которые должен проверить администратор: {count}.",
    level_supporter: "Сторонник",
    level_ambassador: "Посол",
    level_super_ambassador: "Суперпосол",
    level_champion: "Чемпион CodaMi",
  },
  ar: {
    referralTitle: "صديقك أصبح نشطًا على CodaMi",
    referralBody: "+{points} نقطة. شكرًا لمساعدتك CodaMi على النمو!",
    levelTitle: "مستوى جديد: {level}",
    levelBody: "+{points} نقطة إضافية.",
    reviewTitle: "دعوات بحاجة إلى مراجعة",
    reviewBody: "{count} دعوات بحاجة إلى تحقق من المشرف.",
    level_supporter: "داعم",
    level_ambassador: "سفير",
    level_super_ambassador: "سفير متميز",
    level_champion: "بطل CodaMi",
  },
  zh: {
    referralTitle: "你的朋友已在 CodaMi 上活跃",
    referralBody: "+{points} 积分。感谢你帮助 CodaMi 成长！",
    levelTitle: "新等级：{level}",
    levelBody: "+{points} 奖励积分。",
    reviewTitle: "待审核的邀请",
    reviewBody: "有 {count} 个邀请需要管理员检查。",
    level_supporter: "支持者",
    level_ambassador: "大使",
    level_super_ambassador: "超级大使",
    level_champion: "CodaMi 冠军",
  },
  hi: {
    referralTitle: "आपका दोस्त अब CodaMi पर सक्रिय है",
    referralBody: "+{points} पॉइंट। CodaMi को बढ़ाने में मदद के लिए धन्यवाद!",
    levelTitle: "नया स्तर: {level}",
    levelBody: "+{points} बोनस पॉइंट।",
    reviewTitle: "जाँच के लिए निमंत्रण",
    reviewBody: "{count} निमंत्रणों की एडमिन जाँच ज़रूरी है।",
    level_supporter: "समर्थक",
    level_ambassador: "राजदूत",
    level_super_ambassador: "सुपर राजदूत",
    level_champion: "CodaMi चैंपियन",
  },
};

export function pointsText(
  lang: string,
  key: PointsMessageKey,
  vars: Record<string, string> = {},
): string {
  const messages = POINTS_MESSAGES[lang] ?? POINTS_MESSAGES.en;
  return messages[key].replace(/\{(\w+)\}/g, (match, name: string) => vars[name] ?? match);
}
