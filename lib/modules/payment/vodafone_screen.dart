import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../shared/components/constants.dart';

class VodafoneScreen extends StatefulWidget {
  VodafoneScreen({Key? key}) : super(key: key);

  @override
  State<VodafoneScreen> createState() => _VodafoneScreenState();
}

class _VodafoneScreenState extends State<VodafoneScreen> {
  int webProgress=0;
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          title: Text(
            'Charity',
            style:
            TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 35,

            ),
          ),
          leading: IconButton( onPressed: () {Navigator.pop(context);  }, icon: Icon(Icons.arrow_back_ios),),
          backgroundColor: Color.fromRGBO(37, 90, 123,1),
        ),
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 5,width: webProgress*10.toDouble(),color:Colors.black38,),
            Expanded(
              child: WebView(
                initialUrl: Uri.encodeFull(
                    '$vodafoneUrl'),
                javascriptMode: JavascriptMode.unrestricted,
                onProgress: (int progress) {
                  print('WebView is loading (progress : $progress%)');
                  setState((){
                    if (progress==100)
                    {
                      webProgress=progress=0;
                    }
                    webProgress=progress;

                  });
                },

              ),
            ),
          ],
        ));
  }
}
