class ResponseObject {
  final bool isSucess;
  final int statusCode;
  final dynamic responseBody;
  final String? errorMessage;
  final String? successMessage;
  ResponseObject({
    required this.isSucess,
    required this.statusCode,
    required this.responseBody,
    this.errorMessage = '',
    this.successMessage = '',
  });
}
