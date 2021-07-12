import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unsplash_gallery/models/image_list_model.dart';
import 'package:unsplash_gallery/utilities/image_list_loader.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late Future<ImageList> list;

  @override
  void initState() {
    super.initState();
    Network network = Network();
    list = network.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
              top: 12.0, bottom: 12.0, left: 12.0, right: 8.0),
          child: SvgPicture.asset(
            'assets/logo.svg',
            color: Colors.black,
          ),
        ),
        title: Text(
          'Unsplash Gallery',
          style: TextStyle(
              // color: Colors.black
              ),
        ),
      ),
      body: Container(
        child: Center(
          child: Container(
            child: FutureBuilder(
                future: list,
                builder: (context, AsyncSnapshot<ImageList> snapshot) {

                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError)
                        return Center(
                            child: Column(
                          children: [

                                // Icon(
                                //   Icons.error,
                                //   color: Colors.red,
                                // ),
                                // Text(
                                //   'Error: ${snapshot.error}',
                                //   style: TextStyle(color: Colors.red),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                                  child: RichText(
                                      text: TextSpan(children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                    TextSpan(text: 'Error: ${snapshot.error}', style: TextStyle(
                                      color: Colors.red
                                    )),
                                  ])),
                                ),

                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  Network network = Network();
                                  list = network.loadPosts();
                                });
                              },
                              child: Text('Refresh'),
                            )
                          ],
                        ));
                      else {
                        return createListView(snapshot.data!.posts, context, snapshot);
                      }
                  }
                  // if (snapshot.hasData) {
                  //   allPosts = snapshot.data!.posts;
                  //   return createListView(allPosts, context, snapshot);
                  // } else {
                  //   return CircularProgressIndicator();
                  // }
                }),
          ),
        ),
      ),
    );
  }
}

Widget createListView(
    List<ImagePost> list, BuildContext context, AsyncSnapshot snapshot) {
  void _goFullSizePicture(String imageUrl) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImageViewer(imageUrl: imageUrl)));
  }

  return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      // itemExtent: 100.0,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        // return imagePost(context, list[index])
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: InkWell(
            onTap: () => _goFullSizePicture(list[index].image),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(list[index].name),
                  subtitle: Text(list[index].author),
                  leading: Image.network(
                    //TODO: change to cached image
                    list[index].thumbnail,
                    width: 80,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
        );
      });
}

class ImageViewer extends StatelessWidget {
  final String imageUrl;

  const ImageViewer({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fullscreen',
        ),
      ),
      backgroundColor: Colors.black45,
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          placeholder: (context, imageUrl) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, imageUrl, error) => Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              Text(
                'Failed to Load image',
                style: TextStyle(color: Colors.red),
              )
            ],
          )),
        ),
      ),
    );
  }
}
