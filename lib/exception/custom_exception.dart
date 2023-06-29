import 'package:custom_exception/exception/error_code.dart';

abstract class CustomException implements Exception {
  const CustomException(
    this.errorCode, {
    this.info,
  });

  final ErrorCode errorCode;
  final dynamic info;

  @override
  String toString() {
    return 'CustomException{errorCode: ${errorCode.errorCode}, title: ${errorCode.errorTitle}, message: ${errorCode.errorMessage}, info: $info}';
  }
}
