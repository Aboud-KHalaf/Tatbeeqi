import 'package:equatable/equatable.dart';

/// Base Failure class. All specific failures should extend this.
/// I am using Equatable for easier value comparison in tests.
abstract class Failure extends Equatable {
  // Pass properties to the Equatable superclass constructor
  // if you want failures to be distinguishable based on properties.
  // Ex: final String message;
  // const Failure([this.message = '']);
  // @override
  // List<Object> get props => [message];

  // For simplicity here, we won't add properties differentiating failures
  const Failure();

  @override
  List<Object> get props => [];
}

/// Represents a failure related to caching operations (e.g., SharedPreferences).
class CacheFailure extends Failure {
  final String message;

  const CacheFailure({this.message = 'Failed to access cache'});

  @override
  List<Object> get props => [message];
}

/// Represents a generic failure (can be used as a fallback).
class GeneralFailure extends Failure {
  final String message;

  const GeneralFailure({this.message = 'An unexpected error occurred'});

  @override
  List<Object> get props => [message];
}


//  other specific failures corresponding to exceptions
// class ServerFailure extends Failure {}
// class NetworkFailure extends Failure {}