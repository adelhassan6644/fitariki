class SuccessModel {
  bool? isCongrats;
  bool? isReplace = false;
  bool? isClean = false;
  String? title, btnText, routeName;
  String? description;
  dynamic argument;
  SuccessModel(
      {this.isCongrats,
      this.title,
      this.btnText,
      this.routeName,
      this.argument,
      this.isClean,
      this.isReplace,
      this.description});
}
