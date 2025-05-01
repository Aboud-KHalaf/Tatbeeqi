import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/exceptions.dart';
import 'package:tatbeeqi/core/error/failures.dart'; // Assuming you have this
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';
import 'package:tatbeeqi/features/news/data/datasources/news_remote_data_source.dart';
import 'package:tatbeeqi/features/news/domain/repositories/news_repository.dart';
// Add network info check if needed: import 'package:tatbeeqi/core/network/network_info.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo; // Optional: Inject if you check connectivity

  NewsRepositoryImpl({
    required this.remoteDataSource,
    // required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<NewsItemEntity>>> getNewsItems() async {
    // Optional: Check network connectivity first
    // if (await networkInfo.isConnected) {
    try {
      final remoteNews = await remoteDataSource.getNewsItems();
      // The remoteDataSource returns NewsItemModel, which is a subtype of NewsItemEntity
      return Right(remoteNews);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
          ServerFailure('An unexpected error occurred: ${e.toString()}'));
    }
    // } else {
    //   return Left(NetworkFailure()); // Define NetworkFailure if needed
    // }
  }
}
