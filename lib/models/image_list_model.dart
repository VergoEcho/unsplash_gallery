class ImageListModel {
  final List<ImagePost> posts;

  ImageListModel({required this.posts});

  factory ImageListModel.fromJson(List<dynamic> parsedJson) {
    List<ImagePost> posts = parsedJson.map((post) => ImagePost.fromJson(post))
        .toList();
    return ImageListModel(posts: posts);
  }
}

class ImagePost {
  String name;
  String author;
  String thumbnail;
  String image;


  ImagePost(
      {required this.name, required this.author, required this.thumbnail, required this.image});

  factory ImagePost.fromJson(Map<String, dynamic> json) {
    return ImagePost(
        name: json['description'] == null ? json['alt_description'] : json['description'],
        author: json['user']['name'] ,
        thumbnail: json['urls']['thumb'],
        image: json['urls']['regular']
    );
    }
}
