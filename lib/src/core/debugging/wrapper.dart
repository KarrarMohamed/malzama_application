import 'package:flutter/material.dart';
import 'package:malzama_app/src/core/platform/services/caching_services.dart';
import 'package:provider/provider.dart';

class WrapperWidget extends StatelessWidget {
  final Widget child;
  WrapperWidget({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 250,
          ),
          FlatButton(
            child: Text('clear caching'),
            onPressed: () async {
              await CachingServices.clearAllCachedData();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/signup-page', (_) => false);
            },
          ),
          FlatButton(
            child: Text('test'),
            onPressed: () async {
              
            },
          )
        ],
      )),
      body: child,
    );
  }
}
