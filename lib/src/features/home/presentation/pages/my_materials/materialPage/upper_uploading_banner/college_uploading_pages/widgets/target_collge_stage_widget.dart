import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:malzama_app/src/core/platform/services/dialog_services/service_locator.dart';
import 'package:malzama_app/src/features/home/models/users/college_user.dart';
import 'package:malzama_app/src/features/home/presentation/state_provider/user_info_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../../core/references/references.dart';
import '../../../../../../state_provider/profile_page_state_provider.dart';
import '../../state_providers/college_uploads_state_provider.dart';

class CollegeChooseStageWidget extends StatelessWidget {
  final List<FocusNode> focusNodes;

  // Constructor
  CollegeChooseStageWidget({@required this.focusNodes});

  // get the stages list according the the college of the user
  List<String> _getItems(ProfilePageState profilePageState) {
    String college = (locator<UserInfoStateProvider>().userData as CollegeUser).college;
    List<String> _items = References.stagesMapper.values.toList().map((e) => e.toString()).toList();

    RegExp pharmacyPattern = new RegExp(r'صيدلة');
    RegExp dentistPattern = new RegExp(r'سنان');
    RegExp analysisPattern = new RegExp(r'مرضية');

    if (pharmacyPattern.hasMatch(college) || dentistPattern.hasMatch(college)) {
      _items.removeLast();
      return _items;
    } else if (analysisPattern.hasMatch(college)) {
      _items.removeLast();
      _items.removeLast();
      return _items;
    } else {
      return _items;
    }
  }

  @override
  Widget build(BuildContext context) {
    CollegeUploadingState collegeUploadingState = Provider.of<CollegeUploadingState>(context, listen: false);
    ProfilePageState profilePageState = Provider.of<ProfilePageState>(context, listen: false);
    final Size screenSize = MediaQuery.of(context).size;
    ScreenUtil.init(context);

    return Selector<CollegeUploadingState, int>(
      selector: (context, stateProvider) => stateProvider.stage,
      builder: (context, schoolStage, _) => GestureDetector(
        onTap: () => focusNodes.forEach((node) => node.unfocus()),
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(ScreenUtil().setSp(10)),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        validator: (data) {
                          if (data == null)
                            return 'this field is required';
                          else
                            return null;
                        },
                        items: _getItems(profilePageState).map((String stage) {
                          return DropdownMenuItem<int>(
                            child: Text(
                              '$stage  ',
                              //style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            value: int.parse(References.stagesMapper.entries.firstWhere((item) => item.value == stage).key),
                          );
                        }).toList(),
                        onChanged: (update) {
                          print(update);
                          collegeUploadingState.updateTargetStage(update);
                        },
                        value: collegeUploadingState.stage,
                        hint: Align(alignment: Alignment.center, child: Text('Target stage')),
                        selectedItemBuilder: (BuildContext context) {
                          return _getItems(profilePageState).map<Widget>((String item) {
                            return Align(
                                alignment: Alignment.center,
                                child: Text(
                                  item + ' ',
                                  textAlign: TextAlign.center,
                                ));
                          }).toList();
                        },
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
