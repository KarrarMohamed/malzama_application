

import 'package:malzama_app/src/core/api/api_routes/host_addresses.dart';


class CommentsRoutes{

  // Comments UseCases

  /// fetch comments by ids => ['/comments/fetch-comments']
  static  String FETCH_COMMENTS_BY_IDS = HostAddress.host + '/comments/fetch-comments';

  /// upload comment => ['/comments/new-comment']
  static  String UPLOAD_COMMENT = HostAddress.host + '/comments/new-comment';

  /// upload comment => ['/comments/edit-comment']
  static  String EDIT_COMMENT = HostAddress.host + '/comments/edit-comment';

  /// delete comment => ['/comments/delete-comment']
  static  String DELETE_COMMENT = HostAddress.host + '/comments/delete-comment';

  /// rate a comment => ['/comments/rate-comment']
  static  String RATE_COMMENT = HostAddress.host + '/comments/rate-comment';

  // =================================================================================
  /// Replies

  /// upload new reply to a comment => ['/comments/new-reply']
  static  String UPLOAD_NEW_REPLY = HostAddress.host + '/comments/new-reply';

  /// edit a reply to a comment => ['/comments/edit-reply']
  static  String EDIT_REPLY = HostAddress.host + '/comments/edit-reply';

  /// delete a reply to a comment => ['/comments/delete-reply']
  static  String DELETE_REPLY = HostAddress.host + '/comments/delete-reply';

// =================================================================================
}