import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:malzama_app/src/core/general_widgets/helper_functions.dart';
import 'package:malzama_app/src/core/platform/local_database/local_caches/cached_user_info.dart';

import '../../../core/platform/services/caching_services.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void _handleNextDestination(Data d) async {
    if (d.hasToken) {
      print('we are here naving to /home-page');
      Navigator.of(context).pushNamed('/home-page');
    } else if (d.hasInitialPage) {
      Navigator.of(context).pushNamedAndRemoveUntil(d.initialPage, (_) => false);
    } else {
      print('naving to signup page');
      Navigator.of(context).pushNamedAndRemoveUntil('/signup-page', (_) => false);
    }
  }

  Future<Data> _startLaunching() async {
    Data _data = new Data();
    _data.initialPage = await CachingServices.getField(key: 'initial-page');
    _data.token = await CachingServices.getField(key: 'token');
    return _data;
  }

  @override
  void initState() {
    print('inside init state');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _handleNextDestination(await _startLaunching());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.book,
                size: ScreenUtil().setSp(100),
              ),
              Text(
                'Malzama App',
                style: TextStyle(fontSize: ScreenUtil().setSp(100), fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Data {
  String token;
  String initialPage;

  Data({this.token, this.initialPage});

  bool get hasToken => token != null && token.isNotEmpty;

  bool get hasInitialPage => initialPage != null && initialPage.isNotEmpty;
}
