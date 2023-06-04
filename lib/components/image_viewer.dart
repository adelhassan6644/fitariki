import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/components/custom_network_image.dart';
import 'package:flutter/material.dart';



class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key? key,
    required this.image,
    this.isFromInternet = false,
  }) : super(key: key);

  final dynamic image;
  final bool isFromInternet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isFromInternet
          ? Center(
              child: CustomNetworkImage.containerNewWorkImage(
                image: image,
                fit: BoxFit.fill,
                radius: 0,
                width: context.width,
                height: context.height*.8
              ),
            )
          : Image.file(
              image,
              fit: BoxFit.cover,
            ),
    );
  }
}
