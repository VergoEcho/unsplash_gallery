class ImageList {
  final List<ImagePost> posts;

  ImageList({required this.posts});

  factory ImageList.fromJson(List<dynamic> parsedJson) {
    List<ImagePost> posts = parsedJson.map((post) => ImagePost.fromJson(post))
        .toList();
    return ImageList(posts: posts);
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
