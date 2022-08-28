import 'package:malzama_app/src/core/api/api_routes/host_addresses.dart';


class VideoAndPDFRoutes{


  // fetch by id
  /// fetch single video or lecture by id => [/materials/videos-and-pdfs/fetchById]
  static  String FETCH_VIDEO_OR_PDF_BY_ID = HostAddress.host + '/materials/videos-and-pdfs/fetchById';

  // fetch for Pagination
  /// fetch videos or lectures in pagination style => [/materials/videos-and-pdfs/fetch]
  static  String FETCH_VIDEOS_OR_PDFS = HostAddress.host + '/materials/videos-and-pdfs/fetch';

  /// fetch saved videos or pdfs => ['/fetch-saved-materials']
  static  String FETCH_SAVED_VIDEOS_OR_PDFS = HostAddress.host + '/materials/videos-and-pdfs/fetch-saved-materials';

  /// fetch videos or pdfs on refresh => ['/fetch-materials-on-refresh']
  static  String FETCH_MATERIALS_ON_REFRESH = HostAddress.host + '/materials/videos-and-pdfs/fetch-materials-on-refresh';

// ==========================================================================================================================
}