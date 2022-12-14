import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentOptionsBottomSheet extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isComment;

  CommentOptionsBottomSheet({
    @required this.onEdit,
    @required this.onDelete,
    bool isComment,
  })  : this.isComment = isComment ?? false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ScreenUtil().setSp(70)),
          topRight: Radius.circular(ScreenUtil().setSp(70)),
        ),
      ),
      padding: EdgeInsets.all(ScreenUtil().setSp(30)),
      height: ScreenUtil().setHeight(600),
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(20),
            width: ScreenUtil().setWidth(230),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(
                ScreenUtil().setSp(30),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Edit ${isComment ? 'comment' : 'reply'}',
            ),
            onTap: onEdit,
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text(
              'Delete ${isComment ? 'comment' : 'reply'}',
            ),
            onTap: onDelete,
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text(
              'Cancel',
            ),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop(null);
            },
          ),
        ],
      ),
    );
  }
}
