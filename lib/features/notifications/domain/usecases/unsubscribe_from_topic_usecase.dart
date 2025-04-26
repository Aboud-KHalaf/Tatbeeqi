import 'package:dartz/dartz.dart';
import 'package:tatbeeqi/core/error/failures.dart';
import 'package:tatbeeqi/core/usecases/usecase.dart';
import 'package:tatbeeqi/features/notifications/domain/repositories/notification_repository.dart';

class UnsubscribeFromTopicUseCase implements UseCase<Unit, String> {
  final NotificationRepository repository;

  UnsubscribeFromTopicUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String topic) async {
    if (topic.isEmpty) {
      return const Left(GeneralFailure('Topic cannot be empty'));
    }
    return await repository.unsubscribeFromTopic(topic);
  }
}
