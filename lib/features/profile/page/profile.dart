import 'package:fitariki/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_card.dart';
import '../widgets/profile_options.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: const [
        ProfileCard(),
        ProfileOptions(),
      ],
    );
  }
}
