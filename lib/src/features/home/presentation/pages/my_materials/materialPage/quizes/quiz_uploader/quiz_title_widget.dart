import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malzama_app/src/features/home/presentation/state_provider/quiz_uploader_state_provider.dart';
import 'package:provider/provider.dart';

class QuizTitleWidget extends StatelessWidget {
  final TextEditingController controller;

  QuizTitleWidget({this.controller});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    QuizUploaderState quizUploadingState = Provider.of<QuizUploaderState>(context, listen: false);
    ScreenUtil.init(context);

    return Padding(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'title',
          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(ScreenUtil().setSp(20))),
        ),
        validator: (val) {
          if (val.isEmpty) {
            return 'this field is required';
          }
          return null;
        },
      ),
    );
  }
}
