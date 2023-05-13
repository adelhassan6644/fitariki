import 'package:fitariki/app/core/utils/color_resources.dart';
import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'custom_images.dart';

class EmptyWidget extends StatelessWidget {
  final String? img;
  final double? imgHeight;
  final double? emptyHeight;
  final double? imgWidth;
  final bool isSvg;
  final double? spaceBtw;
  final String? txt;
  final String? subText;

  const EmptyWidget(
      {Key? key,
      this.emptyHeight,
      this.spaceBtw,
      this.isSvg = false,
      this.img,
      this.imgHeight,
      this.imgWidth,
      this.txt,
      this.subText,
    })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: emptyHeight, // MediaQueryHelper.height - remain!,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !isSvg
                  ? customImageIcon(
                      imageName: img ?? "",
                      width: imgWidth,
                      height:imgHeight) //width: MediaQueryHelper.width*.8,),
                  : customImageIconSVG(imageName: img ??""),
              SizedBox(height: spaceBtw ?? 35.h),
              Text(txt ?? "نعتذر , لا يوجد اسر الان !",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
               SizedBox(height: 8.h),
              Text(subText ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      color: ColorResources.DETAILS_COLOR,
                      fontWeight: FontWeight.w400))
            ],
          ),
        ),
      ),
    );
  }
}
