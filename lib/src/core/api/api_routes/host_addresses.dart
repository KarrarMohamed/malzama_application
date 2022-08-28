
import 'package:malzama_app/src/core/platform/services/dialog_services/service_locator.dart';
import 'package:malzama_app/src/features/home/presentation/state_provider/user_info_provider.dart';

class HostAddress{

  static const _localHost = 'http://10.0.2.2:3000/api/v1';
  static const _cloudHost = 'https://course-api-v1.herokuapp.com/api/v1';
  static const String _localServer = 'http://192.168.0.108:3000/api/v1';

  static final String host = locator<UserInfoStateProvider>().isEmulator ? _localHost : _cloudHost;
}