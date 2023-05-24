import 'package:flutter/cupertino.dart';

class PaymentProvider extends ChangeNotifier {


  TextEditingController discountCode = TextEditingController();

  int currentPayment = 0;
  onSelectPayment(index) {
    currentPayment = index;
    notifyListeners();
  }

}
