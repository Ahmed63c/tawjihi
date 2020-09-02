import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  String image;
  ImageDialog(this.image);
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(backgroundColor: Colors.white.withOpacity(0.85),
    body: InteractiveViewer(
      panEnabled: false, // Set it to false to prevent panning.
      boundaryMargin: EdgeInsets.all(80),
      minScale: 0.5,
      maxScale: 4,
      child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(image),fit: BoxFit.contain,
                  )
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                  margin: EdgeInsets.only(top: 32,right: 32),
                  child:  Icon(Icons.clear,color: Colors.red,size: 32,)),
            ),
          ],
        ),
    ),
    );

  }
}