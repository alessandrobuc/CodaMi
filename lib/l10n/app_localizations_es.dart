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

  @override
  String get languageChangeLater =>
      'Puedes cambiarlo cuando quieras en tu perfil.';

  @override
  String get reward => 'Recompensa';

  @override
  String get rewardHint => 'Importe en euros';

  @override
  String get rewardNote =>
      'La recompensa es un acuerdo privado entre el dueño y quien encuentre al animal. CodaMi no garantiza ni gestiona ningún pago.';

  @override
  String rewardAmount(String amount) {
    return 'Recompensa $amount';
  }

  @override
  String get adminPanel => 'Panel de administración';

  @override
  String get roleAdmin => 'Administrador';

  @override
  String get roleSupport => 'Soporte';

  @override
  String get supportStaff => 'Equipo de soporte';

  @override
  String get supportStaffSubtitle =>
      'Personas que responden a las solicitudes de soporte';

  @override
  String get adminUsers => 'Usuarios';

  @override
  String get adminListings => 'Anuncios';

  @override
  String get adminReportedContent => 'Contenido denunciado';

  @override
  String get adminTickets => 'Solicitudes de soporte';

  @override
  String get adminVideos => 'Vídeos';

  @override
  String get addSupportStaff => 'Añadir al soporte';

  @override
  String get addSupportStaffHint =>
      'Introduce el email de una cuenta de CodaMi existente.';

  @override
  String get userNotFound => 'Ninguna cuenta de CodaMi usa este email.';

  @override
  String get alreadyStaff => 'Esta persona ya forma parte del equipo.';

  @override
  String staffAdded(String name) {
    return '$name ya forma parte del equipo de soporte.';
  }

  @override
  String removeStaffTitle(String name) {
    return '¿Quitar a $name?';
  }

  @override
  String get removeStaffMessage =>
      'Ya no tendrá acceso al panel de administración.';

  @override
  String get noSupportStaff => 'Todavía no hay nadie en el equipo de soporte.';

  @override
  String get add => 'Añadir';

  @override
  String get actionFailed => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get adminDashboard => 'Panel';

  @override
  String get adminMore => 'Más';

  @override
  String get adminReportedShort => 'Denunciados';

  @override
  String get adminTicketsShort => 'Solicitudes';

  @override
  String get adminSectionSoon => 'Esta sección llegará pronto.';

  @override
  String get statUsers => 'Usuarios registrados';

  @override
  String get statOpenLost => 'Perdidos abiertos';

  @override
  String get statOpenFound => 'Encontrados abiertos';

  @override
  String get statBackHome => 'Mascotas de vuelta en casa';

  @override
  String get flagListing => 'Denunciar anuncio';

  @override
  String get flagTitle => '¿Por qué denuncias este anuncio?';

  @override
  String get flagHint =>
      'Nuestro equipo lo revisará. El propietario no sabrá quién lo denunció.';

  @override
  String get flagReasonSpam => 'Spam o publicidad';

  @override
  String get flagReasonScam => 'Estafa o fraude';

  @override
  String get flagReasonInappropriate => 'Contenido inapropiado';

  @override
  String get flagReasonWrongInfo => 'Información falsa o engañosa';

  @override
  String get flagReasonOther => 'Otro motivo';

  @override
  String get flagNoteHint => 'Añade detalles (opcional)';

  @override
  String get flagSubmit => 'Enviar denuncia';

  @override
  String get flagSent => 'Gracias. Nuestro equipo revisará este anuncio.';

  @override
  String get alreadyFlagged => 'Ya has denunciado este anuncio.';

  @override
  String blockUser(String name) {
    return 'Bloquear a $name';
  }

  @override
  String blockUserTitle(String name) {
    return '¿Bloquear a $name?';
  }

  @override
  String get blockUserMessage =>
      'No verás sus anuncios ni recibirás avisos sobre ellos. Puedes desbloquearlo en Perfil → Usuarios bloqueados.';

  @override
  String get block => 'Bloquear';

  @override
  String userBlocked(String name) {
    return '$name está bloqueado.';
  }

  @override
  String get blockedUsers => 'Usuarios bloqueados';

  @override
  String get noBlockedUsers => 'No has bloqueado a nadie.';

  @override
  String get unblock => 'Desbloquear';

  @override
  String userUnblocked(String name) {
    return '$name está desbloqueado.';
  }

  @override
  String get unknownUser => 'Usuario desconocido';

  @override
  String get hiddenListing => 'Oculto';

  @override
  String get hiddenListingNotice =>
      'El equipo de CodaMi ha ocultado este anuncio y ya no es público.';

  @override
  String get moderation => 'Moderación';

  @override
  String get noFlagsOnListing => 'Nadie ha denunciado este anuncio.';

  @override
  String flagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Denunciado $count veces',
      one: 'Denunciado una vez',
    );
    return '$_temp0';
  }

  @override
  String get dismissFlags => 'Descartar denuncias';

  @override
  String get flagsDismissed => 'Denuncias descartadas.';

  @override
  String get hideListing => 'Ocultar anuncio';

  @override
  String get restoreListing => 'Restaurar anuncio';

  @override
  String get listingHidden =>
      'Anuncio oculto. Solo el propietario puede verlo.';

  @override
  String get listingRestored => 'Anuncio restaurado.';

  @override
  String get deleteListing => 'Eliminar anuncio';

  @override
  String get deleteListingTitle => '¿Eliminar este anuncio?';

  @override
  String get deleteListingMessage =>
      'El anuncio y sus fotos se eliminan para todos. No se puede deshacer.';

  @override
  String get listingDeleted => 'Anuncio eliminado.';

  @override
  String get listingUnavailable => 'Anuncio ya no disponible';

  @override
  String get noReportedContent => 'Nada denunciado';

  @override
  String get noReportedContentMessage =>
      'Los anuncios denunciados por los usuarios aparecerán aquí.';

  @override
  String get filterOpen => 'Abiertos';

  @override
  String get filterResolved => 'Resueltos';

  @override
  String get filterHidden => 'Ocultos';

  @override
  String get noListings => 'No hay anuncios';

  @override
  String get tryAnotherFilter => 'Prueba otro filtro.';

  @override
  String get adminUsersSubtitle => 'Ver, desactivar o eliminar cuentas';

  @override
  String get searchByEmail => 'Buscar por email';

  @override
  String get noUsersFound => 'No se encontraron usuarios.';

  @override
  String get roleUser => 'Usuario';

  @override
  String get userDisabled => 'Desactivado';

  @override
  String get phone => 'Teléfono';

  @override
  String get memberSince => 'Miembro desde';

  @override
  String get disableAccount => 'Desactivar cuenta';

  @override
  String get enableAccount => 'Activar cuenta';

  @override
  String disableUserTitle(String name) {
    return '¿Desactivar la cuenta de $name?';
  }

  @override
  String get disableUserMessage =>
      'Se cerrará su sesión y no podrá entrar. Sus anuncios abiertos se ocultarán hasta que la cuenta se active de nuevo.';

  @override
  String get accountDisabled => 'Cuenta desactivada.';

  @override
  String get accountEnabled => 'Cuenta activada.';

  @override
  String deleteUserTitle(String name) {
    return '¿Eliminar la cuenta de $name?';
  }

  @override
  String get deleteUserMessage =>
      'Se eliminan para siempre su perfil, mascotas, anuncios y fotos. No se puede deshacer.';

  @override
  String get userDeleted => 'Cuenta eliminada.';

  @override
  String get save => 'Guardar';

  @override
  String get requiredField => 'Obligatorio';

  @override
  String get notificationSettingsIntro =>
      'Elige qué avisos recibir y dale a cada uno su propio sonido, para saber qué ha pasado antes de mirar.';

  @override
  String get notificationSound => 'Sonido';

  @override
  String get alertLostTitle => 'Mascotas perdidas cerca';

  @override
  String get alertLostDescription =>
      'Cuando una mascota se pierde en tu ciudad';

  @override
  String get alertFoundTitle => 'Mascotas encontradas cerca';

  @override
  String get alertFoundDescription =>
      'Cuando alguien encuentra una mascota en tu ciudad';

  @override
  String get alertResolvedTitle => 'Finales felices';

  @override
  String get alertResolvedDescription =>
      'Cuando una mascota perdida o encontrada vuelve a casa';

  @override
  String get soundDefault => 'Predeterminado del teléfono';

  @override
  String get soundSilent => 'Silencio';

  @override
  String get soundChime => 'Campanilla';

  @override
  String get soundBell => 'Campana';

  @override
  String get soundBright => 'Brillante';

  @override
  String get soundSoft => 'Suave';

  @override
  String get soundCustom => 'Sonido personalizado';

  @override
  String get soundFromPhone => 'Tonos y melodías del teléfono';

  @override
  String get soundFromFile => 'Música o archivo de audio';

  @override
  String get soundIosNote =>
      'En iPhone, los sonidos de las notificaciones deben venir de la app, así que elige uno de los de arriba.';

  @override
  String get soundPickFailed => 'No se puede usar ese sonido. Prueba con otro.';

  @override
  String get videosForYou => 'Vídeos para ti';

  @override
  String get videosForYourPets => 'Elegidos para tus mascotas';

  @override
  String get videosGeneral => 'Bienestar animal y cuidado responsable';

  @override
  String get videosShuffle => 'Ver otros vídeos';

  @override
  String get videoMotivational => 'Motivación';

  @override
  String get videoEducational => 'Aprende';

  @override
  String get videoTagGeneral => 'Para todos';

  @override
  String get videoLoadError =>
      'No se puede reproducir este vídeo ahora. Inténtalo más tarde.';

  @override
  String get adminVideosSubtitle => 'Sube y gestiona vídeos';

  @override
  String get addVideo => 'Añadir vídeo';

  @override
  String get editVideo => 'Editar vídeo';

  @override
  String get noVideosYet =>
      'Aún no hay vídeos. Añade el primero con el botón de abajo.';

  @override
  String get deleteVideoTitle => '¿Eliminar este vídeo?';

  @override
  String get deleteVideoMessage =>
      'Se quitará de la app para todos. No se puede deshacer.';

  @override
  String get videoHidden => 'Oculto';

  @override
  String get allLanguages => 'Todos los idiomas';

  @override
  String get chooseVideo => 'Elige un vídeo';

  @override
  String get chooseVideoHint =>
      'De tu galería, hasta 200 MB. Los vídeos cortos (menos de 2 minutos) funcionan mejor.';

  @override
  String get videoTitle => 'Título';

  @override
  String get videoType => 'Tipo';

  @override
  String get videoAnimals => 'Animales';

  @override
  String get videoAnimalsHint =>
      'Elige los animales de los que trata el vídeo. Elige \"Para todos\" para vídeos generales que ven todos.';

  @override
  String get videoVisible => 'Visible en la app';

  @override
  String get videoVisibleHint =>
      'Los vídeos ocultos solo los ven los administradores.';

  @override
  String get videoTooLarge =>
      'El vídeo supera los 200 MB. Elige uno más corto.';

  @override
  String get videoSaved => 'Vídeo guardado.';

  @override
  String uploadingProgress(int percent) {
    return 'Subiendo… $percent%';
  }

  @override
  String get navVideos => 'Vídeos';

  @override
  String get videosEmptyTitle => 'Los vídeos están en camino';

  @override
  String get videosEmptyMessage =>
      'Pronto encontrarás aquí vídeos cortos sobre el cuidado de tus animales.';

  @override
  String get moreVideos => 'Más vídeos';

  @override
  String get videoWatched => 'Visto';

  @override
  String get videoBack10 => 'Retroceder 10 segundos';

  @override
  String get videoForward10 => 'Avanzar 10 segundos';

  @override
  String get videoFullscreen => 'Pantalla completa';

  @override
  String get videoExitFullscreen => 'Salir de pantalla completa';

  @override
  String get videoRetry => 'Reintentar';

  @override
  String get videoDeleted => 'Vídeo eliminado.';

  @override
  String get noVideosYetTitle => 'Aún no hay vídeos';

  @override
  String get videoVisibleShort => 'Visibles';

  @override
  String get play => 'Reproducir';

  @override
  String get edit => 'Editar';

  @override
  String get change => 'Cambiar';

  @override
  String get videoSectionFile => 'Vídeo';

  @override
  String get videoSectionDetails => 'Detalles';

  @override
  String get videoSectionAudience => 'Quién lo ve';

  @override
  String get videoCover => 'Portada';

  @override
  String get videoCoverHint => 'Opcional. Se muestra en la tarjeta del vídeo.';

  @override
  String get videoMotivationalHint =>
      'Historias inspiradoras y momentos felices';

  @override
  String get videoEducationalHint => 'Consejos y guías para dueños';

  @override
  String get uploadVideo => 'Subir vídeo';

  @override
  String get helpSupport => 'Ayuda y soporte';

  @override
  String get helpSupportSubtitle => 'Chatea con nosotros o envía una solicitud';

  @override
  String get supportIntroTitle => '¿Cómo podemos ayudarte?';

  @override
  String get supportIntroMessage =>
      'Nuestro equipo responde aquí en la app. Recibirás una notificación cuando respondamos.';

  @override
  String get supportStartChat => 'Iniciar un chat en vivo';

  @override
  String get supportStartChatOnline => 'Hay un operador conectado ahora';

  @override
  String get supportChatOffline =>
      'Ahora no hay ningún operador conectado. Envía una solicitud y te responderemos lo antes posible.';

  @override
  String get supportSendRequest => 'Enviar una solicitud';

  @override
  String get supportSendRequestSubtitle =>
      'Solemos responder en menos de 24 horas';

  @override
  String get supportMyRequests => 'Mis solicitudes';

  @override
  String get supportNoRequests => 'Aún no hay solicitudes';

  @override
  String get supportNoRequestsMessage =>
      'Tus conversaciones con soporte aparecerán aquí.';

  @override
  String get supportNewChat => 'Nuevo chat en vivo';

  @override
  String get supportNewRequest => 'Nueva solicitud';

  @override
  String get supportCategory => 'Tema';

  @override
  String get categoryAccount => 'Cuenta e inicio de sesión';

  @override
  String get categoryListing => 'Un anuncio de pérdida o hallazgo';

  @override
  String get categoryApp => 'Problema con la app';

  @override
  String get categoryOther => 'Otra cosa';

  @override
  String get supportSubject => 'Asunto';

  @override
  String get supportSubjectHint => 'En pocas palabras';

  @override
  String get supportSubjectTooShort => 'Escribe al menos 3 caracteres';

  @override
  String get supportMessage => 'Mensaje';

  @override
  String get supportMessageHint => 'Cuéntanos qué ha pasado';

  @override
  String get supportMessageRequired => 'Escribe un mensaje';

  @override
  String get supportSend => 'Enviar';

  @override
  String get supportTooManyOpen =>
      'Ya tienes 3 solicitudes abiertas. Continúa en una de ellas.';

  @override
  String get supportTypeMessage => 'Escribe un mensaje…';

  @override
  String get supportTeam => 'Soporte de CodaMi';

  @override
  String get supportMarkSolved => 'Marcar como resuelta';

  @override
  String get supportMarkSolvedConfirm =>
      '¿Marcar esta solicitud como resuelta? Puedes volver a escribir si aún necesitas ayuda.';

  @override
  String get supportClosedNote =>
      'Esta solicitud está cerrada. Abre una nueva si necesitas más ayuda.';

  @override
  String get supportResolvedNote =>
      'Marcada como resuelta. Si vuelves a escribir, se reabrirá.';

  @override
  String get supportWaitingNote =>
      '¡Gracias! Nuestro equipo te responderá aquí pronto.';

  @override
  String get kindChat => 'Chat en vivo';

  @override
  String get kindTicket => 'Solicitud';

  @override
  String get caseStatusOpen => 'Abierta';

  @override
  String get caseStatusInProgress => 'En curso';

  @override
  String get caseStatusWaitingUser => 'Esperando respuesta';

  @override
  String get caseStatusResolved => 'Resuelta';

  @override
  String get caseStatusClosed => 'Cerrada';

  @override
  String get filterUnanswered => 'Sin respuesta';

  @override
  String get filterUnassigned => 'Sin asignar';

  @override
  String get filterMine => 'Mías';

  @override
  String get filterActive => 'Activas';

  @override
  String get filterDone => 'Finalizadas';

  @override
  String get supportSearchHint => 'Buscar CM-1042 o email';

  @override
  String get supportNoCases => 'No hay solicitudes aquí';

  @override
  String get supportNoCasesMessage => 'No hay nada pendiente en esta lista.';

  @override
  String get supportTake => 'Hacerme cargo';

  @override
  String get supportTakeToReply =>
      'Hazte cargo de la solicitud para responder.';

  @override
  String get supportAlreadyTaken =>
      'Otro operador ya se ha hecho cargo de esta solicitud.';

  @override
  String get supportUnassigned => 'Sin asignar';

  @override
  String get supportReassign => 'Reasignar';

  @override
  String get supportAssignTo => 'Asignar a';

  @override
  String get supportBackToQueue => 'Devolver a la cola';

  @override
  String get supportChangeStatus => 'Cambiar estado';

  @override
  String get supportChat => 'Chat';

  @override
  String get supportTimeline => 'Historial';

  @override
  String get supportDetails => 'Detalles';

  @override
  String supportWaitingFor(String time) {
    return 'Esperando $time';
  }

  @override
  String get supportOverdue => 'Respuesta tardía';

  @override
  String get supportOpened => 'Abierta';

  @override
  String get supportTakenOver => 'Asumida';

  @override
  String get supportWaitToTake => 'Espera hasta asignación';

  @override
  String get supportFirstReply => 'Primera respuesta';

  @override
  String get supportAvgReply => 'Tiempo medio de respuesta';

  @override
  String get supportHandlingTime => 'Tiempo dedicado';

  @override
  String get supportResolvedAt => 'Resuelta';

  @override
  String get supportMessagesCount => 'Mensajes';

  @override
  String get supportOperator => 'Operador';

  @override
  String get supportUserLabel => 'Usuario';

  @override
  String eventCreated(String name) {
    return 'Abierta por $name';
  }

  @override
  String eventTaken(String name) {
    return 'Asumida por $name';
  }

  @override
  String eventReassigned(String from, String to) {
    return 'Reasignada de $from a $to';
  }

  @override
  String eventStatus(String name, String status) {
    return '$name cambió el estado a $status';
  }

  @override
  String get eventReopened => 'Reabierta por el usuario';

  @override
  String get eventOverdue => 'Sin respuesta dentro del plazo';

  @override
  String get eventAutoClosed => 'Cerrada automáticamente';

  @override
  String get presenceOnline => 'En línea';

  @override
  String get presenceAway => 'Ausente';

  @override
  String get presenceOffline => 'Desconectado';

  @override
  String get presenceAvailable => 'Disponible para el chat';

  @override
  String get presenceAvailableSubtitle =>
      'Los usuarios pueden iniciar un chat mientras haya un operador en línea';

  @override
  String get supportOperators => 'Operadores';

  @override
  String get supportOperatorsSubtitle =>
      'Actividad, casos y tiempos de respuesta';

  @override
  String get operatorOpenCases => 'Casos abiertos';

  @override
  String get operatorTaken => 'Asumidos';

  @override
  String get operatorResolved => 'Resueltos';

  @override
  String get operatorReplies => 'Respuestas';

  @override
  String get operatorAvgHandling => 'Tiempo medio por caso';

  @override
  String operatorLastActive(String time) {
    return 'Última actividad $time';
  }

  @override
  String get operatorCases => 'Casos';

  @override
  String get noOperators =>
      'Aún no hay personal de soporte. Añádelo en Personal de soporte.';

  @override
  String get statUnassigned => 'Solicitudes sin asignar';

  @override
  String get statUnanswered => 'Solicitudes sin respuesta';

  @override
  String get statOverdue => 'Respuestas tardías';

  @override
  String get alertSupportTitle => 'Respuestas de soporte';

  @override
  String get alertSupportDescription =>
      'Cuando el soporte de CodaMi te escribe';

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
  String get searchUsersHint => 'Buscar por nombre o email';

  @override
  String get searchTooShort => 'Escribe al menos 2 caracteres';

  @override
  String get pickStaffTitle => 'Elige un usuario';

  @override
  String get pickStaffHint =>
      'Toca a una persona para añadirla al equipo de soporte.';

  @override
  String makeStaffTitle(String name) {
    return '¿Hacer a $name parte del soporte?';
  }

  @override
  String get makeStaffMessage =>
      'Verá la sección de administración y podrá responder solicitudes y chats. Puedes quitarlo cuando quieras.';

  @override
  String get makeStaff => 'Añadir al equipo';

  @override
  String get supportStaffSwitch => 'Personal de soporte';

  @override
  String get supportStaffSwitchSubtitle =>
      'Puede responder solicitudes y chats';

  @override
  String staffRemoved(String name) {
    return '$name ya no forma parte del equipo de soporte.';
  }

  @override
  String get removeStaffCasesNote => 'Sus casos abiertos vuelven a la cola.';

  @override
  String get pushOpen => 'Abrir';

  @override
  String get chatToday => 'Hoy';

  @override
  String get chatLoadEarlier => 'Cargar mensajes anteriores';

  @override
  String get supportPeople => 'Personas';

  @override
  String get supportTimes => 'Tiempos';

  @override
  String get supportRequestInfo => 'Solicitud';

  @override
  String get supportType => 'Tipo';

  @override
  String get supportResolve => 'Marcar como resuelta';

  @override
  String ticketsWaiting(int count) {
    return '$count esperando respuesta';
  }

  @override
  String get ticketsAllClear => 'Todo al día';

  @override
  String get photoReviewHint =>
      'Fotos retenidas por la IA. Siguen ocultas hasta que decidas.';

  @override
  String get reasonAdult => 'Desnudos o contenido sexual';

  @override
  String get reasonRacy => 'Contenido provocativo';

  @override
  String get reasonViolence => 'Violencia o sangre';

  @override
  String get likelihoodPossible => 'Posible';

  @override
  String get likelihoodLikely => 'Probable';

  @override
  String get likelihoodVeryLikely => 'Muy probable';

  @override
  String get hiddenByAi => 'Ocultada por la IA';

  @override
  String get petPhoto => 'Foto de la mascota';

  @override
  String get listingPhoto => 'Foto del anuncio';

  @override
  String uploadedBy(String name) {
    return 'De $name';
  }

  @override
  String get tapToView => 'Toca para ver';

  @override
  String get approvePhoto => 'Aprobar';

  @override
  String get removePhotoTitle => '¿Eliminar esta foto?';

  @override
  String get removePhotoMessage =>
      'Se eliminará de la mascota o del anuncio del usuario, y se le explicará el motivo.';

  @override
  String get photoApproved => 'Foto aprobada';

  @override
  String get photoRemovedDone => 'Foto eliminada';

  @override
  String get photoUnderReview =>
      'Nuestro equipo está revisando una foto, que estará oculta hasta entonces.';

  @override
  String get reportedTabPhotos => 'Fotos IA';

  @override
  String get reportedTabReports => 'Denuncias de usuarios';

  @override
  String get noPhotosToReview => 'No hay fotos por revisar';

  @override
  String get noPhotosToReviewMessage =>
      'Aquí aparecerán las fotos que retenga la IA.';
}
