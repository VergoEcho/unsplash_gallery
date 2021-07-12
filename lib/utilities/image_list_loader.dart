import 'dart:convert';
import 'package:http/http.dart';
import 'package:unsplash_gallery/models/image_list_model.dart';

class Network {
  static int perPage = 20;
  String url = 'https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9&per_page=$perPage';

  Future<ImageList> loadPosts() async {
    try{
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return ImageList.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get posts");
    }
    } catch(err) {
      print(err);
      throw err;
    }
  }
}