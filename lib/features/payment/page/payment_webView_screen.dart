import 'dart:collection';
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
import 'package:webview_flutter/src/webview.dart';

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

          // //
          // ios: IOSInAppWebViewOptions(applePayAPIEnabled: true),
          // crossPlatform: InAppWebViewOptions(
          //     useShouldOverrideUrlLoading: true, useOnLoadResource: true),
          //
          //
          // javaScriptEnabled: true,
          // userAgent:
          //     'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
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
  bool _isLoading = true;

  WebViewController? controllerGlobal;
  late MyInAppBrowser browser;
  void _initData() async {
    browser = MyInAppBrowser(context);
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      bool swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      bool swInterceptAvailable =
          await AndroidWebViewFeature.isFeatureSupported(
              AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController =
            AndroidServiceWorkerController.instance();
        await serviceWorkerController
            .setServiceWorkerClient(AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            return null;
          },
        ));
      }
    }

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.black,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          browser.webViewController.reload();
        } else if (Platform.isIOS) {
          browser.webViewController.loadUrl(
              urlRequest:
                  URLRequest(url: await browser.webViewController.getUrl()));
        }
      },
    );
    browser.pullToRefreshController = pullToRefreshController;

    await browser.openUrlRequest(
      urlRequest: URLRequest(
        url: (reservationModelProvider!.coupon != null)
            ? Uri.parse(wiselectedUrl +
                "?reservation_id=${widget.rservationId}&coupon_id=${reservationModelProvider!.coupon!.id}")
            : Uri.parse(
                wiselectedUrl + "?reservation_id=${widget.rservationId}"),
      ),
      options: InAppBrowserClassOptions(
        inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          ios: IOSInAppWebViewOptions(applePayAPIEnabled: true),
          crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true, useOnLoadResource: true),
        ),
      ),
    );
  }

  @override
  void initState() {
    reservationModelProvider =
        Provider.of<PaymentProvider>(context, listen: false);

    wiselectedUrl = "${EndPoints.baseUrl}client/OfferTapPayment";

    log(wiselectedUrl);
    // _initData();
    super.initState();
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
                  url: (reservationModelProvider!.coupon != null)
                      ? Uri.parse(wiselectedUrl +
                          "?reservation_id=${widget.rservationId}&coupon_id=${reservationModelProvider!.coupon!.id}")
                      : Uri.parse(wiselectedUrl +
                          "?reservation_id=${widget.rservationId}"),
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
                                    ?.firstName?.split(" ")[0] ??
                                sl<RequestDetailsProvider>()
                                    .requestModel
                                    ?.offer
                                    ?.driverModel
                                    ?.firstName?.split(" ")[0] ??
                                "",
                            btnText: getTranslated("my_trips", context),
                            description:
                                "${getTranslated("trip_was_successfully_paid_for_captain", context)} ${sl<RequestDetailsProvider>().requestModel?.driverModel?.firstName?.split(" ")[0] ?? sl<RequestDetailsProvider>().requestModel?.offer?.driverModel?.firstName?.split(" ")[0] ?? ""}"));
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
                      color: Styles.PRIMARY_COLOR,
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

class MyInAppBrowser extends InAppBrowser {
  final BuildContext context;

  MyInAppBrowser(
    this.context, {
    int? windowId,
    UnmodifiableListView<UserScript>? initialUserScripts,
  }) : super(windowId: windowId, initialUserScripts: initialUserScripts);

  bool _canRedirect = true;

  @override
  Future onBrowserCreated() async {
    print("\n\nBrowser Created!\n\n");
  }

  @override
  Future onLoadStart(url) async {
    print("\n\nStarted: $url\n\n");
    _pageRedirect(url.toString());
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    print("\n\nStopped: $url\n\n");
    _pageRedirect(url.toString());
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
    print("Can't load [$url] Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }
    print("Progress: $progress");
  }

  @override
  void onExit() {
    if (_canRedirect) {
      CustomNavigator.push(Routes.SUCCESS,
          replace: true,
          arguments: SuccessModel(
              isFail: true,
              isReplace: true,
              isPopUp: true,
              // routeName: Routes.PAYMENT,
              description:
                  getTranslated("failed_to_pay_for_the_trip", context)));
    }

    print("\n\nBrowser closed!\n\n");
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      navigationAction) async {
    print("\n\nOverride ${navigationAction.request.url}\n\n");
    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(response) {
    // print("Started at: " + response.startTime.toString() + "ms ---> duration: " + response.duration.toString() + "ms " + (response.url ?? '').toString());
  }

  @override
  void onConsoleMessage(consoleMessage) {
    print("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }

  void _pageRedirect(String url) {
    if (_canRedirect) {
      log("PATH${url}");
      log("query${url}");
      bool isSuccess = url.contains('success');
      bool isFailed = url.contains('fail');
      bool isCancel = url.contains('cancel');

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
                description:
                    "${getTranslated("trip_was_successfully_paid_for_captain", context)} ${sl<RequestDetailsProvider>().requestModel?.driverModel?.firstName}"));
      } else if (isFailed || isCancel) {
        CustomNavigator.push(Routes.SUCCESS,
            replace: true,
            arguments: SuccessModel(
                isFail: true,
                isReplace: true,
                isPopUp: true,
                argument: 2,
                // routeName: Routes.PAYMENT,
                description:
                    getTranslated("failed_to_pay_for_the_trip", context)));
      }
    }
  }
}
