import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malzama_app/src/core/platform/services/dialog_services/service_locator.dart';
import 'package:malzama_app/src/features/home/models/materials/school_material.dart';
import 'package:malzama_app/src/features/home/presentation/pages/my_materials/my_saved_and_uploads/my_uploads/holding_widgets/college/college_uploaded_pdf_widget.dart';
import 'package:malzama_app/src/features/home/presentation/pages/my_materials/my_saved_and_uploads/my_uploads/state_provider/my_uploads_state_provider.dart';
import 'package:malzama_app/src/features/home/presentation/pages/shared/accessory_widgets/no_materials_yet_widget.dart';
import 'package:malzama_app/src/features/home/presentation/state_provider/user_info_provider.dart';
import 'package:provider/provider.dart';

class UploadedLecturesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    MyUploadsStateProvider uploadedLecturesStateProvider = Provider.of<MyUploadsStateProvider>(context, listen: false);
    ScreenUtil.init(context);
    return Scaffold(
      key: uploadedLecturesStateProvider.lecturesScaffoldKey,
      body: Selector<MyUploadsStateProvider, bool>(
        selector: (context, stateProvider) => stateProvider.isFetchingLectures,
        builder: (context, isFetching, _) {
          if (isFetching) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Selector<MyUploadsStateProvider, int>(
            selector: (context, stateProvider) => stateProvider.uploadedLectures.length,
            builder: (context, count, _) => count == 0
                ? NoMaterialYetWidget(
              onReload: () async {
                uploadedLecturesStateProvider.setIsFetchingLecturesTo(true);
                await uploadedLecturesStateProvider.fetchLectures();
                uploadedLecturesStateProvider.setIsFetchingLecturesTo(false);
                locator<UserInfoStateProvider>().fetchUploadedMaterialsCount();
              },
              materialName: 'uploaded lectures',
            )
                : ListView.builder(
              itemCount: count,
              itemBuilder: (context, pos) {
                if (pos == count) {
                  return Container();
                }

                return CollegeUploadedPDFHoldingWidget(pos: pos);

              },
            ),
          );
        },
      ),
    );
  }
}
