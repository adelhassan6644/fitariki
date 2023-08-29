import 'package:flutter/material.dart';
import '../app/core/utils/color_resources.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../features/maps/models/location_model.dart';
import 'custom_images.dart';
import 'package:map_launcher/map_launcher.dart' as mapLaunch;

class AddressPointerWidget extends StatelessWidget {
  const AddressPointerWidget(
      {super.key, required this.location, this.trailerColor, this.trailer});
  final LocationModel? location;
  final String? trailer;
  final Color? trailerColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            bool? isActive = await mapLaunch.MapLauncher.isMapAvailable(
                mapLaunch.MapType.google);
            bool? isAppleActive = await mapLaunch.MapLauncher.isMapAvailable(
                mapLaunch.MapType.apple);
            if (isActive!) {
              await mapLaunch.MapLauncher.showDirections(
                mapType: mapLaunch.MapType.google,
                destination: mapLaunch.Coords(
                  double.parse(location?.latitude ?? "0"),
                  double.parse(location?.longitude ?? "0"),
                ),
                destinationTitle: location?.address ?? "",
              );
            } else if (isAppleActive!) {
              await mapLaunch.MapLauncher.showDirections(
                // mapType: MapType.apple,
                destination: mapLaunch.Coords(
                  double.parse(location?.latitude ?? "0"),
                  double.parse(location?.longitude ?? "0"),
                ),
                destinationTitle: location?.address ?? "",
                mapType: mapLaunch.MapType.apple,
              );
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              customImageIconSVG(
                  imageName: SvgImages.dotIcon, width: 10, height: 10),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location?.address ?? "",
                  style: AppTextStyles.w400.copyWith(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                      height: 1.4,
                      color: Styles.DISABLED),
                ),
              ),
              const SizedBox(width: 8),

              ///Status
              trailer != null
                  ? Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: trailerColor?.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        trailer ?? "",
                        style: AppTextStyles.w400
                            .copyWith(fontSize: 10, color: trailerColor),
                      ),
                    )
                  : const SizedBox(width: 35),
            ],
          ),
        ),
      ],
    );
  }
}
