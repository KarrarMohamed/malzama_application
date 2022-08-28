import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malzama_app/src/core/platform/services/dialog_services/service_locator.dart';
import 'package:malzama_app/src/features/home/models/materials/school_material.dart';
import 'package:malzama_app/src/features/home/presentation/pages/my_materials/my_saved_and_uploads/my_uploads/holding_widgets/college/college_uploaded_video_widget.dart';
import 'package:malzama_app/src/features/home/presentation/pages/my_materials/my_saved_and_uploads/my_uploads/state_provider/my_uploads_state_provider.dart';
import 'package:malzama_app/src/features/home/presentation/pages/shared/accessory_widgets/no_materials_yet_widget.dart';
import 'package:malzama_app/src/features/home/presentation/state_provider/user_info_provider.dart';
import 'package:provider/provider.dart';

class UploadedVideosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    MyUploadsStateProvider uploadedVideoState = Provider.of<MyUploadsStateProvider>(context, listen: false);
    ScreenUtil.init(context);
    return Scaffold(
      key: uploadedVideoState.videosScaffoldKey,
      body: Selector<MyUploadsStateProvider, bool>(
        selector: (context, stateProvider) => stateProvider.isFetchingVideos,
        builder: (context, isFetching, _) {
          if (isFetching) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Selector<MyUploadsStateProvider, int>(
            selector: (context, stateProvider) => stateProvider.uploadedVideos.length,
            builder: (context, count, _) => count == 0
                ? NoMaterialYetWidget(
                    onReload: () async {
                      uploadedVideoState.setIsFetchingVideosTo(true);
                      await uploadedVideoState.fetchVideos();
                      uploadedVideoState.setIsFetchingVideosTo(false);
                      locator<UserInfoStateProvider>().fetchUploadedMaterialsCount();
                    },
                    materialName: 'uploaded videos',
                  )
                : ListView.builder(
                    itemCount: count,
                    itemBuilder: (context, pos) => CollegeUploadedVideoHoldingWidget(pos: pos),
                  ),
          );
        },
      ),
    );
  }
}
