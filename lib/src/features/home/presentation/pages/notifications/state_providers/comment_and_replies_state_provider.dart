

import 'package:flutter/foundation.dart';
import 'package:malzama_app/src/features/home/presentation/pages/shared/comments_and_replies/comment_related_models/comment_model.dart';

class CommentsNotificationStateProvider with ChangeNotifier{
  Comment _comment;
  Comment get comment => _comment;


}