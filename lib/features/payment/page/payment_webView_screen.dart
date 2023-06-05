import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/api/end_points.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../success/model/success_model.dart';



class PaymentWebViewScreen extends StatefulWidget {
final int rservationiD;



  const PaymentWebViewScreen({required this.rservationiD});

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  double value = 0.0;

  var wiselectedUrl;
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        // useShouldInterceptAjaxRequest: true,
        javaScriptCanOpenWindowsAutomatically: true,
        //
        javaScriptEnabled: true,
        userAgent:
        'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,


      ),
      ios: IOSInAppWebViewOptions(

        allowsInlineMediaPlayback: true,

      ));

  PullToRefreshController? pullToRefreshController;
  ContextMenu? contextMenu;
  PaymentProvider? reservationModelProvider ;

  double progress = 0;
  @override
  void initState() {
    super.initState();
    reservationModelProvider   = Provider.of<PaymentProvider>(context,listen: false);
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {


                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {


        },
        onHideContextMenu: () {
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;

        });



      wiselectedUrl ="${EndPoints.baseUrl}client/OfferTapPayment";

print(wiselectedUrl);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,


      appBar: CustomAppBar(

          title: "الدفع",
    ),
      body: Center(
        child: Container(
          width: 1170,

          child: Stack(
            children: [
              InAppWebView(

                initialUrlRequest: URLRequest(
                    url: Uri.parse(wiselectedUrl),
                    method: 'POST',

                    body:
                        (reservationModelProvider!.coupon!=null)?
                    Uint8List.fromList(utf8.encode("reservation_id=${widget.rservationiD}&coupon_id=${reservationModelProvider!.coupon!.id}"
                        )):    Uint8List.fromList(utf8.encode("reservation_id=${widget.rservationiD}"
                        )),

                    headers:
                    {
                      'Content-Type': 'application/json; charset=UTF-8',
                      "Accept": " application/json",

                    }),


                // pullToRefreshController: pullToRefreshController,
                initialOptions: options,
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController!.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;

                  });
                },
                onWebViewCreated: (controller) {
                  setState(() {

                    webViewController = controller;
                  });
                },
                contextMenu: contextMenu,
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  print("PATH"+url!.path ); print("query"+url.query );
                  bool _isSuccess = url.query.contains('success');
                  bool _isFailed = url.query.contains('fail');
                  bool _isCancel = url.query.contains('cancel');

                  if (_isSuccess) {
                    CustomNavigator.push(Routes.SUCCESS,
                        replace: true,
                        arguments: SuccessModel(
                            isCongrats: true,
                            isReplace: true,
                            routeName: Routes.REQUEST_DETAILS,
                            title: "محمد م...",
                            btnText: getTranslated("trip", context),
                            description:"تم دفع تكاليف الرحله بنجاح مع كابتن محمد م..."));
                    // MyApp.navigatorKey.currentState!.pushAndRemoveUntil(CupertinoPageRoute(builder: (builder)=>SuccessScreen()),(x)=>false);

                  } else if (_isFailed) {
                    CustomNavigator.push(Routes.SUCCESS,
                        replace: true,
                        arguments: SuccessModel(
                            isCongrats: true,
                            isReplace: true,
                            routeName: Routes.REQUEST_DETAILS,
                            title: "فشل",
                            btnText: getTranslated("trip", context),
                            description:"فشل دفع تكاليف الرحله."));



                  } else if (_isCancel) {
                    CustomNavigator.push(Routes.SUCCESS,
                        replace: true,
                        arguments: SuccessModel(
                            isCongrats: true,
                            isReplace: true,
                            routeName: Routes.REQUEST_DETAILS,
                            title: "فشل",
                            btnText: getTranslated("trip", context),
                            description:"فشل دفع تكاليف الرحله."));



                  }

                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
                onCloseWindow: (InAppWebViewController){

                },

              ),


              progress < 1.0
                  ? LinearProgressIndicator(value: progress,color: ColorResources.PRIMARY_COLOR,backgroundColor: Colors.red.shade50,)

                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }


}
