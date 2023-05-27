class SuccessModel {
  bool isCongrats;
  bool isPopUp ;
  bool? isReplace = false;
  bool? isClean = false;
  String? title, btnText, routeName;
  String? description;
  dynamic argument;
  SuccessModel(
      {this.isCongrats = true,
      this.title,
      this.btnText,
      this.isPopUp = false,
      this.routeName,
      this.argument,
      this.isClean,
      this.isReplace,
      this.description});
}
