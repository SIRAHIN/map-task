class ResponseModel {
  final bool isSuccess;
  final int statusCode;
  final String errorMessage;
  final dynamic responseData;


  ResponseModel({
  required this.isSuccess,
  required this.statusCode,
  this.errorMessage = 'Something went wrong!',
  required this.responseData,
  });
}