import 'package:malzama_app/src/core/api/api_routes/host_addresses.dart';


class QuizRoutes{

  /// fetch headers of quizes i.e (quizes without questions just credentials) => ['/materials/quizes/fetch-quizes-headers']
  static  String FETCH_QUIZES_HEADERS = HostAddress.host + '/materials/quizes/fetch-quizes-headers';

  /// fetch quizes headers on refresh => ['/fetch-quizes-headers-on-refresh']
  static  String FETCH_QUIZES_HEADERS_ON_REFRESH = HostAddress.host + '/materials/quizes/fetch-quizes-headers-on-refresh';

  /// fetch saved quizes headers => ["/fetch-saved-quizes-headers"]
  static  String FETCH_SAVED_QUIZES_HEADERS = HostAddress.host + '/materials/quizes/fetch-saved-quizes-headers';

  /// fetch quiz questions in pagination style => ['/materials/quizes/fetch-quiz-questions']
  static  String FETCH_QUIZES_QUESTIONS = HostAddress.host + '/materials/quizes/fetch-quiz-questions';


  /// fetch quiz questions in pagination style => ['/materials/quizes/fetch-all-questions']
  static  String FETCH_ALL_QUESTIONS = HostAddress.host + '/materials/quizes/fetch-all-questions';

  ///  fetch total quizes count => ['/materials/quizes/fetch-quizes-count']
  static  String FETCH_QUIZES_COUNT = HostAddress.host + '/materials/quizes/fetch-quizes-count';

  /// edit single quiz item or question => ['/materials/quizes/edit-quiz-item']
  static  String EDIT_QUIZ_ITEM = HostAddress.host + '/materials/quizes/edit-quiz-item';

  /// delete single quiz item or question => ['/materials/quizes/delete-quiz-item']
  static  String DELETE_QUIZ_ITEM = HostAddress.host + '/materials/quizes/delete-quiz-item';

  /// fetch single quiz collection => ['/materials/quizes/fetchById']
  static  String FETCH_QUIZ_BY_ID = HostAddress.host + '/materials/quizes/fetchById';

  /// edit entire quiz  => ['/edit-entire-quiz']
  static  String EDIT_ENTIRE_QUIZ = HostAddress.host +  '/materials/quizes/edit-entire-quiz';

// ========================================================================================================================
}