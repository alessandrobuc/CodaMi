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

  @override
  String get aFriend => 'Un amigo';

  @override
  String get addContact => 'Añadir contacto';

  @override
  String get addTestContacts => 'Añadir contactos de prueba';

  @override
  String get adjustPoints => 'Ajustar puntos';

  @override
  String get adjustPointsAmount => 'Puntos para añadir o quitar';

  @override
  String get adjustPointsAmountHelp =>
      'Usa el signo menos para quitar puntos, p. ej. -20';

  @override
  String get adjustPointsInvalid =>
      'Introduce un número de puntos y un motivo.';

  @override
  String get adjustPointsReason => 'Motivo (lo verá el usuario)';

  @override
  String get adminContactsSubtitle =>
      'Veterinarios, asociaciones y servicios que ven los usuarios';

  @override
  String get adminEmergenciesSubtitle => 'Emergencias animales reportadas';

  @override
  String get alertEmergencyDescription =>
      'Animales que necesitan ayuda urgente cerca de tu ciudad';

  @override
  String get alertEmergencyTitle => 'Emergencias cercanas';

  @override
  String get allContacts => 'Todos';

  @override
  String get ambassadorLevels => 'Niveles de embajador';

  @override
  String get call112 => 'Llamar al 112';

  @override
  String get claim => 'Reclamar';

  @override
  String get claimed => 'Reclamado';

  @override
  String get codeCopied => 'Código copiado';

  @override
  String get confirm => 'Confirmar';

  @override
  String get contactActive => 'Visible para los usuarios';

  @override
  String get contactActiveHelp =>
      'Desactívalo para ocultar el contacto sin borrarlo.';

  @override
  String get contactAddress => 'Dirección';

  @override
  String get contactAreaKm => 'Zona que cubre (km)';

  @override
  String get contactAreaKmHelp =>
      'Hasta qué distancia de su dirección puede ayudar. Déjalo vacío para usar el valor por defecto de los ajustes de emergencias.';

  @override
  String get contactCity => 'Localidad';

  @override
  String get contactHandles => 'Emergencias que atiende';

  @override
  String get contactHandlesHelp =>
      'Déjalas todas desactivadas si atiende cualquier tipo.';

  @override
  String get contactHoursHint => 'Horario, p. ej. Lun–Vie 9:00–18:00';

  @override
  String get contactInactive => 'Oculto';

  @override
  String get contactKindAssociation => 'Asociación protectora de animales';

  @override
  String get contactKindOther => 'Otro servicio';

  @override
  String get contactKindPublicService => 'Servicio veterinario público';

  @override
  String get contactKindVet => 'Veterinario';

  @override
  String get contactMissingFields =>
      'Añade un nombre y coloca el marcador en el mapa.';

  @override
  String get contactName => 'Nombre';

  @override
  String get contactNameHint => 'p. ej. Clínica Veterinaria San Francisco';

  @override
  String get contactPhones => 'Números de teléfono';

  @override
  String get contactPhonesHint => 'Separa los números con comas';

  @override
  String get contactPlace => 'Dónde está';

  @override
  String get contactRecommendedHelp =>
      'Aparece antes que contactos más cercanos cuando se reporta una emergencia.';

  @override
  String get contactTestHelp =>
      'Marcador para pruebas. Se muestra con la etiqueta PRUEBA, nunca se verifica ni recibe emails.';

  @override
  String get contactType => 'Tipo';

  @override
  String get contactVerifiedHelp =>
      'Solo después de que la organización acepte aparecer y se comprueben sus datos.';

  @override
  String get copyCode => 'Copiar';

  @override
  String get dailyActive => 'Activo hoy';

  @override
  String get dailyCheckin => 'Check-in diario';

  @override
  String get dailyRewards => 'Recompensas diarias';

  @override
  String get deleteContactTitle => '¿Borrar este contacto?';

  @override
  String get directions => 'Cómo llegar';

  @override
  String get editContact => 'Editar contacto';

  @override
  String get emergencies => 'Emergencias';

  @override
  String get emergenciesActive => 'Activas';

  @override
  String get emergenciesAll => 'Todas';

  @override
  String get emergenciesNearYou => 'Cerca de ti';

  @override
  String get emergenciesSubtitle => 'Animales que necesitan ayuda urgente';

  @override
  String get emergencyAddPhotos => 'Añade una foto';

  @override
  String get emergencyAddPhotosHint =>
      'Ayuda a otros a encontrar y reconocer al animal';

  @override
  String get emergencyAllContacts => 'Ver todos los contactos de emergencia';

  @override
  String get emergencyAlreadyReported => 'Ya lo has reportado.';

  @override
  String get emergencyCallReporter => 'Llamar a quien lo reportó';

  @override
  String get emergencyClose => 'Cerrar';

  @override
  String get emergencyCloseTitle => '¿Cerrar esta emergencia?';

  @override
  String get emergencyContacts => 'Contactos de emergencia';

  @override
  String get emergencyDetails => '¿Qué está pasando?';

  @override
  String get emergencyDetailsHint =>
      'p. ej. Perro atropellado, tumbado junto a la carretera, todavía respira';

  @override
  String get emergencyDetailsRequired =>
      'Describe la situación en pocas palabras.';

  @override
  String get emergencyDisclaimer =>
      'CodaMi no es un servicio de emergencias. Si un animal está en peligro inmediato, llama primero al 112 o a un veterinario. No dependas solo de las notificaciones de la app.';

  @override
  String get emergencyFalseAlarmTitle => '¿Marcar como falsa alarma?';

  @override
  String get emergencyFindingContacts =>
      'Buscando contactos cerca de este lugar…';

  @override
  String get emergencyHelpDone => '¡Gracias! Se ha avisado a quien lo reportó.';

  @override
  String get emergencyHelpMessage =>
      'Quien lo reportó sabrá que alguien va en camino. Ve solo si es seguro para ti.';

  @override
  String get emergencyHelpTitle => '¿Vas a ayudar?';

  @override
  String get emergencyImHelping => 'Voy a ayudar';

  @override
  String get emergencyMarkFalseAlarm => 'Marcar como falsa alarma';

  @override
  String get emergencyMarkResolved => 'Marcar como resuelta';

  @override
  String get emergencyMissingFields =>
      'Elige qué pasó y el animal, descríbelo y coloca el marcador.';

  @override
  String get emergencyNoContacts =>
      'Aún no hay contactos para esta zona. Llama al 112 o a un veterinario.';

  @override
  String get emergencyPhoneHint =>
      'Lo verán quienes quieran ayudar, para poder llamarte.';

  @override
  String get emergencyPinHint =>
      'Mueve el mapa para poner el marcador donde está el animal.';

  @override
  String get emergencyPinned => 'Marcador colocado';

  @override
  String get emergencyReopen => 'Reabrir';

  @override
  String get emergencyReportFalse => 'Reportar como falsa';

  @override
  String get emergencyReportFalseDone => 'Gracias, nuestro equipo lo revisará.';

  @override
  String get emergencyReportFalseMessage =>
      'Nuestro equipo revisará esta emergencia.';

  @override
  String get emergencyReportFalseTitle => '¿Esta emergencia es falsa?';

  @override
  String get emergencyResolveTitle => '¿Marcar como resuelta?';

  @override
  String get emergencyResolved => 'Marcada como resuelta';

  @override
  String get emergencySend => 'Enviar emergencia';

  @override
  String get emergencySendFailed =>
      'No se pudo enviar la emergencia. Comprueba tu conexión e inténtalo de nuevo, o llama al 112.';

  @override
  String get emergencySending => 'Enviando…';

  @override
  String get emergencySent =>
      'Emergencia enviada. Se está avisando a las personas cercanas. También puedes llamar directamente a los contactos de abajo.';

  @override
  String get emergencySettings => 'Ajustes de emergencias';

  @override
  String get emergencySettingsSubtitle =>
      'Distancias de los avisos y orden de los contactos';

  @override
  String get emergencyStatusClosed => 'Cerrada';

  @override
  String get emergencyStatusFalseAlarm => 'Falsa alarma';

  @override
  String get emergencyStatusHelping => 'Ayuda en camino';

  @override
  String get emergencyStatusOpen => 'Necesita ayuda';

  @override
  String get emergencyStatusResolved => 'Resuelta';

  @override
  String get emergencySuggestedContacts => 'Quién puede ayudar';

  @override
  String get emergencySuggestedContactsHint =>
      'Primero los contactos adecuados más cercanos. Llámalos directamente.';

  @override
  String get emergencyTypeAbandoned => 'Animal abandonado';

  @override
  String get emergencyTypeDanger => 'Animal en peligro';

  @override
  String get emergencyTypeInjured => 'Animal herido';

  @override
  String get emergencyTypeIntervention => 'Solicitud de intervención';

  @override
  String get emergencyTypeOther => 'Otra emergencia';

  @override
  String get emergencyTypeUrgentFound =>
      'Encontrado, necesita atención urgente';

  @override
  String get emergencyUnavailable => 'Esta emergencia ya no está disponible.';

  @override
  String get emergencyWhatHappened => '¿Qué ha pasado?';

  @override
  String get emergencyWhere => '¿Dónde está el animal?';

  @override
  String get emergencyWhereHint =>
      'Se comparte el lugar exacto para que quien ayude pueda encontrar al animal.';

  @override
  String get emergencyYouAreHelping => 'Has dicho que vas a ayudar. ¡Gracias!';

  @override
  String get emergencyYourPhone => 'Tu teléfono';

  @override
  String get flagBurst =>
      'Muchos amigos de este usuario se activaron el mismo día';

  @override
  String get flagDeviceUsed => 'Este teléfono ya se usó para otra invitación';

  @override
  String get flagSameDevice => 'Mismo teléfono que la persona que lo invitó';

  @override
  String get haveInviteCode => '¿Te invitó un amigo? Introduce su código';

  @override
  String get invitePromptTitle => '¿Te ha invitado un amigo?';

  @override
  String get invitePromptBody =>
      'Introduce su código de invitación para que tu amigo reciba el mérito de traerte a CodaMi.';

  @override
  String invitePromptLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'También puedes añadirlo más tarde en Perfil → Invitar amigos, en los $days días siguientes al registro.',
      one: 'También puedes añadirlo más tarde hoy en Perfil → Invitar amigos.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeLabel => 'Código de invitación';

  @override
  String get inviteCodeFromLink =>
      'Rellenado desde tu enlace de invitación. Toca Usar para confirmar.';

  @override
  String get inviteCodeFormat =>
      'Los códigos de invitación tienen 6 letras y números, como ABC234.';

  @override
  String get inviteCodeNotFound =>
      'No hemos encontrado este código. Compruébalo con tu amigo.';

  @override
  String get inviteCodeOwn =>
      'Este es tu propio código. Compártelo con tus amigos.';

  @override
  String inviteCodeTooLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'Los códigos de invitación solo se pueden añadir en los primeros $days días tras el registro.',
      one:
          'Los códigos de invitación solo se pueden añadir el día del registro.',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeTooManyTries =>
      'Demasiados códigos incorrectos hoy. Inténtalo mañana.';

  @override
  String get howInvitesWork => 'Cómo funciona';

  @override
  String get inviteApproved => 'Invitación aprobada';

  @override
  String get inviteCodeAlreadyUsed => 'Ya has usado un código de invitación.';

  @override
  String get inviteCodeInvalid => 'Este código no es válido.';

  @override
  String get inviteCodeNotAllowed =>
      'No puedes usar este código: es tu propio código o ha pasado demasiado tiempo desde que te registraste.';

  @override
  String get inviteFriends => 'Invitar amigos';

  @override
  String get inviteFriendsSubtitle => 'Hazte embajador de CodaMi';

  @override
  String get inviteIntro =>
      'Cada nuevo usuario de CodaMi es un par de ojos más para las mascotas perdidas. Invita a tus amigos y hazte embajador de CodaMi.';

  @override
  String get inviteRejected => 'Invitación rechazada';

  @override
  String get inviteStatusExpired => 'No se activó a tiempo';

  @override
  String get inviteStatusPending => 'Registrado, aún no activo';

  @override
  String get inviteStatusQualified => 'Activo – puntos conseguidos';

  @override
  String get inviteStatusRejected => 'No contabilizado';

  @override
  String get inviteStatusReview => 'En revisión';

  @override
  String get inviteStep1 =>
      'Comparte tu código. Tu amigo lo introduce en Perfil → Invitar amigos después de registrarse.';

  @override
  String get invitedFriends => 'Amigos invitados (activos)';

  @override
  String get invitesToReview => 'Invitaciones por revisar';

  @override
  String get invitesToReviewSubtitle =>
      'Invitaciones retenidas por los controles antifraude';

  @override
  String get levelAmbassador => 'Embajador';

  @override
  String get levelBonus => 'Puntos extra';

  @override
  String get settingsActiveFriends => 'Amigos activos';

  @override
  String get levelChampion => 'Campeón de CodaMi';

  @override
  String get levelSuperAmbassador => 'Superembajador';

  @override
  String get levelSupporter => 'Colaborador';

  @override
  String get myEmergencies => 'Mías';

  @override
  String get myPoints => 'Mis puntos';

  @override
  String get noActiveEmergencies => 'No hay emergencias';

  @override
  String get noEmergenciesMessage =>
      'Aquí aparecen las emergencias reportadas cerca de tu ciudad.';

  @override
  String get noEmergenciesNearby => 'No hay emergencias cerca de ti';

  @override
  String get noEmergencyContacts => 'Aún no hay contactos';

  @override
  String get noEmergencyContactsAdmin =>
      'Añade veterinarios, asociaciones y servicios, o añade contactos de prueba para probar la función.';

  @override
  String get noEmergencyContactsMessage =>
      'Pronto se añadirán contactos. En una emergencia, llama al 112 o a un veterinario.';

  @override
  String get noInvitesToReview => 'Nada que revisar';

  @override
  String get noInvitesToReviewMessage =>
      'Aquí aparecen las invitaciones sospechosas. Ninguna se rechaza sin ti.';

  @override
  String get noInvitesYet =>
      'Aún no hay invitaciones. Comparte tu código para empezar.';

  @override
  String get noLevelYet => 'Aún sin nivel';

  @override
  String get noMyEmergencies => 'No has reportado emergencias';

  @override
  String get noPointsYet =>
      'Aún no tienes puntos. Reclama tu recompensa diaria para empezar.';

  @override
  String get open24h => 'Abierto 24 horas';

  @override
  String get openMapFailed => 'No se pudo abrir el mapa.';

  @override
  String get photos => 'Fotos';

  @override
  String get pointsAdjusted => 'Ajustado por CodaMi';

  @override
  String get pointsDailyActive => 'Activo hoy';

  @override
  String get pointsDailyCheckin => 'Check-in diario';

  @override
  String get pointsFriendJoined => 'Un amigo se ha activado';

  @override
  String get pointsHistory => 'Historial';

  @override
  String get pointsLevelBonus => 'Extra por nuevo nivel';

  @override
  String get pointsOther => 'Puntos';

  @override
  String get pointsSettings => 'Puntos y recompensas';

  @override
  String get pointsSettingsIntro =>
      'Los cambios se aplican al momento. Los valores fuera de rango se sustituyen por los valores por defecto.';

  @override
  String get pointsSettingsSubtitle =>
      'Recompensas diarias, invitaciones y niveles';

  @override
  String get pointsStreakBonus => 'Extra por racha';

  @override
  String get pointsWelcome => 'Extra de bienvenida';

  @override
  String get recommendedContact => 'Recomendado';

  @override
  String get reject => 'Rechazar';

  @override
  String get reportEmergency => 'Reportar una emergencia';

  @override
  String get searchContacts => 'Buscar por nombre o localidad';

  @override
  String get settingsActiveMinutes => 'Minutos de uso para “Activo hoy”';

  @override
  String get settingsAlertsNearby => 'Avisos a personas cercanas';

  @override
  String get settingsAutoCloseHours =>
      'Cerrar después de (horas sin novedades)';

  @override
  String get settingsAutoCloseHoursHelp =>
      'Las emergencias abiertas se cierran solas pasado este tiempo.';

  @override
  String get settingsCodeEntryDays =>
      'Días tras el registro para introducir un código';

  @override
  String get settingsContactsPriority => 'Prioridad de los contactos';

  @override
  String get settingsDefaultAreaKm => 'Zona por defecto (km)';

  @override
  String get settingsDefaultAreaKmHelp =>
      'Se usa para los contactos sin zona propia.';

  @override
  String get settingsEmailContacts => 'Avisos por email a los contactos';

  @override
  String get settingsEmailContactsHelp =>
      'Envía un email a los contactos verificados. Antes hay que configurar el servicio de email.';

  @override
  String get settingsMaxPerDay => 'Amigos activos al día antes de revisar';

  @override
  String get settingsMaxPerDayHelp =>
      'Si se supera en 24 horas, la invitación pasa a revisión.';

  @override
  String get settingsMaxRecipients => 'Máximo de personas avisadas';

  @override
  String get settingsMaxSuggested => 'Contactos sugeridos';

  @override
  String get settingsMinRecipients => 'Personas a alcanzar';

  @override
  String get settingsMinRecipientsHelp =>
      'Se pasa al siguiente círculo hasta alcanzar este número de personas.';

  @override
  String get settingsQualifyDays => 'Días de actividad necesarios';

  @override
  String get settingsQualifyWithinDays =>
      'En un plazo de (días tras el registro)';

  @override
  String get settingsReferralPoints => 'Puntos por cada amigo activo';

  @override
  String get settingsRings => 'Círculos de aviso (km)';

  @override
  String get settingsRingsHelp =>
      'Separados por comas, de menor a mayor, p. ej. 5, 10, 25';

  @override
  String get settingsSaved => 'Guardado';

  @override
  String get settingsStreakDays => 'Días para el extra por racha';

  @override
  String get settingsWeight24h => 'Extra por abierto 24 horas';

  @override
  String get settingsWeightHelp =>
      'Los contactos reciben estos extras y pierden puntos por cada km de distancia. Va primero la puntuación más alta.';

  @override
  String get settingsWeightPerKm => 'Penalización por km';

  @override
  String get settingsWeightPerKmHelp =>
      'Con 1, un contacto recomendado (20) va antes que otro hasta 20 km más cerca.';

  @override
  String get settingsWeightRecommended => 'Extra por recomendado';

  @override
  String get settingsWeightVerified => 'Extra por verificado';

  @override
  String get settingsWelcomePoints => 'Puntos para el amigo invitado';

  @override
  String get settingsWelcomePointsHelp =>
      'Se dan al introducir un código. 0 lo desactiva.';

  @override
  String get shareInvite => 'Compartir';

  @override
  String get statActiveEmergencies => 'Emergencias activas';

  @override
  String get testContactBadge => 'PRUEBA – no es un contacto real';

  @override
  String get topLevelReached => 'Has llegado al nivel más alto. ¡Gracias!';

  @override
  String get useCode => 'Usar';

  @override
  String get verifiedContact => 'Verificado';

  @override
  String get viewInvitee => 'Usuario invitado';

  @override
  String get viewInviter => 'Quien invitó';

  @override
  String get yourInviteCode => 'Tu código de invitación';

  @override
  String get yourInvites => 'Tus invitaciones';

  @override
  String get zeroTurnsOff => '0 lo desactiva';

  @override
  String activeProgress(int done, int total) {
    return '$done de $total minutos hoy';
  }

  @override
  String claimedPoints(int points) {
    return '¡+$points puntos!';
  }

  @override
  String claimedWithBonus(int points, int bonus) {
    return '¡+$points puntos y +$bonus extra por racha!';
  }

  @override
  String emergenciesNearYouCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count emergencias animales cerca de ti',
      one: '1 emergencia animal cerca de ti',
    );
    return '$_temp0';
  }

  @override
  String emergencyAlertedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se ha avisado a $count personas cercanas',
      one: 'Se ha avisado a 1 persona cercana',
      zero: 'Todavía nadie cerca tiene los avisos activados',
    );
    return '$_temp0';
  }

  @override
  String emergencyFalseReports(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Reportada como falsa $count veces',
      one: 'Reportada como falsa una vez',
    );
    return '$_temp0';
  }

  @override
  String emergencyHelpersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count personas van a ayudar',
      one: '1 persona va a ayudar',
    );
    return '$_temp0';
  }

  @override
  String inviteCodeAccepted(String name) {
    return 'Código aceptado. Te invitó $name: ¡bienvenido a CodaMi!';
  }

  @override
  String inviteShareText(String code, String link) {
    return 'Uso CodaMi para ayudar a que las mascotas perdidas vuelvan a casa. Únete con mi código de invitación $code: $link';
  }

  @override
  String inviteStep2(int days, int within) {
    return 'Configura su ciudad y usa la app $days días distintos en los $within días siguientes al registro.';
  }

  @override
  String inviteStep3(int points) {
    return 'Recibes $points puntos y subes de nivel como embajador.';
  }

  @override
  String kmAway(String km) {
    return 'a $km km';
  }

  @override
  String levelFriends(String level) {
    return '$level: amigos activos';
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
      other: '$count amigos activos más para ser $level',
      one: '1 amigo activo más para ser $level',
    );
    return '$_temp0';
  }

  @override
  String plusPoints(int points) {
    return '+$points puntos';
  }

  @override
  String pointsTotal(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points puntos',
      one: '1 punto',
    );
    return '$_temp0';
  }

  @override
  String streakLine(int streak, int days, int bonus) {
    return 'Racha de $streak días · +$bonus extra cada $days días';
  }

  @override
  String get pointsFeedback => 'Opinión enviada';

  @override
  String get whatsNew => 'Novedades';

  @override
  String get whatsNewSubtitle => 'Los cambios de cada versión';

  @override
  String get whatsNewTitle => 'Novedades de CodaMi';

  @override
  String get whatsNewIntro =>
      'Esto es lo que ha cambiado en la última actualización.';

  @override
  String whatsNewVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get whatsNewSectionNew => 'Nuevo';

  @override
  String get whatsNewSectionImproved => 'Mejorado';

  @override
  String get whatsNewSectionFixed => 'Corregido';

  @override
  String get whatsNewEmpty => 'Todavía no hay notas de actualización.';

  @override
  String get whatsNewDone => 'Entendido';

  @override
  String get feedbackTitle => '¿Qué te parece CodaMi?';

  @override
  String get feedbackBody =>
      'Tu opinión llega directamente al equipo de CodaMi y nos ayuda a mejorar la app.';

  @override
  String feedbackPointsOffer(int points) {
    return '+$points puntos por tu primera opinión';
  }

  @override
  String get feedbackStarsHint => 'Toca una estrella para valorar';

  @override
  String get feedbackCommentHint =>
      '¿Qué te gusta o qué se podría mejorar? (opcional)';

  @override
  String get feedbackSend => 'Enviar opinión';

  @override
  String get feedbackLater => 'Ahora no';

  @override
  String get feedbackThanks => '¡Gracias por tu opinión!';

  @override
  String feedbackThanksPoints(int points) {
    return '¡Gracias por tu opinión! +$points puntos';
  }

  @override
  String get feedbackAlreadyToday =>
      'Ya enviaste tu opinión hoy. Podrás enviar otra mañana.';

  @override
  String get sendFeedbackSubtitle => 'Dile al equipo lo que piensas';

  @override
  String get rateCodaMi => 'Valorar CodaMi';

  @override
  String get rateCodaMiSubtitle => 'Deja una reseña en Google Play';

  @override
  String get adminFeedback => 'Opiniones';

  @override
  String get adminFeedbackSubtitle => 'Lo que los usuarios piensan de la app';

  @override
  String get adminFeedbackEmpty => 'Todavía no hay opiniones.';

  @override
  String feedbackRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count valoraciones',
      one: '1 valoración',
    );
    return '$_temp0';
  }

  @override
  String get feedbackNoComment => 'Sin comentario';

  @override
  String get adminWhatsNewSubtitle =>
      'Notas que se muestran a los usuarios tras cada actualización';

  @override
  String get releaseAdd => 'Añadir versión';

  @override
  String get releaseEdit => 'Editar notas';

  @override
  String get releaseVersion => 'Número de versión';

  @override
  String get releaseVersionHelp =>
      'Por ejemplo 1.1.0. Debe coincidir con el nombre de versión de la app en la tienda.';

  @override
  String get releaseVersionInvalid =>
      'Usa números y puntos, por ejemplo 1.1.0.';

  @override
  String get releaseVersionExists => 'Esta versión ya tiene notas.';

  @override
  String get releasePublishedHelp =>
      'Los usuarios solo ven las notas publicadas.';

  @override
  String get releaseDraft => 'Borrador';

  @override
  String get releaseLinesHelp => 'Un cambio por línea.';

  @override
  String get releaseLanguageHelp =>
      'Los idiomas que se dejen vacíos muestran las notas en inglés.';

  @override
  String get releaseEnglishRequired =>
      'Escribe primero las notas en inglés: los demás idiomas las usan como respaldo.';

  @override
  String get releaseDeleteTitle => '¿Eliminar estas notas?';

  @override
  String releaseDeleteBody(String version) {
    return 'Las notas de la versión $version se eliminarán para todos.';
  }

  @override
  String get releaseNone =>
      'Todavía no hay versiones. Añade las notas de tu próxima actualización.';

  @override
  String releaseThisApp(String version) {
    return 'Esta app: versión $version';
  }

  @override
  String get feedbackAndReviews => 'Opiniones y reseñas';

  @override
  String get settingsFeedbackPoints => 'Puntos por la primera opinión';

  @override
  String get settingsFeedbackAfterDays =>
      'Días desde el registro antes de pedir una opinión';

  @override
  String get settingsReviewActiveDays => 'Días de uso antes de preguntar';

  @override
  String get settingsReviewAfterDays =>
      'Días desde el registro antes de la ventana de valoración de la tienda';

  @override
  String get settingsReviewEveryDays =>
      'Días entre solicitudes de valoración en la tienda';

  @override
  String get settingsReviewHelp =>
      'La ventana de valoración de la tienda nunca da puntos: Google Play y la App Store no lo permiten.';

  @override
  String get petitions => 'Peticiones';

  @override
  String get petition => 'Petición';

  @override
  String get petitionsSubtitle =>
      'Campañas por el bienestar animal elegidas por nuestro equipo';

  @override
  String get adminPetitionsSubtitle =>
      'Añade, revisa y publica peticiones por el bienestar animal';

  @override
  String petitionsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count peticiones por el bienestar animal para firmar',
      one: '1 petición por el bienestar animal para firmar',
    );
    return '$_temp0';
  }

  @override
  String get petitionsIntro =>
      'El equipo de CodaMi revisa cada petición antes de que aparezca aquí. La lees y la firmas en el sitio original.';

  @override
  String get petitionsEmpty =>
      'Aún no hay peticiones. El equipo añadirá aquí campañas por el bienestar animal.';

  @override
  String get petitionAdminEmpty =>
      'No hay peticiones aquí. Toca Añadir petición para añadir una de Change.org, Care2, Avaaz o de una organización de confianza.';

  @override
  String get petitionView => 'Ver petición';

  @override
  String get petitionSignOnSite => 'Leer y firmar en el sitio original';

  @override
  String get petitionOpenFailed => 'No se pudo abrir la página de la petición.';

  @override
  String get petitionIssue => 'El problema';

  @override
  String get petitionAction => 'Qué pide la petición';

  @override
  String get petitionWhy => 'Por qué importa a los animales';

  @override
  String get petitionWhere => 'Petición original';

  @override
  String petitionStartedOn(String date) {
    return 'Iniciada el $date';
  }

  @override
  String get petitionDisclaimer =>
      'Esta petición está alojada en un sitio externo. CodaMi no recoge firmas y no es responsable del contenido de la página original.';

  @override
  String get petitionEndedNote =>
      'Esta campaña ha terminado. Aún puedes leer la página original.';

  @override
  String get petitionUnavailableNote =>
      'La petición original ya no está disponible.';

  @override
  String get petitionTopicPets => 'Mascotas';

  @override
  String get petitionTopicWildlife => 'Fauna silvestre';

  @override
  String get petitionTopicFarm => 'Animales de granja';

  @override
  String get petitionTopicTesting => 'Experimentación animal';

  @override
  String get petitionTopicEntertainment => 'Circos y zoológicos';

  @override
  String get petitionTopicMarine => 'Vida marina';

  @override
  String get petitionTopicOther => 'Otros';

  @override
  String get petitionStatusActive => 'Activa';

  @override
  String get petitionStatusCompleted => 'Completada';

  @override
  String get petitionStatusClosed => 'Cerrada';

  @override
  String get petitionStatusUnavailable => 'Ya no disponible';

  @override
  String get petitionReviewPending => 'Por revisar';

  @override
  String get petitionReviewApproved => 'Aprobada';

  @override
  String get petitionReviewRejected => 'Rechazada';

  @override
  String get petitionAdd => 'Añadir petición';

  @override
  String get petitionEdit => 'Editar petición';

  @override
  String get petitionSectionSource => 'Petición original';

  @override
  String get petitionUrl => 'Enlace de la petición';

  @override
  String get petitionUrlInvalid =>
      'Pega el enlace completo, empezando por https://';

  @override
  String get petitionTitle => 'Título';

  @override
  String get petitionSource => 'Plataforma u organización';

  @override
  String get petitionCountry => 'País o zona';

  @override
  String get petitionCountryHelp =>
      'Déjalo vacío para campañas internacionales.';

  @override
  String get petitionStartedOnPick =>
      'Fecha de inicio de la petición (opcional)';

  @override
  String get petitionTopic => 'Tema';

  @override
  String get petitionSectionText => 'Nuestra descripción';

  @override
  String get petitionOwnWordsHelp =>
      'Escribe con tus propias palabras. No copies texto de la página original.';

  @override
  String get petitionSummary => 'Resumen breve';

  @override
  String get petitionImage => 'Imagen';

  @override
  String get petitionImageAdd => 'Añadir imagen';

  @override
  String get petitionImageChange => 'Cambiar imagen';

  @override
  String get petitionImageHelp =>
      'Opcional. Sin imagen, la tarjeta muestra el icono del tema.';

  @override
  String get petitionImagePermission => 'Tenemos permiso para usar esta imagen';

  @override
  String get petitionImagePermissionNeeded =>
      'Confirma que tienes permiso para usar la imagen o elimínala.';

  @override
  String get petitionImageTooBig =>
      'La imagen es demasiado grande. Elige una de menos de 5 MB.';

  @override
  String get petitionChecks => 'Verificación';

  @override
  String get petitionChecksHelp =>
      'Hacen falta las cuatro para aprobar o publicar.';

  @override
  String get petitionCheckExists => 'La página original existe y se abre';

  @override
  String get petitionCheckGenuine =>
      'Trata un problema real de bienestar animal';

  @override
  String get petitionCheckGoal => 'Tiene un objetivo claro';

  @override
  String get petitionCheckHonest =>
      'Sin afirmaciones engañosas ni fraudulentas';

  @override
  String get petitionChecksNeeded =>
      'Marca todas las comprobaciones antes de aprobar o publicar.';

  @override
  String get petitionReview => 'Revisión';

  @override
  String get petitionReviewHelp =>
      'Los usuarios solo ven las peticiones publicadas.';

  @override
  String get petitionRejectReason => 'Motivo (solo lo ven los administradores)';

  @override
  String get petitionStatus => 'Estado de la petición';

  @override
  String get petitionStatusHelp =>
      'Actualízalo cuando la campaña termine o se elimine la página.';

  @override
  String get petitionFixFields => 'Rellena los campos marcados en rojo.';

  @override
  String get petitionDeleteTitle => '¿Eliminar esta petición?';

  @override
  String get petitionDeleteBody => 'Se eliminará de la app para todos.';

  @override
  String petitionAddedOn(String date) {
    return 'Añadida el $date';
  }

  @override
  String petitionPublishedOn(String date) {
    return 'Publicada el $date';
  }

  @override
  String petitionUpdatedOn(String date) {
    return 'Actualizada el $date';
  }

  @override
  String get appUpdates => 'Actualizaciones de la app';

  @override
  String get adminAppUpdatesSubtitle =>
      'Versiones en las tiendas y actualizaciones obligatorias';

  @override
  String get appUpdatesSubtitle => 'Versiones en las tiendas';

  @override
  String get appUpdatesIntro =>
      'Quien tenga una versión anterior verá un aviso de actualización con las novedades de la última versión. Por debajo de la versión mínima, la app no se puede usar hasta actualizarla. No hace falta una nueva compilación para cambiarlas.';

  @override
  String appUpdatesThisPhone(String version) {
    return 'Este teléfono tiene la versión $version';
  }

  @override
  String get appUpdatesAndroid => 'Android (Google Play)';

  @override
  String get appUpdatesIos => 'iPhone (App Store)';

  @override
  String get appUpdatesLatest => 'Última versión en la tienda';

  @override
  String get appUpdatesLatestHelp =>
      'Ponla cuando la actualización ya esté en la tienda. Déjala vacía para no mostrar ningún aviso.';

  @override
  String get appUpdatesMinimum => 'Versión mínima';

  @override
  String get appUpdatesMinimumHelp =>
      'Las versiones anteriores deben actualizarse antes de usar la app. Déjala vacía para ninguna.';

  @override
  String get appUpdatesStoreId => 'ID de App Store';

  @override
  String get appUpdatesStoreIdHelp =>
      'El número del enlace de App Store (apps.apple.com/app/id…). Necesario para el botón Actualizar en iPhone.';

  @override
  String appUpdatesNotesPublished(String version) {
    return 'Las novedades de la $version están publicadas y se muestran con la actualización';
  }

  @override
  String appUpdatesNotesDraft(String version) {
    return 'Las novedades de la $version están guardadas pero no publicadas';
  }

  @override
  String appUpdatesNotesMissing(String version) {
    return 'Aún no hay novedades para la $version';
  }

  @override
  String get appUpdatesBadVersion => 'Usa una versión como 1.2.0';

  @override
  String get appUpdatesMinimumAbove =>
      'La mínima no puede ser mayor que la última versión';

  @override
  String get appUpdatesBadStoreId => 'El ID de App Store solo tiene dígitos';

  @override
  String get appUpdatesRequireTitle => '¿Hacer obligatoria la actualización?';

  @override
  String appUpdatesRequireBody(String version) {
    return 'Todos los que tengan una versión inferior a la $version tendrán que actualizar antes de usar la app.';
  }

  @override
  String get appUpdatesRequireConfirm => 'Hacer obligatoria';

  @override
  String get updateAvailableTitle => 'Actualización disponible';

  @override
  String updateAvailableBody(String latest, String installed) {
    return 'La versión $latest de CodaMi está lista. Tienes la $installed.';
  }

  @override
  String get updateNow => 'Actualizar ahora';

  @override
  String get updateLater => 'Más tarde';

  @override
  String get updateRequiredTitle => 'Actualización necesaria';

  @override
  String updateRequiredBody(String version) {
    return 'Esta versión de CodaMi ya no es compatible. Actualiza a la versión $version para seguir usando la app.';
  }

  @override
  String updateBanner(String version) {
    return 'La versión $version está disponible';
  }

  @override
  String get updateStoreFailed =>
      'No se pudo abrir la tienda. Actualiza CodaMi desde la app de la tienda.';

  @override
  String get rateCodaMiSubtitleIos => 'Deja una reseña en App Store';

  @override
  String get updateContinueAsAdmin => 'Continuar como administrador';

  @override
  String get navShop => 'Tienda';

  @override
  String get shop => 'Tienda';

  @override
  String get adminShopSubtitle =>
      'Productos, marcas, proveedores e interruptor';

  @override
  String get shopSubtitle => 'Productos para tus mascotas';

  @override
  String get shopSearchHint => 'Buscar productos';

  @override
  String get shopEmpty => 'Pronto habrá productos. ¡Vuelve más tarde!';

  @override
  String get shopNoResults => 'Ningún producto coincide.';

  @override
  String get shopInStock => 'En stock';

  @override
  String get shopLowStock => 'Quedan pocos';

  @override
  String get shopOutOfStock => 'Agotado';

  @override
  String get shopComingSoon => 'Próximamente';

  @override
  String get shopModelOwnStock => 'Stock propio';

  @override
  String get shopModelBrand => 'Marca asociada';

  @override
  String get shopModelDropship => 'Dropshipping';

  @override
  String get shopModelAffiliate => 'Enlace de afiliado';

  @override
  String get shopModelOwnStockHelp => 'CodaMi tiene el stock y lo envía.';

  @override
  String get shopModelBrandHelp =>
      'La marca vende a través de CodaMi y envía el pedido.';

  @override
  String get shopModelDropshipHelp =>
      'Un proveedor envía el pedido directamente al cliente.';

  @override
  String get shopModelAffiliateHelp =>
      'Se compra en la web del socio con nuestro enlace; CodaMi gana una comisión.';

  @override
  String shopBuyOn(String partner) {
    return 'Comprar en $partner';
  }

  @override
  String shopAffiliateNote(String partner) {
    return 'Vendido y enviado por $partner. CodaMi puede ganar una comisión por esta compra.';
  }

  @override
  String shopPriceOnPartner(String partner) {
    return 'Precio en $partner';
  }

  @override
  String get shopAddToCart => 'Añadir al carrito';

  @override
  String get shopCheckoutSoon => 'Pronto podrás comprar en la app.';

  @override
  String get shopAllAnimals => 'Para todos los animales';

  @override
  String get shopDescription => 'Descripción';

  @override
  String get shopOpenFailed => 'No se pudo abrir el enlace.';

  @override
  String get shopPreviewOff =>
      'Vista previa: la tienda está apagada, los usuarios no la ven.';

  @override
  String get shopAdminIntro =>
      'Gestiona la tienda CodaMi. Los usuarios solo la ven cuando está encendida.';

  @override
  String get shopOpenSwitch => 'Tienda abierta a los usuarios';

  @override
  String get shopOnHelp => 'Encendida: todos ven la pestaña Tienda.';

  @override
  String get shopOffHelp =>
      'Apagada: los usuarios no la ven. Los admins pueden prepararla.';

  @override
  String get shopTurnOnTitle => '¿Abrir la tienda?';

  @override
  String get shopTurnOnBody =>
      'Todos los usuarios verán al instante la pestaña Tienda y los productos activos.';

  @override
  String get shopTurnOffTitle => '¿Cerrar la tienda?';

  @override
  String get shopTurnOffBody =>
      'La pestaña Tienda desaparece al instante para todos. Se conservan productos y ajustes.';

  @override
  String get shopTurnOn => 'Abrir';

  @override
  String get shopTurnOff => 'Cerrar';

  @override
  String get shopSalesModels => 'Modelos de venta';

  @override
  String get shopSalesModelsHelp =>
      'Apagar un modelo oculta todos sus productos a los usuarios.';

  @override
  String get shopCatalog => 'Catálogo';

  @override
  String get shopProducts => 'Productos';

  @override
  String get shopCategories => 'Categorías';

  @override
  String get shopBrands => 'Marcas';

  @override
  String get shopSuppliers => 'Proveedores';

  @override
  String get shopPreview => 'Vista previa de la tienda';

  @override
  String get shopPreviewSubtitle => 'Ver la tienda como la verán los usuarios';

  @override
  String shopProductsCount(int active, int total) {
    return '$active activos · $total en total';
  }

  @override
  String get shopAddProduct => 'Añadir producto';

  @override
  String get shopEditProduct => 'Editar producto';

  @override
  String get shopProductsEmpty => 'Aún no hay productos. Añade el primero.';

  @override
  String get shopActive => 'Activo';

  @override
  String get shopHidden => 'Oculto';

  @override
  String get shopNeedCategory =>
      'Añade primero una categoría (Tienda → Categorías).';

  @override
  String get shopPhotos => 'Fotos';

  @override
  String get shopPhotosHelp =>
      'Hasta 6 fotos. La primera es la portada; mantén pulsado y arrastra para ordenar.';

  @override
  String get shopAddPhoto => 'Añadir foto';

  @override
  String get shopImageTooBig => 'Las imágenes deben pesar menos de 5 MB.';

  @override
  String get shopDetails => 'Detalles';

  @override
  String get shopName => 'Nombre';

  @override
  String get shopCategory => 'Categoría';

  @override
  String get shopPickCategory => 'Elige una categoría';

  @override
  String get shopAnimals => 'Animales';

  @override
  String get shopAnimalsHelp =>
      'Sin selección significa para todos los animales. Los usuarios ven primero los productos para sus mascotas.';

  @override
  String get shopSalesModel => 'Modelo de venta';

  @override
  String get shopPartnerName => 'Tienda asociada';

  @override
  String get shopAffiliateUrl => 'Enlace de afiliado';

  @override
  String get shopBrand => 'Marca';

  @override
  String get shopNoBrand => 'Sin marca';

  @override
  String get shopSupplier => 'Proveedor';

  @override
  String get shopNoSupplier => 'Sin proveedor';

  @override
  String get shopPriceSection => 'Precio';

  @override
  String get shopPrice => 'Precio (€)';

  @override
  String get shopPriceAffiliateHelp =>
      'Opcional: los precios cambian en la web del socio.';

  @override
  String get shopPriceInvalid => 'Introduce un precio, por ejemplo 12,90';

  @override
  String get shopCompareAt => 'Precio antes del descuento (€)';

  @override
  String get shopCompareAtHelp =>
      'Opcional. Se muestra tachado junto al precio.';

  @override
  String get shopCompareAtInvalid => 'Debe ser mayor que el precio.';

  @override
  String get shopAvailability => 'Disponibilidad';

  @override
  String get shopVisible => 'Visible para los usuarios';

  @override
  String get shopVisibleHelp =>
      'Los productos ocultos solo los ven los admins.';

  @override
  String get shopCategoryVisibleHelp =>
      'Si se oculta, la categoría y todos sus productos quedan ocultos.';

  @override
  String get shopBrandVisibleHelp =>
      'Si se oculta, todos los productos de la marca quedan ocultos.';

  @override
  String get shopSupplierActiveHelp =>
      'Si se apaga, todos los productos de este proveedor quedan ocultos.';

  @override
  String get shopDeleteProductTitle => '¿Eliminar este producto?';

  @override
  String get shopDeleteProductBody =>
      'Se quita de la tienda con sus fotos. No se puede deshacer.';

  @override
  String shopDeleteTitle(String name) {
    return '¿Eliminar $name?';
  }

  @override
  String get shopDeleteBody => 'No se puede deshacer.';

  @override
  String get shopInUse =>
      'Aún lo usan productos o subcategorías, no se puede eliminar. Ocúltalo.';

  @override
  String get shopFixFields => 'Revisa los campos en rojo.';

  @override
  String get shopLinkInvalid =>
      'Introduce un enlace completo que empiece por https://';

  @override
  String get shopAddCategory => 'Añadir categoría';

  @override
  String get shopEditCategory => 'Editar categoría';

  @override
  String get shopAddStarting => 'Añadir las categorías iniciales';

  @override
  String get shopStartingHelp =>
      'Empieza con comida, accesorios, cuidado, juguetes, camas, transportines, tecnología y otros. Podrás cambiarlas luego.';

  @override
  String get shopParent => 'Dentro de la categoría';

  @override
  String get shopNoParent => 'Ninguna (categoría principal)';

  @override
  String get shopIcon => 'Icono';

  @override
  String get shopOrder => 'Posición';

  @override
  String get shopOrderHelp => 'Los números bajos van primero.';

  @override
  String get shopCatFood => 'Comida';

  @override
  String get shopCatAccessories => 'Accesorios';

  @override
  String get shopCatCare => 'Cuidado';

  @override
  String get shopCatToys => 'Juguetes';

  @override
  String get shopCatBeds => 'Camas';

  @override
  String get shopCatCarriers => 'Transportines';

  @override
  String get shopCatTech => 'Tecnología';

  @override
  String get shopCatOther => 'Otros';

  @override
  String get shopAddBrand => 'Añadir marca';

  @override
  String get shopEditBrand => 'Editar marca';

  @override
  String get shopBrandsEmpty =>
      'Aún no hay marcas. Son opcionales; añádelas cuando tengas socios.';

  @override
  String get shopWebsite => 'Sitio web';

  @override
  String get shopLogo => 'Logotipo';

  @override
  String get shopAddLogo => 'Elegir logotipo';

  @override
  String get shopAddSupplier => 'Añadir proveedor';

  @override
  String get shopEditSupplier => 'Editar proveedor';

  @override
  String get shopSuppliersEmpty => 'Aún no hay proveedores.';

  @override
  String get shopSuppliersHelp =>
      'Solo los admins ven los proveedores y sus datos. Apagar un proveedor oculta sus productos.';

  @override
  String get shopContactName => 'Persona de contacto';

  @override
  String get shopEmail => 'Correo';

  @override
  String get shopEmailInvalid => 'Introduce un correo válido.';

  @override
  String get shopPhone => 'Teléfono';

  @override
  String get shopOrderMethod => 'Cómo reciben los pedidos';

  @override
  String get shopOrderManual => 'A mano';

  @override
  String get shopOrderManualHelp =>
      'El equipo reenvía cada pedido al proveedor.';

  @override
  String get shopOrderEmail => 'Correo automático';

  @override
  String get shopOrderEmailHelp =>
      'Cada pedido pagado se envía por correo al proveedor (con el pago).';

  @override
  String get shopNotes => 'Notas (solo admins)';

  @override
  String get shopForYourPets => 'Para tus mascotas';

  @override
  String get shopOnSale => 'En oferta';

  @override
  String get shopAllProducts => 'Todos los productos';

  @override
  String get shopResults => 'Resultados';

  @override
  String shopProductCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count productos',
      one: '1 producto',
    );
    return '$_temp0';
  }

  @override
  String shopYouSave(String amount) {
    return 'Ahorras $amount';
  }

  @override
  String get shopCart => 'Carrito';

  @override
  String get shopCartClear => 'Vaciar';

  @override
  String get shopCartEmpty =>
      'Tu carrito está vacío. Añade productos de la tienda.';

  @override
  String shopCartUnavailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count productos ya no están disponibles',
      one: '1 producto ya no está disponible',
    );
    return '$_temp0';
  }

  @override
  String get shopCheckout => 'Pagar';

  @override
  String get shopPaymentSoon => 'Pronto podrás pagar en la app.';

  @override
  String get shopViewCart => 'Ver carrito';

  @override
  String get shopShipping => 'Envío';

  @override
  String get shopShipTo => 'Enviar a';

  @override
  String get shopShippingNotSet => 'Pronto verás aquí las opciones de envío.';

  @override
  String get shopFree => 'Gratis';

  @override
  String shopFreeAbove(String amount) {
    return 'Gratis desde $amount';
  }

  @override
  String shopFreeShippingGap(String amount) {
    return 'Añade $amount más para envío gratis';
  }

  @override
  String get shopSummary => 'Resumen';

  @override
  String get shopSubtotal => 'Subtotal';

  @override
  String get shopTotal => 'Total';

  @override
  String get shopVatIncluded => 'IVA incluido';

  @override
  String get shopSponsored => 'Patrocinado';

  @override
  String get shopSponsoredSection => 'Patrocinado';

  @override
  String get shopSponsoredHelp =>
      'Mostrar primero en la tienda y su categoría, con la etiqueta \"Patrocinado\".';

  @override
  String get shopSponsorFrom => 'Desde';

  @override
  String get shopSponsorUntil => 'Hasta';

  @override
  String get shopSponsorDatesHelp =>
      'Déjalo vacío para empezar ya y seguir hasta apagarlo.';

  @override
  String get shopSponsorDatesInvalid =>
      'La fecha de fin es anterior a la de inicio.';

  @override
  String get shopNoDate => 'Sin fecha';

  @override
  String get shopCost => 'Precio de coste (€, solo admins)';

  @override
  String get shopCostHelp =>
      'Lo que CodaMi paga al proveedor o a la marca. Los usuarios nunca lo ven.';

  @override
  String shopMargin(String amount, int percent) {
    return 'Margen: $amount ($percent %)';
  }

  @override
  String get shopAffiliateClicks => 'Clics de afiliado';

  @override
  String shopClicksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count clics en \"Comprar\"',
      one: '1 clic en \"Comprar\"',
    );
    return '$_temp0';
  }

  @override
  String get shopLast30Days => 'Últimos 30 días · toca para actualizar';

  @override
  String get shopShippingIntro =>
      'Dónde, cómo y a qué precio envías. Precios con IVA. Se aplica a todos al instante.';

  @override
  String get shopShippingStarting => 'Añadir la configuración inicial';

  @override
  String get shopZones => 'Zonas';

  @override
  String get shopZonesHelp =>
      'Zonas a las que envías. Apaga una para dejar de enviar allí.';

  @override
  String get shopZoneName => 'Nombre de la zona';

  @override
  String get shopAddZone => 'Añadir zona';

  @override
  String get shopZoneItaly => 'Italia';

  @override
  String get shopZoneIslands => 'Sicilia y Cerdeña';

  @override
  String get shopZoneEurope => 'Unión Europea';

  @override
  String get shopMethod => 'Método de envío';

  @override
  String get shopAddMethod => 'Añadir método de envío';

  @override
  String get shopMethodActive => 'Disponible para los usuarios';

  @override
  String get shopMethodStandard => 'Estándar';

  @override
  String get shopMethodExpress => 'Exprés';

  @override
  String get shopMethodStandardTime => '3–5 días laborables';

  @override
  String get shopMethodExpressTime => '1–2 días laborables';

  @override
  String get shopDeliveryTime => 'Plazo de entrega mostrado';

  @override
  String get shopPricePerZone => 'Precio por zona';

  @override
  String get shopPricePerZoneHelp =>
      'Déjalo vacío donde no se ofrece. 0 significa gratis.';

  @override
  String get shopFreeAboveLabel => 'Envío gratis desde (€)';

  @override
  String get shopFreeAboveHelp =>
      'Opcional. Déjalo vacío para cobrar siempre el envío.';
}
