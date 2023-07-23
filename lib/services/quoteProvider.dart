import 'dart:convert';

import 'package:http/http.dart';

class quoteProvider {
  Future<dynamic> getData() async {
    Response response = await get(
      Uri.parse('https://api.quotable.io/random'),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    }
  }
}
