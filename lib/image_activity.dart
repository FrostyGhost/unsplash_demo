import 'package:flutter/material.dart';
import 'package:unsplash_client/homepage.dart';

class ImageActivity extends StatelessWidget {

  ImageActivity({@required this.title, this.data, this.index});

  final title;
  final data;
  final index;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Center(

        child: new Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(

                child: Image.network(
                  data[index]['urls']['small'],
                  width: MediaQuery.of(context).size.width,

                ),
                onTap: () {
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Homepage()));

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}