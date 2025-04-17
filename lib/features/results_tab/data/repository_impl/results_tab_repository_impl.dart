import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart';
import 'package:trait_lens/core/helpers/connectivity_helper.dart';
import 'package:trait_lens/features/ai_detection/data/models/detection_result_model.dart';
import 'package:trait_lens/features/results_tab/data/data_source/results_tab_data_source.dart';
import 'package:trait_lens/features/results_tab/domain/repository/results_tab_repository.dart';

@Injectable(as: ResultsTabRepository)
class ResultsTabRepositoryImpl implements ResultsTabRepository {
  final ResultsTabDataSource _dataSource;

  @factoryMethod
  const ResultsTabRepositoryImpl(this._dataSource);

  @override
  Future<Either<ServerException, List<DetectionResultModel>>>
      getUserResults() async {
    if (await ConnectivityHelper.checkInternetConnection()) {
      final either = await _dataSource.getUserResults();

      return either.fold(
        (error) => Left(ServerException(error.message)),
        (result) => Right(result),
      );
    } else {
      return const Left(NoInternetConnectionException());
    }
  }
}
