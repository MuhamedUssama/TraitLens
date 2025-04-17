import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/core/utils/firebase_services.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';
import 'package:trait_lens/features/results_tab/data/data_source/results_tab_data_source.dart';

@LazySingleton(as: ResultsTabDataSource)
class ResultsTabDataSourceImpl implements ResultsTabDataSource {
  @override
  Future<Either<ServerException, List<DetectionResultModel>>>
      getUserResults() async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot<DetectionResultModel> querySnapshot =
          await FireBaseService.getUserReslutsCollection(userId).get();

      List<DetectionResultModel> results =
          querySnapshot.docs.map((result) => result.data()).toList();

      return Right(results);
    } catch (error) {
      log(error.toString());
      return const Left(FetchDataException());
    }
  }
}
