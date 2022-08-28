import 'package:malzama_app/src/core/api/api_routes/host_addresses.dart';


class CommonRoutes{



  // Common

  /// upload new material videos pdfs or quizes => [ _LOCALHOST_URL + '/materials/common/new' ]
  static  String UPLOAD_NEW_MATERIAL = HostAddress.host + '/materials/common/new';

  ///  delete entire material pdf or video or even entire quiz collection => ['/materials/common/delete']
  static  String DELETE_MATERIAL = HostAddress.host + '/materials/common/delete';

  /// edit a material video or pdf or entire quiz =>  ['/materials/common/edit']
  static  String EDIT_MATERIAL = HostAddress.host + '/materials/common/edit';

  /// add a material to user saved items => ['/materials/common/save']
  static  String MARK_MATERIAL_AS_SAVED = HostAddress.host + '/materials/common/save';

// ///  fetch materials for videos and lectures only => ['/materials/videos-and-pdfs/fetch-material']
// static  String _FETCH_MATERIALS = _LOCALHOST_URL + '/materials/fetch-material';

// ========================================================================================================================
}