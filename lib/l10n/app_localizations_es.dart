// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navHome => 'Inicio';

  @override
  String get navPets => 'Mascotas';

  @override
  String get navProfile => 'Perfil';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get notSet => 'Sin definir';

  @override
  String get soon => 'Pronto';

  @override
  String comingSoon(String feature) {
    return '$feature llegará pronto.';
  }

  @override
  String get profileTitle => 'Perfil';

  @override
  String get myPets => 'Mis mascotas';

  @override
  String get myReports => 'Mis avisos';

  @override
  String get homeCity => 'Ciudad';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get chooseLanguage => 'Elige tu idioma';

  @override
  String get language => 'Idioma';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get signOutTitle => '¿Cerrar sesión?';

  @override
  String get signOutMessage => 'Puedes volver a entrar cuando quieras.';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountTitle => '¿Eliminar tu cuenta?';

  @override
  String get deleteAccountMessage =>
      'Se eliminarán para siempre tu perfil, tus mascotas, tus avisos y sus fotos. No se puede deshacer.';

  @override
  String get deletingAccount => 'Eliminando tu cuenta…';

  @override
  String get myReportsSubtitle => 'Mantén tus avisos al día.';

  @override
  String get statTotal => 'Total';

  @override
  String postedOn(String date) {
    return 'Publicado el $date';
  }

  @override
  String get reportActive => 'Activos';

  @override
  String get reportResolved => 'Resueltos';

  @override
  String get myReportsLoadError => 'No se pudieron cargar tus avisos';

  @override
  String get checkConnection => 'Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get noActiveReports => 'No hay avisos activos';

  @override
  String get noActiveReportsMessage =>
      'Aquí aparecerán los avisos que publiques sobre mascotas perdidas o encontradas.';

  @override
  String get reportAPet => 'Avisar de una mascota';

  @override
  String get nothingResolved => 'Todavía no hay avisos resueltos';

  @override
  String get nothingResolvedMessage =>
      'Cuando marques un aviso como resuelto, aparecerá aquí.';

  @override
  String get markAsFound => 'Marcar como encontrada';

  @override
  String get returnedToOwner => 'Devuelta a su dueño';

  @override
  String get backHome => 'De vuelta en casa';

  @override
  String get reunited => 'Reunida';

  @override
  String get deleteReport => 'Eliminar aviso';

  @override
  String resolveLostTitle(String petName) {
    return '¿$petName ya está en casa?';
  }

  @override
  String get resolveFoundTitle => '¿Has encontrado al dueño?';

  @override
  String resolveLostMessage(String petName) {
    return 'El aviso pasará a \"De vuelta en casa\" en la pestaña Encontradas, para que los vecinos sepan que $petName está a salvo.';
  }

  @override
  String get resolveFoundMessage =>
      'El aviso pasará a \"Reunidas\" en la pestaña Encontradas.';

  @override
  String get notYet => 'Todavía no';

  @override
  String get yesResolved => 'Sí, resuelto';

  @override
  String get reportResolvedSuccess => '¡Qué buena noticia! Aviso resuelto.';

  @override
  String get deleteReportTitle => '¿Eliminar este aviso?';

  @override
  String deleteOpenReportMessage(String petName) {
    return 'Desaparecerá del mapa y de las listas. Si $petName está a salvo, mejor marca el aviso como resuelto para que los vecinos lo sepan.';
  }

  @override
  String get deleteResolvedReportMessage =>
      'Se quitará del mapa y de la lista \"De vuelta en casa\".';

  @override
  String get reportDeleted => 'Aviso eliminado.';

  @override
  String get onboarding1Title => 'Toda mascota merece\n';

  @override
  String get onboarding1Highlight => 'volver a casa';

  @override
  String get onboarding1Body =>
      'CodaMi une a los vecinos para que los perros y gatos perdidos vuelvan con quienes los quieren.';

  @override
  String get onboarding2Title => 'Avisa de una mascota\nen ';

  @override
  String get onboarding2Highlight => 'segundos';

  @override
  String get onboarding2Body =>
      'Haz una foto, marca el lugar y publica un aviso de pérdida o hallazgo. Quien esté cerca lo verá al instante.';

  @override
  String get onboarding3Title => 'Mira quién está\n';

  @override
  String get onboarding3Highlight => 'cerca';

  @override
  String get onboarding3Body =>
      'Mascotas perdidas y encontradas a tu alrededor, en directo en un solo mapa, para que siempre sepas dónde buscar.';

  @override
  String get skip => 'Saltar';

  @override
  String get getStarted => 'Empezar';

  @override
  String get lost => 'Perdida';

  @override
  String get found => 'Encontrada';

  @override
  String get you => 'Tú';

  @override
  String get published => 'Publicado';

  @override
  String get onboardingSampleBreed => 'Golden Retriever · 3 años';

  @override
  String get onboardingSamplePlace => 'Milán · hace 2 h';

  @override
  String get validationNameRequired => 'Escribe tu nombre';

  @override
  String get validationNameTooShort =>
      'El nombre debe tener al menos 2 caracteres';

  @override
  String get validationNameTooLong =>
      'El nombre debe tener menos de 50 caracteres';

  @override
  String get validationNameInvalid =>
      'El nombre solo puede tener letras, espacios, guiones y apóstrofos';

  @override
  String get validationEmailRequired => 'Escribe tu email';

  @override
  String get validationEmailInvalid => 'Escribe un email válido';

  @override
  String get validationPasswordRequired => 'Escribe tu contraseña';

  @override
  String get validationPasswordTooShort =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get validationConfirmRequired => 'Confirma tu contraseña';

  @override
  String get validationPasswordsDontMatch => 'Las contraseñas no coinciden';

  @override
  String get spamNote =>
      '¿No encuentras el email para restablecer la contraseña? Revisa la carpeta de Spam o Correo no deseado; a veces llega ahí.';

  @override
  String get logIn => 'Entrar';

  @override
  String get signUp => 'Registrarse';

  @override
  String get authResetSentTitle => 'Revisa tu correo';

  @override
  String get authResetSentSubtitle =>
      'Te hemos enviado un enlace para restablecer tu contraseña.';

  @override
  String get authLoginTitle => '¡Hola de nuevo!';

  @override
  String get authLoginSubtitle =>
      'Entra para seguir ayudando a las mascotas a volver a casa.';

  @override
  String get authSignupTitle => 'Únete a la manada';

  @override
  String get authSignupSubtitle => 'Crea una cuenta y ayuda a tu barrio.';

  @override
  String get authForgotTitle => '¿Olvidaste tu contraseña?';

  @override
  String get authForgotSubtitle =>
      'Tranquilo, te enviaremos un enlace por email para restablecerla.';

  @override
  String get fullName => 'Nombre completo';

  @override
  String get email => 'Email';

  @override
  String get password => 'Contraseña';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get sendResetLink => 'Enviar enlace';

  @override
  String get or => 'o';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get continueWithApple => 'Continuar con Apple';

  @override
  String get resetLinkSentTo => 'Hemos enviado un enlace a';

  @override
  String get backToLogIn => 'Volver a entrar';

  @override
  String get sendAgain => '¿No te ha llegado? Enviar de nuevo';

  @override
  String get errorOffline =>
      'No tienes conexión. Revísala e inténtalo de nuevo.';

  @override
  String get errorSessionExpired => 'Tu sesión ha caducado. Vuelve a entrar.';

  @override
  String get deleteAccountFailed =>
      'No se pudo eliminar tu cuenta. Inténtalo de nuevo.';

  @override
  String get authErrorGeneric => 'Algo ha fallado. Inténtalo de nuevo.';

  @override
  String get authErrorDisabled => 'Esta cuenta está desactivada.';

  @override
  String get authErrorWrongCredentials => 'Email o contraseña incorrectos.';

  @override
  String get authErrorEmailInUse =>
      'Ya existe una cuenta con este email. Prueba a entrar.';

  @override
  String get authErrorTooManyRequests =>
      'Demasiados intentos. Espera un momento e inténtalo de nuevo.';

  @override
  String get citySearchFailed =>
      'No se pudo buscar la ciudad. Inténtalo de nuevo.';

  @override
  String get placeSearchFailed =>
      'No se pudo buscar el lugar. Inténtalo de nuevo.';

  @override
  String get placeOutsideCity =>
      'Ese lugar está fuera de tu ciudad. Elige uno dentro de la ciudad.';

  @override
  String get placeNotFound => 'No hemos encontrado ese lugar. Elige otro.';

  @override
  String get citySearchOffline =>
      'No se pudo conectar con la búsqueda de ciudades. Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get searchCityHint => 'Busca tu ciudad, p. ej. Milán';

  @override
  String noCitiesFound(String query) {
    return 'No se encontraron ciudades para \"$query\".';
  }

  @override
  String homeCityUpdated(String city) {
    return 'Ciudad actualizada: $city.';
  }

  @override
  String get saveCityFailed =>
      'No se pudo guardar tu ciudad. Inténtalo de nuevo.';

  @override
  String get citySetupTitle => '¿Dónde ';

  @override
  String get citySetupHighlight => 'estás?';

  @override
  String get cityEditTitle => 'Cambia tu ';

  @override
  String get cityEditHighlight => 'ciudad';

  @override
  String get citySetupBody =>
      'Elige tu ciudad para mostrarte las mascotas perdidas y encontradas cerca y avisarte cuando se pierda una en tu zona.';

  @override
  String get saveCity => 'Guardar ciudad';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get notYouSignOut => '¿No eres tú? Cerrar sesión';

  @override
  String greeting(String name) {
    return '¡Hola, $name!';
  }

  @override
  String get showPetsWithin => 'Mostrar mascotas a menos de';

  @override
  String distanceFrom(String city) {
    return 'Distancia desde $city';
  }

  @override
  String get everywhere => 'En todas partes';

  @override
  String distanceKm(int km) {
    return '$km km';
  }

  @override
  String withinKm(int km) {
    return 'a menos de $km km';
  }

  @override
  String get areaNotSet => 'Zona sin definir';

  @override
  String get reportPetSemantics => 'Avisar de una mascota perdida o encontrada';

  @override
  String get map => 'Mapa';

  @override
  String get locationServicesOff =>
      'Activa la ubicación para usar tu posición.';

  @override
  String get locationPermissionDenied =>
      'Permite el acceso a la ubicación en Ajustes para usar tu posición.';

  @override
  String get locationFailed =>
      'No se pudo obtener tu ubicación. Inténtalo de nuevo.';

  @override
  String get back => 'Atrás';

  @override
  String get fullScreen => 'Pantalla completa';

  @override
  String get loadingPets => 'Cargando mascotas…';

  @override
  String get mapLoadFailed =>
      'No se pudieron cargar los avisos. Revisa tu conexión.';

  @override
  String get mapNoLost => 'No hay mascotas perdidas en esta zona';

  @override
  String get mapNoFound => 'No hay mascotas encontradas en esta zona';

  @override
  String get mapNoPets =>
      'No hay mascotas perdidas ni encontradas en esta zona';

  @override
  String get zoomIn => 'Acercar';

  @override
  String get zoomOut => 'Alejar';

  @override
  String get myLocation => 'Mi ubicación';

  @override
  String get myCity => 'Mi ciudad';

  @override
  String get all => 'Todas';

  @override
  String get timeJustNow => 'Ahora mismo';

  @override
  String timeMinutesAgo(int minutes) {
    return 'hace $minutes min';
  }

  @override
  String timeHoursAgo(int hours) {
    return 'hace $hours h';
  }

  @override
  String get timeYesterday => 'Ayer';

  @override
  String timeDaysAgo(int days) {
    return 'hace $days días';
  }

  @override
  String notifLostTitle(String city) {
    return 'Mascota perdida en $city';
  }

  @override
  String notifLostBodyNear(String pet, String street, String city) {
    return '$pet fue vista por última vez cerca de $street, $city. ¡Estate atento!';
  }

  @override
  String notifLostBodyIn(String pet, String city) {
    return '$pet fue vista por última vez en $city. ¡Estate atento!';
  }

  @override
  String notifFoundTitle(String city) {
    return 'Mascota encontrada en $city';
  }

  @override
  String notifFoundBodyNear(String pet, String street, String city) {
    return '$pet fue encontrada cerca de $street, $city. ¿Conoces a su dueño?';
  }

  @override
  String notifFoundBodyIn(String pet, String city) {
    return '$pet fue encontrada en $city. ¿Conoces a su dueño?';
  }

  @override
  String notifBackHomeTitle(String pet) {
    return '$pet está de vuelta en casa';
  }

  @override
  String notifBackHomeBody(String pet, String city) {
    return 'Buenas noticias desde $city: $pet ha aparecido. ¡Gracias por ayudar!';
  }

  @override
  String notifReunitedTitle(String pet) {
    return '$pet está con su familia';
  }

  @override
  String notifReunitedBody(String city) {
    return 'La mascota encontrada en $city ha vuelto con su familia.';
  }

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get markAllRead => 'Marcar todo como leído';

  @override
  String get notificationsLoadError =>
      'No se pudieron cargar las notificaciones';

  @override
  String get allCaughtUp => 'Estás al día';

  @override
  String get notificationsEmpty =>
      'Te avisaremos cuando se pierda o se encuentre una mascota en tu ciudad.';

  @override
  String get notificationsNew => 'Nuevas';

  @override
  String get notificationsEarlier => 'Anteriores';

  @override
  String get reportNotAvailable => 'Aviso no disponible';

  @override
  String get reportRemoved => 'Su autor ha eliminado este aviso.';

  @override
  String get reportsLoadError => 'No se pudieron cargar los avisos';

  @override
  String get pullToRetry =>
      'Revisa tu conexión y desliza hacia abajo para reintentar.';

  @override
  String get noLostNearby => 'No hay mascotas perdidas cerca';

  @override
  String get noLostNearbyMessage =>
      '¡Buenas noticias! Nadie ha avisado de una mascota perdida en tu zona.';

  @override
  String get noFoundYet => 'Aún no hay mascotas encontradas';

  @override
  String get noFoundYetMessage =>
      'Aquí aparecerán las mascotas que encuentren tus vecinos.';

  @override
  String get backHomeSection => 'De vuelta en casa';

  @override
  String get backHomeSectionSubtitle =>
      'Mascotas que han vuelto con sus familias.';

  @override
  String get loadMore => 'Cargar más';

  @override
  String get speciesDog => 'Perro';

  @override
  String get speciesCat => 'Gato';

  @override
  String get speciesOther => 'Otro';

  @override
  String get sexMale => 'Macho';

  @override
  String get sexFemale => 'Hembra';

  @override
  String get sexUnknown => 'No lo sé';

  @override
  String nearPlace(String street, String city) {
    return 'Cerca de $street, $city';
  }

  @override
  String get callFailed => 'No se pudo iniciar la llamada.';

  @override
  String get whatsappFailed => 'No se pudo abrir WhatsApp.';

  @override
  String get emailFailed => 'No se pudo abrir tu app de correo.';

  @override
  String whatsappMessageLost(String pet) {
    return '¡Hola! Te escribo por la mascota perdida \"$pet\" en CodaMi.';
  }

  @override
  String whatsappMessageFound(String pet) {
    return '¡Hola! Te escribo por la mascota encontrada \"$pet\" en CodaMi.';
  }

  @override
  String emailSubjectLost(String pet) {
    return 'Sobre $pet (mascota perdida en CodaMi)';
  }

  @override
  String emailSubjectFound(String pet) {
    return 'Sobre $pet (mascota encontrada en CodaMi)';
  }

  @override
  String shareTitleLost(String pet) {
    return 'MASCOTA PERDIDA: $pet';
  }

  @override
  String shareTitleFound(String pet) {
    return 'MASCOTA ENCONTRADA: $pet';
  }

  @override
  String get shareFooter =>
      '¿Has visto a esta mascota? Abre CodaMi para contactar.';

  @override
  String get lastSeen => 'Vista por última vez';

  @override
  String get foundAt => 'Encontrada en';

  @override
  String areaAbout(int meters) {
    return 'zona de unos $meters m';
  }

  @override
  String get when => 'Cuándo';

  @override
  String get postedBy => 'Publicado por';

  @override
  String get description => 'Descripción';

  @override
  String get call => 'Llamar';

  @override
  String contactTitleLost(String pet) {
    return '¿Has visto a $pet? Contacta';
  }

  @override
  String get contactTitleFound => '¿Es tu mascota? Contacta';

  @override
  String get noContactShared => 'No se han compartido datos de contacto.';

  @override
  String resolvedThanksLost(String pet) {
    return '$pet está de vuelta en casa. ¡Gracias por usar CodaMi!';
  }

  @override
  String get resolvedThanksFound =>
      'Esta mascota ha vuelto con su familia. ¡Gracias por ayudar!';

  @override
  String get yourContactDetails => 'Tus datos de contacto';

  @override
  String markPetAsFound(String pet) {
    return 'Marcar a $pet como encontrada';
  }

  @override
  String get markReturnedToOwner => 'Marcar como devuelta a su dueño';

  @override
  String get copiedToClipboard => 'Copiado al portapapeles.';

  @override
  String get petSaveFailed =>
      'No se pudo guardar tu mascota. Inténtalo de nuevo.';

  @override
  String get petDeleteFailed =>
      'No se pudo eliminar tu mascota. Inténtalo de nuevo.';

  @override
  String get errorPermission => 'No tienes permiso para hacer eso.';

  @override
  String get storageNotReady =>
      'El almacenamiento de fotos aún no está listo. Inténtalo más tarde.';

  @override
  String get storageFull =>
      'El almacenamiento está lleno. Inténtalo más tarde.';

  @override
  String petAdded(String name) {
    return '$name se ha añadido a tus mascotas.';
  }

  @override
  String get petsLoadError => 'No se pudieron cargar tus mascotas';

  @override
  String get noPetsYet => 'Aún no tienes mascotas';

  @override
  String get noPetsYetMessage =>
      'Añade tus mascotas ahora para poder avisar en segundos si alguna se pierde.';

  @override
  String get addFirstPet => 'Añade tu primera mascota';

  @override
  String get petsHeaderEmpty =>
      'Ten listos los perfiles de tus mascotas, por si acaso.';

  @override
  String petsHeaderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count amigos peludos, listos por si pasa algo.',
      one: '1 amigo peludo, listo por si pasa algo.',
    );
    return '$_temp0';
  }

  @override
  String get addPet => 'Añadir';

  @override
  String petUpdated(String name) {
    return '$name se ha actualizado.';
  }

  @override
  String removePetTitle(String name) {
    return '¿Eliminar a $name?';
  }

  @override
  String get removePetMessage =>
      'Se eliminarán el perfil y sus fotos. No se puede deshacer.';

  @override
  String get remove => 'Eliminar';

  @override
  String petRemoved(String name) {
    return '$name se ha eliminado.';
  }

  @override
  String get breed => 'Raza';

  @override
  String get color => 'Color';

  @override
  String get age => 'Edad';

  @override
  String get sex => 'Sexo';

  @override
  String petAddedOn(String date) {
    return 'Añadida el $date';
  }

  @override
  String get distinctiveFeatures => 'Rasgos distintivos';

  @override
  String ifPetGoesMissing(String name) {
    return 'Si $name se pierde';
  }

  @override
  String get ifPetGoesMissingBody =>
      'Publica un aviso de pérdida con este perfil en segundos y se avisará a los vecinos cercanos.';

  @override
  String reportPetAsLost(String name) {
    return 'Avisar de que $name se ha perdido';
  }

  @override
  String get colorBlack => 'Negro';

  @override
  String get colorWhite => 'Blanco';

  @override
  String get colorBrown => 'Marrón';

  @override
  String get colorGolden => 'Dorado';

  @override
  String get colorGrey => 'Gris';

  @override
  String get colorCream => 'Crema';

  @override
  String get colorGinger => 'Pelirrojo';

  @override
  String get petPhotoRequired => 'Añade al menos una foto de tu mascota.';

  @override
  String get petSpeciesRequired =>
      'Indica si tu mascota es un perro, un gato u otro.';

  @override
  String get checkHighlightedFields => 'Revisa los campos marcados.';

  @override
  String get signInToSave => 'Vuelve a entrar para guardar.';

  @override
  String get discardChangesTitle => '¿Descartar cambios?';

  @override
  String get discardPetChanges => 'Se perderán los cambios de esta mascota.';

  @override
  String get keepEditing => 'Seguir editando';

  @override
  String get discard => 'Descartar';

  @override
  String editPetTitle(String name) {
    return 'Editar a $name';
  }

  @override
  String get newPet => 'Nueva mascota';

  @override
  String get whatKindOfPet => '¿Qué tipo de mascota es?';

  @override
  String get name => 'Nombre';

  @override
  String get petNameHint => 'p. ej. Luna';

  @override
  String get petNameRequired => 'Escribe el nombre de tu mascota';

  @override
  String get petNameTooLong => 'El nombre debe tener menos de 40 caracteres';

  @override
  String get breedHint => 'p. ej. Golden Retriever, Mestizo';

  @override
  String get colorHint => 'p. ej. Dorado con el pecho blanco';

  @override
  String get ageHint => 'p. ej. 3 años, 8 meses';

  @override
  String get featuresHint =>
      'Collar, microchip, cicatrices, manchas… cualquier cosa que ayude a reconocer a tu mascota.';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get savePet => 'Guardar mascota';

  @override
  String get cameraPermission => 'Permite el acceso a la cámara en Ajustes.';

  @override
  String get photosPermission => 'Permite el acceso a las fotos en Ajustes.';

  @override
  String get cameraFailed => 'No se pudo abrir la cámara.';

  @override
  String get galleryFailed => 'No se pudo abrir la galería.';

  @override
  String get optional => 'Opcional';

  @override
  String get addPetPhotos => 'Añade fotos de tu mascota';

  @override
  String get addPetPhotosHint =>
      'Las fotos claras y recientes ayudan a reconocerla';

  @override
  String get photoRequired => 'Se necesita al menos una foto';

  @override
  String get tapToMakeCover => 'Toca una foto para que sea la portada.';

  @override
  String get cover => 'Portada';

  @override
  String uploadingPhotos(int percent) {
    return 'Subiendo fotos… $percent%';
  }

  @override
  String get saving => 'Guardando…';

  @override
  String get takePhoto => 'Hacer una foto';

  @override
  String get useCamera => 'Usa la cámara';

  @override
  String get chooseFromGallery => 'Elegir de la galería';

  @override
  String get pickExistingPhoto => 'Elige una foto que ya tengas';

  @override
  String get yourPet => 'tu mascota';

  @override
  String get unknownDog => 'Perro desconocido';

  @override
  String get unknownCat => 'Gato desconocido';

  @override
  String get unknownPet => 'Mascota desconocida';

  @override
  String get errorChooseType =>
      'Indica si has perdido o encontrado una mascota.';

  @override
  String get errorPickPet => 'Elige la mascota que se ha perdido.';

  @override
  String get errorFoundPhoto => 'Añade al menos una foto de la mascota.';

  @override
  String get errorFoundSpecies => '¿Es un perro, un gato u otro?';

  @override
  String get errorChooseCity => 'Elige la ciudad donde ocurrió.';

  @override
  String get errorFutureDate => 'La fecha no puede ser futura.';

  @override
  String get errorDescriptionShort =>
      'Añade una breve descripción (al menos 10 caracteres).';

  @override
  String get errorContactRequired =>
      'Añade un teléfono o un email para que puedan contactarte.';

  @override
  String get errorPhoneInvalid => 'Escribe un número de teléfono válido.';

  @override
  String get discardReportTitle => '¿Descartar este aviso?';

  @override
  String get discardReportMessage =>
      'Se perderá lo que has escrito hasta ahora.';

  @override
  String get signInToPublish => 'Vuelve a entrar para publicar.';

  @override
  String publishedLost(String pet) {
    return '$pet ya está en el mapa. Esperamos que vuelva pronto a casa.';
  }

  @override
  String publishedFound(String pet) {
    return '¡Gracias! $pet ya está en el mapa.';
  }

  @override
  String get reportLostPetTitle => 'Avisar de una mascota perdida';

  @override
  String get reportFoundPetTitle => 'Avisar de una mascota encontrada';

  @override
  String get newReport => 'Nuevo aviso';

  @override
  String stepOf(int current, int total) {
    return '$current de $total';
  }

  @override
  String get publishReport => 'Publicar aviso';

  @override
  String get stepTypeTitle => '¿Qué ha pasado?';

  @override
  String get stepTypeSubtitle =>
      'Corramos la voz entre la gente cercana, rápido.';

  @override
  String get stepFoundPetTitle => 'Háblanos de la mascota';

  @override
  String get stepFoundPetSubtitle =>
      'Una foto clara es la forma más rápida de que su dueño la reconozca.';

  @override
  String get addFoundPhotos => 'Añade fotos de la mascota';

  @override
  String get addFoundPhotosHint => 'Haz una ahora o elige una de tu galería';

  @override
  String get whatKindOfAnimal => '¿Qué animal es?';

  @override
  String get collarName => 'Nombre en el collar o la chapa';

  @override
  String get collarNameHint => 'Déjalo vacío si no lo sabes';

  @override
  String get stepLostPetTitle => '¿Qué mascota se ha perdido?';

  @override
  String get stepLostPetSubtitle =>
      'Usaremos su perfil y sus fotos para que no tengas que escribir nada de nuevo.';

  @override
  String get stepWhereFoundTitle => '¿Dónde la encontraste?';

  @override
  String stepWhereLostTitle(String pet) {
    return '¿Dónde se vio a $pet por última vez?';
  }

  @override
  String get stepWhereSubtitle =>
      'Elige la ciudad y marca el punto en el mapa. Los demás solo ven una zona de unos 100 m, nunca la dirección exacta.';

  @override
  String get streetOrLandmark => 'Calle o punto de referencia';

  @override
  String get pinExactSpot => 'Marca el punto exacto';

  @override
  String spotHintFound(String pet) {
    return 'Mueve el mapa hasta que el marcador esté donde encontraste a $pet.';
  }

  @override
  String spotHintLost(String pet) {
    return 'Mueve el mapa hasta que el marcador esté donde se vio a $pet por última vez.';
  }

  @override
  String spotFarFromCity(int km, String city) {
    return 'Este punto está a $km km de $city. ¿Es correcta la ciudad?';
  }

  @override
  String spotPinned(int meters) {
    return 'Listo. Los demás solo ven una zona de unos $meters m alrededor, nunca el punto exacto.';
  }

  @override
  String get timeHourAgo => 'Hace 1 hora';

  @override
  String get timeThisMorning => 'Esta mañana';

  @override
  String get stepWhenFoundTitle => '¿Cuándo la encontraste?';

  @override
  String stepWhenLostTitle(String pet) {
    return '¿Cuándo viste a $pet por última vez?';
  }

  @override
  String get stepWhenSubtitle => 'Una hora aproximada está bien.';

  @override
  String get changeDate => 'Cambiar fecha';

  @override
  String get changeTime => 'Cambiar hora';

  @override
  String get stepDetailsTitle => '¿Algo más que debamos saber?';

  @override
  String get stepDetailsSubtitle =>
      'Los detalles ayudan a los vecinos a reconocer a la mascota y a contactarte rápido.';

  @override
  String descriptionHintLost(String pet) {
    return 'Color del collar, carácter, cómo se perdió $pet…';
  }

  @override
  String get descriptionHintFound =>
      'Estado, collar, comportamiento, dónde la encontraste exactamente…';

  @override
  String get howToReachYou => '¿Cómo pueden contactarte?';

  @override
  String get contactPrivacyNote =>
      'Solo se muestra en la página del aviso, nunca en las listas.';

  @override
  String get phoneHint => 'Teléfono, p. ej. +39 333 123 4567';

  @override
  String get reachableOnWhatsapp => 'Disponible en WhatsApp';

  @override
  String get reachableOnWhatsappHint => 'Pueden escribirte a este número';

  @override
  String get stepReviewTitle => '¿Listo para publicar?';

  @override
  String get stepReviewSubtitle => 'Así verá tu aviso la gente cercana.';

  @override
  String get iLostMyPet => 'He perdido a mi mascota';

  @override
  String get iFoundAPet => 'He encontrado una mascota';

  @override
  String get iLostMyPetHint =>
      'Avisa a la gente cercana y consigue ayuda para buscar.';

  @override
  String get iFoundAPetHint => 'Ayuda a una mascota perdida a volver a casa.';

  @override
  String get addAPet => 'Añadir mascota';

  @override
  String get pleaseChooseCity => 'Elige una ciudad';

  @override
  String noPlacesFound(String city, String query) {
    return 'No se encontraron lugares en $city para \"$query\".';
  }

  @override
  String searchStreetHint(String city) {
    return 'Busca en $city, p. ej. Via Dante';
  }

  @override
  String get yourCity => 'tu ciudad';

  @override
  String get useMyLocation => 'Usar mi ubicación';

  @override
  String get publishFailed =>
      'No se pudo publicar tu aviso. Inténtalo de nuevo.';

  @override
  String get updateReportFailed =>
      'No se pudo actualizar el aviso. Inténtalo de nuevo.';

  @override
  String get deleteReportFailed =>
      'No se pudo eliminar el aviso. Inténtalo de nuevo.';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfUse => 'Términos de uso';

  @override
  String legalLastUpdated(String date) {
    return 'Última actualización: $date';
  }

  @override
  String get legalEnglishOnly =>
      'Este documento se muestra en inglés. Pronto estará disponible una traducción.';

  @override
  String get deleteAccountPasswordPrompt =>
      'Escribe tu contraseña para confirmar.';

  @override
  String deleteAccountTypeConfirm(String word) {
    return 'Escribe $word para confirmar.';
  }

  @override
  String get wrongPassword => 'Contraseña incorrecta. Inténtalo de nuevo.';

  @override
  String get confirmPasswordAgain =>
      'Por tu seguridad, vuelve a confirmar tu contraseña.';

  @override
  String get contactUs => 'Contáctanos';

  @override
  String get legalQuestions => '¿Preguntas sobre este documento o tus datos?';
}
