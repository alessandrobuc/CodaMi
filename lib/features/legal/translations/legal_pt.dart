import '../legal_content.dart';

const privacyPt = [
  LegalSection(
    "Quem somos",
    "A CodaMi ajuda vizinhos a encontrar animais perdidos e a devolver às suas famílias os animais encontrados. O responsável pelo tratamento é a CodaMi. Pode contactar-nos a qualquer momento através do botão no fim desta página.",
  ),
  LegalSection(
    "Que dados recolhemos",
    "• Conta: o seu nome, endereço de email e palavra-passe. As palavras-passe são geridas pelo Firebase Authentication e nunca as vemos. Se iniciar sessão com a Google ou a Apple, recebemos deles o seu nome, email e fotografia de perfil.\n"
        "• Perfil: a sua cidade, o idioma escolhido e, se o adicionar a um alerta, o seu número de telefone.\n"
        "• Animais: os dados que introduz (nome, espécie, raça, cor, sexo, idade, sinais particulares) e as respetivas fotografias.\n"
        "• Alertas: dados do animal, fotografias, descrição, data e hora, a zona onde o animal foi perdido ou encontrado e os contactos que escolher mostrar.\n"
        "• Notificações: um identificador do dispositivo para lhe enviarmos alertas e a lista de alertas recebidos.\n"
        "• Localização: apenas quando toca em «Usar a minha localização» ou «A minha localização». É usada no seu telemóvel para colocar o marcador e não é guardada isoladamente.",
  ),
  LegalSection(
    "Como protegemos as localizações",
    "Antes de um alerta ser guardado, a localização é deslocada para um ponto aleatório num raio de cerca de 100 m e os números de porta são removidos dos nomes das ruas. As outras pessoas só veem uma zona de cerca de 100 m, nunca a sua morada exata.",
  ),
  LegalSection(
    "Para que usamos os seus dados",
    "• Para pôr a CodaMi a funcionar: criar a sua conta, mostrar alertas no mapa e em listas e permitir que as pessoas se contactem por causa de um animal (execução do nosso acordo consigo).\n"
        "• Para lhe enviar alertas quando um animal é perdido ou encontrado na sua cidade. Pode desativá-los nas definições do telemóvel.\n"
        "• Para manter a CodaMi segura e prevenir abusos (o nosso interesse legítimo).\n"
        "• Para cumprir a lei, quando necessário.",
  ),
  LegalSection(
    "Quem pode ver os seus dados",
    "• Os alertas são visíveis para todos os utilizadores com sessão iniciada na CodaMi: dados do animal, fotografias, descrição, zona aproximada, o seu nome e os contactos que escolheu partilhar.\n"
        "• Os perfis dos seus animais, o seu email e a sua cidade são privados.\n"
        "• Não vendemos os seus dados nem mostramos publicidade.",
  ),
  LegalSection(
    "Prestadores de serviços",
    "Usamos o Google Firebase (Authentication, Cloud Firestore, Cloud Storage, Cloud Functions e Cloud Messaging) para guardar dados e enviar notificações, e a Google Maps Platform para mapas e pesquisa de locais. O início de sessão com a Google e com a Apple é fornecido pela Google e pela Apple. Estes prestadores tratam os dados em nosso nome. Parte do tratamento pode ocorrer fora da União Europeia, protegido pelas Cláusulas Contratuais-Tipo da Comissão Europeia.",
  ),
  LegalSection(
    "Durante quanto tempo os guardamos",
    "Guardamos os seus dados enquanto a sua conta existir. Os alertas continuam visíveis até os eliminar ou eliminar a conta. Quando elimina a conta, o seu perfil, animais, alertas, fotografias e credenciais de acesso são apagados dos nossos sistemas.",
  ),
  LegalSection(
    "Os seus direitos",
    "Ao abrigo do RGPD, pode aceder aos seus dados, retificá-los ou apagá-los, limitar ou opor-se à sua utilização, receber uma cópia e retirar o consentimento a qualquer momento. Escreva-nos através do botão no fim desta página. Pode também apresentar reclamação à autoridade italiana de proteção de dados (Garante per la protezione dei dati personali, www.garanteprivacy.it).",
  ),
  LegalSection(
    "Eliminar a conta",
    "Pode eliminar a sua conta a qualquer momento na app: Perfil → Eliminar conta. Isto remove permanentemente o seu perfil, animais, alertas, fotografias e credenciais de acesso.",
  ),
  LegalSection(
    "Crianças",
    "A CodaMi não se destina a menores de 14 anos. Se soubermos que um menor de 14 anos criou uma conta, iremos eliminá-la.",
  ),
  LegalSection(
    "Segurança",
    "Os dados são enviados através de ligações encriptadas. As regras de acesso garantem que só o próprio pode alterar os seus animais e alertas e que só utilizadores com sessão iniciada podem ver os alertas.",
  ),
  LegalSection(
    "Alterações a esta política",
    "Se fizermos alterações importantes, iremos informá-lo na app antes de entrarem em vigor.",
  ),
];

const termsPt = [
  LegalSection(
    "Sobre a CodaMi",
    "A CodaMi é uma app comunitária gratuita que ajuda as pessoas a assinalar animais perdidos e encontrados e a entrar em contacto umas com as outras. Ao criar uma conta, aceita estes termos.",
  ),
  LegalSection(
    "A sua conta",
    "• Tem de ter pelo menos 14 anos.\n"
        "• Forneça informações corretas e mantenha a sua palavra-passe em segurança.\n"
        "• É responsável pelo que acontece na sua conta.",
  ),
  LegalSection(
    "Alertas e fotografias",
    "• Publique apenas alertas verdadeiros sobre animais realmente perdidos ou encontrados.\n"
        "• Carregue apenas fotografias tiradas por si ou que tenha o direito de usar.\n"
        "• Mantenha os seus alertas atualizados e marque-os como resolvidos quando o animal estiver em segurança.\n"
        "• Não inclua dados pessoais de outras pessoas nem moradas exatas.",
  ),
  LegalSection(
    "O que não é permitido",
    "• Alertas falsos, enganosos ou duplicados.\n"
        "• Vender, comprar ou doar animais.\n"
        "• Spam, publicidade, burlas ou pedidos de dinheiro.\n"
        "• Assédio, ameaças, discurso de ódio ou conteúdos ofensivos.\n"
        "• Usar os contactos de alguém para outro fim que não seja ajudar o seu animal.\n"
        "• Copiar dados da CodaMi de forma automática ou tentar violar a sua segurança.",
  ),
  LegalSection(
    "Encontros e devolução de animais",
    "A CodaMi não verifica os utilizadores nem as informações que partilham. Encontrem-se em locais públicos, peça uma prova de propriedade (fotografias, boletim veterinário, microchip) antes de entregar um animal e contacte a polícia ou as autoridades locais se algo lhe parecer errado. Qualquer acordo ou encontro é entre si e a outra pessoa.",
  ),
  LegalSection(
    "O seu conteúdo",
    "As fotografias e os textos que publica continuam a ser seus. Autoriza-nos a guardá-los e mostrá-los na CodaMi para que a app funcione. Quando elimina um alerta ou a sua conta, deixamos de mostrar esse conteúdo.",
  ),
  LegalSection(
    "Moderação",
    "Podemos remover conteúdos ou suspender contas que violem estes termos ou ponham pessoas ou animais em risco.",
  ),
  LegalSection(
    "Sem garantias",
    "Esforçamo-nos por manter a CodaMi disponível e correta, mas é fornecida «tal como está». Não podemos garantir que um animal seja encontrado nem que as informações partilhadas pelos utilizadores estejam corretas.",
  ),
  LegalSection(
    "Responsabilidade",
    "Na medida permitida por lei, não somos responsáveis por danos indiretos nem pelo comportamento de outros utilizadores. Nada nestes termos limita os seus direitos enquanto consumidor ao abrigo da lei italiana e da UE.",
  ),
  LegalSection(
    "Eliminar a conta",
    "Pode deixar de usar a CodaMi e eliminar a sua conta a qualquer momento: Perfil → Eliminar conta.",
  ),
  LegalSection(
    "Alterações a estes termos",
    "Se fizermos alterações importantes, iremos informá-lo na app antes de entrarem em vigor.",
  ),
  LegalSection(
    "Lei aplicável e contacto",
    "Estes termos regem-se pela lei italiana. Se for consumidor, pode também recorrer aos tribunais do local onde reside. Dúvidas? Escreva-nos através do botão no fim desta página.",
  ),
];
