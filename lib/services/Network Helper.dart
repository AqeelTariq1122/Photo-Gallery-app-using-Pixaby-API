import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkHelper {
  NetworkHelper({required this.url});
  final String url;

  Future<dynamic> getData() async {
    http.Response response;

    response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //jason Data
      String data = response.body;

      dynamic jasonObjects;
      jasonObjects = jsonDecode(data);
      return jasonObjects;

    } else {
      print(response.statusCode);
    }
  }
}
