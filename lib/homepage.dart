
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:unsplash_client/image_activity.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  var now = new DateTime.now();
  List data;
  String _search="cat";

  @override
  void initState() {

    super.initState();
    this.getjsondata();
  }

  Future<String> getjsondata() async {
    try{
      var response= await http.get('https://api.unsplash.com/search/photos?per_page=30&client_id=it1PXzVQRnxgz8v8hazcst7G9rNfXk1qiS8FgHTTMMk&query=${_search}');

      setState(() {
        var converted = json.decode(response.body);
        data=converted['results'];
      });
    }
    catch(e){}
    return 'success';
  }



  Icon cusicon=Icon(Icons.search);
  Widget custext=Text("Upsplash Test App");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upsplash Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: custext,
            actions: <Widget>[
              IconButton(
                onPressed: (){
                  setState(() {
                    if(this.cusicon.icon==Icons.search){
                      this.cusicon=Icon(Icons.cancel);

                      this.custext=TextField(
                        autofocus: true,
                        onChanged: (text){
                          setState(() {
                            _search=text;
                          });
                          getjsondata();
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Image",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            )
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      );
                    }
                    else{
                      this.cusicon=Icon(Icons.search);
                      this.custext=Text("Upsplash Test App");
                    }
                  });
                },
                icon:cusicon,
              )
            ],
          ),
          body:new ListView.builder(
            itemCount: data == null ?0:data.length,
            itemBuilder: (BuildContext context,int index){
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Card(
                        child: new Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(

                                child: Image.network(
                                  data[index]['urls']['small'],
                                  width: MediaQuery.of(context).size.width,

                                ),
                                onTap: () {
                                  setState(() {
                                    Navigator.pushReplacement(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) => new ImageActivity(data:
                                              data, index: index, title: "Оп картинка ^^",)));
                                  });
                                },
                              ),
//                            ////////////////////

                            Text(data[index]['user']['username']),

                              Image.network(
                                  data[index]['user']['username'],
                              )

                            ],
                          ),

                        ),
                      ) ,

                    ],

                  ),
                ),
              );
            },
          )
      ),

    );

  }
}