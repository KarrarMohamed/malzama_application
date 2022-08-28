import 'package:malzama_app/src/core/api/api_routes/host_addresses.dart';

class RegistrationRoutes{


  static  String SIGNUP_URL = HostAddress.host + '/registration/signup';

  /// login url
  ///  => [ _LOCALHOST_URL + '/HostAddress.host/login' ]
  static  String LOGIN_URL = HostAddress.host + '/registration/login';

  /// verify email url
  /// => [ _LOCALHOST_URL + '/registration/check-verification' ]
  static  String VERIFY_EMAIL_URL = HostAddress.host + '/registration/check-verification';

  /// send another verification auth code
  ///  => [ _LOCALHOST_URL + '/registration/send-another-auth-code' ]
  static  String SEND_ANOTHER_AUTH_CODE_URL = HostAddress.host + '/registration/send-another-auth-code';

// =======================================================================================================================
}