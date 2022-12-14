import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/Navigator/routes_names.dart';
import '../../../state_provider/user_info_provider.dart';

class DraftIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    ScreenUtil.init(context);

    return Selector<UserInfoStateProvider, int>(
      selector: (context, stateProvider) => stateProvider.quizDraftsCount,
      builder: (context, quizCollectionsCount, __) => Container(
        //color: Colors.red,
        child: ListTile(
          title: Text(
            'My Drafts',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(60)),
          ),
          subtitle: Text(
            '$quizCollectionsCount quizes',
            style: TextStyle( fontSize: ScreenUtil().setSp(40)),
          ),
          trailing: RaisedButton(
            child: Text('Explore'),
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.VIEW_QUIZ_DRAFTS);
            },
          ),
        ),
      ),
    );
  }
}
