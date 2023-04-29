import 'dart:async';

import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../main_widgets/custom_images.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.028734648456997, 31.37266017021682),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        children: [
          SizedBox(
            width: context.width,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                zoomControlsEnabled: false,
              ),
            ),
          ),
          const SizedBox(height: 16,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customImageIconSVG(
                imageName: SvgImages.sparkles,
                color: ColorResources.PRIMARY_COLOR,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                getTranslated(
                    "the_captains_starting_point_is_further_away_from_you",
                    context),
                maxLines: 1,
                style: AppTextStyles.w400.copyWith(
                    fontSize: 10,
                    color: ColorResources.HINT_COLOR,
                    overflow: TextOverflow.ellipsis),
              ),
              Text(
                " 2.5 كيلو ",
                maxLines: 1,
                style: AppTextStyles.w600.copyWith(
                    fontSize: 10,
                    color: ColorResources.PRIMARY_COLOR,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 8,),

        ],
      ),
    );
  }
}
