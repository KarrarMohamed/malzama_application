import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/api/api_client/clients/quiz_client.dart';
import '../../../../core/general_widgets/helper_functions.dart';
import '../../../../core/platform/local_database/access_objects/general_variables.dart';
import '../../../../core/platform/local_database/access_objects/quiz_access_object.dart';
import '../../../../core/platform/services/file_system_services.dart';
import '../../models/users/user.dart';

class UserInfoStateProvider with ChangeNotifier {
  // to indicate whether the quiz hint message has been shown during the session
  bool _hasShownTheWelcomeMessage = false;

  bool get hasShownTheWelcomeMessage => _hasShownTheWelcomeMessage;

  set hasShownQuizWelcomeMessage(bool update) {
    _hasShownTheWelcomeMessage = update;
  }

  // =========================
  // this whether the device is emulator or not
  bool _isEmulator = true;

  bool get isEmulator => _isEmulator;

  // ====================================
  // this is for quiz collections count availabe for current user in the cloud
  int _quizCollectionsCount;

  int get quizCollectionsCount => _quizCollectionsCount;

  void setQuizCollectionsCountTo(int update) {
    _quizCollectionsCount = update ?? 0;
    notifyMyListeners();
  }

  // the count of uploaded quizes
  int _uploadedQuizsCount;

  int get uploadedQuizsCount => _uploadedQuizsCount;

  void setUploadedQuizsCountTo(int update) {
    _uploadedQuizsCount = update ?? 0;
    notifyMyListeners();
  }

  // =============================================================================================
  // the count of uploaded pdfs
  int _uploadedPDFsCount;

  int get uploadedPDFsCount => _uploadedPDFsCount;

  void setUploadedPDFsCountTo(int update) {
    _uploadedPDFsCount = update ?? 0;
    notifyMyListeners();
  }

  // =============================================================================================

  // the count of uploaded videos
  int _uploadedVideosCount;

  int get uploadedVideosCount => _uploadedVideosCount;

  void setUploadedVideosCountTo(int update) {
    _uploadedVideosCount = update ?? 0;
    notifyMyListeners();
  }

  // =============================================================================================

  /// update user Info and save them
  Future<void> updateUserInfo() async {
    await FileSystemServices.saveUserData(userData.toJSON());
  }

  // =============================================================================================

// count of quizes drafts
  int _quizDraftsCount = 0;

  int get quizDraftsCount => _quizDraftsCount;

  void updateQuizDraftsCount() async {
    var results = await QuizAccessObject().fetchAllDrafts();
    _quizDraftsCount = results.length;
    notifyMyListeners();
  }

  // =============================================================================================

  Future<void> fetchQuizesCount() async {
    var response = await QuizClient().fetchQuizesCount();
    if (response.statusCode == 200) {
      _quizCollectionsCount = json.decode(response.message)['data'];
    } else {
      _quizCollectionsCount = 0;
    }
    notifyMyListeners();
  }

  // =============================================================================================

  // fetch uploaded materials count from local database
  Future<void> fetchUploadedMaterialsCount() async {
    _uploadedPDFsCount = await QuizAccessObject().getUploadedMaterialCount(MyUploaded.LECTURES) ?? 0;
    _uploadedQuizsCount = await QuizAccessObject().getUploadedMaterialCount(MyUploaded.QUIZES) ?? 0;
    _uploadedVideosCount = await QuizAccessObject().getUploadedMaterialCount(MyUploaded.VIDEOS) ?? 0;

    notifyMyListeners();
  }

  // =============================================================================================

  bool showQuizWelcomeMessage = true;

  Future<void> fetchDeviceInfo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
      _isEmulator = !androidDeviceInfo.isPhysicalDevice;
      return;
    }
    IosDeviceInfo iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
    _isEmulator = !iosDeviceInfo.isPhysicalDevice;
  }

  /// [Constructor]
  UserInfoStateProvider() {
    reRunConstructor();
  }

  // =============================================================================================

  Future<void> reRunConstructor()async{
    await fetchDeviceInfo();
    await refreshData();
    startFetching();
    GeneralVariablesService.getQuizWelcomeMessagePermission.then((value) {
      showQuizWelcomeMessage = value ?? true;
    });
  }
  void startFetching() {
    fetchQuizesCount();
    fetchUploadedMaterialsCount();
    loadCachedFiles();
  }

  Future<void> refreshData() async {
    var data  = await FileSystemServices.getUserData();
    print('=' * 100);
    print('after getting data inside refresh data inside userinfoStateProvider');
    print(data);
    userData = data;
    print('=' * 100);
    notifyMyListeners();
    print('end of constructor inside userinfoStateProvider');
  }

  void updateUserData(User user) {
    userData = user;
    notifyMyListeners();
  }

  // =============================================================================================

  PersistentBottomSheetController bottomSheetController;

  // Visibility of the bottom navigation bar of the root navigator
  bool _isBottomNavBarVisible = true;

  bool get isBottomNavBarVisible => _isBottomNavBarVisible;

  void setBottomNavBarVisibilityTo(bool update) {
    if (_isBottomNavBarVisible != update) {
      _isBottomNavBarVisible = update;
      notifyMyListeners();
    }
  }

  // =============================================================================================

  // visibility of the comment floating text field to add a comment
  bool _isCommentTextFieldVisible = false;

  bool get isCommentTextFieldVisible => _isCommentTextFieldVisible;

  void setCommentTextFieldVisibilityTo(bool update) {
    if (_isCommentTextFieldVisible != update) {
      _isCommentTextFieldVisible = update;
      notifyMyListeners();
    }
  }

  // =============================================================================================

  List<String> cachedFiles = [];

  Future<void> loadCachedFiles() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final String subDirPath = directory.path + '/cached_files';
    final bool hasCachedDir = await Directory(subDirPath).exists();
    if (hasCachedDir) {
      List<FileSystemEntity> files = Directory(subDirPath).listSync();
      if (files.isNotEmpty) {
        List<FileSystemEntity> existedFiles = files.where((element) => element.existsSync()).toList();
        if (existedFiles.isNotEmpty) {
          cachedFiles = existedFiles.map((e) => e.path).toList();
        }
      }
    }
  }

  User userData;

  bool get isTeacher => HelperFucntions.isTeacher(this.userData.accountType);

  // void _loadUserData() async {
  //   var data = await FileSystemServices.getUserData();
  //   if (data != null && data != false) {}
  // }

  bool _isDisposed = false;

  void notifyMyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
