import 'package:malzama_app/src/core/api/api_routes/host_addresses.dart';


class ProfileRoutes {


  static  String EDIT_BIO = HostAddress.host + '/users/edit-bio';
  static  String UPDATE_PERSONAL_INFO = HostAddress.host + '/users/update-personal-info';
  static  String VERIFY_AND_UPDATE_INFO = HostAddress.host + '/users/verify-and-update-info';
  static  String DELETE_PICTURE = HostAddress.host + '/users/delete-picture';
  static  String UPLOAD_PICTURE = HostAddress.host + '/users/upload-picture';
  static  String DELETE_BIO = HostAddress.host + '/users/delete-bio';
}
