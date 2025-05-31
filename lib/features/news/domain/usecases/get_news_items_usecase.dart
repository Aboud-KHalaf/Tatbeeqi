import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart'; // Assuming you have a base UseCase
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';
import 'package:tatbeeqi/features/news/domain/repositories/news_repository.dart';

class GetNewsItemsUsecase implements UseCase<List<NewsItemEntity>, NoParams> {
  final NewsRepository repository;

  GetNewsItemsUsecase(this.repository);

  @override
  Future<Either<Failure, List<NewsItemEntity>>> call([NoParams? params]) async {
    return await repository.getNewsItems();
  }
}
