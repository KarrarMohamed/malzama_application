import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malzama_app/src/core/platform/services/caching_services.dart';
import 'package:provider/provider.dart';

import '../../../../../core/references/references.dart';
import '../../state_provider/common_widgets_state_provider.dart';

class SelectCityWidget extends StatelessWidget {
  const SelectCityWidget();

  @override
  Widget build(BuildContext context) {
    CommonWidgetsStateProvider state = Provider.of<CommonWidgetsStateProvider>(context, listen: false);

    print('city rebuilding');
    final Size screenSize = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Selector<CommonWidgetsStateProvider, List<String>>(
      selector: (context, stateProvider) => [
        stateProvider.province,
        stateProvider.errorMessages[5],
      ],
      builder: (context, data, _) => Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
        padding: EdgeInsets.all(ScreenUtil().setSp(25)),
        decoration:
        BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(ScreenUtil().setSp(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(errorText: data[1]),
                    isDense: true,
                    hint: new Text("Select your city"),
                    value: state.province,
                    onChanged: (String newValue) {
                      state.updateCity(newProvince: newValue);
                    },
                    items: References.iraqProvinces.keys.map((province) {
                      return DropdownMenuItem<String>(
                          child: SizedBox(
                            width: ScreenUtil().setWidth(700),
                            height: ScreenUtil().setWidth(70),
                            child: Text(
                              "${References.iraqProvinces[province]}",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          value: province);
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
