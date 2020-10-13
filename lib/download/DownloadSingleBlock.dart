
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ffi';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'DownloadRepo.dart';




class DownloadModel {
  double progress = 0.0;
  String name = '';
  int startTime = 0;
  int endTime = 0;
}
/*
* Event
* */

class DownloadEvent extends Equatable {

  @override
  List<Object> get props => [];

}

class StartDownload extends DownloadEvent {

}

class DownloadProgressOneEvent extends DownloadEvent {
  final double progress;
  final String target;

  DownloadProgressOneEvent({ @required this.progress, @required this.target}): assert( progress != null && target != null );

  @override
  List<Object> get props => [progress,target];

}
class DownloadProgressTwoEvent extends DownloadEvent {
  final double progress;
  final String target;

  DownloadProgressTwoEvent({ @required this.progress, @required this.target}): assert( progress != null && target != null );

  @override
  List<Object> get props => [progress,target];

}
class DownloadProgressThreeEvent extends DownloadEvent {
  final double progress;
  final String target;

  DownloadProgressThreeEvent({ @required this.progress, @required this.target}): assert( progress != null && target != null );

  @override
  List<Object> get props => [progress,target];

}

/**
 *   State
 * */

final Store store = new Store._private();

class Store {

  Store._private() { print('#2'); }

  double singleAverage = 0.0;
  double multiAverage = 0.0;
  double vanilaAverage = 0.0;

}

class DownloadState extends Equatable {

  @override
  List<Object> get props => [];

}

class DownloadProgress extends DownloadState {


  final List<DownloadModel> modelList;

  DownloadProgress({@required this.modelList}): assert( modelList != null );

  DownloadProgress copyWith( List<DownloadModel> modelList ){
    return DownloadProgress( modelList: modelList ?? this.modelList);
  }

  @override
  List<Object> get props => [modelList];

}

class StopDownload extends DownloadState{

}

class DownloadBlock extends Bloc<DownloadEvent, DownloadState> {

  DownloadRepo _downloadRepo;

  DownloadBlock(DownloadRepo downloadRepo) : super(StopDownload()){
    this._downloadRepo = downloadRepo;
  }

  final List<DownloadModel> _list = [];

  @override
  Stream<DownloadState> mapEventToState(DownloadEvent event) async*{
    final currentState = state;

    if (event is StartDownload){
      if (_list.isEmpty){
        final DownloadModel d1 = DownloadModel();
        final DownloadModel d2 = DownloadModel();
        final DownloadModel d3 = DownloadModel();
        d1.name = 'test1.pdf';
        d2.name = 'test2.pdf';
        d3.name = 'test3.pdf';


        d1.startTime = DateTime.now().microsecondsSinceEpoch;
        d2.startTime = DateTime.now().microsecondsSinceEpoch;
        d3.startTime = DateTime.now().microsecondsSinceEpoch;

        _list.add(d1);
        _list.add(d2);
        _list.add(d3);
      }

      _downloadRepo.download(_downloadRepo.rtf,'test1.rtf', (progress, name) => add(DownloadProgressOneEvent(progress:progress, target: name)) );
      _downloadRepo.download(_downloadRepo.rtf,'test2.rtf', (progress, name) => add(DownloadProgressTwoEvent(progress:progress, target: name)) );
      _downloadRepo.download(_downloadRepo.rtf,'test3.rtf', (progress, name) => add(DownloadProgressThreeEvent(progress:progress, target: name)) );

    }else if (event is DownloadProgressOneEvent){
      _list[0].progress = event.progress;
      _list[0].name = event.target;
      if(event.progress == 100){
        _list[0].endTime = DateTime.now().microsecondsSinceEpoch;
        print("#1 start: ${_list[0].startTime}, end: ${_list[0].endTime}, diff: " + ((_list[0].startTime - _list[0].endTime).fromMictoSec()).toString() + " in sec");
        _avg();
      }
      if (currentState is DownloadProgress ){
        yield currentState.copyWith([]);
        yield currentState.copyWith(_list);
      }else{
        yield DownloadProgress(modelList: _list);
      }
    }else if (event is DownloadProgressTwoEvent){
      _list[1].progress = event.progress;
      _list[1].name = event.target;
      if(event.progress == 100){
        _list[1].endTime = DateTime.now().microsecondsSinceEpoch;
        print("#2 start: ${_list[1].startTime}, end: ${_list[1].endTime}, diff: " + ((_list[1].startTime - _list[1].endTime).fromMictoSec()).toString() + " in sec");
        _avg();
      }
      if (currentState is DownloadProgress ){
        yield currentState.copyWith([]);
        yield currentState.copyWith(_list);
      }else{
        yield DownloadProgress(modelList: _list);
      }
    }else if (event is DownloadProgressThreeEvent){
      _list[2].progress = event.progress;
      _list[2].name = event.target;
      if(event.progress == 100){
        _list[2].endTime = DateTime.now().microsecondsSinceEpoch;
        print("#3 start: ${_list[2].startTime}, end: ${_list[2].endTime}, diff: " + ((_list[2].startTime - _list[2].endTime).fromMictoSec()).toString() + " in sec");
        _avg();
      }
      if (currentState is DownloadProgress ){
        yield currentState.copyWith([]);
        yield currentState.copyWith(_list);
      }else{
        yield DownloadProgress(modelList: _list);
      }
    }
  }

  void _avg(){
    if(_list[0].endTime > 0 && _list[1].endTime > 0 && _list[2].endTime > 0){
      final one = _list[0].startTime - _list[0].endTime;
      final two = _list[1].startTime - _list[1].endTime;
      final three = _list[2].startTime - _list[2].endTime;
      final avg = ((one + two + three / 3)).fromMictoSec();
      //print("avg time diff in sec: " + avg.toString());
      store.singleAverage = avg;
    }
  }

}

extension Parse1 on double {

  double fromMictoSec() {
    return (this / 1000000);
  }

}

extension Parse2 on int {

  double fromMictoSec() {
    return (this / 1000000);
  }

}