import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malzama_app/src/features/home/presentation/pages/my_materials/materialPage/state_provider_contracts/material_state_repo.dart';
import 'package:provider/provider.dart';

import '../state_providers/add_comment_widget_state_provider.dart';
import '../state_providers/comment_state_provider.dart';
import 'add_comment_text_field.dart';

class AddNewCommentWidget<B extends MaterialStateRepository> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Container(
      constraints: BoxConstraints(
        minHeight: ScreenUtil().setHeight(10),
        maxHeight: ScreenUtil().setHeight(350),
      ),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(
          ScreenUtil().setSp(50),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: Container(
              //color: Colors.redAccent,
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(35),
                vertical: ScreenUtil().setSp(10),
              ),
              child: AddCommentTextField<B>(),
            ),
          ),
          Selector<AddOrEditCommentWidgetStateProvider, bool>(
            selector: (context, stateProvider) => stateProvider.isSendButtonVisible,
            builder: (context, isSendButtonVisible, _) => isSendButtonVisible
                ? IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _onPressed<B>(context),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ),
        ],
      ),
    );
  }
}

void _onPressed<B extends MaterialStateRepository>(BuildContext context) {
  CommentStateProvider<B> commentStateProvider = Provider.of<CommentStateProvider<B>>(context, listen: false);

  if (commentStateProvider.insideRepliesPage) {
    onUploadingNewReply<B>(context);
  } else {
    onUploadingNewComment<B>(context);
  }
}

/// [on upload new reply]
void onUploadingNewReply<B extends MaterialStateRepository>(BuildContext context) async {
  AddOrEditCommentWidgetStateProvider addOrEditCommentWidgetStateProvider =
      Provider.of<AddOrEditCommentWidgetStateProvider>(context, listen: false);

  final replyText = addOrEditCommentWidgetStateProvider.textController.text;
  addOrEditCommentWidgetStateProvider.resetWidget();
  Provider.of<CommentStateProvider<B>>(context, listen: false).uploadNewReply(content: replyText);
}

/// [on upload new comment]
void onUploadingNewComment<B extends MaterialStateRepository>(BuildContext context) async {
  AddOrEditCommentWidgetStateProvider addOrEditCommentWidgetStateProvider =
      Provider.of<AddOrEditCommentWidgetStateProvider>(context, listen: false);
  CommentStateProvider<B> commentStateProvider = Provider.of<CommentStateProvider<B>>(context, listen: false);
  final String content = addOrEditCommentWidgetStateProvider.textController.text;
  addOrEditCommentWidgetStateProvider.resetWidget();
  bool result = await commentStateProvider.uplaodNewComment(
    content: content,
  );
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(result ? 'new Comment added' : 'failed to add a comment'),
    ),
  );
}
