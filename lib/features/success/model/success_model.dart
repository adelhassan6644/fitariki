class SuccessModel {
  String? title;
  bool isPopUp,isFail;
  String? term;
  String? description;
  String? btnText;
  Function()? onTap;
  SuccessModel({
    this.title,
    this.isPopUp = false,
    this.isFail = false,
    this.description,
    this.term,
    this.btnText,
    this.onTap,
  });
}
