import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/download/DownloadSingleBlock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'DownloadRepo.dart';

class DownloadSingleBlocView extends StatefulWidget {

  DownloadSingleBlocView({ Key key }): super(key:key);

  @override
  DownloadSingleBlocViewBody createState() => DownloadSingleBlocViewBody();
}


class DownloadSingleBlocViewBody extends State<DownloadSingleBlocView> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Single Bloc POC"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            BlocBuilder<DownloadBlock, DownloadState>(builder: (context, state){
              final currentState = state;
              if(currentState is DownloadProgress){
                return Container(
                  child: Expanded(
                    child: new ListView.builder(
                        itemCount: currentState.modelList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new Padding(
                            padding: EdgeInsets.all(15.0),
                            child: new LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 50,
                              animation: false,
                              lineHeight: 20.0,
                              percent: currentState.modelList[index].progress / 100,
                              center: Text(currentState.modelList[index].name + ' ${(currentState.modelList[index].progress).toStringAsFixed(2)} %'),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.green,
                            ),
                          );
                        }),
                  )
                );
              }
              return Container();
            })
            , Container(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(60)
              ),
              child: FlatButton(
                  onPressed: ()  async {
                    context.bloc<DownloadBlock>().add(StartDownload());
                  },
                  child: Container(
                    child: Text( 'Download',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,),),
                  )
              ),)
          ],
        ),

      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}


