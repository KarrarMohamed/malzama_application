import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:malzama_app/src/features/home/presentation/pages/my_materials/materialPage/state_provider_contracts/material_state_repo.dart';
import 'package:provider/provider.dart';

import '../state_providers/add_comment_widget_state_provider.dart';
import 'add_new_comment_widget.dart';
import 'update_already_existing_comment.dart';

class BottomSheetWidget<B extends MaterialStateRepository> extends StatelessWidget {

  const BottomSheetWidget();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Selector<AddOrEditCommentWidgetStateProvider, bool>(
      selector: (context, stateProvider) => stateProvider.isCommentUpdating,
      builder: (context, isUpdatingComment, _) {
        if (isUpdatingComment) {
          return UpdateAlreadyExistedCommentWidget<B>();
        } else {
          return AddNewCommentWidget<B>();
        }
      },
    );
  }
}
