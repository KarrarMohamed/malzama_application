import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/platform/services/dialog_services/service_locator.dart';
import '../../shared/accessory_widgets/load_more_widget_for_pagination.dart';
import '../../shared/accessory_widgets/no_materials_yet_widget.dart';
import '../../shared/material_holding_widgets/college/college_pdf_holding_widget.dart';
import '../../shared/single_page_display_widgets/failed_to_load_materials_widget.dart';
import '../state/pdf_state_provider.dart';

class DisplayHomePage extends StatelessWidget {
  const DisplayHomePage();

  @override
  Widget build(BuildContext context) {

    PDFStateProvider pdfState = Provider.of<PDFStateProvider>(context, listen: false);
    ScreenUtil.init(context);
    return Scaffold(
      key: pdfState.scaffoldKey,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //
      //
      //
      //   },
      // ),
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: Selector<PDFStateProvider, List<dynamic>>(
          selector: (context, stateProvider) => [
            stateProvider.isFetching,
            stateProvider.materials.length,
            stateProvider.failureOfInitialFetch,
          ],
          builder: (context, data, __) {
            if (data.first) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (data.last) {
              return FailedToLoadMaterialsWidget(
                onReload: pdfState.fetchInitialData,
                message: 'Failed to Load lectures',
              );
            }

            if (data[1] == 0) {
              return NoMaterialYetWidget(
                materialName: 'Lectures',
                onReload: pdfState.fetchInitialData,
              );
            }
            return _LecturesList();
          }),
    );
  }
}

class _LecturesList extends StatelessWidget {
  const _LecturesList();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    PDFStateProvider pdfStateProvider = Provider.of<PDFStateProvider>(context, listen: false);
    ScreenUtil.init(context);
    return RefreshIndicator(
      onRefresh: () async {
        await locator<PDFStateProvider>().onRefresh();
      },
      child: Selector<PDFStateProvider, int>(
        selector: (context, stateProvider) => stateProvider.materials.length,
        builder: (context, count, _) => ListView.builder(
          itemCount: count,
          itemBuilder: (context, pos) {
            if (pos == count - 1 && count >= 10) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CollegePDFHoldingWidget<PDFStateProvider>(pos: pos),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  LoadMoreWidget<PDFStateProvider>(
                    onLoadMore: pdfStateProvider.fetchForPagination,
                  ),
                ],
              );
            }

            return CollegePDFHoldingWidget<PDFStateProvider>(pos: pos);
          },
        ),
      ),
    );
  }
}
