import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malzama_app/src/features/home/presentation/pages/my_materials/materialPage/quizes/quiz_collection_model.dart';
import 'package:malzama_app/src/features/home/presentation/pages/my_materials/my_saved_and_uploads/my_uploads/holding_widgets/college/college_uploaded_quiz_widget.dart';
import 'package:malzama_app/src/features/home/presentation/pages/my_materials/my_saved_and_uploads/my_uploads/state_provider/my_uploads_state_provider.dart';
import 'package:malzama_app/src/features/home/presentation/pages/shared/accessory_widgets/no_materials_yet_widget.dart';
import 'package:provider/provider.dart';

class UploadedQuizesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    MyUploadsStateProvider uploadedLecturesStateProvider = Provider.of<MyUploadsStateProvider>(context, listen: false);
    ScreenUtil.init(context);
    return Scaffold(
      key: uploadedLecturesStateProvider.quizesScaffoldKey,
      body: Selector<MyUploadsStateProvider, bool>(
        selector: (context, stateProvider) => stateProvider.isFetchingQuizes,
        builder: (context, isFetching, _) {
          if (isFetching) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Selector<MyUploadsStateProvider, int>(
            selector: (context, stateProvider) => stateProvider.uploadedQuizes.length,
            builder: (context, count, _) => count == 0
                ? NoMaterialYetWidget(
                    onReload: () async {
                      uploadedLecturesStateProvider.setIsFetchingQuizesTo(true);
                      await uploadedLecturesStateProvider.fetchQuizes();
                      uploadedLecturesStateProvider.setIsFetchingQuizesTo(false);
                    },
                    materialName: 'uploaded quizes',
                  )
                : ListView.builder(
                    itemCount: count,
                    itemBuilder: (context, pos) =>  CollegeUploadedQuizHoldingWidget(pos: pos),
                  ),
          );
        },
      ),
    );
  }
}
