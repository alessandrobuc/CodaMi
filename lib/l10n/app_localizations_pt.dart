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
}
