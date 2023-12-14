import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:fitariki/app/core/utils/app_snack_bar.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../helpers/permission_handler.dart';

class DownloadProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  bool isLoading = false;
  bool downloaded = false;
  void download(url, name) async {
    if (await PermissionHandler.checkFilePermission()) {
      isLoading = true;
      String path = "";
      if (Platform.isAndroid) {
        path =
            '${await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS)}/في طريقي/fitariki.$name';
      } else {
        Directory documents = await getApplicationDocumentsDirectory();
        path = '${documents.path}/في طريقي/fitariki.$name}';
      }
      try {
        log(path);

        await _dio.download(
          url ?? "",
          path,
          onReceiveProgress: (v1, v2) {
            // if (v2.abs() == 100) {
            //   downloaded = true;
            //   notifyListeners();
            // }
          },
          options: Options(
            headers: {
              HttpHeaders.acceptEncodingHeader: "*",
            },
          ),
        );

        isLoading = false;
        downloaded = true;
        notifyListeners();
      } catch (e) {
        log(e.toString());
        showToast(getTranslated("something_went_wrong",
            CustomNavigator.navigatorState.currentContext!));
        isLoading = false;
        notifyListeners();
      }
    }
  }
}
