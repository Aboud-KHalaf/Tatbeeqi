import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsItemEntity>>> getNewsItems();
}
