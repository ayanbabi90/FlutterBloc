import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ffi';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'DownloadSingleBlock.dart';
import 'DownloadRepo.dart';


class DownloadEventOne extends Equatable {

  @override
  List<Object> get props => [];

}
class StartDownloadEvent extends DownloadEventOne {

}
class DownloadProgressEventOne extends DownloadEventOne {
  final double progress;

  DownloadProgressEventOne({ @required this.progress}): assert( progress != null );

  @override
  List<Object> get props => [progress];

}


class StateOne extends Equatable {

  @override
  List<Object> get props => [];

}
class StopDownloadOne extends StateOne{

}
class DownloadProgressOne extends StateOne {


  final double progress;

  DownloadProgressOne({@required this.progress}): assert( progress != null );

  DownloadProgressOne copyWith( double progress ){
    return DownloadProgressOne( progress: progress ?? this.progress);
  }

  @override
  List<Object> get props => [progress];

}


class DownloadBlockOne extends Bloc<DownloadEventOne, StateOne> {

  DownloadRepo _downloadRepo;

  int startTime = 0;
  int endTime = 0;


  DownloadBlockOne(DownloadRepo downloadRepo) : super(StopDownloadOne()) {
    this._downloadRepo = downloadRepo;
  }

  @override
  Stream<StateOne> mapEventToState(DownloadEventOne event) async* {
    final currentState = state;
    if(event is StartDownloadEvent){
      startTime = DateTime.now().microsecondsSinceEpoch;
      _downloadRepo.download(_downloadRepo.pdf,'test1.pdf', (progress, name) =>
          add(DownloadProgressEventOne(progress:progress))
      );
    }else if (event is DownloadProgressEventOne){
      if(event.progress == 100){
        endTime = DateTime.now().microsecondsSinceEpoch;
        print("#1 start: $startTime, end: $endTime, diff: " + ((startTime - endTime).fromMictoSec()).toString() + " in sec" );
      }
      if (currentState is DownloadProgressOne ){
        yield currentState.copyWith(event.progress);
      }else{
        yield DownloadProgressOne(progress: event.progress);
      }
    }

  }

}

/*
* */

class DownloadEventTwo extends Equatable {

  @override
  List<Object> get props => [];

}
class StartDownloadEventTwo extends DownloadEventTwo {

}
class DownloadProgressEventTwo extends DownloadEventTwo {
  final double progress;

  DownloadProgressEventTwo({ @required this.progress}): assert( progress != null );

  @override
  List<Object> get props => [progress];

}


class StateTwo  extends Equatable {

  @override
  List<Object> get props => [];

}
class StopDownloadTwo  extends StateTwo{

}
class DownloadProgressTwo  extends StateTwo {


  final double progress;

  DownloadProgressTwo({@required this.progress}): assert( progress != null );

  DownloadProgressTwo copyWith( double progress ){
    return DownloadProgressTwo( progress: progress ?? this.progress);
  }

  @override
  List<Object> get props => [progress];

}


class DownloadBlockTwo extends Bloc<DownloadEventTwo, StateTwo> {

  DownloadRepo _downloadRepo;
  int startTime = 0;
  int endTime = 0;

  DownloadBlockTwo(DownloadRepo downloadRepo) : super(StopDownloadTwo()) {
    this._downloadRepo = downloadRepo;
  }

  @override
  Stream<StateTwo> mapEventToState(DownloadEventTwo event) async* {
    final currentState = state;
    if(event is StartDownloadEventTwo){
      startTime = DateTime.now().microsecondsSinceEpoch;
      _downloadRepo.download(_downloadRepo.pdf,'test2.pdf', (progress, name) => add(DownloadProgressEventTwo(progress: progress)) );
    }else if (event is DownloadProgressEventTwo){
      if(event.progress == 100){
        endTime = DateTime.now().microsecondsSinceEpoch;
        print("#2 start: $startTime, end: $endTime, diff: " + ((startTime - endTime).fromMictoSec()).toString() + " in sec" );
      }
      if (currentState is DownloadProgressTwo ){
        yield currentState.copyWith(event.progress);
      }else{
        yield DownloadProgressTwo(progress: event.progress);
      }
    }
  }



}


/*
* */


class DownloadEventThree extends Equatable {

  @override
  List<Object> get props => [];

}
class StartDownloadEventThree extends DownloadEventThree {

}
class DownloadProgressEventThree extends DownloadEventThree {
  final double progress;

  DownloadProgressEventThree({ @required this.progress}): assert( progress != null );

  @override
  List<Object> get props => [progress];

}


class StateThree  extends Equatable {

  @override
  List<Object> get props => [];

}
class StopDownloadThree   extends StateThree{

}
class DownloadProgressThree   extends StateThree {


  final double progress;

  DownloadProgressThree({@required this.progress}): assert( progress != null );

  DownloadProgressThree copyWith( double progress ){
    return DownloadProgressThree( progress: progress ?? this.progress);
  }

  @override
  List<Object> get props => [progress];

}


class DownloadBlockThree extends Bloc<DownloadEventThree, StateThree> {

  DownloadRepo _downloadRepo;
  int startTime = 0;
  int endTime = 0;

  DownloadBlockThree(DownloadRepo downloadRepo) : super(StopDownloadThree()) {
    this._downloadRepo = downloadRepo;
  }

  @override
  Stream<StateThree> mapEventToState(DownloadEventThree event) async* {
    final currentState = state;
    if(event is StartDownloadEventThree){
      startTime = DateTime.now().microsecondsSinceEpoch;
      _downloadRepo.download(_downloadRepo.pdf,'test3.pdf', (progress, name) => add(DownloadProgressEventThree(progress: progress)) );
    }else if (event is DownloadProgressEventThree){
      if(event.progress == 100){
        endTime = DateTime.now().microsecondsSinceEpoch;
        print("#3 start: $startTime, end: $endTime, diff: " + ((startTime - endTime).fromMictoSec()).toString() + " in sec");
      }
      if (currentState is DownloadProgressThree ){
        yield currentState.copyWith(event.progress);
      }else{
        yield DownloadProgressThree(progress: event.progress);
      }
    }
  }

}
