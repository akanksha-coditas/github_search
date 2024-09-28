import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({
    required this.statusCode,
    required this.message,
    this.data,
  });

  final String statusCode;
  final String message;
  final dynamic data;

  @override
  List<Object?> get props => <Object?>[statusCode, message, data];
}