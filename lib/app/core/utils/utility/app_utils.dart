import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_task/app/core/utils/constants/error_string.dart';



  String addedErrorMessage(
    {String message = ErrorStrings.kServerTimeoutMessage}) {
  return '{"error": "$message"}';
}


class AppUtils {
  AppUtils._();



  ///
  /// email validation
  static bool isValidEmail({required String email}) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  ///
  /// password validation
  static bool isValidPassword({required String password}) {
    if (password.isEmpty || password.length < 6) {
      return false;
    }
    return true;
  }

  ///
  /// error toast
  static void errorToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      // textColor: whiteTextColor,
      // backgroundColor: redBgColor,
    );
  }

  ///
  /// success toast
  static void successToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      // textColor: whiteTextColor,
      // backgroundColor: greenBgColor,
    );
  }
}
