import 'dart:developer';

class ErrorHandler {
  static logError(dynamic e, StackTrace s) {
    log(e.toString(), name: "Error Handler Message");
    log(s.toString(), name: "Error Handler Message");
  }
}
