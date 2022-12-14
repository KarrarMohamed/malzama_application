import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../core/platform/services/dialog_services/dialog_service.dart';
import '../../../../../../../../core/platform/services/dialog_services/service_locator.dart';
import '../state_providers/school_uploads_state_provider.dart';
import 'widgets/school_uploading_choose_school_section.dart';
import 'widgets/school_uploading_choose_school_stage.dart';



class SchoolLectureUploadingFormWidget extends StatefulWidget {
  @override
  _UploadingLectureBodyForSchoolsState createState() => _UploadingLectureBodyForSchoolsState();
}

class _UploadingLectureBodyForSchoolsState extends State<SchoolLectureUploadingFormWidget> {
  GlobalKey<FormState> _formKey;
  String title, description, stage, school_section, topic;

  FocusNode titleFocusNode;
  FocusNode descriptionFocusNode;


  @override
  void initState() {
    super.initState();
    titleFocusNode = new FocusNode();
    descriptionFocusNode = new FocusNode();
    _formKey = new GlobalKey<FormState>();

  }

  @override
  void dispose() {
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();

    print('the building body of uploading lecture has been disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
      ),
      child: GestureDetector(
        onTap: () {
          titleFocusNode.unfocus();
          descriptionFocusNode.unfocus();
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.all(ScreenUtil().setSp(70)),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Upload new lecture', style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(60))),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(50)),
                  TextFormField(
                    focusNode: titleFocusNode,
                    maxLength: 40,
                    decoration: InputDecoration(
                      labelText: 'title',
                    ),
                    validator: (val) {
                      if (val.trim().isEmpty) {
                        return 'this field is required';
                      }
                      return null;
                    },
                    onSaved: (val) => title = val,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  TextFormField(
                    focusNode: descriptionFocusNode,
                    decoration: InputDecoration(
                      labelText: 'description',
                    ),
                    maxLines: null,
                    maxLength: 300,
                    validator: (val) {
                      if (val.trim().isEmpty) {
                        return 'this field is required';
                      }
                      return null;
                    },
                    onSaved: (val) => description = val,
                  ),

                  TargetSchoolStage(focusNodes: [titleFocusNode, descriptionFocusNode]),
                  // SizedBox(
                  //   height: ScreenUtil().setHeight(30),
                  // ),
                  TargetSchoolSection(focusNodes: [titleFocusNode, descriptionFocusNode]),
                  SizedBox(
                    height: ScreenUtil().setHeight(80),
                  ),
                  Consumer<SchoolUploadState>(
                    builder: (context, stateProvider, _) => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                          color: Colors.amber,
                          onPressed: () async {
                            // ANCHOR filePicker
                            FilePickerResult result = await FilePicker.platform.pickFiles(allowedExtensions: ['pdf'],type: FileType.custom);
                            File lecture = new File(result.files.single.path);
                            stateProvider.updateLectureToUpload(lecture);
                          },
                          child: Text(
                              stateProvider.lectureToUpload == null
                                  ? 'Tap here to choose File'
                                  : stateProvider.lectureToUpload.path.split('/').last.length > 40
                                  ? stateProvider.lectureToUpload.path.split('/').last.substring(0, 40)
                                  : stateProvider.lectureToUpload.path.split('/').last,
                              textAlign: TextAlign.center)),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(100)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          Provider.of<SchoolUploadState>(context, listen: false).setAllFieldsToNull();
                          locator<DialogService>().completeAndCloseDialog(null);
                        },
                        child: Text('Cancel'),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(50)),
                      RaisedButton(
                        color: Colors.blueAccent,
                        onPressed: () async {
                          SchoolUploadState lectureState = Provider.of<SchoolUploadState>(context, listen: false);
                          print('we are here inside uploading');
                          if (_formKey.currentState.validate()) {
                            FocusScope.of(context).unfocus();

                            _formKey.currentState.save();
                            final Map<String, dynamic> lectureData = {
                              'title': title,
                              'description': description,
                              'stage': lectureState.targetStage,
                              'school_section': lectureState.targetSchoolSection,
                              'src': lectureState.lectureToUpload
                            };

                            locator<DialogService>().completeAndCloseDialog(lectureData);
                          } else {
                            print('invalid data');
                          }
                        },
                        child: Text(
                          'upload',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

