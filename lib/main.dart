
import 'package:flutter/material.dart';
import 'package:flutter_app/DictResultModel.dart';
import 'package:flutter_app/LogInView.dart';
import 'package:flutter_app/WeatherBlock.dart';
import 'package:flutter_app/download/DownloadSingleBlock.dart';
import 'package:flutter_app/download/DownloadRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'LogInBloc.dart';
import 'NextPage.dart';
import 'WeatherRepo.dart';
import 'download/DownloadMultiBloc.dart';
import 'download/DownloadMultiBlocView.dart';
import 'download/DownloadSingleBlocView.dart';
import 'download/DownloadView.dart';




void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NewHome(),
    ),
);

class NewHome extends StatefulWidget {

  NewHome({ Key key }): super(key:key);

  @override
  Home createState() => Home();
}


class Home extends State<NewHome> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          RaisedButton(
            child: Text("Single Bloc download"),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider<DownloadBlock>(
                  create: (_) => DownloadBlock(DownloadRepo()),
                  child: DownloadSingleBlocView(),
                ),
              ),
            ),
          ),

          RaisedButton(
            child: Text("Vanila download " + store.vanilaAverage.toString()),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => DownloadView()),
            ),
          ),

          RaisedButton(
            child: Text("Multi Bloc download " + store.multiAverage.toString()),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>  MultiBlocProvider(
                  providers: [
                    BlocProvider<DownloadBlockOne>(
                      create: (BuildContext context) =>
                          DownloadBlockOne(DownloadRepo()),
                    ),
                    BlocProvider<DownloadBlockTwo>(
                      create: (BuildContext context) =>
                          DownloadBlockTwo(DownloadRepo()),
                    ),
                    BlocProvider<DownloadBlockThree>(
                      create: (BuildContext context) =>
                          DownloadBlockThree(DownloadRepo()),
                    ),
                  ],
                  child: DownloadMultiBlocView() ,
                ),
              ),
            ),
          ),

        ],
      ),
    );

  }


}

class HomePage extends StatefulWidget{
  HomePage({Key key}): super (key: key);

  @override
  HomePageBody createState() => HomePageBody();

}

class HomePageBody extends State<HomePage> {
final textFile1 = TextEditingController();
final textFile2 = TextEditingController();
//final apiCall = WeatherRepo();

  @override
  void initState() {
    super.initState();
    textFile1.addListener(() {
      print('ayan '+ textFile1.text.toLowerCase());
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(top: 40, left: 14,right: 14),
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60),
                                borderSide: BorderSide(color: Colors.blue)
                            ),
                            hintText: 'City name'
                        ),
                        controller: textFile1,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 80,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(60)
                    ),
                    child: FlatButton(
                        onPressed: () {
                          BlocProvider.of<WeatherBloc>(context).add(FetchWeather(city: textFile1.text.toLowerCase().trim().toString()));
                          //apiCall.getWeatherReport(textFile1.text.toLowerCase().trim());
                        },
                        child: Container(
                          child: Text('GO'),
                        )
                    ),
                  )
                ],
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state){
                    if (state is WeatherIsNotSearched){
                      print("ayan WeatherIsNotSearched ...");
                      return Container(
                        child: Text('Your current weather report.'),
                      );

                    }
                    if(state is WeatherIsLoaded){
                      final model = state.dictResult;
                     // return Text(model.weather.first.description.toString());

                     return ListView.builder(itemBuilder: (context, index){
                       final item = model.weather[index];
                        return Card(
                          child: SizedBox(
                            height: 30,
                            child: Text('Main ' + item.main + ' Description: '+item.description),
                          ),
                        );
                      }, itemCount: model.weather.length, physics: ClampingScrollPhysics(),
                       shrinkWrap: true,);
                      print("ayan WeatherIsLoaded ..." + model.name.toString());
                    }
                    return Container();
                  })
            ],),
          BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state){
                if (state is WeatherIsLoading){
                  print("ayan WeatherIsLoading ...");
                  return Center(child: CircularProgressIndicator());
                }
                return Container();
              })
        ],
      )
      );
  }

  void toNewScreen(BuildContext context){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => NextPage()));
  }

  @override
  getWeatherReport(Main _data) {
    // TODO: implement getWeatherReport
    print("data from delegate: "+ _data.feelsLike.toString());


  }


}