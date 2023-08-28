import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/features/transactions/repo/transactions_repo.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../repo/tracking_repo.dart';

class TrackingProvider extends ChangeNotifier {
  final TrackingRepo repo;

  TrackingProvider({required this.repo});

  bool get isDriver => repo.isDriver();
}
