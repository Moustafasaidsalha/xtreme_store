import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:extreme_store/data/models/response.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../app/routes/routes_constants.dart';

class PaymentPage extends StatefulWidget {
  final String url;
  const PaymentPage({super.key, required this.url});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final WebViewController controller = WebViewController.fromPlatformCreationParams(
      const PlatformWebViewControllerCreationParams(),
    );

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          // onProgress: (int progress) {
          //   debugPrint('WebView is loading (progress : $progress%)');
          // },
          // onPageStarted: (String url) {
          //   debugPrint('Page started loading: $url');
          // },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');
            if(url.contains('https://back.xtremestorekw.com')){
              var response =
              await _controller.runJavaScriptReturningResult('document.body.innerText') as String;
              var r = ResponseModel.fromJson(jsonDecode(response));
              if ((r.flag ?? false) == true) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesConstant.homeLanding,
                      (route) => false,
                );
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesConstant.homeLanding,
                      (route) => false,
                );
              }
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   debugPrint('blocking navigation to ${request.url}');
            //   return NavigationDecision.prevent;
            // }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: WebViewWidget(controller: _controller),
    );
  }
}
