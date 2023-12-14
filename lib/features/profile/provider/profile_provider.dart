import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/data/error/api_error_handler.dart';
import 'package:fitariki/features/profile/model/bank_model.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:jhijri_picker/_src/_jWidgets.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/loading_dialog.dart';
import '../../../data/error/failures.dart';
import '../../../main_providers/schedule_provider.dart';
import '../../../navigation/routes.dart';
import '../../maps/models/location_model.dart';
import '../../post_offer/provider/post_offer_provider.dart';
import '../model/country_model.dart';
import '../model/profile_model.dart';
import '../repo/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;
  final PostOfferProvider postOfferProvider;
  final ScheduleProvider scheduleProvider;
  ProfileProvider({
    required this.profileRepo,
    required this.postOfferProvider,
    required this.scheduleProvider,
  }) {
    getBanks();
    getCountries();
    generateModels();
  }

  bool get isLogin => profileRepo.isLoggedIn();
  bool get isDriver => profileRepo.isDriver();
  String get id => profileRepo.getId();

  final TextEditingController phoneTEC = TextEditingController();

  String countryCode = "+966";
  String countryFlag = "SA";
  void onSelectCountry({required String id, required String code}) {
    countryCode = "+$code";
    countryFlag = id;
    notifyListeners();
  }

  ///Car Data
  TextEditingController carName = TextEditingController();
  TextEditingController plateNumber = TextEditingController();
  TextEditingController plateLetterLeft = TextEditingController();
  TextEditingController plateLetterMiddle = TextEditingController();
  TextEditingController plateLetterRight = TextEditingController();
  TextEditingController carSequenceNumber = TextEditingController();
  TextEditingController carColor = TextEditingController();

  File? carImage;
  onSelectCarImage(File? file) {
    profileModel?.driver?.carInfo?.carImage = file!.path;

    carImage = file;
    notifyListeners();
  }

  DateTime? birthDay;
  String? hijriBirthDay;
  onSelectBirthDay() async {
    await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: CustomNavigator.navigatorState.currentContext!,
      locale: const Locale("ar", "SA"),
      cancelText: getTranslated(
          "cancel", CustomNavigator.navigatorState.currentContext!),
      initialDate: birthDay ?? DateTime(2001, 1, 13),
      firstDate: DateTime(1950, 1, 1),
      fieldLabelText: getTranslated(
          "birthday", CustomNavigator.navigatorState.currentContext!),
      lastDate: DateTime.now(),
    ).then((v) {
      if (v != null) {
        birthDay = v;
        hijriBirthDay =
            "${JHijri(fDate: birthDay ?? DateTime.now()).year}/${JHijri(fDate: birthDay ?? DateTime.now()).month}/${JHijri(fDate: birthDay ?? DateTime.now()).day}";
        notifyListeners();
        debugPrint(hijriBirthDay.toString());
      }
    });
    notifyListeners();
  }

  onSelectHijriBirthDay() async {
    showGlobalDatePicker(
      context: CustomNavigator.navigatorState.currentContext!,
      selectedDate:
          JDateModel(jhijri: JHijri(fDate: birthDay ?? DateTime.now())),
      pickerMode: DatePickerMode.day,
      pickerTheme: Theme.of(
        CustomNavigator.navigatorState.currentContext!,
      ),
      textDirection: TextDirection.rtl,
      locale: const Locale("ar", "SA"),
      okButtonText: "حسناً",
      cancelButtonText: "الغاء",
      onChange: (value) {
        debugPrint(value.toString());
        hijriBirthDay =
            "${value.jhijri.year}/${value.jhijri.month}/${value.jhijri.day}";
        notifyListeners();
      },
      onOk: (value) {
        notifyListeners();
        CustomNavigator.pop();
      },
      onCancel: () {
        CustomNavigator.pop();
      },
      primaryColor: Styles.PRIMARY_COLOR,
      borderRadius: const Radius.circular(10),
      headerTitle: const Center(
        child: Text(
          "التقويم الهجري",
        ),
      ),
    ).then((value) {
      if (value != null) {
        hijriBirthDay =
            "${value.jhijri.year}/${value.jhijri.month}/${value.jhijri.day}";
        notifyListeners();
      }
    });

    notifyListeners();
  }

  DateTime carModel2 = DateTime.now();

  String? carModel;
  List<String> models = [];

  generateModels() {
    for (var i = 0; i < 30; i++) {
      models.add(((DateTime.now().year + 1) - i).toString());
    }
    notifyListeners();
  }

  void selectedModel(value) {
    carModel = value;
    notifyListeners();
  }

  String? carCapacity;
  List<String> seats = ["2", "3", "4", "5", "6", "7", "8"];
  void selectedSeat(value) {
    carCapacity = value;
    notifyListeners();
  }

  File? licenceImage;
  onSelectLicenceImage(File? file) {
    licenceImage = file;
    notifyListeners();
  }

  File? formImage;
  onSelectFormImage(File? file) {
    formImage = file;
    notifyListeners();
  }

  File? insuranceImage;
  onSelectInsuranceImage(File? file) {
    insuranceImage = file;
    notifyListeners();
  }

  ///Bank Data

  TextEditingController fullName = TextEditingController();
  TextEditingController bankAccount = TextEditingController();

  bool hasData = false;
  focus() {
    if (bankAccount.text.isNotEmpty) {
      hasData = true;
    } else {
      hasData = false;
    }
    notifyListeners();
  }

  Bank? bank;
  void selectedBank(value) {
    bank = value;
    notifyListeners();
  }

  File? bankAccountImage;
  onSelectBankAccountImage(File? file) {
    profileModel?.driver?.bankInfo?.accountImage = file!.path;
    bankAccountImage = file;
    notifyListeners();
  }

  ///Personal Data

  double rate = 0.0;
  double wallet = 0.0;
  double pendingWallet = 0.0;
  int reservationCount = 0;
  int requestsCount = 0;
  String? lastUpdate;
  String? status;

  String? image;
  // TextEditingController nickName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController identityNumber = TextEditingController();

  File? profileImage;
  onSelectImage(File? file) {
    isDriver
        ? profileModel?.driver?.image = file!.path
        : profileModel?.client?.image = file!.path;

    profileImage = file;
    notifyListeners();
  }

  List<String> genders = ["male", "female"];
  List<String> genderIcons = [SvgImages.maleIcon, SvgImages.femaleIcon];
  int _gender = 0;
  int get gender => _gender;
  selectedGender(int value) {
    _gender = value;
    notifyListeners();
  }

  Country? nationality;
  selectedNationality(value) {
    nationality = value;
    notifyListeners();
  }

  File? identityImage;
  onSelectIdentityImage(File? file) {
    identityImage = file;
    notifyListeners();
  }

  LocationModel? startLocation;
  onSelectStartLocation(v) {
    startLocation = v;
    notifyListeners();
  }

  LocationModel? endLocation;
  onSelectEndLocation(v) {
    endLocation = v;
    notifyListeners();
  }

  ///Other Data

  DateTime startTime = DateTime.now();
  onSelectStartTime(v) {
    startTime = v;
    notifyListeners();
  }

  DateTime endTime = DateTime.now();
  onSelectEndTime(v) {
    endTime = v;
    notifyListeners();
  }

/*  List<String> timeZones = ["morning", "night"];
  String startTimeZone = "morning";
  String endTimeZone = "morning";
  void selectedStartTimeZone(String value) {
    startTimeZone = value;
    notifyListeners();
  }

  void selectedEndTimeZone(String value) {
    endTimeZone = value;
    notifyListeners();
  }*/

  clear() {
    ///personal data
    image = null;
    profileImage = null;
    // nickName.clear();
    firstName.clear();
    lastName.clear();
    age.clear();
    birthDay = null;
    hijriBirthDay = null;
    _gender = 0;
    phoneTEC.clear();
    countryCode = "+966";
    countryFlag = "SA";
    email.clear();
    nationality = null;
    identityNumber.clear();
    identityImage = null;
    startLocation = null;
    endLocation = null;
    scheduleProvider.selectedDays.clear();
    startTime = DateTime.now();
    endTime = DateTime.now();

    ///Car data
    carName.clear();
    carColor.clear();
    plateNumber.clear();
    plateLetterMiddle.clear();
    plateLetterLeft.clear();
    plateLetterRight.clear();
    carSequenceNumber.clear();
    carCapacity = null;
    carModel = null;
    carImage = null;
    licenceImage = null;
    formImage = null;
    insuranceImage = null;

    ///Bank data
    fullName.clear();
    bank = null;
    bankAccount.clear();
    bankAccountImage = null;
    profileModel = null;
    focus();
  }

  updateTimes() {
    for (var element in scheduleProvider.selectedDays) {
      element.startTime = startTime.toString();
      element.endTime = endTime.toString();
    }
  }

  checkData() {
    updateTimes();
    // if (!isDriver && profileImage == null) {
    //   if (profileModel?.client?.image == null) {
    //     CustomSnackBar.showSnackBar(
    //         notification: AppNotification(
    //             message: "برجاء اختيار الصورةالشخصية!",
    //             isFloating: true,
    //             backgroundColor: ColorResources.IN_ACTIVE,
    //             borderColor: Colors.transparent));
    //     return;
    //   }
    // }
    if (isDriver && profileImage == null) {
      if (isDriver && profileModel?.driver?.image == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار الصورةالشخصية!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
    }

    // if (nickName.text.isEmpty) {
    //   CustomSnackBar.showSnackBar(
    //       notification: AppNotification(
    //           message: "برجاء ادخال اسم الشهرة!",
    //           isFloating: true,
    //           backgroundColor: Styles.IN_ACTIVE,
    //           borderColor: Colors.transparent));
    //   return;
    // }
    if (firstName.text.isEmpty) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: isDriver
                  ? "برجاء ادخال اسمك الثلاثي !"
                  : "برجاء ادخال الاسم الاول !",
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (!isDriver) {
      if (lastName.text.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال الاسم الثاني !",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
    }

    if (age.text.isEmpty) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار العمر !",
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }

    if (isDriver && birthDay == null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار تاريخ الميلاد !",
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }

    if (nationality == null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار الحنسية !",
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (isDriver) {
      if (identityNumber.text.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادحال رقم الهوية !",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (identityImage == null) {
        if (profileModel?.driver?.identityImage == null) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: "برجاء اختيار صورة الهوية !",
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
          return;
        }
      }
    }
    if (email.text.isEmpty) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء ادخال الايميل!",
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (phoneTEC.text.isEmpty) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء ادخال رقم الجوال!",
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (startLocation == null ||
        startLocation?.address == null ||
        startLocation?.latitude == null ||
        startLocation?.longitude == null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء ادخال بداية الطريق!",
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (scheduleProvider.selectedDays.isEmpty) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار الايام!",
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (startTime.isAtSameMomentAs(endTime)) {
      showToast(" وقت النهاية لا يجب ان يكون مثل وقت البداية!");
      return;
    }
    if (endLocation == null ||
        endLocation?.address == null ||
        endLocation?.latitude == null ||
        endLocation?.longitude == null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء ادخال نهاية الطريق!",
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (isDriver) {
      ///Car Data
      if (carName.text.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال اسم السيارة!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (carImage == null) {
        if (profileModel?.driver?.carInfo?.carImage == null) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: "برجاء اختيار صورة السيارة!",
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
          return;
        }
      }
      if (licenceImage == null) {
        if (profileModel?.driver?.carInfo?.licenceImage == null) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: "برجاء اختيار صورة الرخصة!",
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
          return;
        }
      }
      if (carCapacity == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار سعة السيارة!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (carModel == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال موديل السيارة!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (plateLetterRight.text.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال الحرف الايمن من لوحة السيارة!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (plateLetterMiddle.text.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال الحرف الاوسط من لوحة السيارة!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (plateLetterLeft.text.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال الحرف الايسر من لوحة السيارة!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (plateNumber.text.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال أرقام لوحة السيارة!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (formImage == null) {
        if (profileModel?.driver?.carInfo?.formImage == null) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: "برجاء اختيار صورة الاستمارة!",
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
          return;
        }
      }
      if (carSequenceNumber.text.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال الرقم التسلسي للسيارة!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (carColor.text.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال لون السيارة!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (insuranceImage == null) {
        if (profileModel?.driver?.carInfo?.insuranceImage == null) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: "برجاء اختيار صورة التأمين!",
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
          return;
        }
      }

      ///Bank Data
      if (fullName.text.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال الاسم الرباعي!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (bank == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار اسم البنك!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (bankAccount.text.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال رقم الحساب!",
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (bankAccountImage == null) {
        if (profileModel?.driver?.bankInfo?.accountImage == null) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: "برجاء اختيار صورة رقم الحساب!",
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
          return;
        }
      }
    }
    return true;
  }

  ///Update Profile
  ///
  bool isLoadingProfile = false;
  updateProfile({bool fromRegister = false}) async {
    if (checkData() == true) {
      try {
        if (!fromRegister) {
          spinKitDialog();
        }
        isLoadingProfile = true;
        notifyListeners();

        final carData = {
          "name": carName.text.trim(),
          "model": carModel,
          "plateNumber": plateNumber.text.trim(),
          "plateLetterLeft": plateLetterLeft.text.trim(),
          "plateLetterMiddle": plateLetterMiddle.text.trim(),
          "plateLetterRight": plateLetterRight.text.trim(),
          "sequenceNumber": carSequenceNumber.text.trim(),
          "color": carColor.text.trim(),
          "seats_count": carCapacity,
        };

        final bankData = {
          "name": fullName.text.trim(),
          "bank_id": bank?.id,
          "iban": "null",
          "swift": "null",
          "account_number": bankAccount.text.trim(),
        };

        final personalData = {
          isDriver ? "driver" : "client": {
            "fcm_token": await profileRepo.saveDeviceToken(),
            // "nick_name": nickName.text.trim(),
            "first_name": firstName.text.trim(),
            "last_name": lastName.text.trim(),
            "dateOfBirthGregorian": birthDay?.gregorianFormat(),
            "dateOfBirthHijri": hijriBirthDay??"",
            "email": email.text.trim(),
            "phone": phoneTEC.text.trim(),
            "country_flag": countryFlag.trim(),
            "country_code": countryCode.trim(),
            "gender": gender,
            "age": age.text.trim(),
            "country_id": nationality?.id,
            "id_number": identityNumber.text.trim(),
            if (isDriver)
              "driver_days": List<dynamic>.from(
                  scheduleProvider.selectedDays.map((x) => x.toJson())),
            if (!isDriver)
              "client_days": List<dynamic>.from(
                  scheduleProvider.selectedDays.map((x) => x.toJson())),
            "drop_off_location": endLocation!.toJson(),
            "pickup_location": startLocation!.toJson(),
            if (isDriver) "car_info": carData,
            if (isDriver) "bank_info": bankData
          }
        };
        if (profileImage != null) {
          await profileRepo.updateProfile(
              body: FormData.fromMap({
            "image": await MultipartFile.fromFile(profileImage!.path),
          }));
        }
        if (carImage != null) {
          await profileRepo.updateProfile(
              body: FormData.fromMap({
            "car_image": await MultipartFile.fromFile(carImage!.path),
          }));
        }
        if (formImage != null) {
          await profileRepo.updateProfile(
              body: FormData.fromMap({
            "form_image": await MultipartFile.fromFile(formImage!.path),
          }));
        }
        if (insuranceImage != null) {
          await profileRepo.updateProfile(
              body: FormData.fromMap({
            "insurance_image":
                await MultipartFile.fromFile(insuranceImage!.path),
          }));
        }
        if (licenceImage != null) {
          await profileRepo.updateProfile(
              body: FormData.fromMap({
            "licence_image": await MultipartFile.fromFile(licenceImage!.path),
          }));
        }
        if (identityImage != null) {
          await profileRepo.updateProfile(
              body: FormData.fromMap({
            "id_image": await MultipartFile.fromFile(identityImage!.path),
          }));
        }
        if (bankAccountImage != null) {
          await profileRepo.updateProfile(
              body: FormData.fromMap({
            "account_image":
                await MultipartFile.fromFile(bankAccountImage!.path),
          }));
        }

        log(personalData.toString());
        Either<ServerFailure, Response> response =
            await profileRepo.updateProfile(body: personalData);
        response.fold((fail) {
          if (!fromRegister) {
            CustomNavigator.pop();
          }
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: (fail.error),
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
          isLoadingProfile = false;
          notifyListeners();
        }, (response) {
          if (fromRegister) {
            CustomNavigator.push(Routes.DASHBOARD, arguments: 0, clean: true);
          } else {
            CustomNavigator.pop();
          }
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated("successfully_updated",
                      CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: Styles.ACTIVE,
                  borderColor: Colors.transparent));
        });
        isLoadingProfile = false;
        notifyListeners();
      } catch (e) {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: e.toString(),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoadingProfile = false;
        notifyListeners();
      }
    }
  }

  ///Update Profile
  bool isLoading = false;
  ProfileModel? profileModel;
  getProfile() async {
    isLoading = true;
    notifyListeners();

    Either<ServerFailure, Response> response = await profileRepo.getProfile();
    response.fold((l) => null, (response) {
      profileModel = ProfileModel.fromJson(response.data['data']);
      notifyListeners();

      if (isDriver) {
        initDriverData();
      } else {
        initClientData();
      }
      isLoading = false;
      notifyListeners();
    });
  }

  List<Country> countryList = [];
  getCountries() async {
    countryList.clear();
    Either<ServerFailure, Response> response = await profileRepo.getCountries();
    response.fold((l) => null, (response) {
      countryList = response.data['data']["countries"] == null
          ? []
          : List<Country>.from(response.data['data']["countries"]!
              .map((x) => Country.fromJson(x)));
    });
    notifyListeners();
  }

  List<Bank> bankList = [];
  getBanks() async {
    bankList.clear();
    Either<ServerFailure, Response> response = await profileRepo.getBanks();
    response.fold((l) => null, (response) {
      bankList = response.data['data']["banks"] == null
          ? []
          : List<Bank>.from(
              response.data['data']["banks"]!.map((x) => Bank.fromJson(x)));
    });
    notifyListeners();
  }

  initClientData() {
    scheduleProvider.selectedDays = profileModel?.client?.clientDays ?? [];

    if (profileModel!.client!.clientDays!.isNotEmpty) {
      startTime = Methods.convertStringToTime(
              profileModel?.client?.clientDays?[0].startTime) ??
          DateTime.now();
      endTime = Methods.convertStringToTime(
              profileModel?.client?.clientDays?[0].endTime) ??
          DateTime.now();
    }

    status = profileModel?.client?.status;
    startLocation = profileModel?.client?.pickupLocation;
    endLocation = profileModel?.client?.dropOffLocation;
    nationality = profileModel?.client?.national;

    image = profileModel?.client?.image;
    // nickName.text = profileModel?.client?.nickname ?? "";
    firstName.text = profileModel?.client?.firstName ?? "";
    lastName.text = profileModel?.client?.lastName ?? "";
    age.text = profileModel?.client?.age ?? "";
    email.text = profileModel?.client?.email ?? "";
    phoneTEC.text = profileModel?.client?.phone ?? "";
    countryCode = profileModel?.client?.countryCode ?? "+966";
    countryFlag = profileModel?.client?.countryFlag ?? "SA";
    _gender = profileModel?.client?.gender ?? 0;
    rate = profileModel?.client?.rate ?? 0.0;
    requestsCount = profileModel?.client?.requestsCount ?? 0;
    reservationCount = profileModel?.client?.reservationsCount ?? 0;
    lastUpdate = Methods.getDayCount(
      date: profileModel!.client!.updatedAt!,
    ).toString();
  }

  initDriverData() {
    scheduleProvider.selectedDays = profileModel?.driver?.driverDays ?? [];
    status = profileModel?.driver?.status;

    if (scheduleProvider.selectedDays.isNotEmpty) {
      startTime = Methods.convertStringToTime(
              profileModel?.driver?.driverDays?[0].startTime) ??
          DateTime.now();
      endTime = Methods.convertStringToTime(
              profileModel?.driver?.driverDays?[0].endTime) ??
          DateTime.now();
    }

    startLocation = profileModel?.driver?.pickupLocation;
    endLocation = profileModel?.driver?.dropOffLocation;

    image = profileModel?.driver?.image;
    // nickName.text = profileModel?.driver?.nickname ?? "";
    firstName.text = profileModel?.driver?.firstName ?? "";
    age.text = profileModel?.driver?.age ?? "";
    birthDay = profileModel?.driver?.birthDay;
    hijriBirthDay = profileModel?.driver?.hijriBirthDay;
    email.text = profileModel?.driver?.email ?? "";
    phoneTEC.text = profileModel?.driver?.phone ?? "";
    countryCode = profileModel?.driver?.countryCode ?? "+966";
    countryFlag = profileModel?.driver?.countryFlag ?? "SA";
    identityNumber.text = profileModel?.driver?.identityNumber ?? "";
    nationality = profileModel?.driver?.national;
    _gender = profileModel?.driver?.gender ?? 0;
    rate = profileModel?.driver?.rate ?? 0.0;
    requestsCount = profileModel?.driver?.requestsCount ?? 0;
    reservationCount = profileModel?.driver?.reservationsCount ?? 0;
    wallet = profileModel?.driver?.wallet ?? 0.0;
    pendingWallet = profileModel?.driver?.pendingWallet ?? 0.0;
    lastUpdate = Methods.getDayCount(
            date: profileModel?.driver?.updatedAt != null
                ? profileModel!.driver!.updatedAt!
                : DateTime.now())
        .toString();

    carName.text = profileModel?.driver?.carInfo?.name ?? "";
    plateNumber.text = profileModel?.driver?.carInfo?.palletNumber ?? "";
    plateLetterLeft.text = profileModel?.driver?.carInfo?.plateLetterLeft ?? "";
    plateLetterMiddle.text =
        profileModel?.driver?.carInfo?.plateLetterMiddle ?? "";
    plateLetterRight.text =
        profileModel?.driver?.carInfo?.plateLetterRight ?? "";
    carSequenceNumber.text =
        profileModel?.driver?.carInfo?.sequenceNumber ?? "";
    carColor.text = profileModel?.driver?.carInfo?.color ?? "";
    carModel = profileModel?.driver?.carInfo?.model;
    carCapacity = profileModel?.driver?.carInfo?.seatsCount;

    fullName.text = profileModel?.driver?.bankInfo?.fullName ?? "";
    bankAccount.text = profileModel?.driver?.bankInfo?.accountNumber ?? "";
    focus();
    bank = profileModel?.driver?.bankInfo?.bank;
    notifyListeners();
  }
}
