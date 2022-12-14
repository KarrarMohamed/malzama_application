import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import '../../../shared/accessory_widgets/load_more_widget_for_pagination.dart';
import '../../../shared/accessory_widgets/no_materials_yet_widget.dart';
import '../../../shared/material_holding_widgets/college/college_video_holding_widget.dart';
import '../../../shared/single_page_display_widgets/failed_to_load_materials_widget.dart';
import '../state/video_state_provider.dart';

class DisplayVideosPage extends StatefulWidget {
  @override
  _DisplayVideosPageState createState() => _DisplayVideosPageState();
}

class _DisplayVideosPageState extends State<DisplayVideosPage> {
  @override
  Widget build(BuildContext context) {
    VideoStateProvider videoStateProvider = Provider.of<VideoStateProvider>(context, listen: false);
    return Selector<VideoStateProvider, List<dynamic>>(
        selector: (context, stateProvider) => [
              stateProvider.isFetching,
              stateProvider.materials.length,
              stateProvider.failureOfInitialFetch,
            ],
        builder: (context, data, child) {
          if (data.first) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (data.last) {
            return FailedToLoadMaterialsWidget(
              onReload: videoStateProvider.fetchInitialData,
              message: 'Failed to load videos',
            );
          }

          if (data[1] == 0) {
            return NoMaterialYetWidget(
              materialName: 'Videos',
              onReload: videoStateProvider.fetchInitialData,
            );
          }
          return Materials();
        });
  }
}

class Materials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VideoStateProvider videoStateProvider = Provider.of<VideoStateProvider>(context, listen: false);


    return RefreshIndicator(
      onRefresh: () async {
        await videoStateProvider.onRefresh();
        return;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: videoStateProvider.scaffoldKey,
          body: Container(
            padding: EdgeInsets.all(ScreenUtil().setSp(20)),
            color: Colors.grey.withOpacity(0.3),
            child: Selector<VideoStateProvider, int>(
              selector: (context, stateProvider) => stateProvider.materials.length,
              builder: (context, count, _) => ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, pos) {
                    if (pos == count - 1 && count >= 10) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CollegeVideoHoldingWidget<VideoStateProvider>(pos: pos),
                          SizedBox(
                            height: ScreenUtil().setHeight(30),
                          ),
                          LoadMoreWidget<VideoStateProvider>(
                            onLoadMore: videoStateProvider.fetchForPagination,
                          ),
                        ],
                      );
                    }
                    return CollegeVideoHoldingWidget<VideoStateProvider>(pos: pos);
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
