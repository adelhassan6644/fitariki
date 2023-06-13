import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:fitariki/features/payment/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/api/end_points.dart';
import '../../../data/config/di.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../request_details/provider/request_details_provider.dart';
import '../../success/model/success_model.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final int rservationId;

  const PaymentWebViewScreen({super.key, required this.rservationId});

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  double value = 0.0;

  var wiselectedUrl;
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldInterceptAjaxRequest: true,
        javaScriptCanOpenWindowsAutomatically: true,
        //
        javaScriptEnabled: true,
        userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(

        allowsInlineMediaPlayback: true,
      ));

  PullToRefreshController? pullToRefreshController;
  ContextMenu? contextMenu;
  PaymentProvider? reservationModelProvider;

  double progress = 0;
  @override
  void initState() {
    super.initState();
    reservationModelProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: " +
              id.toString() +
              " " +
              contextMenuItemClicked.title);
        });

    wiselectedUrl = "${EndPoints.baseUrl}client/OfferTapPayment";

    log(wiselectedUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: getTranslated("payment", context),
      ),
      body: Center(
        child: SizedBox(
          width: 1170,
          child: Stack(
            children: [
          InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse(wiselectedUrl),
                    method: 'POST',
                    body: (reservationModelProvider!.coupon != null)
                        ? Uint8List.fromList(utf8.encode(
                            "reservation_id=${widget.rservationId}&coupon_id=${reservationModelProvider!.coupon!.id}"))
                        : Uint8List.fromList(utf8
                            .encode("reservation_id=${widget.rservationId}")),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      "Accept": " application/json",
                    }
                    ),

                pullToRefreshController: pullToRefreshController,
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
                  log("PATH${url!.path}");
                  log("query${url.query}");
                  bool isSuccess = url.query.contains('success');
                  bool isFailed = url.query.contains('fail');
                  bool isCancel = url.query.contains('cancel');

                  if (isSuccess) {
                    CustomNavigator.push(Routes.SUCCESS,
                        replace: true,
                        arguments: SuccessModel(
                            isPopUp: true,
                            isCongrats: true,
                            isClean: true,
                            routeName: Routes.DASHBOARD,
                            argument: 1,
                            term: sl<RequestDetailsProvider>()
                                    .requestModel
                                    ?.driverModel
                                    ?.firstName ??
                                "",
                            btnText: getTranslated("my_trips", context),
                            description: "${getTranslated(
                                "trip_was_successfully_paid_for_captain",
                                context)} ${sl<RequestDetailsProvider>()
                                .requestModel
                                ?.driverModel
                                ?.firstName}"));
                  } else if (isFailed || isCancel) {
                    CustomNavigator.push(Routes.SUCCESS,
                        replace: true,
                        arguments: SuccessModel(
                            isFail: true,
                            isReplace: true,
                            isPopUp: true,
                            routeName: Routes.PAYMENT,
                            description: getTranslated(
                                "failed_to_pay_for_the_trip", context)));
                  }
                },
                onConsoleMessage: (controller, consoleMessage) {
                  log("$consoleMessage");
                },
                onCloseWindow: (InAppWebViewController) {},
              ),
              progress < 1.0
                  ? LinearProgressIndicator(
                      value: progress,
                      color: ColorResources.PRIMARY_COLOR,
                      backgroundColor: Colors.red.shade50,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
