import 'package:equatable/equatable.dart';

/// Base Failure class. All specific failures should extend this.
/// I am using Equatable for easier value comparison in tests.
abstract class Failure extends Equatable {
  // Pass properties to the Equatable superclass constructor
  // if you want failures to be distinguishable based on properties.
  final String message;
  const Failure([this.message = '']);
  @override
  List<Object> get props => [message];
}

/// Represents a failure related to caching operations (e.g., SharedPreferences).
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Failed to access cache']);
}

/// Represents a generic failure (can be used as a fallback).
class GeneralFailure extends Failure {
  const GeneralFailure([super.message = 'An unexpected error occurred']);
}

//Notification
/// Represents a failure related to notification permissions.
class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'Permission denied or restricted']);
}

/// Represents a failure during notification operations.
class NotificationFailure extends Failure {
  const NotificationFailure([super.message = 'Failed notification operation']);
}


//  other specific failures corresponding to exceptions
// class ServerFailure extends Failure {}
// class NetworkFailure extends Failure {}