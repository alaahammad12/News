import 'dart:convert';
import 'package:userpost/model/news_model.dart';
import 'package:http/http.dart' as http;
class news_network {
  Future<News> getnews(String category) async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&$category&apiKey=88aaa339b0164d2ea5913583c94417a8");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return News.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed');
    }
  }
}
