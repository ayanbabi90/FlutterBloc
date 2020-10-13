import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/download/DownloadSingleBlock.dart';
import 'package:flutter_app/download/DownloadMultiBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../main.dart';
import 'DownloadRepo.dart';

class DownloadMultiBlocView extends StatefulWidget {
  DownloadMultiBlocView({Key key}) : super(key: key);

  @override
  DownloadMultiBlocViewBody createState() => DownloadMultiBlocViewBody();
}

class DownloadMultiBlocViewBody extends State<DownloadMultiBlocView> {

  int diff1 = 0;
  int diff2 = 0;
  int diff3 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Multi Bloc POC"),
        ),
        body:  ListView(
          children: <Widget>[
            BlocBuilder<DownloadBlockOne, StateOne>(
                builder: (context, state) {
                  final currentState = state;
                  if (currentState is DownloadProgressOne) {
                    if(currentState.progress == 100){
                      diff1 = BlocProvider.of<DownloadBlockOne>(context).endTime - BlocProvider.of<DownloadBlockOne>(context).startTime ;
                      _avg();
                    }
                    return new Padding(
                      padding: EdgeInsets.all(15.0),
                      child: new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: false,
                        lineHeight: 20.0,
                        percent: currentState.progress / 100,
                        center: Text('#1 ${(currentState.progress).toStringAsFixed(2)} %'),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                      ),
                    );
                  }
                  return Container();
                }),
            BlocBuilder<DownloadBlockTwo, StateTwo>(
                builder: (context, state) {
                  final currentState = state;
                  if (currentState is DownloadProgressTwo) {
                    if(currentState.progress == 100){
                      diff2 = BlocProvider.of<DownloadBlockTwo>(context).endTime - BlocProvider.of<DownloadBlockTwo>(context).startTime;
                      _avg();
                    }
                    return new Padding(
                      padding: EdgeInsets.all(15.0),
                      child: new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: false,
                        lineHeight: 20.0,
                        percent: currentState.progress / 100,
                        center: Text('#2 ${(currentState.progress).toStringAsFixed(2)} %'),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                      ),
                    );
                  }
                  return Container();
                }),
            BlocBuilder<DownloadBlockThree, StateThree>(
                builder: (context, state) {
                  final currentState = state;
                  if (currentState is DownloadProgressThree) {
                    if(currentState.progress == 100){
                      diff3 = BlocProvider.of<DownloadBlockThree>(context).endTime - BlocProvider.of<DownloadBlockThree>(context).startTime;
                      _avg();
                    }
                    return new Padding(
                      padding: EdgeInsets.all(15.0),
                      child: new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: false,
                        lineHeight: 20.0,
                        percent: currentState.progress / 100,
                        center: Text('#3 ${(currentState.progress).toStringAsFixed(2)} %'),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                      ),
                    );
                  }
                  return Container();
                }),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(60)),
              child: FlatButton(
                  onPressed: () async {
                    BlocProvider.of<DownloadBlockOne>(context).add(StartDownloadEvent());
                    BlocProvider.of<DownloadBlockTwo>(context).add(StartDownloadEventTwo());
                    BlocProvider.of<DownloadBlockThree>(context).add(StartDownloadEventThree());
                  },
                  child: Container(
                    child: Text(
                      'Download',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  )),
            )
          ],
        ));
  }


  void _avg(){

    if(diff1 > 0 && diff2 > 0 && diff3 > 0){
      final avg = diff1 + diff2 + diff3 / 3;
     // print("avg time diff in sec: " + (avg.fromMictoSec()).toString() + "\n");
      store.multiAverage = avg;
    }
  }

}
