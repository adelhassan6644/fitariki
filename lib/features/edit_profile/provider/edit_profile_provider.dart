import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../maps/models/address_model.dart';
import '../repo/edit_profile_repo.dart';

class EditProfileProvider extends ChangeNotifier {
  final EditProfileRepo editProfileRepo;
  EditProfileProvider({
    required this.editProfileRepo,
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
  List<String> models = ["2022", "2023", "2024"];
  void selectedModel(value) {
    carModel = value;
    notifyListeners();
  }

  String? carCapacity;
  List<String> capacities = ["2", "4", "6"];
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

  AddressModel? startLocation;
  onSelectStartLocation(v){
    startLocation = v;
    notifyListeners();
  }

  AddressModel? endLocation;
  onSelectEndLocation(v){
    endLocation = v;
    notifyListeners();
  }

  ///Other Data
  List<String> days = [
    "السبت",
    "الاحد",
    "الاثنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس",
    "الجمعة",
  ];
  List<String> selectedDays = [];

  onSelectDay(String value) {
    if (selectedDays.contains(value)) {
      selectedDays.remove(value);
    } else {
      selectedDays.add(value);
    }
    notifyListeners();
  }

  checkSelectDay(String value) {
    if (selectedDays.contains(value)) {
      return true;
    } else {
      return false;
    }
  }

  List<String> timeZones = ["morning", "night"];
  String startTimeZone = "morning";
  String endTimeZone = "morning";
  void selectedStartTimeZone(String value) {
    startTimeZone = value;
    notifyListeners();
  }

  void selectedEndTimeZone(String value) {
    endTimeZone = value;
    notifyListeners();
  }

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
      if (selectedDays.isEmpty) {
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
      if (selectedDays.isEmpty) {
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

  ///Update Profile
  updateProfile() async {
    try {
      checkData();
      final personalData = {
        "first_name": firstName,
        "second_name": secondName,
        "email": email,
        "gender": gender,
        "identity_number": identityNumber,
        "age": age,
      };

      final carData = {
        "car_name": carName,
        "car_model": carModel,
        "car_plate": carPlate,
        "car_capacity": carCapacity,
      };

      final bankData = {
        "quadruple_name": quadrupleName,
        "bank_name": bankName,
        "bank_account": bankAccount,
      };

      final otherData = {
        "days": selectedDays.toString(),
        "start_data": startTimeZone,
        "end_data": endTimeZone,
        "start_road": startRoad,
        "end_road": endRoad,
      };


      final values = {...personalData,...carData,...bankData,...otherData};
      Map<String, dynamic> params = Map.from(values);

      FormData formData = FormData.fromMap(params);
      formData.files.addAll([
       if(profileImage != null) MapEntry("image", await MultipartFile.fromFile(profileImage!.path)),
        if(identityImage != null)  MapEntry("identity_image", await MultipartFile.fromFile(identityImage!.path)),
        if(carImage != null) MapEntry("car_image", await MultipartFile.fromFile(carImage!.path)),
        if(licenceImage != null)  MapEntry("license_image", await MultipartFile.fromFile(licenceImage!.path)),
        if(formImage != null) MapEntry("form_image", await MultipartFile.fromFile(formImage!.path)),
        if(insuranceImage != null) MapEntry("insurance_image", await MultipartFile.fromFile(insuranceImage!.path)),
      ]);

    } catch (e) {}
  }
}
