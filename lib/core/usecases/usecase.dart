import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatbeeqi/core/error/failures.dart';

// Base class for UseCases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Used when a UseCase doesn't require parameters
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
