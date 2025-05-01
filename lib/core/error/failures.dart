import 'package:equatable/equatable.dart';

// Base Failure class
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

class NotificationFailure extends Failure {
  const NotificationFailure(super.message);
}

class GeneralFailure extends Failure {
  const GeneralFailure(super.message);
}

// Add other specific failures corresponding to exceptions if needed
// class NetworkFailure extends Failure {}