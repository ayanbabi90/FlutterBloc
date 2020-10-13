
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/download/DownloadSingleBlock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'DownloadRepo.dart';

class DownloadView extends StatefulWidget {

  DownloadView({ Key key }): super(key:key);

  @override
  DownloadViewBody createState() => DownloadViewBody();
}


class DownloadViewBody extends State<DownloadView> implements DownloadDelegate{

  DownloadUseCase downloadRepo;
  DownloadSingleModel d1 = DownloadSingleModel();
  DownloadSingleModel d2 = DownloadSingleModel();
  DownloadSingleModel d3 = DownloadSingleModel();

  var mounted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mounted = true;
  }

  @override
  Widget build(BuildContext context) {
   downloadRepo = DownloadUseCase(this, DownloadRepo());

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Delegate POC"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: false,
              lineHeight: 20.0,
              percent: d1.progress,
              center: Text(d1.name),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: false,
              lineHeight: 20.0,
              percent: d2.progress,
              center: Text(d2.name),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
            ),
          ),
          Padding(padding: EdgeInsets.all(15.0),
            child: new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: false,
              lineHeight: 20.0,
              percent: d3.progress,
              center: Text(d3.name),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
            ),
          ),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(60)
            ),
            child: FlatButton(
                onPressed: ()  async {
                  d1.startTime = DateTime.now().microsecondsSinceEpoch;
                  d2.startTime = DateTime.now().microsecondsSinceEpoch;
                  d3.startTime = DateTime.now().microsecondsSinceEpoch;
                  downloadRepo.downloadAll();
                }
            ,
                child: Container(
                  child: Text( 'Download',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,),),
          )
      ),)
        ],
      ),
    );
  }


  @override
  void progressOne(String name, double progressInDouble) {
    if(mounted){
      setState(() {
        if(progressInDouble == 100){
          d1.endTime = DateTime.now().microsecondsSinceEpoch;
          print("#1 start: ${d1.startTime}, end: ${d1.endTime}, diff: " + ((d1.startTime - d1.endTime).fromMictoSec()).toString() + " in sec" );
          _avg();
        }
        d1.name = "$name ${(progressInDouble).toStringAsFixed(2)}%";
        d1.progress = (progressInDouble / 100);
      });
    }
  }

  @override
  void progressTwo(String name, double progressInDouble) {
    if(mounted){

      setState(() {
        if(progressInDouble == 100){
          d2.endTime = DateTime.now().microsecondsSinceEpoch;
          print("#2 start: ${d2.startTime}, end: ${d2.endTime}, diff: " + ((d2.startTime - d2.endTime).fromMictoSec()).toString() + " in sec");
          _avg();
        }
        d2.name = "$name ${(progressInDouble).toStringAsFixed(2)}%";
        d2.progress = (progressInDouble / 100);
      });
    }
  }

  @override
  void progressThree(String name, double progressInDouble) {
    if(mounted){

      setState(() {
        if(progressInDouble == 100){
          d3.endTime = DateTime.now().microsecondsSinceEpoch;
          print("#3 start: ${d3.startTime}, end: ${d3.endTime}, diff: " + ((d3.startTime - d3.endTime).fromMictoSec()).toString() + " in sec");
          _avg();
        }
        d3.name = "$name ${(progressInDouble).toStringAsFixed(2)}%";
        d3.progress = (progressInDouble / 100);
      });
    }
  }

  void _avg(){
    if(d1.endTime > 0 && d2.endTime > 0 && d3.endTime > 0){
      final one = d1.startTime - d1.endTime;
      final two = d2.startTime - d2.endTime;
      final three = d3.startTime - d3.endTime;
      final avg = ((one + two + three / 3) * 0.000001);
      //print("avg time diff in sec: " + avg.toString());
      store.vanilaAverage = avg;
    }
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    mounted = false;
    downloadRepo = null;
  }

}