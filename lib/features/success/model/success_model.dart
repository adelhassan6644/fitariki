class SuccessModel {
  bool isCongrats;
  bool isFail;
  bool isPopUp;
  bool isReplace;
  bool isClean;
  String? term, btnText, routeName;
  String? description;
  dynamic argument;
  SuccessModel({
    this.isCongrats = true,
    this.isFail = false,
    this.btnText,
    this.isPopUp = false,
    this.routeName,
    this.argument,
    this.isClean = false,
    this.isReplace = false,
    this.description,
    this.term,
  });
}
