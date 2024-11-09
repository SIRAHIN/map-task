import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:map_task/app/core/utils/constants/error_string.dart';
import 'package:map_task/app/core/utils/utility/app_utils.dart';
import 'package:map_task/app/data/models/response_model/response_model.dart';

class NetworkCaller {
  static const int timeoutRequest = 60;

  final Map<String, String> _mainHeaders = {
    'Content-Type': 'application/json',
    'Vary': 'Accept',
  };

  //Get current user header
  static Map<String, String> currentUserHeader({String? token}) {
    Map<String, String> mainHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Vary': 'Accept',
      'Authorization': 'Bearer $token',
    };
    return mainHeaders;
  }

  // Get Request with _mainHeaders //
  Future<ResponseModel> getRequest(String url, {String? token}) async {
    

    final http.Response response =
        await http.get(Uri.parse(url), headers: _mainHeaders).timeout(
      const Duration(seconds: timeoutRequest),
      onTimeout: () {
        return http.Response(addedErrorMessage(), 504);
      },
    );



    final decodedResponse = jsonDecode(response.body);


    if (response.statusCode == 200) {
      if (decodedResponse != null) {

       
        // print(decodedResponse);
        // print(response.statusCode.toString());
        // print('==========${decodedResponse['status']}===========');

        return ResponseModel(
          isSuccess: true,
          statusCode: decodedResponse['status'] ?? response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        // If the body is empty but the status code is 200
        return ResponseModel(
            isSuccess: false,
            statusCode: response.statusCode,
            responseData: 'Invalid Response',
            errorMessage: 'No data returned');
      }
    } else if (response.statusCode == 400) {
      return ResponseModel(
          isSuccess: false,
          statusCode: decodedResponse['status'],
          responseData: decodedResponse['message'],
          errorMessage: decodedResponse['message']);
    } else if (response.statusCode == 401) {
      return ResponseModel(
          isSuccess: false,
          statusCode: decodedResponse['status'],
          responseData: decodedResponse['message'],
          errorMessage: decodedResponse['message']);
    } else if (response.statusCode == 402) {
      return ResponseModel(
          isSuccess: false,
          statusCode: decodedResponse['status'],
          responseData: decodedResponse['message'],
          errorMessage: decodedResponse['message']);
    } else if (response.statusCode == 429) {
      return ResponseModel(
          isSuccess: false,
          statusCode: decodedResponse['status'],
          responseData: decodedResponse['message'],
          errorMessage: decodedResponse['message']);
    } else {
      return ResponseModel(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: 'Something went wrong');
    }
  }

  // post Request With currentUserHeader //
  Future<ResponseModel> postRequest(String url, Map<String, dynamic> body,
      {String? token}) async {
    final http.Response response = await http
        .post(Uri.parse(url),
            headers:
                token == null ? _mainHeaders : currentUserHeader(token: token),
            body: jsonEncode(body))
        .timeout(
      const Duration(seconds: timeoutRequest),
      onTimeout: () {
        return http.Response(ErrorStrings.kServerTimeoutMessage, 504);
      },
    );

    // Handling the response
    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (decodedResponse != null) {
        return ResponseModel(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse,
            errorMessage: 'Success');
      } else if (response.statusCode == 401) {
        return ResponseModel(
            isSuccess: false,
            statusCode: response.statusCode,
            responseData: decodedResponse ?? ErrorStrings.serverErrorMessage,
            errorMessage: ErrorStrings.serverErrorMessage);
      } else if (response.statusCode == 500) {
        return ResponseModel(
            isSuccess: false,
            statusCode: response.statusCode,
            responseData:
                decodedResponse ?? ErrorStrings.unauthorizedUserErrorMessage,
            errorMessage: ErrorStrings.unauthorizedUserErrorMessage);
      } else {
        return ResponseModel(
            isSuccess: false,
            statusCode: response.statusCode,
            responseData: decodedResponse ?? 'Something went Wrong');
      }
    } else {
      return ResponseModel(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse);
    }
  }
}
