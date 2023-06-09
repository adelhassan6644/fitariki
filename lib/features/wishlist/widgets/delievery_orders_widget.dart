import 'package:flutter/cupertino.dart';
import '../../../main_models/offer_model.dart';
import '../../../main_widgets/offer_card.dart';

class DeliveryOrdersWidgets extends StatelessWidget {
  const DeliveryOrdersWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      padding: const EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      children: [
        ...List.generate(
          15,
          (index) => OfferCard(
              isSaved: true,
              offerModel: OfferModel(
                name: "ll",
                duration: 6,
              )),
        )
      ],
    ));
  }
}
