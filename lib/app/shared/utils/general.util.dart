import 'package:connectivity_plus/connectivity_plus.dart';

class GeneralUtils {
  String getCurrentFileName(StackTrace fileTrace) {
    final stackTraceString = fileTrace.toString().split('\n');
    final fileNameRegExp = RegExp(r'([^/]+\.dart):');
    final match = fileNameRegExp.firstMatch(stackTraceString[0]);
    return "${match!.group(1)}";
  }

  String getNewNameFile(String nameFile) {
    return DateTime.now().millisecondsSinceEpoch.toString() + nameFile.split("/").last;
  }

  String getPartPathFile() {
    DateTime data = DateTime.now();
    return '/${data.month.toString()}/${data.day.toString()}/';
  }

  Future<bool> checkInternetConnection() async {
    final Connectivity connectivity = Connectivity();
    final value = await connectivity.checkConnectivity();
    if (value[0] == ConnectivityResult.mobile || value[0] == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
