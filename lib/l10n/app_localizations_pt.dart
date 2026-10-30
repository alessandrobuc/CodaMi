// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get navHome => 'Início';

  @override
  String get navPets => 'Animais';

  @override
  String get navProfile => 'Perfil';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get notSet => 'Não definida';

  @override
  String get soon => 'Em breve';

  @override
  String comingSoon(String feature) {
    return '$feature chega em breve.';
  }

  @override
  String get profileTitle => 'Perfil';

  @override
  String get myPets => 'Os meus animais';

  @override
  String get myReports => 'Os meus alertas';

  @override
  String get homeCity => 'Cidade';

  @override
  String get notifications => 'Notificações';

  @override
  String get chooseLanguage => 'Escolha o idioma';

  @override
  String get language => 'Idioma';

  @override
  String get signOut => 'Terminar sessão';

  @override
  String get signOutTitle => 'Terminar sessão?';

  @override
  String get signOutMessage => 'Pode voltar a entrar quando quiser.';

  @override
  String get deleteAccount => 'Eliminar conta';

  @override
  String get deleteAccountTitle => 'Eliminar a sua conta?';

  @override
  String get deleteAccountMessage =>
      'O seu perfil, os seus animais, os seus alertas e as respetivas fotos serão eliminados para sempre. Não é possível anular.';

  @override
  String get deletingAccount => 'A eliminar a sua conta…';

  @override
  String get myReportsSubtitle => 'Mantenha os seus alertas atualizados.';

  @override
  String get statTotal => 'Total';

  @override
  String postedOn(String date) {
    return 'Publicado a $date';
  }

  @override
  String get reportActive => 'Ativos';

  @override
  String get reportResolved => 'Resolvidos';

  @override
  String get myReportsLoadError => 'Não foi possível carregar os seus alertas';

  @override
  String get checkConnection => 'Verifique a ligação e tente novamente.';

  @override
  String get noActiveReports => 'Sem alertas ativos';

  @override
  String get noActiveReportsMessage =>
      'Os alertas que publicar sobre animais perdidos ou encontrados aparecem aqui.';

  @override
  String get reportAPet => 'Alertar sobre um animal';

  @override
  String get nothingResolved => 'Ainda nada resolvido';

  @override
  String get nothingResolvedMessage =>
      'Quando marcar um alerta como resolvido, ele passa para aqui.';

  @override
  String get markAsFound => 'Marcar como encontrado';

  @override
  String get returnedToOwner => 'Devolvido ao dono';

  @override
  String get backHome => 'De volta a casa';

  @override
  String get reunited => 'Reunido';

  @override
  String get deleteReport => 'Eliminar alerta';

  @override
  String resolveLostTitle(String petName) {
    return 'O $petName já está em casa?';
  }

  @override
  String get resolveFoundTitle => 'Encontrou o dono?';

  @override
  String resolveLostMessage(String petName) {
    return 'O alerta passa para \"De volta a casa\" no separador Encontrados, para os vizinhos saberem que $petName está em segurança.';
  }

  @override
  String get resolveFoundMessage =>
      'O alerta passa para \"Reunidos\" no separador Encontrados.';

  @override
  String get notYet => 'Ainda não';

  @override
  String get yesResolved => 'Sim, resolvido';

  @override
  String get reportResolvedSuccess => 'Que ótima notícia! Alerta resolvido.';

  @override
  String get deleteReportTitle => 'Eliminar este alerta?';

  @override
  String deleteOpenReportMessage(String petName) {
    return 'Vai desaparecer do mapa e das listas. Se $petName está em segurança, marque antes o alerta como resolvido para os vizinhos saberem.';
  }

  @override
  String get deleteResolvedReportMessage =>
      'Vai ser removido do mapa e da lista \"De volta a casa\".';

  @override
  String get reportDeleted => 'Alerta eliminado.';

  @override
  String get onboarding1Title => 'Todos os animais merecem\n';

  @override
  String get onboarding1Highlight => 'voltar a casa';

  @override
  String get onboarding1Body =>
      'O CodaMi junta vizinhos para que cães e gatos perdidos voltem para quem os ama.';

  @override
  String get onboarding2Title => 'Alerte sobre um animal\nem ';

  @override
  String get onboarding2Highlight => 'segundos';

  @override
  String get onboarding2Body =>
      'Tire uma foto, marque o local e publique um alerta de perda ou de achado. Todos por perto veem logo.';

  @override
  String get onboarding3Title => 'Veja quem está\n';

  @override
  String get onboarding3Highlight => 'por perto';

  @override
  String get onboarding3Body =>
      'Animais perdidos e encontrados à sua volta, em direto num só mapa, para saber sempre onde procurar.';

  @override
  String get skip => 'Saltar';

  @override
  String get getStarted => 'Começar';

  @override
  String get lost => 'Perdido';

  @override
  String get found => 'Encontrado';

  @override
  String get you => 'Você';

  @override
  String get published => 'Publicado';

  @override
  String get onboardingSampleBreed => 'Golden Retriever · 3 anos';

  @override
  String get onboardingSamplePlace => 'Milão · há 2 h';

  @override
  String get validationNameRequired => 'Escreva o seu nome';

  @override
  String get validationNameTooShort =>
      'O nome deve ter pelo menos 2 caracteres';

  @override
  String get validationNameTooLong => 'O nome deve ter menos de 50 caracteres';

  @override
  String get validationNameInvalid =>
      'O nome só pode ter letras, espaços, hífenes e apóstrofos';

  @override
  String get validationEmailRequired => 'Escreva o seu email';

  @override
  String get validationEmailInvalid => 'Escreva um email válido';

  @override
  String get validationPasswordRequired => 'Escreva a sua palavra-passe';

  @override
  String get validationPasswordTooShort =>
      'A palavra-passe deve ter pelo menos 8 caracteres';

  @override
  String get validationConfirmRequired => 'Confirme a sua palavra-passe';

  @override
  String get validationPasswordsDontMatch => 'As palavras-passe não coincidem';

  @override
  String get spamNote =>
      'Não encontra o email para repor a palavra-passe? Veja a pasta de Spam ou Lixo, por vezes vai parar lá.';

  @override
  String get logIn => 'Entrar';

  @override
  String get signUp => 'Registar';

  @override
  String get authResetSentTitle => 'Veja o seu email';

  @override
  String get authResetSentSubtitle =>
      'Enviámos-lhe um link para repor a palavra-passe.';

  @override
  String get authLoginTitle => 'Bem-vindo de volta!';

  @override
  String get authLoginSubtitle =>
      'Entre para continuar a ajudar os animais a voltar a casa.';

  @override
  String get authSignupTitle => 'Junte-se à matilha';

  @override
  String get authSignupSubtitle => 'Crie uma conta e ajude o seu bairro.';

  @override
  String get authForgotTitle => 'Esqueceu a palavra-passe?';

  @override
  String get authForgotSubtitle =>
      'Não faz mal, enviamos-lhe um link por email para a repor.';

  @override
  String get fullName => 'Nome completo';

  @override
  String get email => 'Email';

  @override
  String get password => 'Palavra-passe';

  @override
  String get confirmPassword => 'Confirmar palavra-passe';

  @override
  String get forgotPassword => 'Esqueceu a palavra-passe?';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get sendResetLink => 'Enviar link';

  @override
  String get or => 'ou';

  @override
  String get continueWithGoogle => 'Continuar com Google';

  @override
  String get continueWithApple => 'Continuar com Apple';

  @override
  String get resetLinkSentTo => 'Enviámos um link para';

  @override
  String get backToLogIn => 'Voltar a entrar';

  @override
  String get sendAgain => 'Não recebeu? Enviar novamente';

  @override
  String get errorOffline =>
      'Está sem ligação. Verifique a ligação e tente novamente.';

  @override
  String get errorSessionExpired => 'A sua sessão expirou. Volte a entrar.';

  @override
  String get deleteAccountFailed =>
      'Não foi possível eliminar a sua conta. Tente novamente.';

  @override
  String get authErrorGeneric => 'Algo correu mal. Tente novamente.';

  @override
  String get authErrorDisabled => 'Esta conta foi desativada.';

  @override
  String get authErrorWrongCredentials => 'Email ou palavra-passe incorretos.';

  @override
  String get authErrorEmailInUse =>
      'Já existe uma conta com este email. Experimente entrar.';

  @override
  String get authErrorTooManyRequests =>
      'Demasiadas tentativas. Aguarde um momento e tente novamente.';

  @override
  String get citySearchFailed =>
      'A pesquisa da cidade falhou. Tente novamente.';

  @override
  String get placeSearchFailed =>
      'A pesquisa do local falhou. Tente novamente.';

  @override
  String get placeOutsideCity =>
      'Esse local fica fora da sua cidade. Escolha um na cidade.';

  @override
  String get placeNotFound => 'Não encontrámos esse local. Escolha outro.';

  @override
  String get citySearchOffline =>
      'Não foi possível aceder à pesquisa de cidades. Verifique a ligação e tente novamente.';

  @override
  String get searchCityHint => 'Pesquise a sua cidade, ex. Milão';

  @override
  String noCitiesFound(String query) {
    return 'Nenhuma cidade encontrada para \"$query\".';
  }

  @override
  String homeCityUpdated(String city) {
    return 'Cidade atualizada: $city.';
  }

  @override
  String get saveCityFailed =>
      'Não foi possível guardar a sua cidade. Tente novamente.';

  @override
  String get citySetupTitle => 'Onde ';

  @override
  String get citySetupHighlight => 'está?';

  @override
  String get cityEditTitle => 'Mude a sua ';

  @override
  String get cityEditHighlight => 'cidade';

  @override
  String get citySetupBody =>
      'Escolha a sua cidade para lhe mostrarmos os animais perdidos e encontrados por perto e avisarmos quando um animal desaparecer na sua zona.';

  @override
  String get saveCity => 'Guardar cidade';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get notYouSignOut => 'Não é você? Terminar sessão';

  @override
  String greeting(String name) {
    return 'Olá, $name!';
  }

  @override
  String get showPetsWithin => 'Mostrar animais num raio de';

  @override
  String distanceFrom(String city) {
    return 'Distância de $city';
  }

  @override
  String get everywhere => 'Em todo o lado';

  @override
  String distanceKm(int km) {
    return '$km km';
  }

  @override
  String withinKm(int km) {
    return 'num raio de $km km';
  }

  @override
  String get areaNotSet => 'Zona ainda não definida';

  @override
  String get reportPetSemantics =>
      'Alertar sobre um animal perdido ou encontrado';

  @override
  String get map => 'Mapa';

  @override
  String get locationServicesOff =>
      'Ative a localização para usar a sua posição.';

  @override
  String get locationPermissionDenied =>
      'Permita o acesso à localização nas Definições para usar a sua posição.';

  @override
  String get locationFailed =>
      'Não foi possível obter a sua localização. Tente novamente.';

  @override
  String get back => 'Voltar';

  @override
  String get fullScreen => 'Ecrã inteiro';

  @override
  String get loadingPets => 'A carregar animais…';

  @override
  String get mapLoadFailed =>
      'Não foi possível carregar os alertas. Verifique a ligação.';

  @override
  String get mapNoLost => 'Sem animais perdidos nesta zona';

  @override
  String get mapNoFound => 'Sem animais encontrados nesta zona';

  @override
  String get mapNoPets => 'Sem animais perdidos ou encontrados nesta zona';

  @override
  String get zoomIn => 'Aproximar';

  @override
  String get zoomOut => 'Afastar';

  @override
  String get myLocation => 'A minha localização';

  @override
  String get myCity => 'A minha cidade';

  @override
  String get all => 'Todos';

  @override
  String get timeJustNow => 'Agora mesmo';

  @override
  String timeMinutesAgo(int minutes) {
    return 'há $minutes min';
  }

  @override
  String timeHoursAgo(int hours) {
    return 'há $hours h';
  }

  @override
  String get timeYesterday => 'Ontem';

  @override
  String timeDaysAgo(int days) {
    return 'há $days dias';
  }

  @override
  String notifLostTitle(String city) {
    return 'Animal perdido em $city';
  }

  @override
  String notifLostBodyNear(String pet, String street, String city) {
    return '$pet foi visto pela última vez perto de $street, $city. Fique atento!';
  }

  @override
  String notifLostBodyIn(String pet, String city) {
    return '$pet foi visto pela última vez em $city. Fique atento!';
  }

  @override
  String notifFoundTitle(String city) {
    return 'Animal encontrado em $city';
  }

  @override
  String notifFoundBodyNear(String pet, String street, String city) {
    return '$pet foi encontrado perto de $street, $city. Conhece o dono?';
  }

  @override
  String notifFoundBodyIn(String pet, String city) {
    return '$pet foi encontrado em $city. Conhece o dono?';
  }

  @override
  String notifBackHomeTitle(String pet) {
    return '$pet está de volta a casa';
  }

  @override
  String notifBackHomeBody(String pet, String city) {
    return 'Boas notícias de $city: $pet foi encontrado. Obrigado pela ajuda!';
  }

  @override
  String notifReunitedTitle(String pet) {
    return '$pet voltou para a família';
  }

  @override
  String notifReunitedBody(String city) {
    return 'O animal encontrado em $city voltou para a sua família.';
  }

  @override
  String get notificationsTitle => 'Notificações';

  @override
  String get markAllRead => 'Marcar tudo como lido';

  @override
  String get notificationsLoadError =>
      'Não foi possível carregar as notificações';

  @override
  String get allCaughtUp => 'Está tudo em dia';

  @override
  String get notificationsEmpty =>
      'Avisamos quando um animal se perder ou for encontrado na sua cidade.';

  @override
  String get notificationsNew => 'Novas';

  @override
  String get notificationsEarlier => 'Anteriores';

  @override
  String get reportNotAvailable => 'Alerta indisponível';

  @override
  String get reportRemoved => 'Este alerta foi removido pelo autor.';

  @override
  String get reportsLoadError => 'Não foi possível carregar os alertas';

  @override
  String get pullToRetry =>
      'Verifique a ligação e puxe para baixo para tentar novamente.';

  @override
  String get noLostNearby => 'Sem animais perdidos por perto';

  @override
  String get noLostNearbyMessage =>
      'Boas notícias! Ninguém alertou ainda sobre um animal perdido na sua zona.';

  @override
  String get noFoundYet => 'Ainda sem animais encontrados';

  @override
  String get noFoundYetMessage =>
      'Os animais encontrados pelos seus vizinhos aparecem aqui.';

  @override
  String get backHomeSection => 'De volta a casa';

  @override
  String get backHomeSectionSubtitle =>
      'Animais que voltaram para as suas famílias.';

  @override
  String get loadMore => 'Carregar mais';

  @override
  String get speciesDog => 'Cão';

  @override
  String get speciesCat => 'Gato';

  @override
  String get speciesOther => 'Outro';

  @override
  String get sexMale => 'Macho';

  @override
  String get sexFemale => 'Fêmea';

  @override
  String get sexUnknown => 'Não sei';

  @override
  String nearPlace(String street, String city) {
    return 'Perto de $street, $city';
  }

  @override
  String get callFailed => 'Não foi possível iniciar a chamada.';

  @override
  String get whatsappFailed => 'Não foi possível abrir o WhatsApp.';

  @override
  String get emailFailed => 'Não foi possível abrir a app de email.';

  @override
  String whatsappMessageLost(String pet) {
    return 'Olá! Estou a contactar sobre o animal perdido \"$pet\" no CodaMi.';
  }

  @override
  String whatsappMessageFound(String pet) {
    return 'Olá! Estou a contactar sobre o animal encontrado \"$pet\" no CodaMi.';
  }

  @override
  String emailSubjectLost(String pet) {
    return 'Sobre $pet (animal perdido no CodaMi)';
  }

  @override
  String emailSubjectFound(String pet) {
    return 'Sobre $pet (animal encontrado no CodaMi)';
  }

  @override
  String shareTitleLost(String pet) {
    return 'ANIMAL PERDIDO: $pet';
  }

  @override
  String shareTitleFound(String pet) {
    return 'ANIMAL ENCONTRADO: $pet';
  }

  @override
  String get shareFooter =>
      'Viu este animal? Abra o CodaMi para entrar em contacto.';

  @override
  String get lastSeen => 'Visto pela última vez';

  @override
  String get foundAt => 'Encontrado em';

  @override
  String areaAbout(int meters) {
    return 'zona de cerca de $meters m';
  }

  @override
  String get when => 'Quando';

  @override
  String get postedBy => 'Publicado por';

  @override
  String get description => 'Descrição';

  @override
  String get call => 'Ligar';

  @override
  String contactTitleLost(String pet) {
    return 'Viu $pet? Entre em contacto';
  }

  @override
  String get contactTitleFound => 'É o seu animal? Entre em contacto';

  @override
  String get noContactShared => 'Não foram partilhados contactos.';

  @override
  String resolvedThanksLost(String pet) {
    return '$pet está de volta a casa. Obrigado por usar o CodaMi!';
  }

  @override
  String get resolvedThanksFound =>
      'Este animal voltou para a sua família. Obrigado pela ajuda!';

  @override
  String get yourContactDetails => 'Os seus contactos';

  @override
  String markPetAsFound(String pet) {
    return 'Marcar $pet como encontrado';
  }

  @override
  String get markReturnedToOwner => 'Marcar como devolvido ao dono';

  @override
  String get copiedToClipboard => 'Copiado para a área de transferência.';

  @override
  String get petSaveFailed =>
      'Não foi possível guardar o seu animal. Tente novamente.';

  @override
  String get petDeleteFailed =>
      'Não foi possível eliminar o seu animal. Tente novamente.';

  @override
  String get errorPermission => 'Não tem permissão para fazer isso.';

  @override
  String get storageNotReady =>
      'O armazenamento de fotos ainda não está pronto. Tente mais tarde.';

  @override
  String get storageFull =>
      'O armazenamento está cheio de momento. Tente mais tarde.';

  @override
  String petAdded(String name) {
    return '$name foi adicionado aos seus animais.';
  }

  @override
  String get petsLoadError => 'Não foi possível carregar os seus animais';

  @override
  String get noPetsYet => 'Ainda sem animais';

  @override
  String get noPetsYetMessage =>
      'Adicione já os seus animais para poder alertar em segundos se algum se perder.';

  @override
  String get addFirstPet => 'Adicionar o primeiro animal';

  @override
  String get petsHeaderEmpty =>
      'Tenha os perfis dos seus animais prontos, por precaução.';

  @override
  String petsHeaderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count amigos de quatro patas, prontos para o que der e vier.',
      one: '1 amigo de quatro patas, pronto para o que der e vier.',
    );
    return '$_temp0';
  }

  @override
  String get addPet => 'Adicionar';

  @override
  String petUpdated(String name) {
    return '$name foi atualizado.';
  }

  @override
  String removePetTitle(String name) {
    return 'Remover $name?';
  }

  @override
  String get removePetMessage =>
      'O perfil e as fotos serão eliminados. Não é possível anular.';

  @override
  String get remove => 'Remover';

  @override
  String petRemoved(String name) {
    return '$name foi removido.';
  }

  @override
  String get breed => 'Raça';

  @override
  String get color => 'Cor';

  @override
  String get age => 'Idade';

  @override
  String get sex => 'Sexo';

  @override
  String petAddedOn(String date) {
    return 'Adicionado a $date';
  }

  @override
  String get distinctiveFeatures => 'Características especiais';

  @override
  String ifPetGoesMissing(String name) {
    return 'Se $name alguma vez desaparecer';
  }

  @override
  String get ifPetGoesMissingBody =>
      'Publique um alerta de perda com este perfil em segundos e os vizinhos serão avisados.';

  @override
  String reportPetAsLost(String name) {
    return 'Alertar que $name se perdeu';
  }

  @override
  String get colorBlack => 'Preto';

  @override
  String get colorWhite => 'Branco';

  @override
  String get colorBrown => 'Castanho';

  @override
  String get colorGolden => 'Dourado';

  @override
  String get colorGrey => 'Cinzento';

  @override
  String get colorCream => 'Creme';

  @override
  String get colorGinger => 'Ruivo';

  @override
  String get petPhotoRequired => 'Adicione pelo menos uma foto do seu animal.';

  @override
  String get petSpeciesRequired =>
      'Indique se o seu animal é um cão, um gato ou outro.';

  @override
  String get checkHighlightedFields => 'Verifique os campos assinalados.';

  @override
  String get signInToSave => 'Volte a entrar para guardar.';

  @override
  String get discardChangesTitle => 'Descartar alterações?';

  @override
  String get discardPetChanges => 'As alterações a este animal vão perder-se.';

  @override
  String get keepEditing => 'Continuar a editar';

  @override
  String get discard => 'Descartar';

  @override
  String editPetTitle(String name) {
    return 'Editar $name';
  }

  @override
  String get newPet => 'Novo animal';

  @override
  String get whatKindOfPet => 'Que tipo de animal?';

  @override
  String get name => 'Nome';

  @override
  String get petNameHint => 'ex. Luna';

  @override
  String get petNameRequired => 'Escreva o nome do seu animal';

  @override
  String get petNameTooLong => 'O nome deve ter menos de 40 caracteres';

  @override
  String get breedHint => 'ex. Golden Retriever, Rafeiro';

  @override
  String get colorHint => 'ex. Dourado com peito branco';

  @override
  String get ageHint => 'ex. 3 anos, 8 meses';

  @override
  String get featuresHint =>
      'Coleira, microchip, cicatrizes, manchas… tudo o que ajude a reconhecer o seu animal.';

  @override
  String get saveChanges => 'Guardar alterações';

  @override
  String get savePet => 'Guardar animal';

  @override
  String get cameraPermission => 'Permita o acesso à câmara nas Definições.';

  @override
  String get photosPermission => 'Permita o acesso às fotos nas Definições.';

  @override
  String get cameraFailed => 'Não foi possível abrir a câmara.';

  @override
  String get galleryFailed => 'Não foi possível abrir a galeria.';

  @override
  String get optional => 'Opcional';

  @override
  String get addPetPhotos => 'Adicione fotos do seu animal';

  @override
  String get addPetPhotosHint =>
      'Fotos nítidas e recentes ajudam a reconhecê-lo';

  @override
  String get photoRequired => 'É necessária pelo menos uma foto';

  @override
  String get tapToMakeCover => 'Toque numa foto para a tornar capa.';

  @override
  String get cover => 'Capa';

  @override
  String uploadingPhotos(int percent) {
    return 'A enviar fotos… $percent%';
  }

  @override
  String get saving => 'A guardar…';

  @override
  String get takePhoto => 'Tirar uma foto';

  @override
  String get useCamera => 'Usar a câmara';

  @override
  String get chooseFromGallery => 'Escolher da galeria';

  @override
  String get pickExistingPhoto => 'Escolher uma foto existente';

  @override
  String get yourPet => 'o seu animal';

  @override
  String get unknownDog => 'Cão desconhecido';

  @override
  String get unknownCat => 'Gato desconhecido';

  @override
  String get unknownPet => 'Animal desconhecido';

  @override
  String get errorChooseType => 'Indique se perdeu ou encontrou um animal.';

  @override
  String get errorPickPet => 'Escolha o animal que desapareceu.';

  @override
  String get errorFoundPhoto => 'Adicione pelo menos uma foto do animal.';

  @override
  String get errorFoundSpecies => 'É um cão, um gato ou outro?';

  @override
  String get errorChooseCity => 'Escolha a cidade onde aconteceu.';

  @override
  String get errorFutureDate => 'A data não pode ser no futuro.';

  @override
  String get errorDescriptionShort =>
      'Adicione uma breve descrição (pelo menos 10 caracteres).';

  @override
  String get errorContactRequired =>
      'Adicione um telefone ou email para o poderem contactar.';

  @override
  String get errorPhoneInvalid => 'Escreva um número de telefone válido.';

  @override
  String get discardReportTitle => 'Descartar este alerta?';

  @override
  String get discardReportMessage => 'O que escreveu até agora vai perder-se.';

  @override
  String get signInToPublish => 'Volte a entrar para publicar.';

  @override
  String publishedLost(String pet) {
    return '$pet já está no mapa. Esperamos que volte depressa a casa.';
  }

  @override
  String publishedFound(String pet) {
    return 'Obrigado! $pet já está no mapa.';
  }

  @override
  String get reportLostPetTitle => 'Alertar sobre um animal perdido';

  @override
  String get reportFoundPetTitle => 'Alertar sobre um animal encontrado';

  @override
  String get newReport => 'Novo alerta';

  @override
  String stepOf(int current, int total) {
    return '$current de $total';
  }

  @override
  String get publishReport => 'Publicar alerta';

  @override
  String get stepTypeTitle => 'O que aconteceu?';

  @override
  String get stepTypeSubtitle =>
      'Vamos espalhar a notícia por quem está perto, depressa.';

  @override
  String get stepFoundPetTitle => 'Fale-nos do animal';

  @override
  String get stepFoundPetSubtitle =>
      'Uma foto nítida é a forma mais rápida de o dono o reconhecer.';

  @override
  String get addFoundPhotos => 'Adicione fotos do animal';

  @override
  String get addFoundPhotosHint => 'Tire uma agora ou escolha da galeria';

  @override
  String get whatKindOfAnimal => 'Que animal é?';

  @override
  String get collarName => 'Nome na coleira ou chapa';

  @override
  String get collarNameHint => 'Deixe vazio se não souber';

  @override
  String get stepLostPetTitle => 'Que animal desapareceu?';

  @override
  String get stepLostPetSubtitle =>
      'Usamos o perfil e as fotos dele para não ter de escrever nada outra vez.';

  @override
  String get stepWhereFoundTitle => 'Onde o encontrou?';

  @override
  String stepWhereLostTitle(String pet) {
    return 'Onde foi $pet visto pela última vez?';
  }

  @override
  String get stepWhereSubtitle =>
      'Escolha a cidade e marque o ponto no mapa. Os outros só veem uma zona de cerca de 100 m, nunca a morada exata.';

  @override
  String get streetOrLandmark => 'Rua ou ponto de referência';

  @override
  String get pinExactSpot => 'Marque o ponto exato';

  @override
  String spotHintFound(String pet) {
    return 'Mova o mapa até o marcador ficar onde encontrou $pet.';
  }

  @override
  String spotHintLost(String pet) {
    return 'Mova o mapa até o marcador ficar onde $pet foi visto pela última vez.';
  }

  @override
  String spotFarFromCity(int km, String city) {
    return 'Este ponto fica a $km km de $city. A cidade está certa?';
  }

  @override
  String spotPinned(int meters) {
    return 'Marcado. Os outros só veem uma zona de cerca de $meters m à volta, nunca o ponto exato.';
  }

  @override
  String get timeHourAgo => 'Há 1 hora';

  @override
  String get timeThisMorning => 'Esta manhã';

  @override
  String get stepWhenFoundTitle => 'Quando o encontrou?';

  @override
  String stepWhenLostTitle(String pet) {
    return 'Quando viu $pet pela última vez?';
  }

  @override
  String get stepWhenSubtitle => 'Uma hora aproximada chega.';

  @override
  String get changeDate => 'Mudar data';

  @override
  String get changeTime => 'Mudar hora';

  @override
  String get stepDetailsTitle => 'Mais alguma coisa que devamos saber?';

  @override
  String get stepDetailsSubtitle =>
      'Os detalhes ajudam os vizinhos a reconhecer o animal e a contactá-lo depressa.';

  @override
  String descriptionHintLost(String pet) {
    return 'Cor da coleira, comportamento, como $pet desapareceu…';
  }

  @override
  String get descriptionHintFound =>
      'Estado, coleira, comportamento, onde exatamente o encontrou…';

  @override
  String get howToReachYou => 'Como o podem contactar?';

  @override
  String get contactPrivacyNote =>
      'Só aparece na página do alerta, nunca nas listas.';

  @override
  String get phoneHint => 'Telefone, ex. +39 333 123 4567';

  @override
  String get reachableOnWhatsapp => 'Disponível no WhatsApp';

  @override
  String get reachableOnWhatsappHint =>
      'Podem enviar-lhe mensagens para este número';

  @override
  String get stepReviewTitle => 'Pronto para publicar?';

  @override
  String get stepReviewSubtitle =>
      'É assim que as pessoas por perto vão ver o seu alerta.';

  @override
  String get iLostMyPet => 'Perdi o meu animal';

  @override
  String get iFoundAPet => 'Encontrei um animal';

  @override
  String get iLostMyPetHint =>
      'Avise quem está perto e tenha ajuda na procura.';

  @override
  String get iFoundAPetHint => 'Ajude um animal perdido a voltar a casa.';

  @override
  String get addAPet => 'Adicionar animal';

  @override
  String get pleaseChooseCity => 'Escolha uma cidade';

  @override
  String noPlacesFound(String city, String query) {
    return 'Nenhum local encontrado em $city para \"$query\".';
  }

  @override
  String searchStreetHint(String city) {
    return 'Pesquise em $city, ex. Via Dante';
  }

  @override
  String get yourCity => 'a sua cidade';

  @override
  String get useMyLocation => 'Usar a minha localização';

  @override
  String get publishFailed =>
      'Não foi possível publicar o seu alerta. Tente novamente.';

  @override
  String get updateReportFailed =>
      'Não foi possível atualizar o alerta. Tente novamente.';

  @override
  String get deleteReportFailed =>
      'Não foi possível eliminar o alerta. Tente novamente.';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get termsOfUse => 'Termos de utilização';

  @override
  String legalLastUpdated(String date) {
    return 'Última atualização: $date';
  }

  @override
  String get deleteAccountPasswordPrompt =>
      'Escreva a sua palavra-passe para confirmar.';

  @override
  String deleteAccountTypeConfirm(String word) {
    return 'Escreva $word para confirmar.';
  }

  @override
  String get wrongPassword => 'Palavra-passe incorreta. Tente novamente.';

  @override
  String get confirmPasswordAgain =>
      'Por segurança, confirme novamente a sua palavra-passe.';

  @override
  String get contactUs => 'Contacte-nos';

  @override
  String get legalQuestions => 'Dúvidas sobre este documento ou os seus dados?';

  @override
  String get languageChangeLater =>
      'Pode alterá-lo a qualquer momento no seu perfil.';

  @override
  String get reward => 'Recompensa';

  @override
  String get rewardHint => 'Montante em euros';

  @override
  String get rewardNote =>
      'A recompensa é um acordo privado entre o dono e quem encontrar o animal. A CodaMi não garante nem processa qualquer pagamento.';

  @override
  String rewardAmount(String amount) {
    return 'Recompensa $amount';
  }

  @override
  String get adminPanel => 'Painel de administração';

  @override
  String get roleAdmin => 'Administrador';

  @override
  String get roleSupport => 'Suporte';

  @override
  String get supportStaff => 'Equipa de suporte';

  @override
  String get supportStaffSubtitle =>
      'Pessoas que respondem aos pedidos de suporte';

  @override
  String get adminUsers => 'Utilizadores';

  @override
  String get adminListings => 'Anúncios';

  @override
  String get adminReportedContent => 'Conteúdo denunciado';

  @override
  String get adminTickets => 'Pedidos de suporte';

  @override
  String get adminVideos => 'Vídeos';

  @override
  String get addSupportStaff => 'Adicionar ao suporte';

  @override
  String get addSupportStaffHint =>
      'Introduza o email de uma conta CodaMi existente.';

  @override
  String get userNotFound => 'Nenhuma conta CodaMi usa este email.';

  @override
  String get alreadyStaff => 'Esta pessoa já faz parte da equipa.';

  @override
  String staffAdded(String name) {
    return '$name faz agora parte da equipa de suporte.';
  }

  @override
  String removeStaffTitle(String name) {
    return 'Remover $name?';
  }

  @override
  String get removeStaffMessage =>
      'Deixará de ter acesso ao painel de administração.';

  @override
  String get noSupportStaff => 'Ainda não há ninguém na equipa de suporte.';

  @override
  String get add => 'Adicionar';

  @override
  String get actionFailed => 'Algo correu mal. Tente novamente.';

  @override
  String get adminDashboard => 'Painel';

  @override
  String get adminMore => 'Mais';

  @override
  String get adminReportedShort => 'Denunciados';

  @override
  String get adminTicketsShort => 'Pedidos';

  @override
  String get adminSectionSoon => 'Esta secção estará disponível em breve.';

  @override
  String get statUsers => 'Utilizadores registados';

  @override
  String get statOpenLost => 'Perdidos em aberto';

  @override
  String get statOpenFound => 'Encontrados em aberto';

  @override
  String get statBackHome => 'Animais de volta a casa';

  @override
  String get flagListing => 'Denunciar anúncio';

  @override
  String get flagTitle => 'Por que você está denunciando este anúncio?';

  @override
  String get flagHint =>
      'Nossa equipe vai analisá-lo. O dono não saberá quem denunciou.';

  @override
  String get flagReasonSpam => 'Spam ou publicidade';

  @override
  String get flagReasonScam => 'Golpe ou fraude';

  @override
  String get flagReasonInappropriate => 'Conteúdo impróprio';

  @override
  String get flagReasonWrongInfo => 'Informações falsas ou enganosas';

  @override
  String get flagReasonOther => 'Outro motivo';

  @override
  String get flagNoteHint => 'Adicione detalhes (opcional)';

  @override
  String get flagSubmit => 'Enviar denúncia';

  @override
  String get flagSent => 'Obrigado. Nossa equipe vai analisar este anúncio.';

  @override
  String get alreadyFlagged => 'Você já denunciou este anúncio.';

  @override
  String blockUser(String name) {
    return 'Bloquear $name';
  }

  @override
  String blockUserTitle(String name) {
    return 'Bloquear $name?';
  }

  @override
  String get blockUserMessage =>
      'Você não verá mais os anúncios dessa pessoa nem receberá alertas sobre eles. Você pode desbloquear em Perfil → Usuários bloqueados.';

  @override
  String get block => 'Bloquear';

  @override
  String userBlocked(String name) {
    return '$name foi bloqueado.';
  }

  @override
  String get blockedUsers => 'Usuários bloqueados';

  @override
  String get noBlockedUsers => 'Você não bloqueou ninguém.';

  @override
  String get unblock => 'Desbloquear';

  @override
  String userUnblocked(String name) {
    return '$name foi desbloqueado.';
  }

  @override
  String get unknownUser => 'Usuário desconhecido';

  @override
  String get hiddenListing => 'Oculto';

  @override
  String get hiddenListingNotice =>
      'Este anúncio foi ocultado pela equipe CodaMi e não é mais público.';

  @override
  String get moderation => 'Moderação';

  @override
  String get noFlagsOnListing => 'Ninguém denunciou este anúncio.';

  @override
  String flagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Denunciado $count vezes',
      one: 'Denunciado uma vez',
    );
    return '$_temp0';
  }

  @override
  String get dismissFlags => 'Descartar denúncias';

  @override
  String get flagsDismissed => 'Denúncias descartadas.';

  @override
  String get hideListing => 'Ocultar anúncio';

  @override
  String get restoreListing => 'Restaurar anúncio';

  @override
  String get listingHidden => 'Anúncio ocultado. Só o dono ainda pode vê-lo.';

  @override
  String get listingRestored => 'Anúncio restaurado.';

  @override
  String get deleteListing => 'Excluir anúncio';

  @override
  String get deleteListingTitle => 'Excluir este anúncio?';

  @override
  String get deleteListingMessage =>
      'O anúncio e as fotos são excluídos para todos. Isso não pode ser desfeito.';

  @override
  String get listingDeleted => 'Anúncio excluído.';

  @override
  String get listingUnavailable => 'Anúncio não está mais disponível';

  @override
  String get noReportedContent => 'Nenhuma denúncia';

  @override
  String get noReportedContentMessage =>
      'Os anúncios denunciados pelos usuários aparecerão aqui.';

  @override
  String get filterOpen => 'Abertos';

  @override
  String get filterResolved => 'Resolvidos';

  @override
  String get filterHidden => 'Ocultos';

  @override
  String get noListings => 'Nenhum anúncio';

  @override
  String get tryAnotherFilter => 'Tente outro filtro.';

  @override
  String get adminUsersSubtitle => 'Ver, desativar ou excluir contas';

  @override
  String get searchByEmail => 'Buscar por e-mail';

  @override
  String get noUsersFound => 'Nenhum usuário encontrado.';

  @override
  String get roleUser => 'Usuário';

  @override
  String get userDisabled => 'Desativado';

  @override
  String get phone => 'Telefone';

  @override
  String get memberSince => 'Membro desde';

  @override
  String get disableAccount => 'Desativar conta';

  @override
  String get enableAccount => 'Reativar conta';

  @override
  String disableUserTitle(String name) {
    return 'Desativar a conta de $name?';
  }

  @override
  String get disableUserMessage =>
      'A pessoa será desconectada e não poderá entrar. Os anúncios abertos ficam ocultos até a conta ser reativada.';

  @override
  String get accountDisabled => 'Conta desativada.';

  @override
  String get accountEnabled => 'Conta reativada.';

  @override
  String deleteUserTitle(String name) {
    return 'Excluir a conta de $name?';
  }

  @override
  String get deleteUserMessage =>
      'Exclui para sempre o perfil, os pets, os anúncios e as fotos. Isso não pode ser desfeito.';

  @override
  String get userDeleted => 'Conta excluída.';

  @override
  String get save => 'Guardar';

  @override
  String get requiredField => 'Obrigatório';

  @override
  String get notificationSettingsIntro =>
      'Escolha quais alertas receber e dê a cada um o seu próprio som, para saber o que aconteceu antes de olhar.';

  @override
  String get notificationSound => 'Som';

  @override
  String get alertLostTitle => 'Animais perdidos por perto';

  @override
  String get alertLostDescription =>
      'Quando um animal desaparece na sua cidade';

  @override
  String get alertFoundTitle => 'Animais encontrados por perto';

  @override
  String get alertFoundDescription =>
      'Quando alguém encontra um animal na sua cidade';

  @override
  String get alertResolvedTitle => 'Finais felizes';

  @override
  String get alertResolvedDescription =>
      'Quando um animal perdido ou encontrado volta para casa';

  @override
  String get soundDefault => 'Padrão do telefone';

  @override
  String get soundSilent => 'Silencioso';

  @override
  String get soundChime => 'Carrilhão';

  @override
  String get soundBell => 'Sino';

  @override
  String get soundBright => 'Vibrante';

  @override
  String get soundSoft => 'Suave';

  @override
  String get soundCustom => 'Som personalizado';

  @override
  String get soundFromPhone => 'Toques e sons do telefone';

  @override
  String get soundFromFile => 'Música ou ficheiro de áudio';

  @override
  String get soundIosNote =>
      'No iPhone, os sons das notificações têm de vir da app, por isso escolha um dos sons acima.';

  @override
  String get soundPickFailed =>
      'Não foi possível usar esse som. Experimente outro.';

  @override
  String get videosForYou => 'Vídeos para si';

  @override
  String get videosForYourPets => 'Escolhidos para os seus animais';

  @override
  String get videosGeneral => 'Bem-estar animal e cuidados responsáveis';

  @override
  String get videosShuffle => 'Ver outros vídeos';

  @override
  String get videoMotivational => 'Motivação';

  @override
  String get videoEducational => 'Aprender';

  @override
  String get videoTagGeneral => 'Para todos';

  @override
  String get videoLoadError =>
      'Não é possível reproduzir este vídeo agora. Tente mais tarde.';

  @override
  String get adminVideosSubtitle => 'Carregar e gerir vídeos';

  @override
  String get addVideo => 'Adicionar vídeo';

  @override
  String get editVideo => 'Editar vídeo';

  @override
  String get noVideosYet =>
      'Ainda não há vídeos. Adicione o primeiro com o botão abaixo.';

  @override
  String get deleteVideoTitle => 'Eliminar este vídeo?';

  @override
  String get deleteVideoMessage =>
      'Será removido da app para todos. Não é possível anular.';

  @override
  String get videoHidden => 'Oculto';

  @override
  String get allLanguages => 'Todos os idiomas';

  @override
  String get chooseVideo => 'Escolher um vídeo';

  @override
  String get chooseVideoHint =>
      'Da sua galeria, até 200 MB. Vídeos curtos (menos de 2 minutos) funcionam melhor.';

  @override
  String get videoTitle => 'Título';

  @override
  String get videoType => 'Tipo';

  @override
  String get videoAnimals => 'Animais';

  @override
  String get videoAnimalsHint =>
      'Escolha os animais de que o vídeo trata. Escolha \"Para todos\" para vídeos gerais mostrados a todos.';

  @override
  String get videoVisible => 'Visível na app';

  @override
  String get videoVisibleHint =>
      'Os vídeos ocultos só são vistos pelos administradores.';

  @override
  String get videoTooLarge =>
      'O vídeo tem mais de 200 MB. Escolha um mais curto.';

  @override
  String get videoSaved => 'Vídeo guardado.';

  @override
  String uploadingProgress(int percent) {
    return 'A carregar… $percent%';
  }

  @override
  String get navVideos => 'Vídeos';

  @override
  String get videosEmptyTitle => 'Os vídeos estão a caminho';

  @override
  String get videosEmptyMessage =>
      'Em breve vai encontrar aqui vídeos curtos sobre como cuidar dos seus animais.';

  @override
  String get moreVideos => 'Mais vídeos';

  @override
  String get videoWatched => 'Visto';

  @override
  String get videoBack10 => 'Recuar 10 segundos';

  @override
  String get videoForward10 => 'Avançar 10 segundos';

  @override
  String get videoFullscreen => 'Ecrã inteiro';

  @override
  String get videoExitFullscreen => 'Sair do ecrã inteiro';

  @override
  String get videoRetry => 'Tentar novamente';

  @override
  String get videoDeleted => 'Vídeo eliminado.';

  @override
  String get noVideosYetTitle => 'Ainda sem vídeos';

  @override
  String get videoVisibleShort => 'Visíveis';

  @override
  String get play => 'Reproduzir';

  @override
  String get edit => 'Editar';

  @override
  String get change => 'Alterar';

  @override
  String get videoSectionFile => 'Vídeo';

  @override
  String get videoSectionDetails => 'Detalhes';

  @override
  String get videoSectionAudience => 'Quem o vê';

  @override
  String get videoCover => 'Imagem de capa';

  @override
  String get videoCoverHint => 'Opcional. Aparece no cartão do vídeo.';

  @override
  String get videoMotivationalHint =>
      'Histórias inspiradoras e momentos felizes';

  @override
  String get videoEducationalHint => 'Dicas e guias para donos';

  @override
  String get uploadVideo => 'Carregar vídeo';

  @override
  String get helpSupport => 'Ajuda e suporte';

  @override
  String get helpSupportSubtitle => 'Converse conosco ou envie um pedido';

  @override
  String get supportIntroTitle => 'Como podemos ajudar?';

  @override
  String get supportIntroMessage =>
      'Nossa equipe responde aqui no app. Você receberá uma notificação quando respondermos.';

  @override
  String get supportStartChat => 'Iniciar um chat ao vivo';

  @override
  String get supportStartChatOnline => 'Um atendente está online agora';

  @override
  String get supportChatOffline =>
      'Nenhum atendente está online agora. Envie um pedido e responderemos o quanto antes.';

  @override
  String get supportSendRequest => 'Enviar um pedido';

  @override
  String get supportSendRequestSubtitle =>
      'Normalmente respondemos em até 24 horas';

  @override
  String get supportMyRequests => 'Meus pedidos';

  @override
  String get supportNoRequests => 'Nenhum pedido ainda';

  @override
  String get supportNoRequestsMessage =>
      'Suas conversas com o suporte aparecerão aqui.';

  @override
  String get supportNewChat => 'Novo chat ao vivo';

  @override
  String get supportNewRequest => 'Novo pedido';

  @override
  String get supportCategory => 'Assunto';

  @override
  String get categoryAccount => 'Conta e login';

  @override
  String get categoryListing => 'Um anúncio de perdido ou encontrado';

  @override
  String get categoryApp => 'Problema com o app';

  @override
  String get categoryOther => 'Outro assunto';

  @override
  String get supportSubject => 'Assunto';

  @override
  String get supportSubjectHint => 'Em poucas palavras';

  @override
  String get supportSubjectTooShort => 'Escreva pelo menos 3 caracteres';

  @override
  String get supportMessage => 'Mensagem';

  @override
  String get supportMessageHint => 'Conte-nos o que aconteceu';

  @override
  String get supportMessageRequired => 'Escreva uma mensagem';

  @override
  String get supportSend => 'Enviar';

  @override
  String get supportTooManyOpen =>
      'Você já tem 3 pedidos abertos. Continue em um deles.';

  @override
  String get supportTypeMessage => 'Escreva uma mensagem…';

  @override
  String get supportTeam => 'Suporte CodaMi';

  @override
  String get supportMarkSolved => 'Marcar como resolvido';

  @override
  String get supportMarkSolvedConfirm =>
      'Marcar este pedido como resolvido? Você pode escrever novamente se ainda precisar de ajuda.';

  @override
  String get supportClosedNote =>
      'Este pedido está encerrado. Abra um novo se precisar de mais ajuda.';

  @override
  String get supportResolvedNote =>
      'Marcado como resolvido. Escrever novamente reabre o pedido.';

  @override
  String get supportWaitingNote =>
      'Obrigado! Nossa equipe responderá aqui em breve.';

  @override
  String get kindChat => 'Chat ao vivo';

  @override
  String get kindTicket => 'Pedido';

  @override
  String get caseStatusOpen => 'Aberto';

  @override
  String get caseStatusInProgress => 'Em andamento';

  @override
  String get caseStatusWaitingUser => 'Aguardando resposta';

  @override
  String get caseStatusResolved => 'Resolvido';

  @override
  String get caseStatusClosed => 'Encerrado';

  @override
  String get filterUnanswered => 'Sem resposta';

  @override
  String get filterUnassigned => 'Não atribuídos';

  @override
  String get filterMine => 'Meus';

  @override
  String get filterActive => 'Ativos';

  @override
  String get filterDone => 'Concluídos';

  @override
  String get supportSearchHint => 'Buscar CM-1042 ou e-mail';

  @override
  String get supportNoCases => 'Nenhum pedido aqui';

  @override
  String get supportNoCasesMessage => 'Nada aguardando nesta lista.';

  @override
  String get supportTake => 'Assumir caso';

  @override
  String get supportTakeToReply => 'Assuma o caso para responder.';

  @override
  String get supportAlreadyTaken => 'Outro atendente já assumiu este caso.';

  @override
  String get supportUnassigned => 'Não atribuído';

  @override
  String get supportReassign => 'Reatribuir';

  @override
  String get supportAssignTo => 'Atribuir a';

  @override
  String get supportBackToQueue => 'Voltar para a fila';

  @override
  String get supportChangeStatus => 'Alterar status';

  @override
  String get supportChat => 'Chat';

  @override
  String get supportTimeline => 'Histórico';

  @override
  String get supportDetails => 'Detalhes';

  @override
  String supportWaitingFor(String time) {
    return 'Aguardando há $time';
  }

  @override
  String get supportOverdue => 'Resposta atrasada';

  @override
  String get supportOpened => 'Aberto';

  @override
  String get supportTakenOver => 'Assumido';

  @override
  String get supportWaitToTake => 'Espera até assumir';

  @override
  String get supportFirstReply => 'Primeira resposta';

  @override
  String get supportAvgReply => 'Tempo médio de resposta';

  @override
  String get supportHandlingTime => 'Tempo gasto';

  @override
  String get supportResolvedAt => 'Resolvido';

  @override
  String get supportMessagesCount => 'Mensagens';

  @override
  String get supportOperator => 'Atendente';

  @override
  String get supportUserLabel => 'Usuário';

  @override
  String eventCreated(String name) {
    return 'Aberto por $name';
  }

  @override
  String eventTaken(String name) {
    return 'Assumido por $name';
  }

  @override
  String eventReassigned(String from, String to) {
    return 'Reatribuído de $from para $to';
  }

  @override
  String eventStatus(String name, String status) {
    return '$name alterou o status para $status';
  }

  @override
  String get eventReopened => 'Reaberto pelo usuário';

  @override
  String get eventOverdue => 'Sem resposta dentro do prazo';

  @override
  String get eventAutoClosed => 'Encerrado automaticamente';

  @override
  String get presenceOnline => 'Online';

  @override
  String get presenceAway => 'Ausente';

  @override
  String get presenceOffline => 'Offline';

  @override
  String get presenceAvailable => 'Disponível para o chat';

  @override
  String get presenceAvailableSubtitle =>
      'Os usuários podem iniciar um chat enquanto um atendente estiver online';

  @override
  String get supportOperators => 'Atendentes';

  @override
  String get supportOperatorsSubtitle =>
      'Atividade, casos e tempos de resposta';

  @override
  String get operatorOpenCases => 'Casos abertos';

  @override
  String get operatorTaken => 'Assumidos';

  @override
  String get operatorResolved => 'Resolvidos';

  @override
  String get operatorReplies => 'Respostas';

  @override
  String get operatorAvgHandling => 'Tempo médio por caso';

  @override
  String operatorLastActive(String time) {
    return 'Última atividade $time';
  }

  @override
  String get operatorCases => 'Casos';

  @override
  String get noOperators =>
      'Ainda não há atendentes. Adicione em Equipe de suporte.';

  @override
  String get statUnassigned => 'Pedidos não atribuídos';

  @override
  String get statUnanswered => 'Pedidos sem resposta';

  @override
  String get statOverdue => 'Respostas atrasadas';

  @override
  String get alertSupportTitle => 'Respostas do suporte';

  @override
  String get alertSupportDescription =>
      'Quando o suporte CodaMi escreve para você';

  @override
  String durationSeconds(int n) {
    return '$n s';
  }

  @override
  String durationMinutes(int n) {
    return '$n min';
  }

  @override
  String durationHours(int h, int m) {
    return '$h h $m min';
  }

  @override
  String durationDays(int d, int h) {
    return '$d d $h h';
  }

  @override
  String get searchUsersHint => 'Buscar por nome ou e-mail';

  @override
  String get searchTooShort => 'Digite pelo menos 2 caracteres';

  @override
  String get pickStaffTitle => 'Escolha um usuário';

  @override
  String get pickStaffHint =>
      'Toque em uma pessoa para adicioná-la à equipe de suporte.';

  @override
  String makeStaffTitle(String name) {
    return 'Tornar $name parte do suporte?';
  }

  @override
  String get makeStaffMessage =>
      'Essa pessoa verá a área de administração e poderá responder pedidos e chats. Você pode removê-la a qualquer momento.';

  @override
  String get makeStaff => 'Adicionar à equipe';

  @override
  String get supportStaffSwitch => 'Equipe de suporte';

  @override
  String get supportStaffSwitchSubtitle => 'Pode responder pedidos e chats';

  @override
  String staffRemoved(String name) {
    return '$name não faz mais parte da equipe de suporte.';
  }

  @override
  String get removeStaffCasesNote => 'Os casos abertos voltam para a fila.';

  @override
  String get pushOpen => 'Abrir';

  @override
  String get chatToday => 'Hoje';

  @override
  String get chatLoadEarlier => 'Carregar mensagens anteriores';

  @override
  String get supportPeople => 'Pessoas';

  @override
  String get supportTimes => 'Tempos';

  @override
  String get supportRequestInfo => 'Pedido';

  @override
  String get supportType => 'Tipo';

  @override
  String get supportResolve => 'Marcar como resolvido';

  @override
  String ticketsWaiting(int count) {
    return '$count aguardando resposta';
  }

  @override
  String get ticketsAllClear => 'Tudo em dia';

  @override
  String get photoReviewHint =>
      'Fotos retidas pela IA. Ficam ocultas até decidires.';

  @override
  String get reasonAdult => 'Nudez ou conteúdo sexual';

  @override
  String get reasonRacy => 'Conteúdo provocador';

  @override
  String get reasonViolence => 'Violência ou sangue';

  @override
  String get likelihoodPossible => 'Possível';

  @override
  String get likelihoodLikely => 'Provável';

  @override
  String get likelihoodVeryLikely => 'Muito provável';

  @override
  String get hiddenByAi => 'Oculta pela IA';

  @override
  String get petPhoto => 'Foto do animal';

  @override
  String get listingPhoto => 'Foto do anúncio';

  @override
  String uploadedBy(String name) {
    return 'De $name';
  }

  @override
  String get tapToView => 'Toca para ver';

  @override
  String get approvePhoto => 'Aprovar';

  @override
  String get removePhotoTitle => 'Remover esta foto?';

  @override
  String get removePhotoMessage =>
      'Será removida do animal ou do anúncio do utilizador, que será informado do motivo.';

  @override
  String get photoApproved => 'Foto aprovada';

  @override
  String get photoRemovedDone => 'Foto removida';

  @override
  String get photoUnderReview =>
      'A nossa equipa está a verificar uma foto, que fica oculta até lá.';

  @override
  String get reportedTabPhotos => 'Fotos IA';

  @override
  String get reportedTabReports => 'Denúncias';

  @override
  String get noPhotosToReview => 'Nenhuma foto para rever';

  @override
  String get noPhotosToReviewMessage =>
      'As fotos retidas pela IA vão aparecer aqui.';

  @override
  String get aFriend => 'Um amigo';

  @override
  String get addContact => 'Adicionar contacto';

  @override
  String get addTestContacts => 'Adicionar contactos de teste';

  @override
  String get adjustPoints => 'Ajustar pontos';

  @override
  String get adjustPointsAmount => 'Pontos a adicionar ou retirar';

  @override
  String get adjustPointsAmountHelp =>
      'Usa o sinal menos para retirar pontos, ex. -20';

  @override
  String get adjustPointsInvalid => 'Introduz um número de pontos e um motivo.';

  @override
  String get adjustPointsReason => 'Motivo (visível para o utilizador)';

  @override
  String get adminContactsSubtitle =>
      'Veterinários, associações e serviços mostrados aos utilizadores';

  @override
  String get adminEmergenciesSubtitle => 'Emergências com animais comunicadas';

  @override
  String get alertEmergencyDescription =>
      'Animais que precisam de ajuda urgente perto da tua cidade';

  @override
  String get alertEmergencyTitle => 'Emergências por perto';

  @override
  String get allContacts => 'Todos';

  @override
  String get ambassadorLevels => 'Níveis de embaixador';

  @override
  String get call112 => 'Ligar para o 112';

  @override
  String get claim => 'Receber';

  @override
  String get claimed => 'Recebido';

  @override
  String get codeCopied => 'Código copiado';

  @override
  String get confirm => 'Confirmar';

  @override
  String get contactActive => 'Visível para os utilizadores';

  @override
  String get contactActiveHelp =>
      'Desativa para ocultar o contacto sem o apagar.';

  @override
  String get contactAddress => 'Morada';

  @override
  String get contactAreaKm => 'Zona abrangida (km)';

  @override
  String get contactAreaKmHelp =>
      'Até que distância da morada pode ajudar. Deixa vazio para usar o valor predefinido das definições de emergência.';

  @override
  String get contactCity => 'Localidade';

  @override
  String get contactHandles => 'Emergências que atende';

  @override
  String get contactHandlesHelp =>
      'Deixa tudo desativado se atender qualquer tipo.';

  @override
  String get contactHoursHint => 'Horário, ex. Seg–Sex 9:00–18:00';

  @override
  String get contactInactive => 'Oculto';

  @override
  String get contactKindAssociation => 'Associação de proteção animal';

  @override
  String get contactKindOther => 'Outro serviço';

  @override
  String get contactKindPublicService => 'Serviço veterinário público';

  @override
  String get contactKindVet => 'Veterinário';

  @override
  String get contactMissingFields =>
      'Adiciona um nome e coloca o marcador no mapa.';

  @override
  String get contactName => 'Nome';

  @override
  String get contactNameHint => 'ex. Clínica Veterinária São Francisco';

  @override
  String get contactPhones => 'Números de telefone';

  @override
  String get contactPhonesHint => 'Separa os números com vírgulas';

  @override
  String get contactPlace => 'Onde fica';

  @override
  String get contactRecommendedHelp =>
      'Aparece antes de contactos mais próximos quando é comunicada uma emergência.';

  @override
  String get contactTestHelp =>
      'Contacto fictício para testes. Mostrado com a etiqueta TESTE, nunca verificado nem contactado por email.';

  @override
  String get contactType => 'Tipo';

  @override
  String get contactVerifiedHelp =>
      'Só depois de a organização aceitar aparecer e de os dados serem confirmados.';

  @override
  String get copyCode => 'Copiar';

  @override
  String get dailyActive => 'Ativo hoje';

  @override
  String get dailyCheckin => 'Check-in diário';

  @override
  String get dailyRewards => 'Prémios diários';

  @override
  String get deleteContactTitle => 'Apagar este contacto?';

  @override
  String get directions => 'Direções';

  @override
  String get editContact => 'Editar contacto';

  @override
  String get emergencies => 'Emergências';

  @override
  String get emergenciesActive => 'Ativas';

  @override
  String get emergenciesAll => 'Todas';

  @override
  String get emergenciesNearYou => 'Perto de ti';

  @override
  String get emergenciesSubtitle => 'Animais que precisam de ajuda urgente';

  @override
  String get emergencyAddPhotos => 'Adiciona uma foto';

  @override
  String get emergencyAddPhotosHint =>
      'Ajuda os outros a encontrar e reconhecer o animal';

  @override
  String get emergencyAllContacts => 'Ver todos os contactos de emergência';

  @override
  String get emergencyAlreadyReported => 'Já comunicaste isto.';

  @override
  String get emergencyCallReporter => 'Ligar a quem comunicou';

  @override
  String get emergencyClose => 'Fechar';

  @override
  String get emergencyCloseTitle => 'Fechar esta emergência?';

  @override
  String get emergencyContacts => 'Contactos de emergência';

  @override
  String get emergencyDetails => 'O que está a acontecer?';

  @override
  String get emergencyDetailsHint =>
      'ex. Cão atropelado, deitado à beira da estrada, ainda respira';

  @override
  String get emergencyDetailsRequired =>
      'Descreve a situação em poucas palavras.';

  @override
  String get emergencyDisclaimer =>
      'O CodaMi não é um serviço de emergência. Se um animal estiver em perigo imediato, liga primeiro para o 112 ou para um veterinário. Não dependas só das notificações da app.';

  @override
  String get emergencyFalseAlarmTitle => 'Marcar como falso alarme?';

  @override
  String get emergencyFindingContacts =>
      'A procurar contactos perto deste local…';

  @override
  String get emergencyHelpDone => 'Obrigado! Quem comunicou foi avisado.';

  @override
  String get emergencyHelpMessage =>
      'Quem comunicou vai saber que alguém está a caminho. Vai só se for seguro para ti.';

  @override
  String get emergencyHelpTitle => 'Vais ajudar?';

  @override
  String get emergencyImHelping => 'Vou ajudar';

  @override
  String get emergencyMarkFalseAlarm => 'Marcar como falso alarme';

  @override
  String get emergencyMarkResolved => 'Marcar como resolvida';

  @override
  String get emergencyMissingFields =>
      'Escolhe o que aconteceu e o animal, descreve a situação e coloca o marcador.';

  @override
  String get emergencyNoContacts =>
      'Ainda não há contactos para esta zona. Liga para o 112 ou para um veterinário.';

  @override
  String get emergencyPhoneHint =>
      'Visível para quem quer ajudar, para te poderem ligar.';

  @override
  String get emergencyPinHint =>
      'Move o mapa para pôr o marcador onde está o animal.';

  @override
  String get emergencyPinned => 'Marcador colocado';

  @override
  String get emergencyReopen => 'Reabrir';

  @override
  String get emergencyReportFalse => 'Denunciar como falsa';

  @override
  String get emergencyReportFalseDone =>
      'Obrigado, a nossa equipa vai verificar.';

  @override
  String get emergencyReportFalseMessage =>
      'A nossa equipa vai verificar esta emergência.';

  @override
  String get emergencyReportFalseTitle => 'Esta emergência é falsa?';

  @override
  String get emergencyResolveTitle => 'Marcar como resolvida?';

  @override
  String get emergencyResolved => 'Marcada como resolvida';

  @override
  String get emergencySend => 'Enviar emergência';

  @override
  String get emergencySendFailed =>
      'Não foi possível enviar a emergência. Verifica a ligação e tenta outra vez, ou liga para o 112.';

  @override
  String get emergencySending => 'A enviar…';

  @override
  String get emergencySent =>
      'Emergência enviada. As pessoas por perto estão a ser avisadas. Também podes ligar diretamente para os contactos abaixo.';

  @override
  String get emergencySettings => 'Definições de emergência';

  @override
  String get emergencySettingsSubtitle =>
      'Distâncias dos avisos e ordem dos contactos';

  @override
  String get emergencyStatusClosed => 'Fechada';

  @override
  String get emergencyStatusFalseAlarm => 'Falso alarme';

  @override
  String get emergencyStatusHelping => 'Ajuda a caminho';

  @override
  String get emergencyStatusOpen => 'Precisa de ajuda';

  @override
  String get emergencyStatusResolved => 'Resolvida';

  @override
  String get emergencySuggestedContacts => 'Quem pode ajudar';

  @override
  String get emergencySuggestedContactsHint =>
      'Primeiro os contactos adequados mais próximos. Liga-lhes diretamente.';

  @override
  String get emergencyTypeAbandoned => 'Animal abandonado';

  @override
  String get emergencyTypeDanger => 'Animal em perigo';

  @override
  String get emergencyTypeInjured => 'Animal ferido';

  @override
  String get emergencyTypeIntervention => 'Pedido de intervenção';

  @override
  String get emergencyTypeOther => 'Outra emergência';

  @override
  String get emergencyTypeUrgentFound =>
      'Encontrado, precisa de cuidados urgentes';

  @override
  String get emergencyUnavailable => 'Esta emergência já não está disponível.';

  @override
  String get emergencyWhatHappened => 'O que aconteceu?';

  @override
  String get emergencyWhere => 'Onde está o animal?';

  @override
  String get emergencyWhereHint =>
      'O local exato é partilhado para que quem ajuda consiga encontrar o animal.';

  @override
  String get emergencyYouAreHelping => 'Disseste que vais ajudar. Obrigado!';

  @override
  String get emergencyYourPhone => 'O teu telefone';

  @override
  String get flagBurst =>
      'Muitos amigos deste utilizador ficaram ativos no mesmo dia';

  @override
  String get flagDeviceUsed => 'Este telemóvel já foi usado para outro convite';

  @override
  String get flagSameDevice => 'Mesmo telemóvel de quem o convidou';

  @override
  String get haveInviteCode => 'Um amigo convidou-te? Introduz o código dele';

  @override
  String get invitePromptTitle => 'Foste convidado por um amigo?';

  @override
  String get invitePromptBody =>
      'Introduz o código de convite dele para que o teu amigo receba o crédito por te trazer para o CodaMi.';

  @override
  String invitePromptLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Também o podes adicionar mais tarde em Perfil → Convidar amigos, nos $days dias após o registo.',
      one:
          'Também o podes adicionar mais tarde hoje em Perfil → Convidar amigos.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeLabel => 'Código de convite';

  @override
  String get inviteCodeFromLink =>
      'Preenchido a partir do seu link de convite. Toque em Usar para confirmar.';

  @override
  String get inviteCodeFormat =>
      'Os códigos de convite têm 6 letras e números, como ABC234.';

  @override
  String get inviteCodeNotFound =>
      'Não encontrámos este código. Confirma-o com o teu amigo.';

  @override
  String get inviteCodeOwn =>
      'Este é o teu próprio código. Partilha-o com os teus amigos.';

  @override
  String inviteCodeTooLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Os códigos de convite só podem ser adicionados nos primeiros $days dias após o registo.',
      one: 'Os códigos de convite só podem ser adicionados no dia do registo.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeTooManyTries =>
      'Demasiados códigos errados hoje. Tenta novamente amanhã.';

  @override
  String get howInvitesWork => 'Como funciona';

  @override
  String get inviteApproved => 'Convite aprovado';

  @override
  String get inviteCodeAlreadyUsed => 'Já usaste um código de convite.';

  @override
  String get inviteCodeInvalid => 'Este código não é válido.';

  @override
  String get inviteCodeNotAllowed =>
      'Não podes usar este código: é o teu próprio código, ou já passou demasiado tempo desde o registo.';

  @override
  String get inviteFriends => 'Convidar amigos';

  @override
  String get inviteFriendsSubtitle => 'Torna-te embaixador do CodaMi';

  @override
  String get inviteIntro =>
      'Cada novo utilizador do CodaMi é mais um par de olhos para os animais perdidos. Convida os teus amigos e torna-te embaixador do CodaMi.';

  @override
  String get inviteRejected => 'Convite recusado';

  @override
  String get inviteStatusExpired => 'Não ficou ativo a tempo';

  @override
  String get inviteStatusPending => 'Registado, ainda não ativo';

  @override
  String get inviteStatusQualified => 'Ativo – pontos ganhos';

  @override
  String get inviteStatusRejected => 'Não contabilizado';

  @override
  String get inviteStatusReview => 'Em verificação';

  @override
  String get inviteStep1 =>
      'Partilha o teu código. O teu amigo introduz-o em Perfil → Convidar amigos depois de se registar.';

  @override
  String get invitedFriends => 'Amigos convidados (ativos)';

  @override
  String get invitesToReview => 'Convites para rever';

  @override
  String get invitesToReviewSubtitle =>
      'Convites retidos pelos controlos antifraude';

  @override
  String get levelAmbassador => 'Embaixador';

  @override
  String get levelBonus => 'Pontos de bónus';

  @override
  String get settingsActiveFriends => 'Amigos ativos';

  @override
  String get levelChampion => 'Campeão CodaMi';

  @override
  String get levelSuperAmbassador => 'Super Embaixador';

  @override
  String get levelSupporter => 'Apoiante';

  @override
  String get myEmergencies => 'As minhas';

  @override
  String get myPoints => 'Os meus pontos';

  @override
  String get noActiveEmergencies => 'Sem emergências';

  @override
  String get noEmergenciesMessage =>
      'As emergências comunicadas perto da tua cidade aparecem aqui.';

  @override
  String get noEmergenciesNearby => 'Sem emergências perto de ti';

  @override
  String get noEmergencyContacts => 'Ainda não há contactos';

  @override
  String get noEmergencyContactsAdmin =>
      'Adiciona veterinários, associações e serviços, ou contactos de teste para experimentar a função.';

  @override
  String get noEmergencyContactsMessage =>
      'Em breve serão adicionados contactos. Numa emergência, liga para o 112 ou para um veterinário.';

  @override
  String get noInvitesToReview => 'Nada para rever';

  @override
  String get noInvitesToReviewMessage =>
      'Os convites suspeitos aparecem aqui. Nenhum é recusado sem ti.';

  @override
  String get noInvitesYet =>
      'Ainda não há convites. Partilha o teu código para começar.';

  @override
  String get noLevelYet => 'Ainda sem nível';

  @override
  String get noMyEmergencies => 'Não comunicaste emergências';

  @override
  String get noPointsYet =>
      'Ainda não tens pontos. Recebe o teu prémio diário para começar.';

  @override
  String get open24h => 'Aberto 24 horas';

  @override
  String get openMapFailed => 'Não foi possível abrir o mapa.';

  @override
  String get photos => 'Fotos';

  @override
  String get pointsAdjusted => 'Ajustado pelo CodaMi';

  @override
  String get pointsDailyActive => 'Ativo hoje';

  @override
  String get pointsDailyCheckin => 'Check-in diário';

  @override
  String get pointsFriendJoined => 'Um amigo ficou ativo';

  @override
  String get pointsHistory => 'Histórico';

  @override
  String get pointsLevelBonus => 'Bónus de novo nível';

  @override
  String get pointsOther => 'Pontos';

  @override
  String get pointsSettings => 'Pontos e prémios';

  @override
  String get pointsSettingsIntro =>
      'As alterações aplicam-se de imediato. Os valores fora dos limites são substituídos pelos predefinidos.';

  @override
  String get pointsSettingsSubtitle => 'Prémios diários, convites e níveis';

  @override
  String get pointsStreakBonus => 'Bónus de sequência';

  @override
  String get pointsWelcome => 'Bónus de boas-vindas';

  @override
  String get recommendedContact => 'Recomendado';

  @override
  String get reject => 'Recusar';

  @override
  String get reportEmergency => 'Comunicar uma emergência';

  @override
  String get searchContacts => 'Pesquisar por nome ou localidade';

  @override
  String get settingsActiveMinutes => 'Minutos de utilização para “Ativo hoje”';

  @override
  String get settingsAlertsNearby => 'Avisos a pessoas por perto';

  @override
  String get settingsAutoCloseHours => 'Fechar após (horas sem novidades)';

  @override
  String get settingsAutoCloseHoursHelp =>
      'As emergências abertas fecham sozinhas após este tempo.';

  @override
  String get settingsCodeEntryDays =>
      'Dias após o registo para introduzir um código';

  @override
  String get settingsContactsPriority => 'Prioridade dos contactos';

  @override
  String get settingsDefaultAreaKm => 'Zona predefinida (km)';

  @override
  String get settingsDefaultAreaKmHelp =>
      'Usada para contactos sem zona própria.';

  @override
  String get settingsEmailContacts => 'Avisos por email aos contactos';

  @override
  String get settingsEmailContactsHelp =>
      'Envia um email aos contactos verificados. Primeiro é preciso configurar o serviço de email.';

  @override
  String get settingsMaxPerDay =>
      'Amigos ativos por dia antes de uma verificação';

  @override
  String get settingsMaxPerDayHelp =>
      'Acima disto em 24 horas, o convite vai para verificação.';

  @override
  String get settingsMaxRecipients => 'Máximo de pessoas avisadas';

  @override
  String get settingsMaxSuggested => 'Contactos sugeridos';

  @override
  String get settingsMinRecipients => 'Pessoas a alcançar';

  @override
  String get settingsMinRecipientsHelp =>
      'Usa-se o círculo seguinte até alcançar este número de pessoas.';

  @override
  String get settingsQualifyDays => 'Dias de atividade necessários';

  @override
  String get settingsQualifyWithinDays => 'No prazo de (dias após o registo)';

  @override
  String get settingsReferralPoints => 'Pontos por cada amigo ativo';

  @override
  String get settingsRings => 'Círculos de aviso (km)';

  @override
  String get settingsRingsHelp =>
      'Separados por vírgulas, do menor para o maior, ex. 5, 10, 25';

  @override
  String get settingsSaved => 'Guardado';

  @override
  String get settingsStreakDays => 'Dias para o bónus de sequência';

  @override
  String get settingsWeight24h => 'Bónus por aberto 24 horas';

  @override
  String get settingsWeightHelp =>
      'Os contactos recebem estes bónus e perdem pontos por cada km de distância. A pontuação mais alta aparece primeiro.';

  @override
  String get settingsWeightPerKm => 'Penalização por km';

  @override
  String get settingsWeightPerKmHelp =>
      'Com 1, um contacto recomendado (20) aparece antes de outro até 20 km mais perto.';

  @override
  String get settingsWeightRecommended => 'Bónus por recomendado';

  @override
  String get settingsWeightVerified => 'Bónus por verificado';

  @override
  String get settingsWelcomePoints => 'Pontos para o amigo convidado';

  @override
  String get settingsWelcomePointsHelp =>
      'Dados quando introduz um código. 0 desativa.';

  @override
  String get shareInvite => 'Partilhar';

  @override
  String get statActiveEmergencies => 'Emergências ativas';

  @override
  String get testContactBadge => 'TESTE – não é um contacto real';

  @override
  String get topLevelReached => 'Chegaste ao nível mais alto. Obrigado!';

  @override
  String get useCode => 'Usar';

  @override
  String get verifiedContact => 'Verificado';

  @override
  String get viewInvitee => 'Utilizador convidado';

  @override
  String get viewInviter => 'Quem convidou';

  @override
  String get yourInviteCode => 'O teu código de convite';

  @override
  String get yourInvites => 'Os teus convites';

  @override
  String get zeroTurnsOff => '0 desativa';

  @override
  String activeProgress(int done, int total) {
    return '$done de $total minutos hoje';
  }

  @override
  String claimedPoints(int points) {
    return '+$points pontos!';
  }

  @override
  String claimedWithBonus(int points, int bonus) {
    return '+$points pontos e +$bonus de bónus de sequência!';
  }

  @override
  String emergenciesNearYouCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count emergências com animais perto de ti',
      one: '1 emergência com animais perto de ti',
    );
    return '$_temp0';
  }

  @override
  String emergencyAlertedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pessoas por perto foram avisadas',
      one: '1 pessoa por perto foi avisada',
      zero: 'Ainda ninguém por perto tem os avisos ativos',
    );
    return '$_temp0';
  }

  @override
  String emergencyFalseReports(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Denunciada como falsa $count vezes',
      one: 'Denunciada como falsa uma vez',
    );
    return '$_temp0';
  }

  @override
  String emergencyHelpersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pessoas vão ajudar',
      one: '1 pessoa vai ajudar',
    );
    return '$_temp0';
  }

  @override
  String inviteCodeAccepted(String name) {
    return 'Código aceite. Foste convidado por $name: bem-vindo ao CodaMi!';
  }

  @override
  String inviteShareText(String code, String link) {
    return 'Uso o CodaMi para ajudar os animais perdidos a voltar a casa. Junta-te com o meu código de convite $code: $link';
  }

  @override
  String inviteStep2(int days, int within) {
    return 'Define a sua cidade e usa a app em $days dias diferentes nos $within dias após o registo.';
  }

  @override
  String inviteStep3(int points) {
    return 'Recebes $points pontos e sobes nos níveis de embaixador.';
  }

  @override
  String kmAway(String km) {
    return 'a $km km';
  }

  @override
  String levelFriends(String level) {
    return '$level: amigos ativos';
  }

  @override
  String levelRule(String level, int friends, int bonus) {
    return '$level · $friends+ amigos · +$bonus';
  }

  @override
  String nextLevelHint(int count, String level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mais $count amigos ativos para seres $level',
      one: 'Mais 1 amigo ativo para seres $level',
    );
    return '$_temp0';
  }

  @override
  String plusPoints(int points) {
    return '+$points pontos';
  }

  @override
  String pointsTotal(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points pontos',
      one: '1 ponto',
    );
    return '$_temp0';
  }

  @override
  String streakLine(int streak, int days, int bonus) {
    return 'Sequência de $streak dias · +$bonus de bónus a cada $days dias';
  }

  @override
  String get pointsFeedback => 'Opinião enviada';

  @override
  String get whatsNew => 'Novidades';

  @override
  String get whatsNewSubtitle => 'As alterações de cada versão';

  @override
  String get whatsNewTitle => 'Novidades do CodaMi';

  @override
  String get whatsNewIntro => 'Eis o que mudou na última atualização.';

  @override
  String whatsNewVersion(String version) {
    return 'Versão $version';
  }

  @override
  String get whatsNewSectionNew => 'Novo';

  @override
  String get whatsNewSectionImproved => 'Melhorado';

  @override
  String get whatsNewSectionFixed => 'Corrigido';

  @override
  String get whatsNewEmpty => 'Ainda não há notas de atualização.';

  @override
  String get whatsNewDone => 'Entendido';

  @override
  String get feedbackTitle => 'O que achas do CodaMi?';

  @override
  String get feedbackBody =>
      'A tua opinião chega diretamente à equipa do CodaMi e ajuda-nos a melhorar a app.';

  @override
  String feedbackPointsOffer(int points) {
    return '+$points pontos pela tua primeira opinião';
  }

  @override
  String get feedbackStarsHint => 'Toca numa estrela para avaliar';

  @override
  String get feedbackCommentHint =>
      'O que gostas, ou o que podia ser melhor? (opcional)';

  @override
  String get feedbackSend => 'Enviar opinião';

  @override
  String get feedbackLater => 'Agora não';

  @override
  String get feedbackThanks => 'Obrigado pela tua opinião!';

  @override
  String feedbackThanksPoints(int points) {
    return 'Obrigado pela tua opinião! +$points pontos';
  }

  @override
  String get feedbackAlreadyToday =>
      'Já enviaste uma opinião hoje. Podes enviar outra amanhã.';

  @override
  String get sendFeedbackSubtitle => 'Diz à equipa o que pensas';

  @override
  String get rateCodaMi => 'Avaliar o CodaMi';

  @override
  String get rateCodaMiSubtitle => 'Deixa uma avaliação no Google Play';

  @override
  String get adminFeedback => 'Opiniões';

  @override
  String get adminFeedbackSubtitle => 'O que os utilizadores pensam da app';

  @override
  String get adminFeedbackEmpty => 'Ainda não há opiniões.';

  @override
  String feedbackRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count avaliações',
      one: '1 avaliação',
    );
    return '$_temp0';
  }

  @override
  String get feedbackNoComment => 'Sem comentário';

  @override
  String get adminWhatsNewSubtitle =>
      'Notas mostradas aos utilizadores após cada atualização';

  @override
  String get releaseAdd => 'Adicionar versão';

  @override
  String get releaseEdit => 'Editar notas';

  @override
  String get releaseVersion => 'Número da versão';

  @override
  String get releaseVersionHelp =>
      'Por exemplo 1.1.0. Tem de corresponder ao nome da versão da app na loja.';

  @override
  String get releaseVersionInvalid =>
      'Usa números e pontos, por exemplo 1.1.0.';

  @override
  String get releaseVersionExists => 'Esta versão já tem notas.';

  @override
  String get releasePublishedHelp =>
      'Os utilizadores só veem as notas publicadas.';

  @override
  String get releaseDraft => 'Rascunho';

  @override
  String get releaseLinesHelp => 'Uma alteração por linha.';

  @override
  String get releaseLanguageHelp =>
      'Os idiomas deixados em branco mostram as notas em inglês.';

  @override
  String get releaseEnglishRequired =>
      'Escreve primeiro as notas em inglês: os outros idiomas recorrem a elas.';

  @override
  String get releaseDeleteTitle => 'Eliminar estas notas?';

  @override
  String releaseDeleteBody(String version) {
    return 'As notas da versão $version serão removidas para todos.';
  }

  @override
  String get releaseNone =>
      'Ainda não há versões. Adiciona as notas da tua próxima atualização.';

  @override
  String releaseThisApp(String version) {
    return 'Esta app: versão $version';
  }

  @override
  String get feedbackAndReviews => 'Opiniões e avaliações';

  @override
  String get settingsFeedbackPoints => 'Pontos pela primeira opinião';

  @override
  String get settingsFeedbackAfterDays =>
      'Dias após o registo antes de pedir uma opinião';

  @override
  String get settingsReviewActiveDays => 'Dias de utilização antes de pedir';

  @override
  String get settingsReviewAfterDays =>
      'Dias após o registo antes da janela de avaliação da loja';

  @override
  String get settingsReviewEveryDays =>
      'Dias entre pedidos de avaliação na loja';

  @override
  String get settingsReviewHelp =>
      'A janela de avaliação da loja nunca dá pontos: o Google Play e a App Store não o permitem.';

  @override
  String get petitions => 'Petições';

  @override
  String get petition => 'Petição';

  @override
  String get petitionsSubtitle =>
      'Campanhas pelo bem-estar animal escolhidas pela nossa equipa';

  @override
  String get adminPetitionsSubtitle =>
      'Adicionar, rever e publicar petições pelo bem-estar animal';

  @override
  String petitionsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count petições pelo bem-estar animal para assinar',
      one: '1 petição pelo bem-estar animal para assinar',
    );
    return '$_temp0';
  }

  @override
  String get petitionsIntro =>
      'A equipa CodaMi verifica cada petição antes de aparecer aqui. Leia-a e assine-a no site original.';

  @override
  String get petitionsEmpty =>
      'Ainda não há petições. A equipa vai adicionar aqui campanhas pelo bem-estar animal.';

  @override
  String get petitionAdminEmpty =>
      'Não há petições aqui. Toque em Adicionar petição para adicionar uma do Change.org, Care2, Avaaz ou de uma organização de confiança.';

  @override
  String get petitionView => 'Ver petição';

  @override
  String get petitionSignOnSite => 'Ler e assinar no site original';

  @override
  String get petitionOpenFailed =>
      'Não foi possível abrir a página da petição.';

  @override
  String get petitionIssue => 'O problema';

  @override
  String get petitionAction => 'O que a petição pede';

  @override
  String get petitionWhy => 'Porque é importante para os animais';

  @override
  String get petitionWhere => 'Petição original';

  @override
  String petitionStartedOn(String date) {
    return 'Iniciada a $date';
  }

  @override
  String get petitionDisclaimer =>
      'Esta petição está alojada num site externo. A CodaMi não recolhe assinaturas e não é responsável pelo conteúdo da página original.';

  @override
  String get petitionEndedNote =>
      'Esta campanha terminou. Ainda pode ler a página original.';

  @override
  String get petitionUnavailableNote =>
      'A petição original já não está disponível.';

  @override
  String get petitionTopicPets => 'Animais de estimação';

  @override
  String get petitionTopicWildlife => 'Vida selvagem';

  @override
  String get petitionTopicFarm => 'Animais de quinta';

  @override
  String get petitionTopicTesting => 'Testes em animais';

  @override
  String get petitionTopicEntertainment => 'Circos e zoos';

  @override
  String get petitionTopicMarine => 'Vida marinha';

  @override
  String get petitionTopicOther => 'Outros';

  @override
  String get petitionStatusActive => 'Ativa';

  @override
  String get petitionStatusCompleted => 'Concluída';

  @override
  String get petitionStatusClosed => 'Encerrada';

  @override
  String get petitionStatusUnavailable => 'Já não disponível';

  @override
  String get petitionReviewPending => 'Por rever';

  @override
  String get petitionReviewApproved => 'Aprovada';

  @override
  String get petitionReviewRejected => 'Rejeitada';

  @override
  String get petitionAdd => 'Adicionar petição';

  @override
  String get petitionEdit => 'Editar petição';

  @override
  String get petitionSectionSource => 'Petição original';

  @override
  String get petitionUrl => 'Link da petição';

  @override
  String get petitionUrlInvalid =>
      'Cole o link completo, a começar por https://';

  @override
  String get petitionTitle => 'Título';

  @override
  String get petitionSource => 'Plataforma ou organização';

  @override
  String get petitionCountry => 'País ou região';

  @override
  String get petitionCountryHelp =>
      'Deixe em branco para campanhas internacionais.';

  @override
  String get petitionStartedOnPick => 'Data de início da petição (opcional)';

  @override
  String get petitionTopic => 'Tema';

  @override
  String get petitionSectionText => 'A nossa descrição';

  @override
  String get petitionOwnWordsHelp =>
      'Escreva por palavras suas. Não copie texto da página original.';

  @override
  String get petitionSummary => 'Resumo curto';

  @override
  String get petitionImage => 'Imagem';

  @override
  String get petitionImageAdd => 'Adicionar imagem';

  @override
  String get petitionImageChange => 'Alterar imagem';

  @override
  String get petitionImageHelp =>
      'Opcional. Sem imagem, o cartão mostra o ícone do tema.';

  @override
  String get petitionImagePermission =>
      'Temos autorização para usar esta imagem';

  @override
  String get petitionImagePermissionNeeded =>
      'Confirme que tem autorização para usar a imagem ou remova-a.';

  @override
  String get petitionImageTooBig =>
      'A imagem é demasiado grande. Escolha uma com menos de 5 MB.';

  @override
  String get petitionChecks => 'Verificação';

  @override
  String get petitionChecksHelp =>
      'As quatro são necessárias para aprovar ou publicar.';

  @override
  String get petitionCheckExists => 'A página original existe e abre';

  @override
  String get petitionCheckGenuine =>
      'Trata de um problema real de bem-estar animal';

  @override
  String get petitionCheckGoal => 'Tem um objetivo claro';

  @override
  String get petitionCheckHonest => 'Sem afirmações enganosas ou fraudulentas';

  @override
  String get petitionChecksNeeded =>
      'Marque todas as verificações antes de aprovar ou publicar.';

  @override
  String get petitionReview => 'Revisão';

  @override
  String get petitionReviewHelp =>
      'Só as petições publicadas são mostradas aos utilizadores.';

  @override
  String get petitionRejectReason => 'Motivo (visível só para administradores)';

  @override
  String get petitionStatus => 'Estado da petição';

  @override
  String get petitionStatusHelp =>
      'Atualize-o quando a campanha terminar ou a página for removida.';

  @override
  String get petitionFixFields => 'Preencha os campos assinalados a vermelho.';

  @override
  String get petitionDeleteTitle => 'Eliminar esta petição?';

  @override
  String get petitionDeleteBody => 'Será removida da app para todos.';

  @override
  String petitionAddedOn(String date) {
    return 'Adicionada a $date';
  }

  @override
  String petitionPublishedOn(String date) {
    return 'Publicada a $date';
  }

  @override
  String petitionUpdatedOn(String date) {
    return 'Atualizada a $date';
  }

  @override
  String get appUpdates => 'Atualizações do app';

  @override
  String get adminAppUpdatesSubtitle =>
      'Versões nas lojas e atualizações obrigatórias';

  @override
  String get appUpdatesSubtitle => 'Versões nas lojas';

  @override
  String get appUpdatesIntro =>
      'Quem tem uma versão anterior vê um aviso de atualização com as novidades da versão mais recente. Abaixo da versão mínima, o app não pode ser usado até ser atualizado. Não é preciso um novo build para mudar isso.';

  @override
  String appUpdatesThisPhone(String version) {
    return 'Este telefone tem a versão $version';
  }

  @override
  String get appUpdatesAndroid => 'Android (Google Play)';

  @override
  String get appUpdatesIos => 'iPhone (App Store)';

  @override
  String get appUpdatesLatest => 'Versão mais recente na loja';

  @override
  String get appUpdatesLatestHelp =>
      'Defina quando a atualização estiver disponível na loja. Deixe vazio para não mostrar aviso.';

  @override
  String get appUpdatesMinimum => 'Versão mínima';

  @override
  String get appUpdatesMinimumHelp =>
      'Versões anteriores precisam ser atualizadas antes de usar o app. Deixe vazio para nenhuma.';

  @override
  String get appUpdatesStoreId => 'ID da App Store';

  @override
  String get appUpdatesStoreIdHelp =>
      'O número no link da App Store (apps.apple.com/app/id…). Necessário para o botão Atualizar no iPhone.';

  @override
  String appUpdatesNotesPublished(String version) {
    return 'As novidades da $version estão publicadas e aparecem com a atualização';
  }

  @override
  String appUpdatesNotesDraft(String version) {
    return 'As novidades da $version estão salvas, mas não publicadas';
  }

  @override
  String appUpdatesNotesMissing(String version) {
    return 'Ainda não há novidades para a $version';
  }

  @override
  String get appUpdatesBadVersion => 'Use uma versão como 1.2.0';

  @override
  String get appUpdatesMinimumAbove =>
      'A mínima não pode ser maior que a versão mais recente';

  @override
  String get appUpdatesBadStoreId => 'O ID da App Store tem apenas dígitos';

  @override
  String get appUpdatesRequireTitle => 'Tornar a atualização obrigatória?';

  @override
  String appUpdatesRequireBody(String version) {
    return 'Todos abaixo da versão $version terão que atualizar antes de usar o app.';
  }

  @override
  String get appUpdatesRequireConfirm => 'Tornar obrigatória';

  @override
  String get updateAvailableTitle => 'Atualização disponível';

  @override
  String updateAvailableBody(String latest, String installed) {
    return 'A versão $latest do CodaMi está pronta. Você tem a $installed.';
  }

  @override
  String get updateNow => 'Atualizar agora';

  @override
  String get updateLater => 'Mais tarde';

  @override
  String get updateRequiredTitle => 'Atualização necessária';

  @override
  String updateRequiredBody(String version) {
    return 'Esta versão do CodaMi não é mais suportada. Atualize para a versão $version para continuar usando o app.';
  }

  @override
  String updateBanner(String version) {
    return 'A versão $version está disponível';
  }

  @override
  String get updateStoreFailed =>
      'Não foi possível abrir a loja. Atualize o CodaMi pelo app da loja.';

  @override
  String get rateCodaMiSubtitleIos => 'Deixe uma avaliação na App Store';

  @override
  String get updateContinueAsAdmin => 'Continuar como administrador';

  @override
  String get navShop => 'Loja';

  @override
  String get shop => 'Loja';

  @override
  String get adminShopSubtitle =>
      'Produtos, marcas, fornecedores e interruptor';

  @override
  String get shopSubtitle => 'Produtos para os seus animais';

  @override
  String get shopSearchHint => 'Pesquisar produtos';

  @override
  String get shopEmpty => 'Os produtos chegam em breve. Volte mais tarde!';

  @override
  String get shopNoResults => 'Nenhum produto corresponde.';

  @override
  String get shopInStock => 'Em stock';

  @override
  String get shopLowStock => 'Últimas unidades';

  @override
  String get shopOutOfStock => 'Esgotado';

  @override
  String get shopComingSoon => 'Em breve';

  @override
  String get shopModelOwnStock => 'Stock próprio';

  @override
  String get shopModelBrand => 'Marca parceira';

  @override
  String get shopModelDropship => 'Dropshipping';

  @override
  String get shopModelAffiliate => 'Link de afiliado';

  @override
  String get shopModelOwnStockHelp => 'A CodaMi tem o stock e envia.';

  @override
  String get shopModelBrandHelp =>
      'A marca vende através da CodaMi e envia a encomenda.';

  @override
  String get shopModelDropshipHelp =>
      'Um fornecedor envia a encomenda diretamente ao cliente.';

  @override
  String get shopModelAffiliateHelp =>
      'Comprado no site do parceiro através do nosso link; a CodaMi recebe comissão.';

  @override
  String shopBuyOn(String partner) {
    return 'Comprar na $partner';
  }

  @override
  String shopAffiliateNote(String partner) {
    return 'Vendido e enviado por $partner. A CodaMi pode receber uma comissão por esta compra.';
  }

  @override
  String shopPriceOnPartner(String partner) {
    return 'Preço na $partner';
  }

  @override
  String get shopAddToCart => 'Adicionar ao carrinho';

  @override
  String get shopCheckoutSoon => 'A compra na app chega em breve.';

  @override
  String get shopAllAnimals => 'Para todos os animais';

  @override
  String get shopDescription => 'Descrição';

  @override
  String get shopOpenFailed => 'Não foi possível abrir o link.';

  @override
  String get shopPreviewOff =>
      'Pré-visualização: a loja está desligada, os utilizadores não a veem.';

  @override
  String get shopAdminIntro =>
      'Gira a Loja CodaMi. Os utilizadores só a veem quando está ligada.';

  @override
  String get shopOpenSwitch => 'Loja aberta aos utilizadores';

  @override
  String get shopOnHelp => 'Ligada: todos veem o separador Loja.';

  @override
  String get shopOffHelp =>
      'Desligada: os utilizadores não a veem. Os admins podem prepará-la.';

  @override
  String get shopTurnOnTitle => 'Abrir a loja?';

  @override
  String get shopTurnOnBody =>
      'Todos os utilizadores verão logo o separador Loja e os produtos ativos.';

  @override
  String get shopTurnOffTitle => 'Fechar a loja?';

  @override
  String get shopTurnOffBody =>
      'O separador Loja desaparece logo para todos. Produtos e definições mantêm-se.';

  @override
  String get shopTurnOn => 'Abrir';

  @override
  String get shopTurnOff => 'Fechar';

  @override
  String get shopSalesModels => 'Modelos de venda';

  @override
  String get shopSalesModelsHelp =>
      'Desligar um modelo esconde todos os seus produtos.';

  @override
  String get shopCatalog => 'Catálogo';

  @override
  String get shopProducts => 'Produtos';

  @override
  String get shopCategories => 'Categorias';

  @override
  String get shopBrands => 'Marcas';

  @override
  String get shopSuppliers => 'Fornecedores';

  @override
  String get shopPreview => 'Pré-visualizar a loja';

  @override
  String get shopPreviewSubtitle => 'Ver a loja como os utilizadores';

  @override
  String shopProductsCount(int active, int total) {
    return '$active ativos · $total no total';
  }

  @override
  String get shopAddProduct => 'Adicionar produto';

  @override
  String get shopEditProduct => 'Editar produto';

  @override
  String get shopProductsEmpty => 'Ainda não há produtos. Adicione o primeiro.';

  @override
  String get shopActive => 'Ativo';

  @override
  String get shopHidden => 'Oculto';

  @override
  String get shopNeedCategory =>
      'Adicione primeiro uma categoria (Loja → Categorias).';

  @override
  String get shopPhotos => 'Fotos';

  @override
  String get shopPhotosHelp =>
      'Até 6 fotos. A primeira é a capa; mantenha premido e arraste para reordenar.';

  @override
  String get shopAddPhoto => 'Adicionar foto';

  @override
  String get shopImageTooBig => 'As imagens têm de ter menos de 5 MB.';

  @override
  String get shopDetails => 'Detalhes';

  @override
  String get shopName => 'Nome';

  @override
  String get shopCategory => 'Categoria';

  @override
  String get shopPickCategory => 'Escolha uma categoria';

  @override
  String get shopAnimals => 'Animais';

  @override
  String get shopAnimalsHelp =>
      'Sem seleção significa para todos os animais. Os utilizadores veem primeiro os produtos para os seus animais.';

  @override
  String get shopSalesModel => 'Modelo de venda';

  @override
  String get shopPartnerName => 'Loja parceira';

  @override
  String get shopAffiliateUrl => 'Link de afiliado';

  @override
  String get shopBrand => 'Marca';

  @override
  String get shopNoBrand => 'Sem marca';

  @override
  String get shopSupplier => 'Fornecedor';

  @override
  String get shopNoSupplier => 'Sem fornecedor';

  @override
  String get shopPriceSection => 'Preço';

  @override
  String get shopPrice => 'Preço (€)';

  @override
  String get shopPriceAffiliateHelp =>
      'Opcional: os preços mudam no site do parceiro.';

  @override
  String get shopPriceInvalid => 'Introduza um preço, por exemplo 12,90';

  @override
  String get shopCompareAt => 'Preço antes do desconto (€)';

  @override
  String get shopCompareAtHelp => 'Opcional. Aparece riscado ao lado do preço.';

  @override
  String get shopCompareAtInvalid => 'Tem de ser superior ao preço.';

  @override
  String get shopAvailability => 'Disponibilidade';

  @override
  String get shopVisible => 'Visível para os utilizadores';

  @override
  String get shopVisibleHelp =>
      'Os produtos ocultos só são vistos pelos admins.';

  @override
  String get shopCategoryVisibleHelp =>
      'Se oculta, a categoria e todos os produtos ficam escondidos.';

  @override
  String get shopBrandVisibleHelp =>
      'Se oculta, todos os produtos da marca ficam escondidos.';

  @override
  String get shopSupplierActiveHelp =>
      'Se desligado, todos os produtos deste fornecedor ficam escondidos.';

  @override
  String get shopDeleteProductTitle => 'Eliminar este produto?';

  @override
  String get shopDeleteProductBody =>
      'É removido da loja com as fotos. Não pode ser desfeito.';

  @override
  String shopDeleteTitle(String name) {
    return 'Eliminar $name?';
  }

  @override
  String get shopDeleteBody => 'Não pode ser desfeito.';

  @override
  String get shopInUse =>
      'Ainda é usado por produtos ou subcategorias e não pode ser eliminado. Oculte-o.';

  @override
  String get shopFixFields => 'Verifique os campos a vermelho.';

  @override
  String get shopLinkInvalid =>
      'Introduza um link completo começado por https://';

  @override
  String get shopAddCategory => 'Adicionar categoria';

  @override
  String get shopEditCategory => 'Editar categoria';

  @override
  String get shopAddStarting => 'Adicionar as categorias iniciais';

  @override
  String get shopStartingHelp =>
      'Comece com comida, acessórios, cuidados, brinquedos, camas, transportadoras, tecnologia e outros. Pode alterá-las depois.';

  @override
  String get shopParent => 'Dentro da categoria';

  @override
  String get shopNoParent => 'Nenhuma (categoria principal)';

  @override
  String get shopIcon => 'Ícone';

  @override
  String get shopOrder => 'Posição';

  @override
  String get shopOrderHelp => 'Números mais baixos aparecem primeiro.';

  @override
  String get shopCatFood => 'Alimentação';

  @override
  String get shopCatAccessories => 'Acessórios';

  @override
  String get shopCatCare => 'Cuidados';

  @override
  String get shopCatToys => 'Brinquedos';

  @override
  String get shopCatBeds => 'Camas';

  @override
  String get shopCatCarriers => 'Transportadoras';

  @override
  String get shopCatTech => 'Tecnologia';

  @override
  String get shopCatOther => 'Outros';

  @override
  String get shopAddBrand => 'Adicionar marca';

  @override
  String get shopEditBrand => 'Editar marca';

  @override
  String get shopBrandsEmpty =>
      'Ainda não há marcas. São opcionais; adicione-as quando tiver parceiros.';

  @override
  String get shopWebsite => 'Site';

  @override
  String get shopLogo => 'Logótipo';

  @override
  String get shopAddLogo => 'Escolher logótipo';

  @override
  String get shopAddSupplier => 'Adicionar fornecedor';

  @override
  String get shopEditSupplier => 'Editar fornecedor';

  @override
  String get shopSuppliersEmpty => 'Ainda não há fornecedores.';

  @override
  String get shopSuppliersHelp =>
      'Só os admins veem os fornecedores e os seus dados. Desligar um fornecedor esconde os produtos.';

  @override
  String get shopContactName => 'Pessoa de contacto';

  @override
  String get shopEmail => 'Email';

  @override
  String get shopEmailInvalid => 'Introduza um email válido.';

  @override
  String get shopPhone => 'Telefone';

  @override
  String get shopOrderMethod => 'Como recebem as encomendas';

  @override
  String get shopOrderManual => 'Manualmente';

  @override
  String get shopOrderManualHelp =>
      'A equipa encaminha cada encomenda ao fornecedor.';

  @override
  String get shopOrderEmail => 'Email automático';

  @override
  String get shopOrderEmailHelp =>
      'Cada encomenda paga é enviada por email ao fornecedor (com o checkout).';

  @override
  String get shopNotes => 'Notas (só admins)';

  @override
  String get shopForYourPets => 'Para os seus animais';

  @override
  String get shopOnSale => 'Em promoção';

  @override
  String get shopAllProducts => 'Todos os produtos';

  @override
  String get shopResults => 'Resultados';

  @override
  String shopProductCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count produtos',
      one: '1 produto',
    );
    return '$_temp0';
  }

  @override
  String shopYouSave(String amount) {
    return 'Poupa $amount';
  }

  @override
  String get shopCart => 'Carrinho';

  @override
  String get shopCartClear => 'Esvaziar';

  @override
  String get shopCartEmpty =>
      'O carrinho está vazio. Adicione produtos da loja.';

  @override
  String shopCartUnavailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count produtos já não estão disponíveis',
      one: '1 produto já não está disponível',
    );
    return '$_temp0';
  }

  @override
  String get shopCheckout => 'Finalizar';

  @override
  String get shopPaymentSoon => 'O pagamento na app chega em breve.';

  @override
  String get shopViewCart => 'Ver carrinho';

  @override
  String get shopShipping => 'Envio';

  @override
  String get shopShipTo => 'Enviar para';

  @override
  String get shopShippingNotSet =>
      'As opções de envio aparecerão aqui em breve.';

  @override
  String get shopFree => 'Grátis';

  @override
  String shopFreeAbove(String amount) {
    return 'Grátis acima de $amount';
  }

  @override
  String shopFreeShippingGap(String amount) {
    return 'Adicione mais $amount para envio grátis';
  }

  @override
  String get shopSummary => 'Resumo';

  @override
  String get shopSubtotal => 'Subtotal';

  @override
  String get shopTotal => 'Total';

  @override
  String get shopVatIncluded => 'IVA incluído';

  @override
  String get shopSponsored => 'Patrocinado';

  @override
  String get shopSponsoredSection => 'Patrocinado';

  @override
  String get shopSponsoredHelp =>
      'Mostrar primeiro na loja e na categoria, com a etiqueta \"Patrocinado\".';

  @override
  String get shopSponsorFrom => 'De';

  @override
  String get shopSponsorUntil => 'Até';

  @override
  String get shopSponsorDatesHelp =>
      'Deixe vazio para começar já e manter até desligar.';

  @override
  String get shopSponsorDatesInvalid => 'A data de fim é anterior à de início.';

  @override
  String get shopNoDate => 'Sem data';

  @override
  String get shopCost => 'Preço de custo (€, só admins)';

  @override
  String get shopCostHelp =>
      'O que a CodaMi paga ao fornecedor ou à marca. Os utilizadores nunca o veem.';

  @override
  String shopMargin(String amount, int percent) {
    return 'Margem: $amount ($percent%)';
  }

  @override
  String get shopAffiliateClicks => 'Cliques de afiliado';

  @override
  String shopClicksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cliques em \"Comprar\"',
      one: '1 clique em \"Comprar\"',
    );
    return '$_temp0';
  }

  @override
  String get shopLast30Days => 'Últimos 30 dias · toque para atualizar';

  @override
  String get shopShippingIntro =>
      'Para onde, como e a que preço envia. Preços com IVA. Aplica-se a todos de imediato.';

  @override
  String get shopShippingStarting => 'Adicionar a configuração inicial';

  @override
  String get shopZones => 'Zonas';

  @override
  String get shopZonesHelp =>
      'Zonas para onde envia. Desligue uma para deixar de enviar.';

  @override
  String get shopZoneName => 'Nome da zona';

  @override
  String get shopAddZone => 'Adicionar zona';

  @override
  String get shopZoneItaly => 'Itália';

  @override
  String get shopZoneIslands => 'Sicília e Sardenha';

  @override
  String get shopZoneEurope => 'União Europeia';

  @override
  String get shopMethod => 'Método de envio';

  @override
  String get shopAddMethod => 'Adicionar método de envio';

  @override
  String get shopMethodActive => 'Disponível para os utilizadores';

  @override
  String get shopMethodStandard => 'Normal';

  @override
  String get shopMethodExpress => 'Expresso';

  @override
  String get shopMethodStandardTime => '3–5 dias úteis';

  @override
  String get shopMethodExpressTime => '1–2 dias úteis';

  @override
  String get shopDeliveryTime => 'Prazo de entrega mostrado';

  @override
  String get shopPricePerZone => 'Preço por zona';

  @override
  String get shopPricePerZoneHelp =>
      'Deixe vazio onde não é oferecido. 0 significa grátis.';

  @override
  String get shopFreeAboveLabel => 'Envio grátis acima de (€)';

  @override
  String get shopFreeAboveHelp =>
      'Opcional. Deixe vazio para cobrar sempre o envio.';
}
