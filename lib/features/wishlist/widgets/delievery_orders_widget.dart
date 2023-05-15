import 'package:fitariki/features/maps/models/address_model.dart';
import 'package:flutter/cupertino.dart';
import '../../../main_models/offer_model.dart';
import '../../../main_models/weak_model.dart';
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
            (index) =>  OfferCard(
                  isSaved: true, offerModel: OfferModel(name: "ll",duration: 6,dropOff: LocationModel(latitude: "",longitude: "",address: "aa"),
                dropOn: LocationModel(latitude: "",longitude: "",address: "aa"),
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              driverId: 1,offerType: 1,offerDays: [ WeekModel(
                  id: 6,
                  dayName: "السبت",
                  startTime: DateTime.now(),
                  endTime: DateTime.now(),
                ),]


            ),
                )),
      ],
    ));
  }
}
