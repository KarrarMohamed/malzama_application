import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malzama_app/src/features/home/presentation/pages/my_materials/materialPage/state_provider_contracts/material_state_repo.dart';
import 'package:provider/provider.dart';

import '../../state_providers/add_comment_widget_state_provider.dart';
import '../../state_providers/comment_state_provider.dart';

class RepliesDisplayPageHeader<B extends MaterialStateRepository> extends StatelessWidget {
  const RepliesDisplayPageHeader();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    CommentStateProvider<B> commentStateProvider = Provider.of<CommentStateProvider<B>>(context, listen: false);
    ScreenUtil.init(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setSp(30), horizontal: ScreenUtil().setSp(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Provider.of<AddOrEditCommentWidgetStateProvider>(context, listen: false).resetWidget();
                commentStateProvider.closeRepliesDisplayPage();
              },
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'replies to your comment on ali\'s lecture to your comment on ali\'s lecture',
                    style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                'view lecture',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blueAccent,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
