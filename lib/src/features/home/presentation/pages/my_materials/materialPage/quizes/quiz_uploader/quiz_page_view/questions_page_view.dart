import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:malzama_app/src/features/home/presentation/state_provider/quiz_uploader_state_provider.dart';
import 'package:provider/provider.dart';

import 'quiz_input_page.dart';
import 'quiz_review_page.dart';

class QuizQuestionsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    QuizUploaderState uploadingState =
        Provider.of<QuizUploaderState>(context, listen: false);
    ScreenUtil.init(context);
    return Container(
      color: Colors.grey,
      height: ScreenUtil().setHeight(1600),
      child: SizedBox.expand(
        child: PageView.builder(
            physics: BouncingScrollPhysics(),
            controller: uploadingState.pageController,
            //scrollDirection: Axis.horizontal,
            itemCount: uploadingState.quizList.length,
            onPageChanged: (pos) {
              uploadingState.updateCurrentPageIndex(pos);
            },
            itemBuilder: (context, pos) {
              return Selector<QuizUploaderState, bool>(
                selector: (context, stateProvider) =>
                    stateProvider.quizList[pos].inReviewMode,
                builder: (context, inReviewMode, __) => AnimatedSwitcher(
                  child: inReviewMode
                      ? animatedQuizReviewBuilder(
                          pos, uploadingState, screenSize)
                      : animatedQuizEditBuilder(pos, uploadingState),
                  duration: Duration(milliseconds: 350),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.bounceInOut,
                ),
              );
            }),
      ),
    );
  }

  animatedQuizEditBuilder(int pos, QuizUploaderState uploadingState) {
    return Center(
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().setSp(25)),
          color: Colors.grey[200],
        ),
        duration: Duration(milliseconds: 500),
        child: QuizEditBuilder(
          pos: pos,
        ),
        width: ScreenUtil().setWidth(
          pos == uploadingState.currentPageIndex ? 1200 : 400,
        ),
        height: ScreenUtil().setHeight(
          pos == uploadingState.currentPageIndex ? 1500 : 400,
        ),
      ),
    );
  }

  animatedQuizReviewBuilder(
      int pos, QuizUploaderState uploadingState, Size screenSize) {
    return Center(
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(ScreenUtil().setSp(25)),
        ),
        duration: Duration(milliseconds: 500),
        child: QuizReviewBuilder(pos: pos),
        width: ScreenUtil().setWidth(
          pos == uploadingState.currentPageIndex ? 1200 : 400,
        ),
        height: ScreenUtil().setHeight(
          pos == uploadingState.currentPageIndex ? 1500 : 400,
        ),

        //color: pos % 2 == 0 ? Colors.blueAccent : Colors.redAccent,
      ),
    );
  }
}
