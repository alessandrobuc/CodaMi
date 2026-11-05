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

  @override
  String get helpSupport => '帮助与支持';

  @override
  String get helpSupportSubtitle => '与我们聊天或提交请求';

  @override
  String get supportIntroTitle => '我们能帮你什么？';

  @override
  String get supportIntroMessage => '我们的团队会在应用内回复。回复时你会收到通知。';

  @override
  String get supportStartChat => '开始在线聊天';

  @override
  String get supportStartChatOnline => '现在有客服在线';

  @override
  String get supportChatOffline => '目前没有客服在线。提交请求后我们会尽快回复。';

  @override
  String get supportSendRequest => '提交请求';

  @override
  String get supportSendRequestSubtitle => '我们通常在 24 小时内回复';

  @override
  String get supportMyRequests => '我的请求';

  @override
  String get supportNoRequests => '暂无请求';

  @override
  String get supportNoRequestsMessage => '你与客服的对话会显示在这里。';

  @override
  String get supportNewChat => '新的在线聊天';

  @override
  String get supportNewRequest => '新请求';

  @override
  String get supportCategory => '主题';

  @override
  String get categoryAccount => '账户与登录';

  @override
  String get categoryListing => '走失或寻获信息';

  @override
  String get categoryApp => '应用问题';

  @override
  String get categoryOther => '其他';

  @override
  String get supportSubject => '标题';

  @override
  String get supportSubjectHint => '简单描述';

  @override
  String get supportSubjectTooShort => '请至少输入 3 个字符';

  @override
  String get supportMessage => '消息';

  @override
  String get supportMessageHint => '告诉我们发生了什么';

  @override
  String get supportMessageRequired => '请输入消息';

  @override
  String get supportSend => '发送';

  @override
  String get supportTooManyOpen => '你已有 3 个未完成的请求，请在其中一个中继续。';

  @override
  String get supportTypeMessage => '输入消息…';

  @override
  String get supportTeam => 'CodaMi 客服';

  @override
  String get supportMarkSolved => '标记为已解决';

  @override
  String get supportMarkSolvedConfirm => '将此请求标记为已解决？如仍需帮助，可以再次发送消息。';

  @override
  String get supportClosedNote => '此请求已关闭。如需更多帮助，请新建请求。';

  @override
  String get supportResolvedNote => '已标记为已解决。再次发送消息会重新打开。';

  @override
  String get supportWaitingNote => '谢谢！我们的团队很快会在这里回复。';

  @override
  String get kindChat => '在线聊天';

  @override
  String get kindTicket => '请求';

  @override
  String get caseStatusOpen => '待处理';

  @override
  String get caseStatusInProgress => '处理中';

  @override
  String get caseStatusWaitingUser => '等待回复';

  @override
  String get caseStatusResolved => '已解决';

  @override
  String get caseStatusClosed => '已关闭';

  @override
  String get filterUnanswered => '未回复';

  @override
  String get filterUnassigned => '未分配';

  @override
  String get filterMine => '我的';

  @override
  String get filterActive => '进行中';

  @override
  String get filterDone => '已完成';

  @override
  String get supportSearchHint => '搜索 CM-1042 或邮箱';

  @override
  String get supportNoCases => '这里没有请求';

  @override
  String get supportNoCasesMessage => '此列表中没有待处理的内容。';

  @override
  String get supportTake => '接手此请求';

  @override
  String get supportTakeToReply => '接手此请求后才能回复。';

  @override
  String get supportAlreadyTaken => '其他客服已接手此请求。';

  @override
  String get supportUnassigned => '未分配';

  @override
  String get supportReassign => '重新分配';

  @override
  String get supportAssignTo => '分配给';

  @override
  String get supportBackToQueue => '放回队列';

  @override
  String get supportChangeStatus => '更改状态';

  @override
  String get supportChat => '聊天';

  @override
  String get supportTimeline => '时间线';

  @override
  String get supportDetails => '详情';

  @override
  String supportWaitingFor(String time) {
    return '已等待 $time';
  }

  @override
  String get supportOverdue => '回复超时';

  @override
  String get supportOpened => '创建时间';

  @override
  String get supportTakenOver => '接手时间';

  @override
  String get supportWaitToTake => '等待接手时长';

  @override
  String get supportFirstReply => '首次回复';

  @override
  String get supportAvgReply => '平均回复时间';

  @override
  String get supportHandlingTime => '处理时长';

  @override
  String get supportResolvedAt => '解决时间';

  @override
  String get supportMessagesCount => '消息数';

  @override
  String get supportOperator => '客服';

  @override
  String get supportUserLabel => '用户';

  @override
  String eventCreated(String name) {
    return '$name 创建了请求';
  }

  @override
  String eventTaken(String name) {
    return '$name 接手了请求';
  }

  @override
  String eventReassigned(String from, String to) {
    return '已从 $from 重新分配给 $to';
  }

  @override
  String eventStatus(String name, String status) {
    return '$name 将状态改为$status';
  }

  @override
  String get eventReopened => '用户重新打开了请求';

  @override
  String get eventOverdue => '未在时限内回复';

  @override
  String get eventAutoClosed => '已自动关闭';

  @override
  String get presenceOnline => '在线';

  @override
  String get presenceAway => '离开';

  @override
  String get presenceOffline => '离线';

  @override
  String get presenceAvailable => '可接待在线聊天';

  @override
  String get presenceAvailableSubtitle => '有客服在线时，用户可以发起在线聊天';

  @override
  String get supportOperators => '客服人员';

  @override
  String get supportOperatorsSubtitle => '活动、请求与回复时间';

  @override
  String get operatorOpenCases => '进行中的请求';

  @override
  String get operatorTaken => '已接手';

  @override
  String get operatorResolved => '已解决';

  @override
  String get operatorReplies => '回复数';

  @override
  String get operatorAvgHandling => '每个请求的平均时长';

  @override
  String operatorLastActive(String time) {
    return '最近活动 $time';
  }

  @override
  String get operatorCases => '请求';

  @override
  String get noOperators => '暂无客服人员，请在客服团队中添加。';

  @override
  String get statUnassigned => '未分配的请求';

  @override
  String get statUnanswered => '未回复的请求';

  @override
  String get statOverdue => '超时未回复';

  @override
  String get alertSupportTitle => '客服回复';

  @override
  String get alertSupportDescription => 'CodaMi 客服给你发消息时';

  @override
  String durationSeconds(int n) {
    return '$n 秒';
  }

  @override
  String durationMinutes(int n) {
    return '$n 分钟';
  }

  @override
  String durationHours(int h, int m) {
    return '$h 小时 $m 分钟';
  }

  @override
  String durationDays(int d, int h) {
    return '$d 天 $h 小时';
  }

  @override
  String get searchUsersHint => '按姓名或邮箱搜索';

  @override
  String get searchTooShort => '请至少输入 2 个字符';

  @override
  String get pickStaffTitle => '选择用户';

  @override
  String get pickStaffHint => '点击某人即可将其加入客服团队。';

  @override
  String makeStaffTitle(String name) {
    return '将 $name 设为客服人员？';
  }

  @override
  String get makeStaffMessage => '对方将看到管理端，并可回复请求和在线聊天。你可以随时移除。';

  @override
  String get makeStaff => '加入团队';

  @override
  String get supportStaffSwitch => '客服人员';

  @override
  String get supportStaffSwitchSubtitle => '可回复请求和在线聊天';

  @override
  String staffRemoved(String name) {
    return '$name 已不再是客服人员。';
  }

  @override
  String get removeStaffCasesNote => '其未完成的请求将回到队列。';

  @override
  String get pushOpen => '打开';

  @override
  String get chatToday => '今天';

  @override
  String get chatLoadEarlier => '加载更早的消息';

  @override
  String get supportPeople => '人员';

  @override
  String get supportTimes => '时间';

  @override
  String get supportRequestInfo => '请求';

  @override
  String get supportType => '类型';

  @override
  String get supportResolve => '标记为已解决';

  @override
  String ticketsWaiting(int count) {
    return '$count 个等待回复';
  }

  @override
  String get ticketsAllClear => '全部处理完毕';

  @override
  String get photoReviewHint => '被 AI 拦下的照片，在你做出决定前保持隐藏。';

  @override
  String get reasonAdult => '裸露或色情内容';

  @override
  String get reasonRacy => '挑逗性内容';

  @override
  String get reasonViolence => '暴力或血腥';

  @override
  String get likelihoodPossible => '可能';

  @override
  String get likelihoodLikely => '很可能';

  @override
  String get likelihoodVeryLikely => '极有可能';

  @override
  String get hiddenByAi => '已被 AI 隐藏';

  @override
  String get petPhoto => '宠物照片';

  @override
  String get listingPhoto => '启事照片';

  @override
  String uploadedBy(String name) {
    return '上传者：$name';
  }

  @override
  String get tapToView => '点击查看';

  @override
  String get approvePhoto => '通过';

  @override
  String get removePhotoTitle => '移除这张照片？';

  @override
  String get removePhotoMessage => '照片将从该用户的宠物或启事中移除，并会告知用户原因。';

  @override
  String get photoApproved => '照片已通过';

  @override
  String get photoRemovedDone => '照片已移除';

  @override
  String get photoUnderReview => '我们的团队正在审核一张照片，审核完成前将保持隐藏。';

  @override
  String get reportedTabPhotos => 'AI 照片';

  @override
  String get reportedTabReports => '用户举报';

  @override
  String get noPhotosToReview => '没有待审核的照片';

  @override
  String get noPhotosToReviewMessage => '被 AI 拦下的照片会显示在这里。';

  @override
  String get aFriend => '一位朋友';

  @override
  String get addContact => '添加联系人';

  @override
  String get addTestContacts => '添加测试联系人';

  @override
  String get adjustPoints => '调整积分';

  @override
  String get adjustPointsAmount => '要增加或扣除的积分';

  @override
  String get adjustPointsAmountHelp => '用负号扣除积分，例如 -20';

  @override
  String get adjustPointsInvalid => '请输入积分数量和原因。';

  @override
  String get adjustPointsReason => '原因（用户可见）';

  @override
  String get adminContactsSubtitle => '向用户显示的兽医、机构和服务';

  @override
  String get adminEmergenciesSubtitle => '已报告的动物紧急情况';

  @override
  String get alertEmergencyDescription => '你所在城市附近急需帮助的动物';

  @override
  String get alertEmergencyTitle => '附近的紧急情况';

  @override
  String get allContacts => '全部';

  @override
  String get ambassadorLevels => '大使等级';

  @override
  String get call112 => '拨打 112';

  @override
  String get claim => '领取';

  @override
  String get claimed => '已领取';

  @override
  String get codeCopied => '已复制邀请码';

  @override
  String get confirm => '确认';

  @override
  String get contactActive => '对用户显示';

  @override
  String get contactActiveHelp => '关闭后隐藏该联系人，但不会删除。';

  @override
  String get contactAddress => '地址';

  @override
  String get contactAreaKm => '服务范围（公里）';

  @override
  String get contactAreaKmHelp => '距地址多远范围内可以提供帮助。留空则使用紧急情况设置中的默认值。';

  @override
  String get contactCity => '城镇';

  @override
  String get contactHandles => '可处理的紧急情况';

  @override
  String get contactHandlesHelp => '如果可处理所有类型，全部保持关闭即可。';

  @override
  String get contactHoursHint => '营业时间，例如 周一至周五 9:00–18:00';

  @override
  String get contactInactive => '已隐藏';

  @override
  String get contactKindAssociation => '动物保护机构';

  @override
  String get contactKindOther => '其他服务';

  @override
  String get contactKindPublicService => '公共兽医服务';

  @override
  String get contactKindVet => '兽医';

  @override
  String get contactMissingFields => '请填写名称并在地图上放置标记。';

  @override
  String get contactName => '名称';

  @override
  String get contactNameHint => '例如 圣方济各宠物医院';

  @override
  String get contactPhones => '电话号码';

  @override
  String get contactPhonesHint => '多个号码用逗号分隔';

  @override
  String get contactPlace => '所在位置';

  @override
  String get contactRecommendedHelp => '报告紧急情况时，排在更近的联系人前面。';

  @override
  String get contactTestHelp => '用于测试的占位联系人。显示“测试”标签，永不认证，也不会收到邮件。';

  @override
  String get contactType => '类型';

  @override
  String get contactVerifiedHelp => '仅在机构同意列出且信息核实后开启。';

  @override
  String get copyCode => '复制';

  @override
  String get dailyActive => '今日活跃';

  @override
  String get dailyCheckin => '每日签到';

  @override
  String get dailyRewards => '每日奖励';

  @override
  String get deleteContactTitle => '删除此联系人？';

  @override
  String get directions => '路线';

  @override
  String get editContact => '编辑联系人';

  @override
  String get emergencies => '紧急情况';

  @override
  String get emergenciesActive => '进行中';

  @override
  String get emergenciesAll => '全部';

  @override
  String get emergenciesNearYou => '你附近';

  @override
  String get emergenciesSubtitle => '急需帮助的动物';

  @override
  String get emergencyAddPhotos => '添加照片';

  @override
  String get emergencyAddPhotosHint => '帮助他人找到并认出这只动物';

  @override
  String get emergencyAllContacts => '查看所有紧急联系人';

  @override
  String get emergencyAlreadyReported => '你已经报告过了。';

  @override
  String get emergencyCallReporter => '联系报告人';

  @override
  String get emergencyClose => '关闭';

  @override
  String get emergencyCloseTitle => '关闭此紧急情况？';

  @override
  String get emergencyContacts => '紧急联系人';

  @override
  String get emergencyDetails => '发生了什么？';

  @override
  String get emergencyDetailsHint => '例如 一只狗被车撞了，躺在路边，还有呼吸';

  @override
  String get emergencyDetailsRequired => '请用几句话描述情况。';

  @override
  String get emergencyDisclaimer =>
      'CodaMi 不是紧急救援服务。如果动物正处于紧急危险中，请先拨打 112 或联系兽医。不要只依赖应用通知。';

  @override
  String get emergencyFalseAlarmTitle => '标记为误报？';

  @override
  String get emergencyFindingContacts => '正在查找此地附近的联系人…';

  @override
  String get emergencyHelpDone => '谢谢！已通知报告人。';

  @override
  String get emergencyHelpMessage => '报告人会知道有人正在赶来。请在确保自身安全的情况下前往。';

  @override
  String get emergencyHelpTitle => '你要去帮忙吗？';

  @override
  String get emergencyImHelping => '我去帮忙';

  @override
  String get emergencyMarkFalseAlarm => '标记为误报';

  @override
  String get emergencyMarkResolved => '标记为已解决';

  @override
  String get emergencyMissingFields => '请选择发生了什么和动物种类，描述情况并放置标记。';

  @override
  String get emergencyNoContacts => '该地区还没有联系人。请拨打 112 或联系兽医。';

  @override
  String get emergencyPhoneHint => '愿意帮忙的人可以看到，方便给你打电话。';

  @override
  String get emergencyPinHint => '移动地图，把标记放在动物所在的位置。';

  @override
  String get emergencyPinned => '已放置标记';

  @override
  String get emergencyReopen => '重新打开';

  @override
  String get emergencyReportFalse => '举报为虚假';

  @override
  String get emergencyReportFalseDone => '谢谢，我们的团队会核查。';

  @override
  String get emergencyReportFalseMessage => '我们的团队会核查这个紧急情况。';

  @override
  String get emergencyReportFalseTitle => '这是虚假的紧急情况吗？';

  @override
  String get emergencyResolveTitle => '标记为已解决？';

  @override
  String get emergencyResolved => '已标记为已解决';

  @override
  String get emergencySend => '发送紧急情况';

  @override
  String get emergencySendFailed => '无法发送。请检查网络后重试，或拨打 112。';

  @override
  String get emergencySending => '正在发送…';

  @override
  String get emergencySent => '已发送。正在通知附近的人。你也可以直接拨打下方的联系人。';

  @override
  String get emergencySettings => '紧急情况设置';

  @override
  String get emergencySettingsSubtitle => '提醒范围和联系人排序';

  @override
  String get emergencyStatusClosed => '已关闭';

  @override
  String get emergencyStatusFalseAlarm => '误报';

  @override
  String get emergencyStatusHelping => '救助正在赶来';

  @override
  String get emergencyStatusOpen => '需要帮助';

  @override
  String get emergencyStatusResolved => '已解决';

  @override
  String get emergencySuggestedContacts => '谁能帮忙';

  @override
  String get emergencySuggestedContactsHint => '最近的合适联系人排在前面。请直接联系他们。';

  @override
  String get emergencyTypeAbandoned => '被遗弃的动物';

  @override
  String get emergencyTypeDanger => '处于危险中的动物';

  @override
  String get emergencyTypeInjured => '受伤的动物';

  @override
  String get emergencyTypeIntervention => '请求救助';

  @override
  String get emergencyTypeOther => '其他紧急情况';

  @override
  String get emergencyTypeUrgentFound => '发现动物，需要紧急护理';

  @override
  String get emergencyUnavailable => '此紧急情况已不可用。';

  @override
  String get emergencyWhatHappened => '发生了什么？';

  @override
  String get emergencyWhere => '动物在哪里？';

  @override
  String get emergencyWhereHint => '会分享准确位置，方便救助者找到动物。';

  @override
  String get emergencyYouAreHelping => '你表示会去帮忙，谢谢！';

  @override
  String get emergencyYourPhone => '你的电话';

  @override
  String get flagBurst => '该用户的许多朋友在同一天变为活跃';

  @override
  String get flagDeviceUsed => '这部手机已用于另一个邀请';

  @override
  String get flagSameDevice => '与邀请人使用同一部手机';

  @override
  String get haveInviteCode => '朋友邀请你了吗？输入他的邀请码';

  @override
  String get invitePromptTitle => '是朋友邀请你来的吗？';

  @override
  String get invitePromptBody => '输入朋友的邀请码，让你的朋友获得邀请你加入 CodaMi 的奖励。';

  @override
  String invitePromptLater(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '你也可以稍后在 个人资料 → 邀请好友 中添加，需在注册后 $days 天内。',
      one: '你也可以今天稍后在 个人资料 → 邀请好友 中添加。',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeLabel => '邀请码';

  @override
  String get inviteCodeFromLink => '已从你的邀请链接中填入。点击“使用”确认。';

  @override
  String get inviteCodeFormat => '邀请码由 6 位字母和数字组成，例如 ABC234。';

  @override
  String get inviteCodeNotFound => '找不到这个邀请码。请向朋友确认。';

  @override
  String get inviteCodeOwn => '这是你自己的邀请码。请分享给你的朋友。';

  @override
  String inviteCodeTooLate(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '邀请码只能在注册后的前 $days 天内添加。',
      one: '邀请码只能在注册当天添加。',
    );
    return '$_temp0';
  }

  @override
  String get inviteCodeTooManyTries => '今天输入错误的邀请码次数过多。请明天再试。';

  @override
  String get howInvitesWork => '规则说明';

  @override
  String get inviteApproved => '邀请已批准';

  @override
  String get inviteCodeAlreadyUsed => '你已经使用过邀请码。';

  @override
  String get inviteCodeInvalid => '邀请码无效。';

  @override
  String get inviteCodeNotAllowed => '无法使用此邀请码：这是你自己的邀请码，或注册时间已太久。';

  @override
  String get inviteFriends => '邀请朋友';

  @override
  String get inviteFriendsSubtitle => '成为 CodaMi 大使';

  @override
  String get inviteIntro => '每位新的 CodaMi 用户都会为走失的宠物多带来一双眼睛。邀请朋友，成为 CodaMi 大使。';

  @override
  String get inviteRejected => '邀请已拒绝';

  @override
  String get inviteStatusExpired => '未能按时变为活跃';

  @override
  String get inviteStatusPending => '已注册，尚未活跃';

  @override
  String get inviteStatusQualified => '活跃 – 已获得积分';

  @override
  String get inviteStatusRejected => '不计入';

  @override
  String get inviteStatusReview => '审核中';

  @override
  String get inviteStep1 => '分享你的邀请码。朋友注册后在 个人资料 → 邀请朋友 中输入。';

  @override
  String get invitedFriends => '已邀请的朋友（活跃）';

  @override
  String get invitesToReview => '待审核的邀请';

  @override
  String get invitesToReviewSubtitle => '被反作弊检查拦下的邀请';

  @override
  String get levelAmbassador => '大使';

  @override
  String get levelBonus => '奖励积分';

  @override
  String get settingsActiveFriends => '活跃好友';

  @override
  String get levelChampion => 'CodaMi 冠军';

  @override
  String get levelSuperAmbassador => '超级大使';

  @override
  String get levelSupporter => '支持者';

  @override
  String get myEmergencies => '我的';

  @override
  String get myPoints => '我的积分';

  @override
  String get noActiveEmergencies => '没有紧急情况';

  @override
  String get noEmergenciesMessage => '你所在城市附近报告的紧急情况会显示在这里。';

  @override
  String get noEmergenciesNearby => '你附近没有紧急情况';

  @override
  String get noEmergencyContacts => '还没有联系人';

  @override
  String get noEmergencyContactsAdmin => '添加兽医、机构和服务，或添加测试联系人来试用此功能。';

  @override
  String get noEmergencyContactsMessage => '联系人即将添加。遇到紧急情况，请拨打 112 或联系兽医。';

  @override
  String get noInvitesToReview => '没有需要审核的内容';

  @override
  String get noInvitesToReviewMessage => '可疑的邀请会显示在这里。没有你的决定，不会拒绝任何邀请。';

  @override
  String get noInvitesYet => '还没有邀请。分享你的邀请码开始吧。';

  @override
  String get noLevelYet => '暂无等级';

  @override
  String get noMyEmergencies => '你还没有报告过紧急情况';

  @override
  String get noPointsYet => '还没有积分。领取每日奖励开始吧。';

  @override
  String get open24h => '24 小时营业';

  @override
  String get openMapFailed => '无法打开地图。';

  @override
  String get photos => '照片';

  @override
  String get pointsAdjusted => '由 CodaMi 调整';

  @override
  String get pointsDailyActive => '今日活跃';

  @override
  String get pointsDailyCheckin => '每日签到';

  @override
  String get pointsFriendJoined => '一位朋友变为活跃';

  @override
  String get pointsHistory => '记录';

  @override
  String get pointsLevelBonus => '新等级奖励';

  @override
  String get pointsOther => '积分';

  @override
  String get pointsSettings => '积分与奖励';

  @override
  String get pointsSettingsIntro => '修改会立即生效。超出范围的数值会被默认值替代。';

  @override
  String get pointsSettingsSubtitle => '每日奖励、邀请和等级';

  @override
  String get pointsStreakBonus => '连续奖励';

  @override
  String get pointsWelcome => '欢迎奖励';

  @override
  String get recommendedContact => '推荐';

  @override
  String get reject => '拒绝';

  @override
  String get reportEmergency => '报告紧急情况';

  @override
  String get searchContacts => '按名称或城镇搜索';

  @override
  String get settingsActiveMinutes => '“今日活跃”所需使用分钟数';

  @override
  String get settingsAlertsNearby => '通知附近的人';

  @override
  String get settingsAutoCloseHours => '多久后关闭（无更新的小时数）';

  @override
  String get settingsAutoCloseHoursHelp => '进行中的紧急情况超过此时间会自动关闭。';

  @override
  String get settingsCodeEntryDays => '注册后可输入邀请码的天数';

  @override
  String get settingsContactsPriority => '联系人优先级';

  @override
  String get settingsDefaultAreaKm => '默认服务范围（公里）';

  @override
  String get settingsDefaultAreaKmHelp => '用于没有自定义范围的联系人。';

  @override
  String get settingsEmailContacts => '向联系人发送邮件提醒';

  @override
  String get settingsEmailContactsHelp => '向已认证的联系人发送邮件。需先设置邮件服务。';

  @override
  String get settingsMaxPerDay => '每天活跃朋友数上限（超过则审核）';

  @override
  String get settingsMaxPerDayHelp => '24 小时内超过此数量，邀请会进入审核。';

  @override
  String get settingsMaxRecipients => '最多通知人数';

  @override
  String get settingsMaxSuggested => '推荐联系人数';

  @override
  String get settingsMinRecipients => '需要触达的人数';

  @override
  String get settingsMinRecipientsHelp => '会逐步扩大到下一个圈，直到达到这个人数。';

  @override
  String get settingsQualifyDays => '需要的活跃天数';

  @override
  String get settingsQualifyWithinDays => '期限（注册后的天数）';

  @override
  String get settingsReferralPoints => '每位活跃朋友的积分';

  @override
  String get settingsRings => '提醒范围圈（公里）';

  @override
  String get settingsRingsHelp => '用逗号分隔，从小到大，例如 5, 10, 25';

  @override
  String get settingsSaved => '已保存';

  @override
  String get settingsStreakDays => '连续奖励所需天数';

  @override
  String get settingsWeight24h => '24 小时营业加分';

  @override
  String get settingsWeightHelp => '联系人获得这些加分，并按距离每公里扣分。得分最高的排在最前。';

  @override
  String get settingsWeightPerKm => '每公里扣分';

  @override
  String get settingsWeightPerKmHelp => '设为 1 时，推荐联系人（20）会排在近 20 公里以内的其他联系人前面。';

  @override
  String get settingsWeightRecommended => '推荐加分';

  @override
  String get settingsWeightVerified => '认证加分';

  @override
  String get settingsWelcomePoints => '被邀请朋友的积分';

  @override
  String get settingsWelcomePointsHelp => '输入邀请码时发放。设为 0 即关闭。';

  @override
  String get shareInvite => '分享';

  @override
  String get statActiveEmergencies => '进行中的紧急情况';

  @override
  String get testContactBadge => '测试 – 非真实联系人';

  @override
  String get topLevelReached => '你已达到最高等级，谢谢！';

  @override
  String get useCode => '使用';

  @override
  String get verifiedContact => '已认证';

  @override
  String get viewInvitee => '被邀请用户';

  @override
  String get viewInviter => '邀请人';

  @override
  String get yourInviteCode => '你的邀请码';

  @override
  String get yourInvites => '你的邀请';

  @override
  String get zeroTurnsOff => '设为 0 即关闭';

  @override
  String activeProgress(int done, int total) {
    return '今天 $done/$total 分钟';
  }

  @override
  String claimedPoints(int points) {
    return '+$points 积分！';
  }

  @override
  String claimedWithBonus(int points, int bonus) {
    return '+$points 积分，外加 +$bonus 连续奖励！';
  }

  @override
  String emergenciesNearYouCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '你附近有 $count 起动物紧急情况',
    );
    return '$_temp0';
  }

  @override
  String emergencyAlertedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已通知附近 $count 人',
      zero: '附近还没有人开启提醒',
    );
    return '$_temp0';
  }

  @override
  String emergencyFalseReports(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '被举报为虚假 $count 次',
    );
    return '$_temp0';
  }

  @override
  String emergencyHelpersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 人正在赶去帮忙',
    );
    return '$_temp0';
  }

  @override
  String inviteCodeAccepted(String name) {
    return '邀请码已接受。$name 邀请了你，欢迎来到 CodaMi！';
  }

  @override
  String inviteShareText(String code, String link) {
    return '我在用 CodaMi 帮助走失的宠物回家。用我的邀请码 $code 加入吧：$link';
  }

  @override
  String inviteStep2(int days, int within) {
    return '对方设置所在城市，并在注册后 $within 天内有 $days 天使用应用。';
  }

  @override
  String inviteStep3(int points) {
    return '你获得 $points 积分，并提升大使等级。';
  }

  @override
  String kmAway(String km) {
    return '距离 $km 公里';
  }

  @override
  String levelFriends(String level) {
    return '$level：活跃朋友数';
  }

  @override
  String levelRule(String level, int friends, int bonus) {
    return '$level · $friends+ 位朋友 · +$bonus';
  }

  @override
  String nextLevelHint(int count, String level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '再邀请 $count 位活跃朋友即可成为$level',
    );
    return '$_temp0';
  }

  @override
  String plusPoints(int points) {
    return '+$points 积分';
  }

  @override
  String pointsTotal(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points 积分',
    );
    return '$_temp0';
  }

  @override
  String streakLine(int streak, int days, int bonus) {
    return '已连续 $streak 天 · 每 $days 天奖励 +$bonus';
  }

  @override
  String get pointsFeedback => '已提交反馈';

  @override
  String get whatsNew => '新功能';

  @override
  String get whatsNewSubtitle => '每个版本的更新内容';

  @override
  String get whatsNewTitle => 'CodaMi 新功能';

  @override
  String get whatsNewIntro => '以下是最近一次更新的变化。';

  @override
  String whatsNewVersion(String version) {
    return '版本 $version';
  }

  @override
  String get whatsNewSectionNew => '新增';

  @override
  String get whatsNewSectionImproved => '改进';

  @override
  String get whatsNewSectionFixed => '修复';

  @override
  String get whatsNewEmpty => '暂无更新说明。';

  @override
  String get whatsNewDone => '知道了';

  @override
  String get feedbackTitle => '你觉得 CodaMi 怎么样？';

  @override
  String get feedbackBody => '你的反馈会直接发送给 CodaMi 团队，帮助我们把应用做得更好。';

  @override
  String feedbackPointsOffer(int points) {
    return '首次反馈可得 +$points 积分';
  }

  @override
  String get feedbackStarsHint => '点击星星评分';

  @override
  String get feedbackCommentHint => '你喜欢什么，或者哪里可以改进？（选填）';

  @override
  String get feedbackSend => '提交反馈';

  @override
  String get feedbackLater => '以后再说';

  @override
  String get feedbackThanks => '感谢你的反馈！';

  @override
  String feedbackThanksPoints(int points) {
    return '感谢你的反馈！+$points 积分';
  }

  @override
  String get feedbackAlreadyToday => '你今天已经提交过反馈了，明天可以再提交。';

  @override
  String get sendFeedbackSubtitle => '告诉团队你的想法';

  @override
  String get rateCodaMi => '为 CodaMi 评分';

  @override
  String get rateCodaMiSubtitle => '在 Google Play 上留下评价';

  @override
  String get adminFeedback => '用户反馈';

  @override
  String get adminFeedbackSubtitle => '用户对应用的看法';

  @override
  String get adminFeedbackEmpty => '暂无反馈。';

  @override
  String feedbackRatingsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个评分',
    );
    return '$_temp0';
  }

  @override
  String get feedbackNoComment => '无评论';

  @override
  String get adminWhatsNewSubtitle => '每次更新后向用户显示的说明';

  @override
  String get releaseAdd => '添加版本';

  @override
  String get releaseEdit => '编辑说明';

  @override
  String get releaseVersion => '版本号';

  @override
  String get releaseVersionHelp => '例如 1.1.0。必须与应用商店中的应用版本名称一致。';

  @override
  String get releaseVersionInvalid => '请使用数字和点，例如 1.1.0。';

  @override
  String get releaseVersionExists => '该版本已有说明。';

  @override
  String get releasePublishedHelp => '用户只能看到已发布的说明。';

  @override
  String get releaseDraft => '草稿';

  @override
  String get releaseLinesHelp => '每行一项更改。';

  @override
  String get releaseLanguageHelp => '留空的语言将显示英文说明。';

  @override
  String get releaseEnglishRequired => '请先填写英文说明：其他语言缺失时会使用英文。';

  @override
  String get releaseDeleteTitle => '删除这些说明？';

  @override
  String releaseDeleteBody(String version) {
    return '版本 $version 的说明将对所有人删除。';
  }

  @override
  String get releaseNone => '暂无版本。请添加下次更新的说明。';

  @override
  String releaseThisApp(String version) {
    return '本应用：版本 $version';
  }

  @override
  String get feedbackAndReviews => '反馈和评价';

  @override
  String get settingsFeedbackPoints => '首次反馈的积分';

  @override
  String get settingsFeedbackAfterDays => '注册后多少天请求反馈';

  @override
  String get settingsReviewActiveDays => '使用多少天后请求';

  @override
  String get settingsReviewAfterDays => '注册后多少天显示商店评分窗口';

  @override
  String get settingsReviewEveryDays => '商店评分请求的间隔天数';

  @override
  String get settingsReviewHelp =>
      '商店评分窗口从不奖励积分：Google Play 和 App Store 不允许这样做。';

  @override
  String get petitions => '请愿';

  @override
  String get petition => '请愿';

  @override
  String get petitionsSubtitle => '由我们团队精选的动物福利活动';

  @override
  String get adminPetitionsSubtitle => '添加、审核并发布动物福利请愿';

  @override
  String petitionsBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 份动物福利请愿等你签署',
      one: '1 份动物福利请愿等你签署',
    );
    return '$_temp0';
  }

  @override
  String get petitionsIntro => 'CodaMi 团队会在每份请愿展示前进行核实。你可以在原网站阅读并签署。';

  @override
  String get petitionsEmpty => '暂无请愿。团队会在这里添加动物福利活动。';

  @override
  String get petitionAdminEmpty =>
      '这里还没有请愿。点击“添加请愿”，从 Change.org、Care2、Avaaz 或可信机构添加一份。';

  @override
  String get petitionView => '查看请愿';

  @override
  String get petitionSignOnSite => '在原网站阅读并签署';

  @override
  String get petitionOpenFailed => '无法打开请愿页面。';

  @override
  String get petitionIssue => '问题';

  @override
  String get petitionAction => '请愿诉求';

  @override
  String get petitionWhy => '为什么这对动物很重要';

  @override
  String get petitionWhere => '原始请愿';

  @override
  String petitionStartedOn(String date) {
    return '发起于 $date';
  }

  @override
  String get petitionDisclaimer => '此请愿由外部网站托管。CodaMi 不收集签名，也不对原页面的内容负责。';

  @override
  String get petitionEndedNote => '此活动已结束。你仍可以阅读原页面。';

  @override
  String get petitionUnavailableNote => '原始请愿已无法访问。';

  @override
  String get petitionTopicPets => '宠物';

  @override
  String get petitionTopicWildlife => '野生动物';

  @override
  String get petitionTopicFarm => '农场动物';

  @override
  String get petitionTopicTesting => '动物实验';

  @override
  String get petitionTopicEntertainment => '马戏团和动物园';

  @override
  String get petitionTopicMarine => '海洋生物';

  @override
  String get petitionTopicOther => '其他';

  @override
  String get petitionStatusActive => '进行中';

  @override
  String get petitionStatusCompleted => '已完成';

  @override
  String get petitionStatusClosed => '已关闭';

  @override
  String get petitionStatusUnavailable => '已失效';

  @override
  String get petitionReviewPending => '待审核';

  @override
  String get petitionReviewApproved => '已通过';

  @override
  String get petitionReviewRejected => '已拒绝';

  @override
  String get petitionAdd => '添加请愿';

  @override
  String get petitionEdit => '编辑请愿';

  @override
  String get petitionSectionSource => '原始请愿';

  @override
  String get petitionUrl => '请愿链接';

  @override
  String get petitionUrlInvalid => '请粘贴以 https:// 开头的完整链接';

  @override
  String get petitionTitle => '标题';

  @override
  String get petitionSource => '平台或机构';

  @override
  String get petitionCountry => '国家或地区';

  @override
  String get petitionCountryHelp => '国际性活动请留空。';

  @override
  String get petitionStartedOnPick => '请愿发起日期（选填）';

  @override
  String get petitionTopic => '主题';

  @override
  String get petitionSectionText => '我们的描述';

  @override
  String get petitionOwnWordsHelp => '请用自己的话撰写，不要复制原页面的文字。';

  @override
  String get petitionSummary => '简短摘要';

  @override
  String get petitionImage => '图片';

  @override
  String get petitionImageAdd => '添加图片';

  @override
  String get petitionImageChange => '更换图片';

  @override
  String get petitionImageHelp => '选填。没有图片时，卡片会显示主题图标。';

  @override
  String get petitionImagePermission => '我们已获得使用此图片的许可';

  @override
  String get petitionImagePermissionNeeded => '请确认你有权使用该图片，或将其移除。';

  @override
  String get petitionImageTooBig => '图片太大。请选择小于 5 MB 的图片。';

  @override
  String get petitionChecks => '核实';

  @override
  String get petitionChecksHelp => '四项全部勾选后才能通过或发布。';

  @override
  String get petitionCheckExists => '原页面存在且可以打开';

  @override
  String get petitionCheckGenuine => '涉及真实的动物福利问题';

  @override
  String get petitionCheckGoal => '目标明确';

  @override
  String get petitionCheckHonest => '没有误导性或欺诈性内容';

  @override
  String get petitionChecksNeeded => '请先勾选所有核实项，再通过或发布。';

  @override
  String get petitionReview => '审核';

  @override
  String get petitionReviewHelp => '只有已发布的请愿才会向用户显示。';

  @override
  String get petitionRejectReason => '原因（仅管理员可见）';

  @override
  String get petitionStatus => '请愿状态';

  @override
  String get petitionStatusHelp => '活动结束或页面被删除时请更新状态。';

  @override
  String get petitionFixFields => '请填写标红的字段。';

  @override
  String get petitionDeleteTitle => '确定删除这份请愿？';

  @override
  String get petitionDeleteBody => '它将从应用中对所有人移除。';

  @override
  String petitionAddedOn(String date) {
    return '添加于 $date';
  }

  @override
  String petitionPublishedOn(String date) {
    return '发布于 $date';
  }

  @override
  String petitionUpdatedOn(String date) {
    return '更新于 $date';
  }

  @override
  String get appUpdates => '应用更新';

  @override
  String get adminAppUpdatesSubtitle => '商店版本与强制更新';

  @override
  String get appUpdatesSubtitle => '商店中的版本';

  @override
  String get appUpdatesIntro =>
      '使用旧版本的用户会看到更新提示，并附带最新版本的更新内容。低于最低版本时，必须更新后才能使用应用。修改这些设置无需发布新版本。';

  @override
  String appUpdatesThisPhone(String version) {
    return '此手机的版本为 $version';
  }

  @override
  String get appUpdatesAndroid => 'Android（Google Play）';

  @override
  String get appUpdatesIos => 'iPhone（App Store）';

  @override
  String get appUpdatesLatest => '商店中的最新版本';

  @override
  String get appUpdatesLatestHelp => '更新在商店上线后再填写。留空则不显示更新提示。';

  @override
  String get appUpdatesMinimum => '最低版本';

  @override
  String get appUpdatesMinimumHelp => '更旧的版本必须先更新才能使用应用。留空表示不限制。';

  @override
  String get appUpdatesStoreId => 'App Store ID';

  @override
  String get appUpdatesStoreIdHelp =>
      'App Store 链接中的数字（apps.apple.com/app/id…）。iPhone 上的更新按钮需要它。';

  @override
  String appUpdatesNotesPublished(String version) {
    return '$version 的更新内容已发布，会随更新提示显示';
  }

  @override
  String appUpdatesNotesDraft(String version) {
    return '$version 的更新内容已保存但未发布';
  }

  @override
  String appUpdatesNotesMissing(String version) {
    return '$version 还没有更新内容';
  }

  @override
  String get appUpdatesBadVersion => '请使用类似 1.2.0 的版本号';

  @override
  String get appUpdatesMinimumAbove => '最低版本不能高于最新版本';

  @override
  String get appUpdatesBadStoreId => 'App Store ID 只能包含数字';

  @override
  String get appUpdatesRequireTitle => '要强制更新吗？';

  @override
  String appUpdatesRequireBody(String version) {
    return '所有低于 $version 的用户都必须更新后才能使用应用。';
  }

  @override
  String get appUpdatesRequireConfirm => '强制更新';

  @override
  String get updateAvailableTitle => '有可用更新';

  @override
  String updateAvailableBody(String latest, String installed) {
    return 'CodaMi $latest 版已推出。您当前是 $installed。';
  }

  @override
  String get updateNow => '立即更新';

  @override
  String get updateLater => '稍后';

  @override
  String get updateRequiredTitle => '需要更新';

  @override
  String updateRequiredBody(String version) {
    return '此版本的 CodaMi 已不再支持。请更新到 $version 版以继续使用。';
  }

  @override
  String updateBanner(String version) {
    return '$version 版现已推出';
  }

  @override
  String get updateStoreFailed => '无法打开应用商店。请在商店应用中更新 CodaMi。';

  @override
  String get rateCodaMiSubtitleIos => '在 App Store 上评分';

  @override
  String get updateContinueAsAdmin => '以管理员身份继续';

  @override
  String get navShop => '商店';

  @override
  String get shop => '商店';

  @override
  String get adminShopSubtitle => '商品、品牌、供应商和开关';

  @override
  String get shopSubtitle => '为您的宠物精选商品';

  @override
  String get shopSearchHint => '搜索商品';

  @override
  String get shopEmpty => '商品即将上架，敬请期待！';

  @override
  String get shopNoResults => '没有匹配的商品。';

  @override
  String get shopInStock => '有货';

  @override
  String get shopLowStock => '仅剩少量';

  @override
  String get shopOutOfStock => '缺货';

  @override
  String get shopComingSoon => '即将上架';

  @override
  String get shopModelOwnStock => '自有库存';

  @override
  String get shopModelBrand => '品牌合作';

  @override
  String get shopModelDropship => '代发货';

  @override
  String get shopModelAffiliate => '联盟链接';

  @override
  String get shopModelOwnStockHelp => '由 CodaMi 备货并发货。';

  @override
  String get shopModelBrandHelp => '品牌通过 CodaMi 销售并负责发货。';

  @override
  String get shopModelDropshipHelp => '由供应商直接发货给顾客。';

  @override
  String get shopModelAffiliateHelp => '通过我们的链接在合作方网站购买，CodaMi 获得佣金。';

  @override
  String shopBuyOn(String partner) {
    return '在 $partner 购买';
  }

  @override
  String shopAffiliateNote(String partner) {
    return '由 $partner 销售并发货。CodaMi 可能从此次购买中获得佣金。';
  }

  @override
  String shopPriceOnPartner(String partner) {
    return '价格见 $partner';
  }

  @override
  String get shopAddToCart => '加入购物车';

  @override
  String get shopCheckoutSoon => '应用内购买即将推出。';

  @override
  String get shopAllAnimals => '适合所有动物';

  @override
  String get shopDescription => '描述';

  @override
  String get shopOpenFailed => '无法打开链接。';

  @override
  String get shopPreviewOff => '预览：商店已关闭，用户看不到。';

  @override
  String get shopAdminIntro => '管理 CodaMi 商店。只有开启时用户才能看到。';

  @override
  String get shopOpenSwitch => '向用户开放商店';

  @override
  String get shopOnHelp => '开启：所有人都能看到商店标签。';

  @override
  String get shopOffHelp => '关闭：用户看不到商店，管理员仍可准备内容。';

  @override
  String get shopTurnOnTitle => '开启商店？';

  @override
  String get shopTurnOnBody => '所有用户将立即看到商店标签和上架商品。';

  @override
  String get shopTurnOffTitle => '关闭商店？';

  @override
  String get shopTurnOffBody => '商店标签将立即对所有用户隐藏，商品和设置会保留。';

  @override
  String get shopTurnOn => '开启';

  @override
  String get shopTurnOff => '关闭';

  @override
  String get shopSalesModels => '销售模式';

  @override
  String get shopSalesModelsHelp => '关闭某个模式会对用户隐藏其全部商品。';

  @override
  String get shopCatalog => '商品目录';

  @override
  String get shopProducts => '商品';

  @override
  String get shopCategories => '分类';

  @override
  String get shopBrands => '品牌';

  @override
  String get shopSuppliers => '供应商';

  @override
  String get shopPreview => '预览商店';

  @override
  String get shopPreviewSubtitle => '以用户视角查看商店';

  @override
  String shopProductsCount(int active, int total) {
    return '$active 个上架 · 共 $total 个';
  }

  @override
  String get shopAddProduct => '添加商品';

  @override
  String get shopEditProduct => '编辑商品';

  @override
  String get shopProductsEmpty => '还没有商品，添加第一个吧。';

  @override
  String get shopActive => '上架';

  @override
  String get shopHidden => '隐藏';

  @override
  String get shopNeedCategory => '请先添加分类（商店 → 分类）。';

  @override
  String get shopPhotos => '照片';

  @override
  String get shopPhotosHelp => '最多 6 张照片，第一张为封面；长按拖动可调整顺序。';

  @override
  String get shopAddPhoto => '添加照片';

  @override
  String get shopImageTooBig => '图片必须小于 5 MB。';

  @override
  String get shopDetails => '详情';

  @override
  String get shopName => '名称';

  @override
  String get shopCategory => '分类';

  @override
  String get shopPickCategory => '请选择分类';

  @override
  String get shopAnimals => '适用动物';

  @override
  String get shopAnimalsHelp => '不选表示适合所有动物。用户会优先看到适合自己宠物的商品。';

  @override
  String get shopSalesModel => '销售模式';

  @override
  String get shopPartnerName => '合作商店';

  @override
  String get shopAffiliateUrl => '联盟链接';

  @override
  String get shopBrand => '品牌';

  @override
  String get shopNoBrand => '无品牌';

  @override
  String get shopSupplier => '供应商';

  @override
  String get shopNoSupplier => '无供应商';

  @override
  String get shopPriceSection => '价格';

  @override
  String get shopPrice => '价格（€）';

  @override
  String get shopPriceAffiliateHelp => '可选：价格以合作方网站为准。';

  @override
  String get shopPriceInvalid => '请输入价格，例如 12.90';

  @override
  String get shopCompareAt => '折前价格（€）';

  @override
  String get shopCompareAtHelp => '可选，以删除线显示在价格旁。';

  @override
  String get shopCompareAtInvalid => '必须高于售价。';

  @override
  String get shopAvailability => '库存状态';

  @override
  String get shopVisible => '对用户可见';

  @override
  String get shopVisibleHelp => '隐藏的商品只有管理员可见。';

  @override
  String get shopCategoryVisibleHelp => '隐藏后，该分类及其全部商品对用户不可见。';

  @override
  String get shopBrandVisibleHelp => '隐藏后，该品牌的全部商品对用户不可见。';

  @override
  String get shopSupplierActiveHelp => '关闭后，该供应商的全部商品对用户不可见。';

  @override
  String get shopDeleteProductTitle => '删除此商品？';

  @override
  String get shopDeleteProductBody => '商品及其照片将被删除，无法撤销。';

  @override
  String shopDeleteTitle(String name) {
    return '删除 $name？';
  }

  @override
  String get shopDeleteBody => '此操作无法撤销。';

  @override
  String get shopInUse => '仍被商品或子分类使用，无法删除。请改为隐藏。';

  @override
  String get shopFixFields => '请检查标红的字段。';

  @override
  String get shopLinkInvalid => '请输入以 https:// 开头的完整链接';

  @override
  String get shopAddCategory => '添加分类';

  @override
  String get shopEditCategory => '编辑分类';

  @override
  String get shopAddStarting => '添加初始分类';

  @override
  String get shopStartingHelp => '从食品、配件、护理、玩具、窝垫、外出箱、科技和其他开始，之后可重命名、隐藏或删除。';

  @override
  String get shopParent => '所属分类';

  @override
  String get shopNoParent => '无（主分类）';

  @override
  String get shopIcon => '图标';

  @override
  String get shopOrder => '排序';

  @override
  String get shopOrderHelp => '数字越小越靠前。';

  @override
  String get shopCatFood => '宠物食品';

  @override
  String get shopCatAccessories => '配件';

  @override
  String get shopCatCare => '护理用品';

  @override
  String get shopCatToys => '玩具';

  @override
  String get shopCatBeds => '窝垫';

  @override
  String get shopCatCarriers => '外出箱包';

  @override
  String get shopCatTech => '智能设备';

  @override
  String get shopCatOther => '其他';

  @override
  String get shopAddBrand => '添加品牌';

  @override
  String get shopEditBrand => '编辑品牌';

  @override
  String get shopBrandsEmpty => '还没有品牌。品牌可选，有合作伙伴时再添加。';

  @override
  String get shopWebsite => '网站';

  @override
  String get shopLogo => '标志';

  @override
  String get shopAddLogo => '选择标志';

  @override
  String get shopAddSupplier => '添加供应商';

  @override
  String get shopEditSupplier => '编辑供应商';

  @override
  String get shopSuppliersEmpty => '还没有供应商。';

  @override
  String get shopSuppliersHelp => '只有管理员能看到供应商及其信息。关闭供应商会隐藏其商品。';

  @override
  String get shopContactName => '联系人';

  @override
  String get shopEmail => '邮箱';

  @override
  String get shopEmailInvalid => '请输入有效的邮箱地址。';

  @override
  String get shopPhone => '电话';

  @override
  String get shopOrderMethod => '订单如何发送';

  @override
  String get shopOrderManual => '手动';

  @override
  String get shopOrderManualHelp => '由团队将每个订单转给供应商。';

  @override
  String get shopOrderEmail => '自动邮件';

  @override
  String get shopOrderEmailHelp => '每笔已付款订单会通过邮件发给供应商（随结账功能上线）。';

  @override
  String get shopNotes => '备注（仅管理员）';

  @override
  String get shopForYourPets => '适合您的宠物';

  @override
  String get shopOnSale => '特价';

  @override
  String get shopAllProducts => '全部商品';

  @override
  String get shopResults => '搜索结果';

  @override
  String shopProductCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 件商品',
    );
    return '$_temp0';
  }

  @override
  String shopYouSave(String amount) {
    return '立省 $amount';
  }

  @override
  String get shopCart => '购物车';

  @override
  String get shopCartClear => '清空';

  @override
  String get shopCartEmpty => '购物车是空的，去商店添加商品吧。';

  @override
  String shopCartUnavailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 件商品已无法购买',
    );
    return '$_temp0';
  }

  @override
  String get shopCheckout => '结账';

  @override
  String get shopPaymentSoon => '应用内支付即将推出。';

  @override
  String get shopViewCart => '查看购物车';

  @override
  String get shopShipping => '配送';

  @override
  String get shopShipTo => '配送至';

  @override
  String get shopShippingNotSet => '配送方式即将在此显示。';

  @override
  String get shopFree => '免费';

  @override
  String shopFreeAbove(String amount) {
    return '满 $amount 免运费';
  }

  @override
  String shopFreeShippingGap(String amount) {
    return '再买 $amount 即可免运费';
  }

  @override
  String get shopSummary => '订单摘要';

  @override
  String get shopSubtotal => '小计';

  @override
  String get shopTotal => '合计';

  @override
  String get shopVatIncluded => '含增值税';

  @override
  String get shopSponsored => '赞助';

  @override
  String get shopSponsoredSection => '赞助推广';

  @override
  String get shopSponsoredHelp => '在商店及其分类中置顶显示，并带有“赞助”标签。';

  @override
  String get shopSponsorFrom => '开始';

  @override
  String get shopSponsorUntil => '结束';

  @override
  String get shopSponsorDatesHelp => '留空表示立即开始，直到关闭为止。';

  @override
  String get shopSponsorDatesInvalid => '结束日期早于开始日期。';

  @override
  String get shopNoDate => '无日期';

  @override
  String get shopCost => '成本价（€，仅管理员）';

  @override
  String get shopCostHelp => 'CodaMi 支付给供应商或品牌的价格，用户永远看不到。';

  @override
  String shopMargin(String amount, int percent) {
    return '利润：$amount（$percent%）';
  }

  @override
  String get shopAffiliateClicks => '联盟点击';

  @override
  String shopClicksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '“购买”点击 $count 次',
    );
    return '$_temp0';
  }

  @override
  String get shopLast30Days => '最近 30 天 · 点击刷新';

  @override
  String get shopShippingIntro => '配送地区、方式和价格（含增值税），保存后立即对所有用户生效。';

  @override
  String get shopShippingStarting => '添加初始设置';

  @override
  String get shopZones => '配送地区';

  @override
  String get shopZonesHelp => '您配送的地区，关闭后将不再配送到该地区。';

  @override
  String get shopZoneName => '地区名称';

  @override
  String get shopAddZone => '添加地区';

  @override
  String get shopZoneItaly => '意大利';

  @override
  String get shopZoneIslands => '西西里和撒丁岛';

  @override
  String get shopZoneEurope => '欧盟';

  @override
  String get shopMethod => '配送方式';

  @override
  String get shopAddMethod => '添加配送方式';

  @override
  String get shopMethodActive => '向用户提供';

  @override
  String get shopMethodStandard => '标准配送';

  @override
  String get shopMethodExpress => '快速配送';

  @override
  String get shopMethodStandardTime => '3–5 个工作日';

  @override
  String get shopMethodExpressTime => '1–2 个工作日';

  @override
  String get shopDeliveryTime => '向用户显示的配送时间';

  @override
  String get shopPricePerZone => '各地区运费';

  @override
  String get shopPricePerZoneHelp => '不提供的地区留空，0 表示免费。';

  @override
  String get shopFreeAboveLabel => '满额免运费（€）';

  @override
  String get shopFreeAboveHelp => '可选，留空则始终收取运费。';

  @override
  String get inviteQrTitle => '您的二维码';

  @override
  String get inviteQrSubtitle => '保存或打印传单，邀请附近的人。';

  @override
  String get inviteQrScreenTitle => '二维码和传单';

  @override
  String get inviteQrCode => '二维码';

  @override
  String get inviteFlyer => '传单';

  @override
  String get inviteQrHelp => '朋友用手机相机扫描，即可通过您的邀请码获取 CodaMi。';

  @override
  String get inviteFlyerHelp => '可直接打印并在附近分发的传单。';

  @override
  String get inviteSaveToPhotos => '保存到相册';

  @override
  String get inviteSaved => '已保存到相册';

  @override
  String get inviteSaveDenied => '保存失败，请在手机设置中允许 CodaMi 添加照片。';

  @override
  String get flyerTitle => '帮助走失的宠物回家';

  @override
  String get flyerText => '加入 CodaMi，邻居们互相帮助寻找走失和捡到的宠物的免费应用。';

  @override
  String get flyerScan => '用手机相机扫描';

  @override
  String flyerCode(String code) {
    return '邀请码：$code';
  }

  @override
  String get flyerFree => '免费应用';

  @override
  String get walksTitle => '遛宠地点';

  @override
  String get walksSubtitle => '附近的公园、狗狗乐园和步道';

  @override
  String get adminWalksSubtitle => 'Google 地点搜索、距离、类型、已隐藏地点';

  @override
  String get walkDogParks => '狗狗乐园';

  @override
  String get walkParks => '公园';

  @override
  String get walkGreen => '绿地';

  @override
  String get walkTrails => '步道';

  @override
  String walkNearYou(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '附近 $count 个地点',
    );
    return '$_temp0';
  }

  @override
  String walkNearCity(int count, String city) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$city 附近 $count 个地点',
    );
    return '$_temp0';
  }

  @override
  String get walkUseMyLocation => '使用我的位置';

  @override
  String get walkNeedLocation => '允许定位或在个人资料中设置城市，即可查看附近地点。';

  @override
  String get walkShowMap => '显示地图';

  @override
  String get walkShowList => '显示列表';

  @override
  String get walkSearching => '正在查找地点…';

  @override
  String get walkNoPlaces => '这里没有找到地点，试试更大的距离。';

  @override
  String get walkLimitReached => '今日搜索次数已达上限，请明天再试。';

  @override
  String get walkTurnedOff => '遛宠地点暂时不可用。';

  @override
  String get walkUnavailable => '无法加载地点，请检查网络后重试。';

  @override
  String get walkSearchHere => '搜索此区域';

  @override
  String get walkDataFromGoogle => '地点数据来自 Google';

  @override
  String walkPhotoBy(String name) {
    return '照片：$name（Google）';
  }

  @override
  String get walkOpenNow => '营业中';

  @override
  String get walkClosedNow => '已关闭';

  @override
  String get walkDogsAllowed => '允许带狗';

  @override
  String get walkDogsNotAllowed => '禁止带狗';

  @override
  String get walkOpeningHours => '营业时间';

  @override
  String get walkDirections => '路线';

  @override
  String get walkCall => '致电';

  @override
  String get walkWebsite => '网站';

  @override
  String get walkDetailsFailed => '无法加载更多详情。';

  @override
  String get walkOpenFailed => '无法打开。';

  @override
  String get walkHide => '隐藏此地点（管理员）';

  @override
  String get walkHidden => '已对所有人隐藏';

  @override
  String get walkAdminIntro =>
      'Google 会在每位用户周围查找公园、狗狗乐园、绿地和步道。每次搜索都有少量费用，限额可保护预算。';

  @override
  String get walkShowToUsers => '向用户显示';

  @override
  String get walkOnHelp => '开启：用户可在个人资料和首页地图中看到。';

  @override
  String get walkOffHelp => '关闭：只有管理员可通过下方按钮试用。';

  @override
  String get walkDefaultDistance => '默认距离';

  @override
  String get walkPlaceTypes => '地点类型';

  @override
  String get walkLimits => '每位用户每日限额';

  @override
  String get walkDailySearches => '搜索次数';

  @override
  String get walkDailySearchesHelp => '每次搜索查找一个区域内的地点。';

  @override
  String get walkDailyDetails => '地点详情';

  @override
  String get walkDailyDetailsHelp => '打开地点时会加载照片、评分和营业时间。';

  @override
  String get walkLimitInvalid => '限额必须在 1 到 1000 之间。';

  @override
  String get walkHiddenPlaces => '已隐藏地点';

  @override
  String get walkHiddenEmpty => '暂无。以管理员身份打开地点，点按“隐藏此地点”即可移除不合适的地点。';

  @override
  String get walkShowAgain => '重新显示';

  @override
  String get walkOpenScreen => '打开遛宠地点';

  @override
  String get supportCodami => '支持 CodaMi';

  @override
  String get supportProfileSubtitle => '自愿支持，帮助 CodaMi 持续运行';

  @override
  String get adminSupportSubtitle => '自愿支持：显示位置、频率、金额';

  @override
  String get supportHeaderTitle => 'CodaMi 免费，并将一直免费';

  @override
  String get supportHeaderText => '如果您认可 CodaMi 为动物所做的事，可以自愿小额支持。完全自愿。';

  @override
  String get supportUsesTitle => '您的支持用于';

  @override
  String get supportUseServers => '保持应用运行的服务器';

  @override
  String get supportUseDevelopment => '应用开发';

  @override
  String get supportUseModeration => '内容审核';

  @override
  String get supportUseSupport => '用户支持';

  @override
  String get supportUseTranslations => '翻译';

  @override
  String get supportUseFeatures => '新功能与改进';

  @override
  String get supportUseCampaigns => '动物福利宣传活动';

  @override
  String get supportChooseAmount => '选择金额';

  @override
  String supportWith(Object amount) {
    return '支持 $amount';
  }

  @override
  String get supportFinePrint =>
      '通过 Google Play 或 App Store 付款。您的支持用于运营和改进 CodaMi，不是慈善捐款，也不会在应用中带来任何特权。不支持也可完整使用 CodaMi。';

  @override
  String get supportThanks => '谢谢！';

  @override
  String get supportThanksText => '您的支持让 CodaMi 能继续帮助动物。';

  @override
  String get supportSoon => '应用内支付即将推出，感谢您愿意支持！';

  @override
  String get supportClose => '关闭';

  @override
  String get supportPromptReportTitle => '您的发布已上线';

  @override
  String get supportPromptFoundTitle => '太好了！';

  @override
  String get supportPromptText => 'CodaMi 对所有人免费。如果您愿意，小额自愿支持可帮助它持续运行。完全自愿。';

  @override
  String get supportAdminIntro =>
      '通过 Google Play 和 App Store 的自愿支持。始终自愿，绝不阻止用户使用。';

  @override
  String get supportPaymentsNotReady =>
      '应用商店支付尚未接入：用户可看到页面和金额，按钮提示即将推出。需要在 Google Play Console 中设置付款资料，并在两个商店创建商品。';

  @override
  String get supportShowToUsers => '向用户显示';

  @override
  String get supportOnHelp => '开启：在下方开启的位置显示。';

  @override
  String get supportOffHelp => '关闭：用户在任何地方都看不到，您仍可预览页面。';

  @override
  String get supportWhere => '显示位置';

  @override
  String get supportWhereProfile => '个人资料 → 支持 CodaMi';

  @override
  String get supportWhereReport => '发布信息之后';

  @override
  String get supportWhereFound => '宠物找到或信息已解决时';

  @override
  String get supportSettings => '设置';

  @override
  String get supportDaysBetween => '两次提示间隔天数';

  @override
  String get supportDaysBetweenHelp => '发布信息或宠物找到后的提示，在此天数内最多显示一次。';

  @override
  String get supportAmounts => '金额（€）';

  @override
  String get supportAmountsHelp => '最多 6 个，用逗号分隔，每个金额对应商店中的一个商品。';

  @override
  String get supportAmountsInvalid => '最多输入 6 个金额，例如 1, 3, 5, 10, 25';

  @override
  String get supportPreview => '预览页面';

  @override
  String get adminInvites => '邀请';

  @override
  String get adminInvitesSubtitle => '按用户统计邀请、二维码扫描和排名';

  @override
  String get inviteBucketActive => '活跃';

  @override
  String get inviteBucketInactive => '不活跃';

  @override
  String get inviteBucketWaiting => '等待中';

  @override
  String get inviteStillUsing => '仍在使用应用';

  @override
  String get inviteQrScans => '二维码扫描';

  @override
  String get inviteLinkOpens => '链接打开';

  @override
  String get inviteSignedUp => '已注册';

  @override
  String get inviteBucketsHelp =>
      '活跃：好友已开始使用 CodaMi，邀请人已获得积分。不活跃：未在规定时间内活跃，或已被拒绝。等待中：仍有时间变为活跃。';

  @override
  String inviteStillUsingHelp(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '仍在使用：最近 $days 天内打开过应用的活跃好友。',
    );
    return '$_temp0';
  }

  @override
  String get invitedFriendsTitle => '已邀请的好友';

  @override
  String get seeInvitedFriends => '查看已邀请的好友';

  @override
  String inviteJoinedOn(String date) {
    return '注册于 $date';
  }

  @override
  String inviteLastInApp(String date) {
    return '最近一次使用应用：$date';
  }

  @override
  String get periodThisMonth => '本月';

  @override
  String get periodLastMonth => '上月';

  @override
  String get periodAllTime => '全部时间';

  @override
  String get periodChooseDates => '选择日期';

  @override
  String get sortMostActive => '最活跃';

  @override
  String get sortMostInvited => '邀请最多';

  @override
  String get inviteWholeApp => '整个应用';

  @override
  String get inviteRanking => '排名';

  @override
  String inviteRankingUsers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 位用户',
    );
    return '$_temp0';
  }

  @override
  String get noInvitesInPeriod => '此期间没有邀请';

  @override
  String get noInvitesInPeriodMessage => '使用邀请码注册的好友以及二维码或链接的打开次数会显示在这里。';

  @override
  String get adminNoInvites => '该用户还没有邀请任何人。';

  @override
  String get invitesLoadError => '无法加载邀请。请检查网络连接后重试。';

  @override
  String get settingsStillUsingDays => '计为“仍在使用应用”的天数';

  @override
  String get breedScanner => '品种识别';

  @override
  String get scannerSubtitle => '用 AI 识别您宠物的品种';

  @override
  String get adminScannerSubtitle => 'AI 品种识别：开关、每日次数、AI 模型';

  @override
  String get scannerIntroTitle => '这是什么品种？';

  @override
  String get scannerIntroText => '拍摄或选择一张狗、猫或其他宠物的照片。AI 会给出最可能的品种并介绍它们。';

  @override
  String get scannerTipWhole => '拍到整只动物，侧面或正面';

  @override
  String get scannerTipLight => '光线充足，不要模糊';

  @override
  String get scannerTipOne => '照片中只有一只动物';

  @override
  String get scannerScanning => '正在查看照片…';

  @override
  String get scannerEstimate => '这是 AI 的估计，并非保证。只有兽医或 DNA 检测才能确认品种。';

  @override
  String get scannerPrivacy => '照片仅用于识别，不会被保存。';

  @override
  String get scannerMostLikely => '最可能';

  @override
  String get scannerMixed => '混血';

  @override
  String scannerPercent(int value) {
    return '$value%';
  }

  @override
  String get scannerConfidenceHigh => '非常可能';

  @override
  String get scannerConfidenceMedium => '可能';

  @override
  String get scannerConfidenceLow => '不确定';

  @override
  String get scannerOtherBreeds => '其他可能的品种';

  @override
  String get scannerMixOthers => '混血中的其他品种';

  @override
  String get scannerPoorPhoto => '照片不太清晰，结果可能不够准确。换一张照片可获得更好的结果。';

  @override
  String get scannerAboutBreed => '关于这个品种';

  @override
  String get scannerAboutMix => '关于这种混血';

  @override
  String get breedFactSize => '体型';

  @override
  String get breedFactWeight => '体重';

  @override
  String get breedFactLifeSpan => '寿命';

  @override
  String get breedFactTemperament => '性格';

  @override
  String get breedFactCharacteristics => '特征';

  @override
  String get breedFactCare => '护理';

  @override
  String get scannerNoAnimalTitle => '未找到动物';

  @override
  String get scannerNoAnimalText => '我们无法清楚地看到动物。请在光线充足时拍摄整只动物。';

  @override
  String get scannerTryAnother => '换一张照片';

  @override
  String get scannerSaveToPet => '将品种保存到我的宠物';

  @override
  String get scannerUseBreed => '使用这个品种';

  @override
  String get scannerChoosePet => '哪只宠物？';

  @override
  String scannerBreedSaved(String name) {
    return '已为$name保存品种';
  }

  @override
  String get scannerNoPets => '请先添加宠物，然后即可保存其品种。';

  @override
  String get scannerLimit => '今天的识别次数已用完。请明天再试。';

  @override
  String get scannerOff => '品种识别暂不可用。';

  @override
  String get scannerBadPhoto => '无法使用这张照片。请选择另一张。';

  @override
  String get scannerUnavailable => '识别功能暂时不可用。请稍后再试。';

  @override
  String get scannerIdentifyWithAi => '用 AI 识别品种';

  @override
  String get scannerAdminIntro =>
      '用户拍摄或选择照片，AI 给出品种、其他可能的品种和相关信息。每次识别费用不到 1 美分。照片不会被保存。';

  @override
  String get scannerOnHelp => '开启：用户可在个人资料和添加宠物时看到识别功能。';

  @override
  String get scannerOffHelp => '关闭：仅管理员可以试用。';

  @override
  String get scannerSettings => '识别设置';

  @override
  String get scannerDailyScans => '每位用户每日识别次数';

  @override
  String get scannerDailyScansHelp => '1 到 100。失败的识别不计入。';

  @override
  String get scannerModel => 'AI 模型';

  @override
  String get scannerModelHelp =>
      '用于识别的 Google Gemini 模型。点按即可从 Google 目前提供的模型中选择。';

  @override
  String get scannerModelInvalid => '请输入 Gemini 模型名称，例如 gemini-3.8-flash。';

  @override
  String get scannerLimitInvalid => '请输入 1 到 100 之间的数字。';

  @override
  String get scannerOpen => '试用识别';

  @override
  String get scannerModelChoose => '选择 AI 模型';

  @override
  String get scannerModelTierLite => '最便宜、最快，准确度稍低';

  @override
  String get scannerModelTierFlash => '快速准确，成本低';

  @override
  String get scannerModelTierPro => '最准确，但更慢、费用更高';

  @override
  String get scannerModelRecommended => '推荐';

  @override
  String get scannerModelFromGoogle => 'Google 目前提供的 Gemini 模型。';

  @override
  String get scannerModelOffline => '无法加载 Google 的列表，因此显示常用模型。';

  @override
  String get scannerModelGone => 'Google 已不再提供此模型。请选择其他模型，以便识别继续正常工作。';

  @override
  String get scannerModelRetry => '重试';

  @override
  String get heatCalendar => '发情期日历';

  @override
  String heatCalendarOf(String name) {
    return '$name的发情期日历';
  }

  @override
  String get adminHeatSubtitle => '发情期：开关和各物种的典型值';

  @override
  String get heatRecord => '记录发情期';

  @override
  String get heatEdit => '编辑发情期';

  @override
  String heatInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days 天后',
      one: '明天',
      zero: '今天',
    );
    return '$_temp0';
  }

  @override
  String get heatUpcoming => '接下来预计的发情期';

  @override
  String get heatHistory => '历史记录';

  @override
  String get heatHistoryEmpty => '还没有记录发情期。点按“记录发情期”添加第一条。';

  @override
  String get heatOngoing => '进行中';

  @override
  String heatLengthDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days 天',
    );
    return '$_temp0';
  }

  @override
  String get heatEstimateNote => '未来的日期只是估计，每只动物都不一样。有关繁育、绝育和健康问题，请咨询兽医。';

  @override
  String get heatInHeatNow => '正在发情期';

  @override
  String heatDayNumber(int day) {
    return '第 $day 天';
  }

  @override
  String get heatEndToday => '发情期今天结束';

  @override
  String get heatNextExpected => '下次发情期预计在';

  @override
  String get heatNoEstimate => '记录第一次发情期，即可查看下一次的预计时间。';

  @override
  String get heatNoEstimateMore => '再记录一次发情期，即可查看下一次的预计时间。';

  @override
  String heatCycleSummary(int cycle, int heat) {
    return '周期约 $cycle 天 · 发情期约持续 $heat 天';
  }

  @override
  String heatBasedOn(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '根据 $count 次记录的发情期。',
    );
    return '$_temp0';
  }

  @override
  String get heatBasedOnTypical => '在有更多记录之前，使用该物种的典型值。';

  @override
  String get heatReminders => '提醒';

  @override
  String get heatRemindMe => '在下次发情期前提醒我';

  @override
  String get heatRemindNeedsEstimate => '有预计日期后即可使用。';

  @override
  String heatRemindDaysBefore(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '提前 $days 天',
    );
    return '$_temp0';
  }

  @override
  String heatNextReminder(String date) {
    return '下次提醒：$date';
  }

  @override
  String get heatDeleteConfirm => '删除这次发情期？';

  @override
  String get heatDeleteMessage => '它将从历史记录和估计中移除。';

  @override
  String get heatDelete => '删除';

  @override
  String get heatEndBeforeStart => '结束日期不能早于开始日期。';

  @override
  String get heatStart => '开始';

  @override
  String get heatEnd => '结束';

  @override
  String get heatStillInHeat => '仍在发情期';

  @override
  String get heatNotes => '备注';

  @override
  String get heatNotesHint => '行为、出血、看兽医…';

  @override
  String heatCardInHeat(int day) {
    return '正在发情期 · 第 $day 天';
  }

  @override
  String heatCardNext(String date) {
    return '下次发情期预计在 $date 左右';
  }

  @override
  String get heatCardRecordFirst => '记录发情期，并在下次之前收到提醒';

  @override
  String get heatLegendRecorded => '已记录';

  @override
  String get heatLegendEstimated => '预计';

  @override
  String get heatLegendToday => '今天';

  @override
  String get heatAdminIntro =>
      '主人记录母宠物的发情期。应用会估计下一次的时间，并可提前发送提醒。在宠物有自己的记录之前，使用典型值。';

  @override
  String get heatOnHelp => '开启：主人可在母宠物的页面看到发情期日历。';

  @override
  String get heatOffHelp => '关闭：仅管理员可见。';

  @override
  String get heatTypicalCycle => '典型周期（天）';

  @override
  String get heatTypicalHeat => '典型发情期长度（天）';

  @override
  String get heatTypicalHelp => '在宠物有两次记录之前使用。对于其他动物，周期为 0 表示在此之前不做估计。';

  @override
  String get heatInvalidValues => '周期：7 到 400 天（其他动物可为 0）。长度：1 到 60 天。';

  @override
  String get adminSittingSubtitle => '宠物照看：开关、举报、请求、照看者、评价';

  @override
  String get sitAbout => '关于我';

  @override
  String get sitAboutHint => '您是谁，为什么喜欢动物';

  @override
  String get sitAboutTooShort => '请至少写几句关于自己的话。';

  @override
  String get sitAccept => '接受';

  @override
  String get sitAcceptText => '该请求将预订给这位照看者，其他报价将被拒绝。';

  @override
  String sitAcceptTitle(String name) {
    return '选择 $name？';
  }

  @override
  String get sitAccepted => '已预订！在聊天中打个招呼吧。';

  @override
  String get sitAddPetFirst => '请先在“宠物”标签中添加您的宠物。';

  @override
  String get sitAdminIntro =>
      '主人发布请求，照看者发送报价，双方在应用中聊天。只有双方确认服务后才能评价。付款由用户之间自行约定。';

  @override
  String get sitAdminReported => '已举报';

  @override
  String get sitAdminReviews => '评价';

  @override
  String get sitAdminSettings => '设置';

  @override
  String get sitAlreadyReviewed => '您已评价过此服务。';

  @override
  String get sitAnimals => '我照看的动物';

  @override
  String get sitArea => '我愿意前往的距离';

  @override
  String get sitAvailability => '可用时间';

  @override
  String get sitAvailabilityHint => '例如：周末、晚上、八月';

  @override
  String get sitBecomeSitter => '成为宠物照看者';

  @override
  String get sitBecomeSitterText => '创建您的资料，为附近的宠物提供照看。';

  @override
  String get sitBecomeSitterToOffer => '创建照看者资料后即可发送报价';

  @override
  String sitBookedWith(String name) {
    return '已预订：$name';
  }

  @override
  String get sitBudget => '预算（可选）';

  @override
  String get sitBudgetHint => '例如：每天 20 欧元';

  @override
  String get sitCancelBooking => '取消预订';

  @override
  String get sitCantMessage => '您无法向此用户发送消息。';

  @override
  String get sitChat => '聊天';

  @override
  String get sitChatSafety => '请保护好付款和个人信息。如有可疑情况请举报。';

  @override
  String sitChatWith(String name) {
    return '与 $name 聊天';
  }

  @override
  String get sitChats => '聊天';

  @override
  String get sitChoosePets => '请至少选择一只宠物。';

  @override
  String get sitChooseSpeciesServices => '请至少选择一种动物和一项服务。';

  @override
  String sitCityArea(String city, int km) {
    return '$city · 最远 $km 公里';
  }

  @override
  String sitCityDistance(String city, int km) {
    return '$city · 距离 $km 公里';
  }

  @override
  String get sitCloseRequest => '关闭请求';

  @override
  String get sitCloseText => '之后将无人能再发送报价。';

  @override
  String get sitCloseTitle => '关闭此请求？';

  @override
  String sitCompletedCount(int count) {
    return '已完成：$count';
  }

  @override
  String get sitConfirmButton => '是的，已完成';

  @override
  String get sitConfirmText => '宠物照看完成后请确认。双方都确认后，即可留下已验证的评价。';

  @override
  String get sitConfirmTitle => '宠物照看完成了吗？';

  @override
  String get sitConfirmed => '谢谢，已确认。';

  @override
  String get sitDaysInvalid => '请输入 0 到 60 之间的数字。';

  @override
  String get sitDecline => '拒绝';

  @override
  String get sitDismiss => '忽略';

  @override
  String get sitEdit => '编辑';

  @override
  String get sitExperience => '经验';

  @override
  String get sitExperienceHint => '养过或照看过的宠物、培训、课程';

  @override
  String get sitFrom => '从';

  @override
  String get sitHiddenDone => '已隐藏。';

  @override
  String get sitHiddenLabel => '已隐藏';

  @override
  String get sitHide => '隐藏';

  @override
  String get sitHideTheirProfile => '隐藏其照看者资料';

  @override
  String get sitKindChat => '聊天';

  @override
  String get sitKindRequest => '请求';

  @override
  String get sitKindReview => '评价';

  @override
  String get sitKindSitter => '照看者资料';

  @override
  String sitLeaveReview(String name) {
    return '评价 $name';
  }

  @override
  String get sitMessageHint => '输入消息';

  @override
  String get sitMinAccountDays => '新账户可评价前需等待的天数';

  @override
  String get sitMinAccountDaysHelp => '0 到 60。有助于防止虚假账户。';

  @override
  String get sitMyOffers => '我的报价';

  @override
  String get sitMyRequests => '我的请求';

  @override
  String get sitMySitterProfile => '我的照看者资料';

  @override
  String get sitNeedCity => '请先在个人资料中设置城市：请求和资料只显示城市，不显示您的地址。';

  @override
  String get sitNewRequest => '新请求';

  @override
  String get sitNoChats => '还没有聊天。';

  @override
  String get sitNoMyRequests => '您还没有寻找过宠物照看者。';

  @override
  String get sitNoOffersYet => '还没有报价。附近的照看者会看到您的请求。';

  @override
  String get sitNoRequestsNearby => '附近暂时没有请求。';

  @override
  String get sitNoReviewsYet => '还没有评价';

  @override
  String get sitNoSittersNearby => '附近还没有照看者。';

  @override
  String get sitNotAvailableNow => '现在无法进行此操作。';

  @override
  String get sitNotFound => '未找到或已不可用。';

  @override
  String get sitNotes => '详情';

  @override
  String get sitNotesHint => '作息、饮食、药物，以及照看者需要知道的一切';

  @override
  String get sitNothingReported => '没有举报。';

  @override
  String get sitOffHelp => '关闭：仅管理员可见。';

  @override
  String get sitOfferAccepted => '已接受';

  @override
  String get sitOfferDeclined => '已拒绝';

  @override
  String get sitOfferMessage => '您的留言';

  @override
  String get sitOfferMessageHint => '介绍一下自己，并说明您会如何照看宠物';

  @override
  String get sitOfferPending => '等待中';

  @override
  String get sitOfferPrice => '您的价格（可选）';

  @override
  String get sitOfferSent => '报价已发送。';

  @override
  String get sitOfferWithdrawn => '已撤回';

  @override
  String sitOffersTitle(int count) {
    return '报价（$count）';
  }

  @override
  String get sitOnHelp => '开启：用户可在“宠物”标签和个人资料中看到宠物照看。';

  @override
  String get sitOpen => '打开';

  @override
  String sitPrice(String price) {
    return '价格：$price';
  }

  @override
  String get sitProfilePaused => '已暂停：他人不可见';

  @override
  String get sitProfileVisible => '宠物主人可见';

  @override
  String get sitPromo => '寻找照看者，或照看附近的宠物';

  @override
  String get sitPublish => '发布';

  @override
  String sitRatingSummary(String rating, int count) {
    return '$rating（$count）';
  }

  @override
  String get sitReport => '举报';

  @override
  String get sitRequest => '宠物照看请求';

  @override
  String get sitRequestPublished => '请求已发布。';

  @override
  String get sitReviewHint => '仅限双方都确认过的服务。请公正、具体。';

  @override
  String get sitReviewText => '您的评价（可选）';

  @override
  String sitReviewsTitle(int count) {
    return '已验证的评价（$count）';
  }

  @override
  String get sitSafetyText =>
      'CodaMi 只负责连接用户，不参与服务本身。请先见面，查看资料和评价，直接约定付款，切勿提前付款给陌生人。';

  @override
  String get sitSafetyTitle => '注意安全';

  @override
  String sitSayHello(String name) {
    return '向 $name 打个招呼';
  }

  @override
  String get sitSend => '发送';

  @override
  String get sitSendOffer => '发送报价';

  @override
  String get sitServiceBoarding => '寄养在照看者家';

  @override
  String get sitServiceDaycare => '日间托管';

  @override
  String get sitServiceOvernight => '在家过夜照看';

  @override
  String get sitServiceVisits => '上门探访';

  @override
  String get sitServiceWalks => '遛宠物';

  @override
  String get sitServices => '服务';

  @override
  String get sitShow => '显示';

  @override
  String get sitShowMyProfile => '显示我的资料';

  @override
  String sitShownArea(String city) {
    return '显示为：$city';
  }

  @override
  String get sitShownDone => '已重新显示。';

  @override
  String get sitSitterProfile => '宠物照看者';

  @override
  String get sitStatusBooked => '已预订';

  @override
  String get sitStatusClosed => '已关闭';

  @override
  String get sitStatusDone => '已完成';

  @override
  String get sitStatusOpen => '开放中';

  @override
  String get sitTabMine => '我的';

  @override
  String get sitTabRequests => '请求';

  @override
  String get sitTabSitters => '照看者';

  @override
  String get sitThanksReview => '感谢您的评价！';

  @override
  String get sitTitle => '宠物照看';

  @override
  String get sitTo => '到';

  @override
  String get sitVerifiedService => '已验证的服务';

  @override
  String get sitViewProfile => '查看资料';

  @override
  String get sitWaitingOtherConfirm => '正在等待对方确认。';

  @override
  String get sitWhatService => '您需要什么？';

  @override
  String get sitWhen => '时间';

  @override
  String get sitWhichPets => '哪些宠物？';

  @override
  String get sitWithdraw => '撤回';

  @override
  String get sitYes => '是';

  @override
  String get sitYouAreBooked => '您是此请求的宠物照看者。';

  @override
  String sitYouBlocked(String name) {
    return '您已屏蔽 $name。';
  }

  @override
  String get sitYourOffer => '您的报价';

  @override
  String get sitHeroText => '附近值得信赖的人，评价都来自真实完成的服务。';

  @override
  String sitDaysTotal(int count) {
    return '天数：$count';
  }

  @override
  String get sitStepPublished => '已发布';

  @override
  String get sitStepConfirmed => '已确认';

  @override
  String get sitStepReviewed => '已评价';

  @override
  String get sitStatRating => '评分';

  @override
  String get sitStatOpenRequests => '开放中的请求';

  @override
  String get sitAdminOverview => '概览';

  @override
  String get schTitle => '我的日程';

  @override
  String schTitleOf(String name) {
    return '$name 的日程';
  }

  @override
  String get schSubtitle => '看兽医、用药、美容和提醒';

  @override
  String get schPromo => '安排看兽医、用药等事项，并设置提醒';

  @override
  String schNext(String what, String when) {
    return '下一项：$what · $when';
  }

  @override
  String get schAddEvent => '新建事项';

  @override
  String get schEditEvent => '编辑事项';

  @override
  String get schEdit => '编辑';

  @override
  String get schTabCalendar => '日历';

  @override
  String get schTabUpcoming => '即将到来';

  @override
  String get schTabDone => '已完成';

  @override
  String get schToday => '今天';

  @override
  String get schTomorrow => '明天';

  @override
  String get schAllDay => '全天';

  @override
  String get schEmptyTitle => '还没有安排';

  @override
  String get schEmptyUpcoming => '点击“新建事项”，添加看兽医、用药、喂食时间或任何提醒。';

  @override
  String get schEmptyDay => '这一天没有安排。';

  @override
  String get schEmptyDone => '标记为已完成的事项会显示在这里。';

  @override
  String get schMissed => '尚未完成';

  @override
  String get schAllPets => '全部';

  @override
  String get schAllTypes => '所有类型';

  @override
  String get schType => '类型';

  @override
  String get schTypeVet => '看兽医';

  @override
  String get schTypeVaccine => '疫苗接种';

  @override
  String get schTypeMedicine => '用药';

  @override
  String get schTypeGrooming => '美容';

  @override
  String get schTypeFeeding => '喂食';

  @override
  String get schTypeWalk => '散步或活动';

  @override
  String get schTypeNote => '备注';

  @override
  String get schTypeOther => '其他';

  @override
  String get schEventTitle => '标题';

  @override
  String schTitleHint(String type) {
    return '可选。留空则为：$type';
  }

  @override
  String get schVaccineName => '疫苗';

  @override
  String get schVaccineHint => '例如：狂犬病、加强针';

  @override
  String get schMedicineName => '药物和剂量';

  @override
  String get schMedicineHint => '例如：抗生素，1 片';

  @override
  String get schForPets => '给哪些宠物？';

  @override
  String get schForPetsHelp => '不选则为一般提醒。';

  @override
  String get schDate => '日期';

  @override
  String get schRepeat => '重复';

  @override
  String get schRepeatNone => '不重复';

  @override
  String get schRepeatDaily => '每天';

  @override
  String get schRepeatWeekly => '每周';

  @override
  String get schRepeatMonthly => '每月';

  @override
  String get schRepeatYearly => '每年';

  @override
  String get schEvery => '每';

  @override
  String schUnitDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '天',
    );
    return '$_temp0';
  }

  @override
  String schUnitWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '周',
    );
    return '$_temp0';
  }

  @override
  String schUnitMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '个月',
    );
    return '$_temp0';
  }

  @override
  String schUnitYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '年',
    );
    return '$_temp0';
  }

  @override
  String get schOnDays => '在这些日子';

  @override
  String get schEnds => '结束';

  @override
  String get schEndsNever => '从不';

  @override
  String get schEndsOn => '在某个日期';

  @override
  String get schEndsAfter => '重复一定次数后';

  @override
  String get schTimes => '次数';

  @override
  String get schInvalidEvery => '请输入 1 到 99 之间的数字。';

  @override
  String get schInvalidCount => '请输入 1 到 999 之间的数字。';

  @override
  String get schUntilBeforeStart => '结束日期不能早于开始日期。';

  @override
  String get schRemind => '提醒';

  @override
  String get schRemindHelp => '最多 2 个提醒，即使应用关闭也会以通知发送。';

  @override
  String get schRemindMax => '最多可以选择 2 个提醒。';

  @override
  String get schRemindAtTime => '准时';

  @override
  String get schRemindAllDay => '当天 9:00';

  @override
  String get schRemind15 => '提前 15 分钟';

  @override
  String get schRemind60 => '提前 1 小时';

  @override
  String get schRemindDay => '提前 1 天';

  @override
  String get schRemindWeek => '提前 1 周';

  @override
  String get schNoReminders => '无提醒';

  @override
  String get schPlace => '地点';

  @override
  String get schPlaceHint => '诊所、美容店、公园…';

  @override
  String get schNotes => '备注';

  @override
  String get schMarkDone => '标记为已完成';

  @override
  String get schUndoDone => '标记为未完成';

  @override
  String get schDoneLabel => '已完成';

  @override
  String get schSkip => '跳过这一次';

  @override
  String get schSkipped => '已跳过这一次';

  @override
  String get schDeleteConfirm => '删除这个事项？';

  @override
  String get schDeleteMessage => '它会和提醒一起被删除。';

  @override
  String get schDeleted => '已删除';

  @override
  String get schRepeatScopeText => '这个事项会重复。仅这一次，还是所有次？';

  @override
  String get schOnlyThis => '仅这一次';

  @override
  String get schAllTimes => '所有次';

  @override
  String schEveryDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '每 $count 天',
      one: '每天',
    );
    return '$_temp0';
  }

  @override
  String schEveryWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '每 $count 周',
      one: '每周',
    );
    return '$_temp0';
  }

  @override
  String schEveryMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '每 $count 个月',
      one: '每月',
    );
    return '$_temp0';
  }

  @override
  String schEveryYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '每 $count 年',
      one: '每年',
    );
    return '$_temp0';
  }

  @override
  String schUntil(String date) {
    return '直到 $date';
  }

  @override
  String schTimesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 次',
      one: '1 次',
    );
    return '$_temp0';
  }

  @override
  String schHeatExpected(String name) {
    return '$name：预计发情';
  }

  @override
  String get schEstimate => '估计';

  @override
  String get schSeeAll => '查看全部';

  @override
  String schPetEmpty(String name) {
    return '$name 没有即将到来的事项。';
  }

  @override
  String schPetEventsTitle(String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$name 有 $count 个日程事项',
    );
    return '$_temp0';
  }

  @override
  String get schPetEventsMessage => '也一起删除吗？与其他宠物共享的事项会保留，只是去掉这只宠物。';

  @override
  String get schKeepEvents => '保留';

  @override
  String get schDeleteEvents => '删除';

  @override
  String get schWhenNow => '现在';

  @override
  String schWhenInMinutes(int count) {
    return '$count 分钟后';
  }

  @override
  String get schWhenInHour => '1 小时后';

  @override
  String schWhenOn(String date) {
    return '$date';
  }

  @override
  String get adminScheduleSubtitle => '个人日程和提醒：开启或关闭';

  @override
  String get schAdminIntro =>
      '每位用户都有私人日程，可安排看兽医、疫苗、用药、美容、喂食和其他活动，并收到推送提醒。只有用户本人能看到，管理员也看不到。';

  @override
  String get schOnHelp => '开启：用户可以在宠物标签、宠物页面和个人资料中看到“我的日程”。';

  @override
  String get schOffHelp => '关闭：只有管理员能看到。';
}
