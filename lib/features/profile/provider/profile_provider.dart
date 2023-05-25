import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/features/profile/model/bank_model.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/loading_dialog.dart';
import '../../../data/error/failures.dart';
import '../../../main_providers/schedule_provider.dart';
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
    getRoleType();
    getProfile();
    getBanks();
    getCountries();
  }

  ///Get Role Type

  String? role;


  getRoleType() {
    role = profileRepo.getRoleType();
    notifyListeners();
  }

  bool get isLogin => profileRepo.isLoggedIn();
  bool get isDriver =>  profileRepo.isDriver();

  String? get roleType => profileRepo.getRoleType();

  ///Car Data
  TextEditingController carName = TextEditingController();
  TextEditingController carPlate = TextEditingController();

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

  TextEditingController fullName = TextEditingController();
  TextEditingController bankAccount = TextEditingController();

  Bank? bank;
  // List<String> banks = ["بنك الاهلي المصري", "بنك الرياض", "بنك QNB"];
  void selectedBank(  value) {
    bank = bankList[bankList.indexWhere((element) => element.name==value)];


    notifyListeners();
  }

  File? bankAccountImage;
  onSelectBankAccountImage(File? file) {
    bankAccountImage = file;
    notifyListeners();
  }

  ///Personal Data

  double rate = 0.0;
  double wallet = 0.0;
  String? lastUpdate;

  String? image;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController identityNumber = TextEditingController();

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

  Country? nationality;
  selectedNationality(value) {

    nationality = countryList[countryList.indexWhere((element) => element.name==value)];
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
  // checkData() {
  //   if (role == "driver") {
  //     if (profileImage == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار الصورةالشخصية!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (fullName == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال الاسم الثلاثي!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (age == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار العمر!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (nationality == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار الحنسية!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (identityNumber == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادحال رقم الهوية!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (identityImage == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار صورة الهوية!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (email == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال الايميل!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (startRoad == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال بداية الطريق!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (endRoad == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال نهاية الطريق!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (carName == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال اسم السيارة!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (carModel == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال موديل السيارة!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (carPlate == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال لوحة السيارة!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (carImage == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار صورة السيارة!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (carCapacity == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال سعة السيارة!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (licenceImage == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار صورة الرخصة!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (formImage == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار صورة الاستمارة!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (insuranceImage == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار صورة التأمين!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (quadrupleName == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال الاسم الرباعي!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (bankName == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار اسم البنك!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (bankAccount == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال رقم الحساب!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (bankAccountImage == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار صورة رقم الحساب!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (scheduleProvider.selectedDays.isEmpty) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار الايام!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //   } else {
  //     if (profileImage == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار الصورةالشخصية!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (firstName == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال الاسم الاول!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (lastName == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال الاسم الثاني!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (age == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار العمر!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (nationality == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار الحنسية!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (startRoad == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال بداية الطريق!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (endRoad == null) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء ادخال نهاية الطريق!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //     if (scheduleProvider.selectedDays.isEmpty) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: "برجاء اختيار الايام!",
  //               isFloating: true,
  //               backgroundColor: ColorResources.IN_ACTIVE,
  //               borderColor: Colors.transparent));
  //       return;
  //     }
  //   }
  // }

  updateTimes() {
    for (var element in scheduleProvider.selectedDays) {
      element.startTime = startTime.toString();
      element.endTime = endTime.toString();
    }
  }

  ///Update Profile
  updateProfile() async {
    try {
      updateTimes();
      spinKitDialog();
      isLoading = true;
      notifyListeners();

      // checkData();
      final carData = {
        "name": carName.text.trim(),
        "model": carModel,
        "pallet_number": carPlate.text.trim(),
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
        "name": fullName.text.trim(),
        "bank_id": bank?.id,
        "iban": "null",
        "swift": "null",
        "account_number": bankAccount.text.trim(),

      };

      final personalData = {
        role: {

          "first_name": firstName.text.trim(),
          "last_name": lastName.text.trim(),
          "email": email.text.trim(),
          "gender": gender,
          "age": age.text.trim(),
          "national": nationality?.name,
          "country_id": nationality?.id,
          "identity_number": identityNumber.text.trim(),

          if (role == "driver")
            "driver_days": List<dynamic>.from(
                scheduleProvider.selectedDays.map((x) => x.toJson())),
          if (role == "client")
            "client_days": List<dynamic>.from(
                scheduleProvider.selectedDays.map((x) => x.toJson())),
          "drop_off_location": endLocation!.toJson(),
          "pickup_location": startLocation!.toJson(),
          if (role == "driver") "car_info": carData,
          if (role == "driver") "bank_info": bankData
        }
      };
      FormData.fromMap({
        if (identityImage != null)
        "identity_image":
        await MultipartFile.fromFile(identityImage!.path),
        if (profileImage != null) "image":
        await MultipartFile.fromFile(profileImage!.path),
      });

      log(personalData.toString());
      Either<ServerFailure, Response> response =
          await profileRepo.updateProfile(body: personalData);
      response.fold((fail) {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));

        isLoading = false;
        notifyListeners();
      }, (response) {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "تم تحديث بياناتك بنجاح !",
                isFloating: true,
                backgroundColor: ColorResources.ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomNavigator.pop();
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
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

      if (role == "driver") {
        initDriverData();
      } else {
        initClientData();
      }
      isLoading = false;
      notifyListeners();
    });
  }
  List<Country> countryList=[];
  getCountries() async {
    countryList=[];
    Either<ServerFailure, Response> response = await profileRepo.getCountries();
    response.fold((l) => null, (response) {
      countryList=response.data['data']["countries"] == null ? [] : List<Country>.from(response.data['data']["countries"]!.map((x) => Country.fromJson(x)));
      profileModel = ProfileModel.fromJson(response.data['data']);
      if (role == "driver") {
        initDriverData();
      } else {
        initClientData();
      }

    });
  }
  List<Bank> bankList=[];
  getBanks() async {
    bankList=[];
    Either<ServerFailure, Response> response = await profileRepo.getBanks();
    response.fold((l) => null, (response) {
      profileModel = ProfileModel.fromJson(response.data['data']);
      bankList=response.data['data']["banks"] == null ? [] : List<Bank>.from(response.data['data']["banks"]!.map((x) => Bank.fromJson(x)));
      if (role == "driver") {
        initDriverData();
      } else {
        initClientData();
      }

    });
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

    startLocation = profileModel?.client?.pickupLocation;
    endLocation = profileModel?.client?.dropOffLocation;

    image = profileModel?.client?.image;
    firstName.text = profileModel?.client?.firstName ?? "";
    lastName.text = profileModel?.client?.lastName ?? "";
    age.text = profileModel?.client?.age ?? "";
    email.text = profileModel?.client?.email ?? "";
    phone.text = profileModel?.client?.phone ?? "";
    _gender = profileModel?.client?.gender ?? 0;
    rate = profileModel?.client?.rate ?? 0.0;
    wallet = profileModel?.client?.wallet ?? 0.0;
    lastUpdate = Methods.getDayCount(
      date: profileModel!.client!.updatedAt!,
    ).toString();
  }

  initDriverData() {
    scheduleProvider.selectedDays = profileModel?.driver?.driverDays ?? [];

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
    firstName.text = profileModel?.driver?.firstName ?? "";
    age.text = profileModel?.driver?.age ?? "";
    email.text = profileModel?.driver?.email ?? "";
    phone.text = profileModel?.driver?.phone ?? "";
    identityNumber.text = profileModel?.driver?.identityNumber ?? "";
    if(profileModel?.driver?.national!=null) {
      nationality = profileModel?.driver?.national;
    }
    _gender = profileModel?.driver?.gender ?? 0;
    rate = profileModel?.driver?.rate ?? 0.0;

    lastUpdate = Methods.getDayCount(
      date: profileModel?.driver?.updatedAt != null? profileModel!.driver!.updatedAt! :DateTime.now()
    ).toString();

    carName.text = profileModel?.driver?.carInfo?.name ?? "";
    carPlate.text = profileModel?.driver?.carInfo?.palletNumber ?? "";
    carModel = profileModel?.driver?.carInfo?.model;
    carCapacity = profileModel?.driver?.carInfo?.seatsCount;

    fullName.text = profileModel?.driver?.bankInfo?.fullName ?? "";
    bankAccount.text = profileModel?.driver?.bankInfo?.accountNumber ?? "";
    bank = profileModel?.driver?.bankInfo?.bank;
    notifyListeners();
  }
}
