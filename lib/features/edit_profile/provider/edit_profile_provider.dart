import 'package:fitariki/features/edit_profile/repo/profile_repo.dart';
import 'package:flutter/cupertino.dart';

class EditProfileProvider extends ChangeNotifier{
  final EditProfileRepo editProfileRepo;
  EditProfileProvider({required this.editProfileRepo,});

   String? profileImage;

}