import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../data/error/failures.dart';
import '../../../main_providers/schedule_provider.dart';
import '../../post_offer/provider/post_offer_provider.dart';
import '../../maps/models/address_model.dart';
import '../model/profile_model.dart';
import '../repo/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo editProfileRepo;
  final PostOfferProvider postOfferProvider;
  final ScheduleProvider scheduleProvider;
  ProfileProvider({
    required this.editProfileRepo,
    required this.postOfferProvider,
    required this.scheduleProvider,
  }) {
    getRoleType();
  }

  ///Get Role Type

  String? role;
  getRoleType() {
    role = editProfileRepo.getRoleType();
    notifyListeners();
  }

  ///Car Data
  String? carName;
  String? carPlate;

  File? carImage;
  onSelectCarImage(File? file) {
    carImage = file;
    notifyListeners();
  }

  String? carModel;
  List<String> models = [
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024"
  ];
  void selectedModel(value) {
    carModel = value;
    notifyListeners();
  }

  String? carCapacity;
  List<String> capacities = ["2", "3", "4", "5", "6", "6", "8"];
  void selectedCapacity(value) {
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
  String? quadrupleName;
  String? bankAccount;

  String? bankName;
  List<String> banks = ["بنك الاهلي المصري", "بنك الرياض", "بنك QNB"];
  void selectedBank(value) {
    bankName = value;
    notifyListeners();
  }

  File? bankAccountImage;
  onSelectBankAccountImage(File? file) {
    bankAccountImage = file;
    notifyListeners();
  }

  ///Road
  String? startRoad;
  String? endRoad;

  ///Personal Data

  String? image;
  String? firstName;
  String? secondName;
  String? fullName;
  String? email;
  String? identityNumber;

  File? profileImage;
  onSelectImage(File? file) {
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

  String? age;
  selectedAge(value) {
    age = value;
    notifyListeners();
  }

  String? nationality;
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

  checkData() {
    if (role == "driver") {
      if (profileImage == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار الصورةالشخصية!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (fullName == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال الاسم الثلاثي!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (age == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار العمر!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (nationality == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار الحنسية!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (identityNumber == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادحال رقم الهوية!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (identityImage == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار صورة الهوية!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (email == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال الايميل!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (startRoad == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال بداية الطريق!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (endRoad == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال نهاية الطريق!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (carName == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال اسم السيارة!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (carModel == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال موديل السيارة!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (carPlate == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال لوحة السيارة!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (carImage == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار صورة السيارة!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (carCapacity == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال سعة السيارة!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (licenceImage == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار صورة الرخصة!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (formImage == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار صورة الاستمارة!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (insuranceImage == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار صورة التأمين!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (quadrupleName == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال الاسم الرباعي!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (bankName == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار اسم البنك!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (bankAccount == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال رقم الحساب!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (bankAccountImage == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار صورة رقم الحساب!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (scheduleProvider.selectedDays.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار الايام!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
    } else {
      if (profileImage == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار الصورةالشخصية!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (firstName == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال الاسم الاول!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (secondName == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال الاسم الثاني!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (age == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار العمر!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (nationality == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار الحنسية!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (startRoad == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال بداية الطريق!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (endRoad == null) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء ادخال نهاية الطريق!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
      if (scheduleProvider.selectedDays.isEmpty) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "برجاء اختيار الايام!",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        return;
      }
    }
  }

  updateTimes() {
    for (var element in scheduleProvider.selectedDays) {
      element.startTime = startTime;
      element.endTime = endTime;
    }
  }

  ///Update Profile
  updateProfile() async {
    try {
      updateTimes();
      // checkData();
      final carData = {
        "name": carName,
        "model": carModel,
        "pallet_number": carPlate,
        "seats_count": carCapacity,
        if (carImage != null) "car_image": "cbvb",
        // await MultipartFile.fromFile(carImage!.path),
        if (formImage != null) "form_image": "cbvb",
        // await MultipartFile.fromFile(formImage!.path),
        if (insuranceImage != null) "insurance_image": "cb",
        // await MultipartFile.fromFile(insuranceImage!.path),
        if (licenceImage != null) "licence_image": "cb",
        // await MultipartFile.fromFile(licenceImage!.path),
      };

      final bankData = {
        "full_name": quadrupleName,
        "bank": bankName,
        "iban": "null",
        "swift": "null",
        "account_number": bankAccount,
        if (bankAccountImage != null) "account_image": "dsdsds",
        // await MultipartFile.fromFile(bankAccountImage!.path),
      };

      final personalData = {
        "driver": {
          "first_name": fullName,
          "last_name": fullName,
          "email": email,
          "gender": gender,
          "identity_number": identityNumber,
          "age": age,
          if (profileImage != null)
            "image": "cbb",
          // await MultipartFile.fromFile(profileImage!.path),
          if (role == "driver")
            "driver_days": List<dynamic>.from(
                scheduleProvider.selectedDays.map((x) => x.toJson())),
          if (role == "client")
            "client_days": List<dynamic>.from(
                scheduleProvider.selectedDays.map((x) => x.toJson())),
          "drop_off_location": endLocation!.toJson(),
          "pickup_location": startLocation!.toJson(),

          "car_info": carData,
          "bank_info": bankData
        }
      };

      print(personalData);
      FormData formData = FormData.fromMap(personalData);
      Either<ServerFailure, Response> response =
          await editProfileRepo.updateProfile(body: personalData);
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        profileModel = ProfileModel.fromJson(response.data['data']);
        initDriverData();
        initClientData();
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {}
  }

  ///Update Profile
  bool isLoading = false;
  ProfileModel? profileModel;
  getProfile() async {
    isLoading = true;
    notifyListeners();
    Either<ServerFailure, Response> response =
        await editProfileRepo.getProfile();
    response.fold((l) => null, (response) {
      profileModel = ProfileModel.fromJson(response.data['data']);
      initDriverData();
      isLoading = false;
      notifyListeners();
    });
  }

  initClientData() {
    scheduleProvider.selectedDays = profileModel?.client?.clientDays ?? [];
    startTime =
        profileModel?.client?.clientDays?[0].startTime ?? DateTime.now();
    endTime = profileModel?.client?.clientDays?[0].endTime ?? DateTime.now();

    image = profileModel?.client?.image;
    firstName = profileModel?.client?.firstName;
    secondName = profileModel?.client?.lastName;
    age = profileModel?.client?.age;
    nationality = profileModel?.client?.national;
    _gender = profileModel?.client?.gender ?? 0;

    startLocation = profileModel?.client?.pickupLocation;
    endLocation = profileModel?.client?.dropOffLocation;
  }

  initDriverData() {
    scheduleProvider.selectedDays = profileModel?.driver?.driverDays ?? [];
    startTime =
        profileModel?.driver?.driverDays?[0].startTime ?? DateTime.now();
    endTime = profileModel?.driver?.driverDays?[0].endTime ?? DateTime.now();

    startLocation = profileModel?.driver?.pickupLocation;
    endLocation = profileModel?.driver?.dropOffLocation;

    image = profileModel?.driver?.image;
    fullName =
        "${profileModel?.driver?.firstName} ${profileModel?.driver?.lastName}";
    nationality = profileModel?.driver?.national;
    _gender = profileModel?.driver?.gender ?? 0;
    age = profileModel?.driver?.age;
    bankName = profileModel?.driver?.bankInfo?.bank;
    carModel = profileModel?.driver?.carInfo?.model.toString();
    carCapacity = profileModel?.driver?.carInfo?.seatsCount.toString();
  }
}
