import 'package:flutter/cupertino.dart';
import 'captain_card_widget.dart';

class CaptainsWidgets extends StatelessWidget {
  const CaptainsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      padding: const EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      children: [...List.generate(15, (index) => const CaptainCardWidget())],
    ));
  }
}
