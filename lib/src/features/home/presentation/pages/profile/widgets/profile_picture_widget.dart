import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:malzama_app/src/core/general_widgets/helper_functions.dart';
import 'package:malzama_app/src/features/home/presentation/pages/shared/accessory_widgets/small_circular_progress_indicator.dart';
import 'package:malzama_app/src/features/home/presentation/state_provider/profile_page_state_provider.dart';
import 'package:provider/provider.dart';

class ProfilePictureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    ProfilePageState profilePageState = Provider.of<ProfilePageState>(context, listen: false);
    ScreenUtil.init(context);
    return InkWell(
      onTap: () async {
        if (profilePageState.isProfilePictureClickable) {
          final bool enableDelete = profilePageState.profilePicture != null;
          print('deleteEnabled = $enableDelete');
          var value = await HelperFucntions.showProfilePicturesModalSheet(
            context: context,
            pictureName: 'profile',
            enableDelete: enableDelete,
          );
          profilePageState.onProfilePictureOptionsHandler(context, value);
        }
      },
      child: Hero(
        tag: 'profile',
        child: Selector<ProfilePageState, File>(
          selector: (context, stateProvider) => stateProvider.profilePicture,
          builder: (context, profilePicture, _) => Container(
            width: ScreenUtil().setWidth(230),
            height: ScreenUtil().setHeight(230),
            decoration: BoxDecoration(
              color: Colors.white,
              border: profilePicture == null ? Border.all(width: 2, color: Colors.black) : null,
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(profilePageState.profilePicture == null ? 1100 : 115)),
              image: DecorationImage(
                image:
                profilePicture != null ? FileImage(profilePicture) : AssetImage(profilePageState.defaultProfilePicture),
                fit: BoxFit.fill,
              ),
            ),
            child: Selector<ProfilePageState, List<dynamic>>(
              selector: (context, stateProvider) => [
                stateProvider.isUploadingProfilePicture,
                stateProvider.profilePicture,
                stateProvider.isDeletingProfilePicture,
              ],
              builder: (context, data, _) {
                if (data.first || data.last)
                  return Center(
                    child: SmallCircularProgressIndicator(),
                  );

                if (data[1] != null) {
                  return Container();
                }
                return Icon(
                  Icons.add_a_photo,
                  size: ScreenUtil().setSp(100),
                  color: Colors.black,
                );
              },
            ),
            //child: Icon(Icons.add_a_photo,size: 50,),
          ),
        ),
      ),
    );
  }
}
