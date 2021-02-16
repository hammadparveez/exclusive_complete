import 'package:http/http.dart';

class InternetCheckRepo {
  Future<bool> checkInternet() async {
    final Duration duration = Duration(seconds: 30);
    final response =
        await get("https://www.google.com/").timeout(duration, onTimeout: () {
      print("Internet connection not available");
      return Response(null, 404);
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}
