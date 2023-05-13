import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../../components/custom_app_bar.dart';
import '../widegts/ratting_card.dart';

class Ratting extends StatelessWidget {
  const Ratting({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: title,
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 16.h),
            physics: const BouncingScrollPhysics(),
            children: [
              ...List.generate(
                  5,
                  (index) => RattingCard(
                        isSeen: index == 0 || index == 1 ? false : true,
                      ))
            ],
          ))
        ],
      ),
    );
  }
}
