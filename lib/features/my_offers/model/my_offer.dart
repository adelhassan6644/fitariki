import '../../../main_models/offer_model.dart';

class MyOffersModel {
  List<OfferModel>? offers;

  MyOffersModel({this.offers});

  MyOffersModel.fromJson(Map<String, dynamic> json) {
    if (json['offers'] != null) {
      offers = [];
      json['offers'].forEach((v) {
        offers!.add(OfferModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}