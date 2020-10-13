
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;

import 'DictResultModel.dart';

class NextPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: NextPageListView(),
    );
  }
}

class NextPageListView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return ListState();
  }

}

class ListState extends State<NextPageListView>{
  String _url = 'https://owlbot.info/api/v4/dictionary/';

  TextEditingController _editingController = TextEditingController();

  StreamController _streamController;
  Stream _stream;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;

  }

  _search(String str) async {
    if(_editingController.text == null || _editingController.text == 0){
      _streamController.add(null);
      return null;
    }
    _streamController.add("waiting");
    http.Response response = await http.get(_url+str, headers: {"Authorization":"Token 08dbf3a6c1ac8f9fad4bdf4f5788a40e12bbbbe6"});
    _streamController.add(json.decode(response.body));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TextField(
                controller: _editingController,
                onChanged: (String txt){
                  _search(txt);
                },
                decoration: InputDecoration(
                  hintText: "Search any words.",
                  contentPadding: const EdgeInsets.only(left: 26),
                  border: InputBorder.none,

                ),
              ),
              IconButton(
                icon: Icon(
                    Icons.search,
                    color: Colors.white,
                ),
                onPressed: (){

                },

              )
            ],
          ),
          StreamBuilder(
            stream: _stream,
            builder: (BuildContext ctx, AsyncSnapshot snp){
              if(snp.data == null){
                return Center(
                  child: Text("Enter some search"),
                );
              }
              return ListView.builder(
                  itemCount: snp.data["definitions"],
                  itemBuilder: (BuildContext context, int index){
                    return ListBody(
                      children: <Widget>[
                        Container(
                          color: Colors.grey,
                          child: ListTile(
                            leading: snp.data["definitions"][index]["image_url"] == null ? null : CircleAvatar(
                              backgroundImage: NetworkImage(snp.data["definitions"][index]["image_url"]),
                            ),
                            title: Text( _editingController.text.trim() + " " + snp.data["definitions"][index]["type"]),
                            subtitle: Text(snp.data["definitions"][index]["definition"]),
                          ),
                        )
                      ],
                    );
                  }
              );
            },
          )
        ],
      ),
    );
  }

}

