import 'package:hive/hive.dart';

abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});

  String get message => errorMessage;
}

/// Represents a failure when working with local storage (Hive, SQLite, etc.)
class LocalFailure extends Failure {
  LocalFailure({required super.errorMessage});

  /// Creates a failure based on a specific exception
  factory LocalFailure.fromException(Object exception) {
    if (exception is HiveError) {
      return LocalFailure(errorMessage: 'Hive Error: ${exception.message}');
    }
    if (exception is TypeError) {
      return LocalFailure(errorMessage: 'Type Casting Error');
    }
    if (exception is StateError) {
      return LocalFailure(errorMessage: 'Invalid State: ${exception.message}');
    }
    // Add more exception handling if you want
    return LocalFailure(errorMessage: 'Unknown Local Storage Error');
  }

  /// Creates a failure for when data is not found
  factory LocalFailure.notFound() {
    return LocalFailure(errorMessage: 'Item Not Found');
  }

  /// Creates a failure for when the box is not opened
  factory LocalFailure.boxNotOpen() {
    return LocalFailure(errorMessage: 'Box Not Opened');
  }
}
