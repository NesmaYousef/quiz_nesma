import 'dart:convert';

import 'package:http/http.dart';

class imageProvider {
  Future<dynamic> getImage() async {
    Response responseImage = await get(Uri.parse(
        'https://random.imagecdn.app/v1/image?category=buildings&format=json'));

    if (responseImage.statusCode == 200) {
      print(responseImage.body);
      return jsonDecode(responseImage.body);
    }
  }
}
