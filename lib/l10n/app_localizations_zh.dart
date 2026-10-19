// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get navHome => '首页';

  @override
  String get navPets => '宠物';

  @override
  String get navProfile => '我的';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get notSet => '未设置';

  @override
  String get soon => '即将推出';

  @override
  String comingSoon(String feature) {
    return '$feature即将推出。';
  }

  @override
  String get profileTitle => '我的';

  @override
  String get myPets => '我的宠物';

  @override
  String get myReports => '我的启事';

  @override
  String get homeCity => '所在城市';

  @override
  String get notifications => '通知';

  @override
  String get chooseLanguage => '选择语言';

  @override
  String get language => '语言';

  @override
  String get signOut => '退出登录';

  @override
  String get signOutTitle => '确定退出登录？';

  @override
  String get signOutMessage => '你可以随时重新登录。';

  @override
  String get deleteAccount => '注销账户';

  @override
  String get deleteAccountTitle => '确定注销账户？';

  @override
  String get deleteAccountMessage => '你的个人资料、宠物、启事及其照片将被永久删除，且无法恢复。';

  @override
  String get deletingAccount => '正在注销账户…';

  @override
  String get myReportsSubtitle => '请及时更新你的启事。';

  @override
  String get statTotal => '总计';

  @override
  String postedOn(String date) {
    return '发布于 $date';
  }

  @override
  String get reportActive => '进行中';

  @override
  String get reportResolved => '已解决';

  @override
  String get myReportsLoadError => '无法加载你的启事';

  @override
  String get checkConnection => '请检查网络连接后重试。';

  @override
  String get noActiveReports => '没有进行中的启事';

  @override
  String get noActiveReportsMessage => '你发布的寻宠或招领启事会显示在这里。';

  @override
  String get reportAPet => '发布启事';

  @override
  String get nothingResolved => '还没有已解决的启事';

  @override
  String get nothingResolvedMessage => '将启事标记为已解决后，会显示在这里。';

  @override
  String get markAsFound => '标记为已找到';

  @override
  String get returnedToOwner => '已归还主人';

  @override
  String get backHome => '已回家';

  @override
  String get reunited => '已团聚';

  @override
  String get deleteReport => '删除启事';

  @override
  String resolveLostTitle(String petName) {
    return '$petName已经回家了吗？';
  }

  @override
  String get resolveFoundTitle => '找到主人了吗？';

  @override
  String resolveLostMessage(String petName) {
    return '启事将移到“招领”页的“已回家”中，让邻居们知道$petName已平安。';
  }

  @override
  String get resolveFoundMessage => '启事将移到“招领”页的“已团聚”中。';

  @override
  String get notYet => '还没有';

  @override
  String get yesResolved => '是的，已解决';

  @override
  String get reportResolvedSuccess => '太好了！启事已解决。';

  @override
  String get deleteReportTitle => '确定删除这条启事？';

  @override
  String deleteOpenReportMessage(String petName) {
    return '它将从地图和列表中消失。如果$petName已平安，建议改为标记为已解决，让邻居们知道。';
  }

  @override
  String get deleteResolvedReportMessage => '它将从地图和“已回家”列表中移除。';

  @override
  String get reportDeleted => '启事已删除。';

  @override
  String get onboarding1Title => '每只宠物都值得\n';

  @override
  String get onboarding1Highlight => '回家';

  @override
  String get onboarding1Body => 'CodaMi 连接邻里，让走失的猫狗回到爱它们的人身边。';

  @override
  String get onboarding2Title => '几秒钟\n';

  @override
  String get onboarding2Highlight => '发布启事';

  @override
  String get onboarding2Body => '拍张照片、标出位置，发布寻宠或招领启事，附近的人会立刻看到。';

  @override
  String get onboarding3Title => '看看\n';

  @override
  String get onboarding3Highlight => '身边动态';

  @override
  String get onboarding3Body => '周边走失和被找到的宠物，实时汇聚在一张地图上，让你随时知道去哪里找。';

  @override
  String get skip => '跳过';

  @override
  String get getStarted => '开始使用';

  @override
  String get lost => '走失';

  @override
  String get found => '招领';

  @override
  String get you => '你';

  @override
  String get published => '已发布';

  @override
  String get onboardingSampleBreed => '金毛寻回犬 · 3岁';

  @override
  String get onboardingSamplePlace => '米兰 · 2小时前';

  @override
  String get validationNameRequired => '请输入你的姓名';

  @override
  String get validationNameTooShort => '姓名至少需要2个字符';

  @override
  String get validationNameTooLong => '姓名不能超过50个字符';

  @override
  String get validationNameInvalid => '姓名只能包含字母、空格、连字符和撇号';

  @override
  String get validationEmailRequired => '请输入你的邮箱';

  @override
  String get validationEmailInvalid => '请输入有效的邮箱地址';

  @override
  String get validationPasswordRequired => '请输入密码';

  @override
  String get validationPasswordTooShort => '密码至少需要8个字符';

  @override
  String get validationConfirmRequired => '请确认密码';

  @override
  String get validationPasswordsDontMatch => '两次输入的密码不一致';

  @override
  String get spamNote => '找不到重置密码的邮件？请查看垃圾邮件文件夹，有时邮件会被放到那里。';

  @override
  String get logIn => '登录';

  @override
  String get signUp => '注册';

  @override
  String get authResetSentTitle => '请查收邮件';

  @override
  String get authResetSentSubtitle => '我们已向你发送了重置密码的链接。';

  @override
  String get authLoginTitle => '欢迎回来！';

  @override
  String get authLoginSubtitle => '登录后继续帮助宠物回家。';

  @override
  String get authSignupTitle => '加入我们';

  @override
  String get authSignupSubtitle => '创建账户，帮助你的社区。';

  @override
  String get authForgotTitle => '忘记密码？';

  @override
  String get authForgotSubtitle => '别担心，我们会通过邮件发送重置链接。';

  @override
  String get fullName => '姓名';

  @override
  String get email => '邮箱';

  @override
  String get password => '密码';

  @override
  String get confirmPassword => '确认密码';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get createAccount => '创建账户';

  @override
  String get sendResetLink => '发送重置链接';

  @override
  String get or => '或';

  @override
  String get continueWithGoogle => '使用 Google 继续';

  @override
  String get continueWithApple => '使用 Apple 继续';

  @override
  String get resetLinkSentTo => '重置链接已发送至';

  @override
  String get backToLogIn => '返回登录';

  @override
  String get sendAgain => '没收到？重新发送';

  @override
  String get errorOffline => '网络未连接，请检查后重试。';

  @override
  String get errorSessionExpired => '登录已过期，请重新登录。';

  @override
  String get deleteAccountFailed => '无法注销账户，请重试。';

  @override
  String get authErrorGeneric => '出了点问题，请重试。';

  @override
  String get authErrorDisabled => '该账户已被停用。';

  @override
  String get authErrorWrongCredentials => '邮箱或密码错误。';

  @override
  String get authErrorEmailInUse => '该邮箱已注册账户，请尝试登录。';

  @override
  String get authErrorTooManyRequests => '尝试次数过多，请稍后再试。';

  @override
  String get citySearchFailed => '城市搜索失败，请重试。';

  @override
  String get placeSearchFailed => '地点搜索失败，请重试。';

  @override
  String get placeOutsideCity => '该地点不在你的城市内，请选择城市内的地点。';

  @override
  String get placeNotFound => '找不到该地点，请换一个。';

  @override
  String get citySearchOffline => '无法连接城市搜索，请检查网络后重试。';

  @override
  String get searchCityHint => '搜索你的城市，例如米兰';

  @override
  String noCitiesFound(String query) {
    return '未找到与“$query”相关的城市。';
  }

  @override
  String homeCityUpdated(String city) {
    return '城市已更新为$city。';
  }

  @override
  String get saveCityFailed => '无法保存城市，请重试。';

  @override
  String get citySetupTitle => '你在';

  @override
  String get citySetupHighlight => '哪里？';

  @override
  String get cityEditTitle => '更改你的';

  @override
  String get cityEditHighlight => '城市';

  @override
  String get citySetupBody => '选择你的城市，我们会为你显示附近走失和被找到的宠物，并在你所在区域有宠物走失时通知你。';

  @override
  String get saveCity => '保存城市';

  @override
  String get continueLabel => '继续';

  @override
  String get notYouSignOut => '不是你？退出登录';

  @override
  String greeting(String name) {
    return '你好，$name！';
  }

  @override
  String get showPetsWithin => '显示范围';

  @override
  String distanceFrom(String city) {
    return '距离$city';
  }

  @override
  String get everywhere => '不限';

  @override
  String distanceKm(int km) {
    return '$km 公里';
  }

  @override
  String withinKm(int km) {
    return '$km 公里内';
  }

  @override
  String get areaNotSet => '尚未设置区域';

  @override
  String get reportPetSemantics => '发布寻宠或招领启事';

  @override
  String get map => '地图';

  @override
  String get locationServicesOff => '请开启定位服务以使用你的位置。';

  @override
  String get locationPermissionDenied => '请在设置中允许访问位置。';

  @override
  String get locationFailed => '无法获取你的位置，请重试。';

  @override
  String get back => '返回';

  @override
  String get fullScreen => '全屏';

  @override
  String get loadingPets => '正在加载宠物…';

  @override
  String get mapLoadFailed => '无法加载启事，请检查网络连接。';

  @override
  String get mapNoLost => '此区域没有走失的宠物';

  @override
  String get mapNoFound => '此区域没有被找到的宠物';

  @override
  String get mapNoPets => '此区域没有走失或被找到的宠物';

  @override
  String get zoomIn => '放大';

  @override
  String get zoomOut => '缩小';

  @override
  String get myLocation => '我的位置';

  @override
  String get myCity => '我的城市';

  @override
  String get all => '全部';

  @override
  String get timeJustNow => '刚刚';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes分钟前';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours小时前';
  }

  @override
  String get timeYesterday => '昨天';

  @override
  String timeDaysAgo(int days) {
    return '$days天前';
  }

  @override
  String notifLostTitle(String city) {
    return '$city有宠物走失';
  }

  @override
  String notifLostBodyNear(String pet, String street, String city) {
    return '$pet最后出现在$city$street附近，请留意！';
  }

  @override
  String notifLostBodyIn(String pet, String city) {
    return '$pet最后出现在$city，请留意！';
  }

  @override
  String notifFoundTitle(String city) {
    return '$city有人捡到宠物';
  }

  @override
  String notifFoundBodyNear(String pet, String street, String city) {
    return '有人在$city$street附近找到了$pet。你认识它的主人吗？';
  }

  @override
  String notifFoundBodyIn(String pet, String city) {
    return '有人在$city找到了$pet。你认识它的主人吗？';
  }

  @override
  String notifBackHomeTitle(String pet) {
    return '$pet已经回家了';
  }

  @override
  String notifBackHomeBody(String pet, String city) {
    return '来自$city的好消息：$pet已经找到了。感谢你的帮助！';
  }

  @override
  String notifReunitedTitle(String pet) {
    return '$pet已与家人团聚';
  }

  @override
  String notifReunitedBody(String city) {
    return '在$city被找到的宠物已回到家人身边。';
  }

  @override
  String get notificationsTitle => '通知';

  @override
  String get markAllRead => '全部标为已读';

  @override
  String get notificationsLoadError => '无法加载通知';

  @override
  String get allCaughtUp => '暂无新消息';

  @override
  String get notificationsEmpty => '你所在城市有宠物走失或被找到时，我们会通知你。';

  @override
  String get notificationsNew => '最新';

  @override
  String get notificationsEarlier => '更早';

  @override
  String get reportNotAvailable => '启事不可用';

  @override
  String get reportRemoved => '发布者已删除这条启事。';

  @override
  String get reportsLoadError => '无法加载启事';

  @override
  String get pullToRetry => '请检查网络连接，下拉重试。';

  @override
  String get noLostNearby => '附近没有走失的宠物';

  @override
  String get noLostNearbyMessage => '好消息！你的区域还没有人发布寻宠启事。';

  @override
  String get noFoundYet => '还没有招领信息';

  @override
  String get noFoundYetMessage => '邻居们找到的宠物会显示在这里。';

  @override
  String get backHomeSection => '已回家';

  @override
  String get backHomeSectionSubtitle => '这些宠物已经回到了家人身边。';

  @override
  String get loadMore => '加载更多';

  @override
  String get speciesDog => '狗';

  @override
  String get speciesCat => '猫';

  @override
  String get speciesOther => '其他';

  @override
  String get sexMale => '公';

  @override
  String get sexFemale => '母';

  @override
  String get sexUnknown => '不确定';

  @override
  String nearPlace(String street, String city) {
    return '$city$street附近';
  }

  @override
  String get callFailed => '无法拨打电话。';

  @override
  String get whatsappFailed => '无法打开 WhatsApp。';

  @override
  String get emailFailed => '无法打开邮件应用。';

  @override
  String whatsappMessageLost(String pet) {
    return '你好！我想咨询 CodaMi 上走失的宠物“$pet”。';
  }

  @override
  String whatsappMessageFound(String pet) {
    return '你好！我想咨询 CodaMi 上被找到的宠物“$pet”。';
  }

  @override
  String emailSubjectLost(String pet) {
    return '关于$pet（CodaMi 寻宠启事）';
  }

  @override
  String emailSubjectFound(String pet) {
    return '关于$pet（CodaMi 招领启事）';
  }

  @override
  String shareTitleLost(String pet) {
    return '寻宠启事：$pet';
  }

  @override
  String shareTitleFound(String pet) {
    return '招领启事：$pet';
  }

  @override
  String get shareFooter => '见过这只宠物吗？打开 CodaMi 联系发布者。';

  @override
  String get lastSeen => '最后出现地点';

  @override
  String get foundAt => '发现地点';

  @override
  String areaAbout(int meters) {
    return '约 $meters 米范围';
  }

  @override
  String get when => '时间';

  @override
  String get postedBy => '发布者';

  @override
  String get description => '描述';

  @override
  String get call => '打电话';

  @override
  String contactTitleLost(String pet) {
    return '见过$pet吗？请联系';
  }

  @override
  String get contactTitleFound => '这是你的宠物吗？请联系';

  @override
  String get noContactShared => '未提供联系方式。';

  @override
  String resolvedThanksLost(String pet) {
    return '$pet已经回家了。感谢使用 CodaMi！';
  }

  @override
  String get resolvedThanksFound => '这只宠物已回到家人身边。感谢你的帮助！';

  @override
  String get yourContactDetails => '你的联系方式';

  @override
  String markPetAsFound(String pet) {
    return '标记$pet已找到';
  }

  @override
  String get markReturnedToOwner => '标记为已归还主人';

  @override
  String get copiedToClipboard => '已复制到剪贴板。';

  @override
  String get petSaveFailed => '无法保存宠物，请重试。';

  @override
  String get petDeleteFailed => '无法删除宠物，请重试。';

  @override
  String get errorPermission => '你没有执行此操作的权限。';

  @override
  String get storageNotReady => '照片存储尚未就绪，请稍后再试。';

  @override
  String get storageFull => '存储空间已满，请稍后再试。';

  @override
  String petAdded(String name) {
    return '$name已添加到你的宠物。';
  }

  @override
  String get petsLoadError => '无法加载你的宠物';

  @override
  String get noPetsYet => '还没有宠物';

  @override
  String get noPetsYetMessage => '现在添加你的宠物，万一走失可以在几秒内发布启事。';

  @override
  String get addFirstPet => '添加第一只宠物';

  @override
  String get petsHeaderEmpty => '提前准备好宠物档案，以防万一。';

  @override
  String petsHeaderCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 位毛孩子，档案已就绪。',
      one: '1 位毛孩子，档案已就绪。',
    );
    return '$_temp0';
  }

  @override
  String get addPet => '添加';

  @override
  String petUpdated(String name) {
    return '$name已更新。';
  }

  @override
  String removePetTitle(String name) {
    return '确定移除$name？';
  }

  @override
  String get removePetMessage => '档案及其照片将被删除，且无法恢复。';

  @override
  String get remove => '移除';

  @override
  String petRemoved(String name) {
    return '$name已移除。';
  }

  @override
  String get breed => '品种';

  @override
  String get color => '毛色';

  @override
  String get age => '年龄';

  @override
  String get sex => '性别';

  @override
  String petAddedOn(String date) {
    return '添加于 $date';
  }

  @override
  String get distinctiveFeatures => '特征';

  @override
  String ifPetGoesMissing(String name) {
    return '如果$name走失了';
  }

  @override
  String get ifPetGoesMissingBody => '用这份档案几秒钟就能发布寻宠启事，附近的邻居会收到提醒。';

  @override
  String reportPetAsLost(String name) {
    return '发布$name的寻宠启事';
  }

  @override
  String get colorBlack => '黑色';

  @override
  String get colorWhite => '白色';

  @override
  String get colorBrown => '棕色';

  @override
  String get colorGolden => '金色';

  @override
  String get colorGrey => '灰色';

  @override
  String get colorCream => '奶油色';

  @override
  String get colorGinger => '橘色';

  @override
  String get petPhotoRequired => '请至少添加一张宠物照片。';

  @override
  String get petSpeciesRequired => '请选择你的宠物是狗、猫还是其他。';

  @override
  String get checkHighlightedFields => '请检查标出的字段。';

  @override
  String get signInToSave => '请重新登录后保存。';

  @override
  String get discardChangesTitle => '放弃修改？';

  @override
  String get discardPetChanges => '对这只宠物的修改将会丢失。';

  @override
  String get keepEditing => '继续编辑';

  @override
  String get discard => '放弃';

  @override
  String editPetTitle(String name) {
    return '编辑$name';
  }

  @override
  String get newPet => '新宠物';

  @override
  String get whatKindOfPet => '是什么宠物？';

  @override
  String get name => '名字';

  @override
  String get petNameHint => '例如：露娜';

  @override
  String get petNameRequired => '请输入宠物的名字';

  @override
  String get petNameTooLong => '名字不能超过40个字符';

  @override
  String get breedHint => '例如：金毛、混血';

  @override
  String get colorHint => '例如：金色，胸口白色';

  @override
  String get ageHint => '例如：3岁、8个月';

  @override
  String get featuresHint => '项圈、芯片、疤痕、斑点……任何有助于认出你宠物的特征。';

  @override
  String get saveChanges => '保存修改';

  @override
  String get savePet => '保存宠物';

  @override
  String get cameraPermission => '请在设置中允许访问相机。';

  @override
  String get photosPermission => '请在设置中允许访问照片。';

  @override
  String get cameraFailed => '无法打开相机。';

  @override
  String get galleryFailed => '无法打开相册。';

  @override
  String get optional => '选填';

  @override
  String get addPetPhotos => '添加宠物照片';

  @override
  String get addPetPhotosHint => '清晰的近照更容易让人认出它';

  @override
  String get photoRequired => '至少需要一张照片';

  @override
  String get tapToMakeCover => '点击照片将其设为封面。';

  @override
  String get cover => '封面';

  @override
  String uploadingPhotos(int percent) {
    return '正在上传照片… $percent%';
  }

  @override
  String get saving => '正在保存…';

  @override
  String get takePhoto => '拍照';

  @override
  String get useCamera => '使用相机';

  @override
  String get chooseFromGallery => '从相册选择';

  @override
  String get pickExistingPhoto => '选择已有照片';

  @override
  String get yourPet => '你的宠物';

  @override
  String get unknownDog => '不知名的狗';

  @override
  String get unknownCat => '不知名的猫';

  @override
  String get unknownPet => '不知名的宠物';

  @override
  String get errorChooseType => '请选择你是丢失还是捡到了宠物。';

  @override
  String get errorPickPet => '请选择走失的宠物。';

  @override
  String get errorFoundPhoto => '请至少添加一张这只动物的照片。';

  @override
  String get errorFoundSpecies => '它是狗、猫还是其他？';

  @override
  String get errorChooseCity => '请选择事发城市。';

  @override
  String get errorFutureDate => '日期不能晚于现在。';

  @override
  String get errorDescriptionShort => '请添加简短描述（至少10个字符）。';

  @override
  String get errorContactRequired => '请留下电话或邮箱，方便别人联系你。';

  @override
  String get errorPhoneInvalid => '请输入有效的电话号码。';

  @override
  String get discardReportTitle => '放弃这条启事？';

  @override
  String get discardReportMessage => '你目前填写的内容将会丢失。';

  @override
  String get signInToPublish => '请重新登录后发布。';

  @override
  String publishedLost(String pet) {
    return '$pet已出现在地图上。希望它早日回家。';
  }

  @override
  String publishedFound(String pet) {
    return '谢谢！$pet已出现在地图上。';
  }

  @override
  String get reportLostPetTitle => '发布寻宠启事';

  @override
  String get reportFoundPetTitle => '发布招领启事';

  @override
  String get newReport => '新启事';

  @override
  String stepOf(int current, int total) {
    return '第 $current/$total 步';
  }

  @override
  String get publishReport => '发布启事';

  @override
  String get stepTypeTitle => '发生了什么？';

  @override
  String get stepTypeSubtitle => '让我们尽快通知附近的人。';

  @override
  String get stepFoundPetTitle => '介绍一下这只动物';

  @override
  String get stepFoundPetSubtitle => '清晰的照片是让主人认出它的最快方式。';

  @override
  String get addFoundPhotos => '添加这只动物的照片';

  @override
  String get addFoundPhotosHint => '现在拍一张，或从相册中选择';

  @override
  String get whatKindOfAnimal => '是什么动物？';

  @override
  String get collarName => '项圈或名牌上的名字';

  @override
  String get collarNameHint => '不知道可以留空';

  @override
  String get stepLostPetTitle => '哪只宠物走失了？';

  @override
  String get stepLostPetSubtitle => '我们会使用它的档案和照片，你无需重新填写。';

  @override
  String get stepWhereFoundTitle => '你在哪里找到它的？';

  @override
  String stepWhereLostTitle(String pet) {
    return '$pet最后出现在哪里？';
  }

  @override
  String get stepWhereSubtitle =>
      '先选择城市，再在地图上标出位置。其他人只能看到约 100 米的范围，绝不会看到确切地址。';

  @override
  String get streetOrLandmark => '街道或地标';

  @override
  String get pinExactSpot => '标出确切位置';

  @override
  String spotHintFound(String pet) {
    return '拖动地图，让标记落在你找到$pet的地方。';
  }

  @override
  String spotHintLost(String pet) {
    return '拖动地图，让标记落在$pet最后出现的地方。';
  }

  @override
  String spotFarFromCity(int km, String city) {
    return '此位置距$city $km 公里。城市选对了吗？';
  }

  @override
  String spotPinned(int meters) {
    return '已标记。其他人只能看到周围约 $meters 米的范围，绝不会看到确切位置。';
  }

  @override
  String get timeHourAgo => '1小时前';

  @override
  String get timeThisMorning => '今天早上';

  @override
  String get stepWhenFoundTitle => '你什么时候找到它的？';

  @override
  String stepWhenLostTitle(String pet) {
    return '你最后一次见到$pet是什么时候？';
  }

  @override
  String get stepWhenSubtitle => '大概的时间就可以。';

  @override
  String get changeDate => '修改日期';

  @override
  String get changeTime => '修改时间';

  @override
  String get stepDetailsTitle => '还有其他需要说明的吗？';

  @override
  String get stepDetailsSubtitle => '详细信息能帮助邻居认出宠物并尽快联系你。';

  @override
  String descriptionHintLost(String pet) {
    return '项圈颜色、性格、$pet是怎么走失的……';
  }

  @override
  String get descriptionHintFound => '状况、项圈、行为、具体在哪里找到的……';

  @override
  String get howToReachYou => '别人如何联系你？';

  @override
  String get contactPrivacyNote => '仅在启事页面显示，不会出现在列表中。';

  @override
  String get phoneHint => '电话，例如 +39 333 123 4567';

  @override
  String get reachableOnWhatsapp => '可通过 WhatsApp 联系';

  @override
  String get reachableOnWhatsappHint => '别人可以通过这个号码给你发消息';

  @override
  String get stepReviewTitle => '准备好发布了吗？';

  @override
  String get stepReviewSubtitle => '附近的人会看到这样的启事。';

  @override
  String get iLostMyPet => '我的宠物走失了';

  @override
  String get iFoundAPet => '我捡到了一只宠物';

  @override
  String get iLostMyPetHint => '通知附近的人，获得寻找帮助。';

  @override
  String get iFoundAPetHint => '帮助走失的宠物回家。';

  @override
  String get addAPet => '添加宠物';

  @override
  String get pleaseChooseCity => '请选择城市';

  @override
  String noPlacesFound(String city, String query) {
    return '在$city未找到与“$query”相关的地点。';
  }

  @override
  String searchStreetHint(String city) {
    return '在$city搜索，例如 Via Dante';
  }

  @override
  String get yourCity => '你的城市';

  @override
  String get useMyLocation => '使用我的位置';

  @override
  String get publishFailed => '无法发布启事，请重试。';

  @override
  String get updateReportFailed => '无法更新启事，请重试。';

  @override
  String get deleteReportFailed => '无法删除启事，请重试。';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get termsOfUse => '使用条款';

  @override
  String legalLastUpdated(String date) {
    return '最后更新：$date';
  }

  @override
  String get deleteAccountPasswordPrompt => '请输入密码以确认。';

  @override
  String deleteAccountTypeConfirm(String word) {
    return '请输入 $word 以确认。';
  }

  @override
  String get wrongPassword => '密码错误，请重试。';

  @override
  String get confirmPasswordAgain => '为了你的安全，请再次确认密码。';

  @override
  String get contactUs => '联系我们';

  @override
  String get legalQuestions => '对本文件或你的数据有疑问？';

  @override
  String get languageChangeLater => '你可以随时在个人资料中更改。';

  @override
  String get reward => '酬谢';

  @override
  String get rewardHint => '金额（欧元）';

  @override
  String get rewardNote => '酬谢是主人与发现者之间的私人约定。CodaMi 不担保也不处理任何付款。';

  @override
  String rewardAmount(String amount) {
    return '酬谢 $amount';
  }

  @override
  String get adminPanel => '管理面板';

  @override
  String get roleAdmin => '管理员';

  @override
  String get roleSupport => '客服';

  @override
  String get supportStaff => '客服团队';

  @override
  String get supportStaffSubtitle => '负责回复支持请求的成员';

  @override
  String get adminUsers => '用户';

  @override
  String get adminListings => '发布信息';

  @override
  String get adminReportedContent => '被举报的内容';

  @override
  String get adminTickets => '支持请求';

  @override
  String get adminVideos => '视频';

  @override
  String get addSupportStaff => '添加客服';

  @override
  String get addSupportStaffHint => '请输入已有 CodaMi 账户的邮箱。';

  @override
  String get userNotFound => '没有使用此邮箱的 CodaMi 账户。';

  @override
  String get alreadyStaff => '此人已在团队中。';

  @override
  String staffAdded(String name) {
    return '$name 已加入客服团队。';
  }

  @override
  String removeStaffTitle(String name) {
    return '移除 $name？';
  }

  @override
  String get removeStaffMessage => '对方将无法再访问管理面板。';

  @override
  String get noSupportStaff => '客服团队暂无成员。';

  @override
  String get add => '添加';

  @override
  String get actionFailed => '出了点问题，请重试。';

  @override
  String get adminDashboard => '概览';

  @override
  String get adminMore => '更多';

  @override
  String get adminReportedShort => '被举报';

  @override
  String get adminTicketsShort => '支持请求';

  @override
  String get adminSectionSoon => '此功能即将推出。';

  @override
  String get statUsers => '注册用户';

  @override
  String get statOpenLost => '进行中的走失信息';

  @override
  String get statOpenFound => '进行中的拾获信息';

  @override
  String get statBackHome => '已回家的宠物';

  @override
  String get flagListing => '举报信息';

  @override
  String get flagTitle => '你为什么要举报这条信息？';

  @override
  String get flagHint => '我们的团队会进行审核。发布者不会知道是谁举报的。';

  @override
  String get flagReasonSpam => '垃圾信息或广告';

  @override
  String get flagReasonScam => '诈骗';

  @override
  String get flagReasonInappropriate => '不当内容';

  @override
  String get flagReasonWrongInfo => '虚假或误导性信息';

  @override
  String get flagReasonOther => '其他原因';

  @override
  String get flagNoteHint => '补充说明（可选）';

  @override
  String get flagSubmit => '提交举报';

  @override
  String get flagSent => '谢谢。我们的团队会审核这条信息。';

  @override
  String get alreadyFlagged => '你已经举报过这条信息。';

  @override
  String blockUser(String name) {
    return '屏蔽 $name';
  }

  @override
  String blockUserTitle(String name) {
    return '屏蔽 $name？';
  }

  @override
  String get blockUserMessage =>
      '你将不再看到对方的信息，也不会收到相关提醒。可以在 个人资料 → 已屏蔽用户 中取消屏蔽。';

  @override
  String get block => '屏蔽';

  @override
  String userBlocked(String name) {
    return '已屏蔽 $name。';
  }

  @override
  String get blockedUsers => '已屏蔽用户';

  @override
  String get noBlockedUsers => '你还没有屏蔽任何人。';

  @override
  String get unblock => '取消屏蔽';

  @override
  String userUnblocked(String name) {
    return '已取消屏蔽 $name。';
  }

  @override
  String get unknownUser => '未知用户';

  @override
  String get hiddenListing => '已隐藏';

  @override
  String get hiddenListingNotice => '此信息已被 CodaMi 团队隐藏，不再公开。';

  @override
  String get moderation => '内容管理';

  @override
  String get noFlagsOnListing => '没有人举报这条信息。';

  @override
  String flagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '被举报 $count 次',
    );
    return '$_temp0';
  }

  @override
  String get dismissFlags => '忽略举报';

  @override
  String get flagsDismissed => '已忽略举报。';

  @override
  String get hideListing => '隐藏信息';

  @override
  String get restoreListing => '恢复信息';

  @override
  String get listingHidden => '信息已隐藏，只有发布者还能看到。';

  @override
  String get listingRestored => '信息已恢复。';

  @override
  String get deleteListing => '删除信息';

  @override
  String get deleteListingTitle => '删除这条信息？';

  @override
  String get deleteListingMessage => '信息及其照片将对所有人删除，且无法撤销。';

  @override
  String get listingDeleted => '信息已删除。';

  @override
  String get listingUnavailable => '信息已不可用';

  @override
  String get noReportedContent => '暂无举报';

  @override
  String get noReportedContentMessage => '用户举报的信息会显示在这里。';

  @override
  String get filterOpen => '进行中';

  @override
  String get filterResolved => '已解决';

  @override
  String get filterHidden => '已隐藏';

  @override
  String get noListings => '暂无信息';

  @override
  String get tryAnotherFilter => '试试其他筛选条件。';

  @override
  String get adminUsersSubtitle => '查看、停用或删除账户';

  @override
  String get searchByEmail => '按邮箱搜索';

  @override
  String get noUsersFound => '未找到用户。';

  @override
  String get roleUser => '用户';

  @override
  String get userDisabled => '已停用';

  @override
  String get phone => '电话';

  @override
  String get memberSince => '注册时间';

  @override
  String get disableAccount => '停用账户';

  @override
  String get enableAccount => '启用账户';

  @override
  String disableUserTitle(String name) {
    return '停用 $name 的账户？';
  }

  @override
  String get disableUserMessage => '对方将被退出登录且无法再登录。账户重新启用前，其进行中的信息将保持隐藏。';

  @override
  String get accountDisabled => '账户已停用。';

  @override
  String get accountEnabled => '账户已启用。';

  @override
  String deleteUserTitle(String name) {
    return '删除 $name 的账户？';
  }

  @override
  String get deleteUserMessage => '将永久删除其个人资料、宠物、信息和照片，且无法撤销。';

  @override
  String get userDeleted => '账户已删除。';

  @override
  String get save => '保存';

  @override
  String get requiredField => '必填';

  @override
  String get notificationSettingsIntro =>
      '选择要接收的提醒，并为每种提醒设置不同的声音，不用看手机就知道发生了什么。';

  @override
  String get notificationSound => '声音';

  @override
  String get alertLostTitle => '附近走失的宠物';

  @override
  String get alertLostDescription => '当你所在城市有宠物走失时';

  @override
  String get alertFoundTitle => '附近找到的宠物';

  @override
  String get alertFoundDescription => '当有人在你所在城市找到宠物时';

  @override
  String get alertResolvedTitle => '圆满结局';

  @override
  String get alertResolvedDescription => '当走失或被找到的宠物回到家时';

  @override
  String get soundDefault => '手机默认';

  @override
  String get soundSilent => '静音';

  @override
  String get soundChime => '风铃';

  @override
  String get soundBell => '铃声';

  @override
  String get soundBright => '明快';

  @override
  String get soundSoft => '柔和';

  @override
  String get soundCustom => '自定义声音';

  @override
  String get soundFromPhone => '手机里的铃声和提示音';

  @override
  String get soundFromFile => '音乐或音频文件';

  @override
  String get soundIosNote => '在 iPhone 上，通知声音必须来自应用本身，请从上面的声音中选择。';

  @override
  String get soundPickFailed => '无法使用该声音，请换一个试试。';

  @override
  String get videosForYou => '为你推荐的视频';

  @override
  String get videosForYourPets => '根据你的宠物挑选';

  @override
  String get videosGeneral => '动物福利与负责任的养宠';

  @override
  String get videosShuffle => '换一批';

  @override
  String get videoMotivational => '励志';

  @override
  String get videoEducational => '知识';

  @override
  String get videoTagGeneral => '所有人';

  @override
  String get videoLoadError => '暂时无法播放此视频，请稍后再试。';

  @override
  String get adminVideosSubtitle => '上传和管理视频';

  @override
  String get addVideo => '添加视频';

  @override
  String get editVideo => '编辑视频';

  @override
  String get noVideosYet => '还没有视频。点击下方按钮添加第一个。';

  @override
  String get deleteVideoTitle => '删除这个视频？';

  @override
  String get deleteVideoMessage => '它将从应用中对所有人移除，且无法撤销。';

  @override
  String get videoHidden => '已隐藏';

  @override
  String get allLanguages => '所有语言';

  @override
  String get chooseVideo => '选择视频';

  @override
  String get chooseVideoHint => '从相册选择，最大 200 MB。短视频（2 分钟以内）效果最好。';

  @override
  String get videoTitle => '标题';

  @override
  String get videoType => '类型';

  @override
  String get videoAnimals => '动物';

  @override
  String get videoAnimalsHint => '选择视频涉及的动物。选择“所有人”表示向所有用户展示的通用视频。';

  @override
  String get videoVisible => '在应用中显示';

  @override
  String get videoVisibleHint => '隐藏的视频只有管理员可见。';

  @override
  String get videoTooLarge => '视频超过 200 MB，请选择更短的视频。';

  @override
  String get videoSaved => '视频已保存。';

  @override
  String uploadingProgress(int percent) {
    return '正在上传… $percent%';
  }

  @override
  String get navVideos => '视频';

  @override
  String get videosEmptyTitle => '视频即将上线';

  @override
  String get videosEmptyMessage => '很快这里会有关于照顾宠物的短视频。';

  @override
  String get moreVideos => '更多视频';

  @override
  String get videoWatched => '已看过';

  @override
  String get videoBack10 => '后退 10 秒';

  @override
  String get videoForward10 => '前进 10 秒';

  @override
  String get videoFullscreen => '全屏';

  @override
  String get videoExitFullscreen => '退出全屏';

  @override
  String get videoRetry => '重试';

  @override
  String get videoDeleted => '视频已删除。';

  @override
  String get noVideosYetTitle => '还没有视频';

  @override
  String get videoVisibleShort => '可见';

  @override
  String get play => '播放';

  @override
  String get edit => '编辑';

  @override
  String get change => '更换';

  @override
  String get videoSectionFile => '视频';

  @override
  String get videoSectionDetails => '详情';

  @override
  String get videoSectionAudience => '谁能看到';

  @override
  String get videoCover => '封面图片';

  @override
  String get videoCoverHint => '可选，显示在视频卡片上。';

  @override
  String get videoMotivationalHint => '鼓舞人心的故事和快乐时刻';

  @override
  String get videoEducationalHint => '给主人的建议和指南';

  @override
  String get uploadVideo => '上传视频';
}
