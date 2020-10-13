import 'dart:ffi';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class DownloadSingleModel {
  String name = '';
  double progress = 0.0;
  int startTime = 0;
  int endTime = 0;
}


class DownloadDelegate {
  void progressOne(String name, double progressInDouble){}
  void progressTwo(String name, double progressInDouble){}
  void progressThree(String name, double progressInDouble){}
}

typedef OnProgress(double progress, String name);

class DownloadUseCase {
 // Dio dio = Dio();
  DownloadDelegate downloadDelegate;
  DownloadRepo _downloadRepo;


  
  DownloadUseCase(this.downloadDelegate, DownloadRepo downloadRepo){
    this._downloadRepo = downloadRepo;
  }

  void downloadAll() {

    _downloadRepo.download(_downloadRepo.rtf, '1_new.rtf', (progress, name) => {
      downloadDelegate.progressOne("#1 $name", progress)
    });

    _downloadRepo.download(_downloadRepo.rtf, '2_new.rtf', (progress, name) => {
      downloadDelegate.progressTwo("#2 $name", progress)
    });
    _downloadRepo.download(_downloadRepo.rtf, '3_new.rtf', (progress, name) => {
      downloadDelegate.progressThree("#3 $name", progress)
    });
  }



}


class DownloadRepo {

  final pdf = 'https://ars.els-cdn.com/content/image/1-s2.0-S2211124719302785-mmc2.pdf';
  final mp3 = 'https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_5MG.mp3';
  final docx = 'https://file-examples-com.github.io/uploads/2017/02/file-sample_1MB.docx';
  final rtf = 'https://file-examples-com.github.io/uploads/2019/09/file-sample_100kB.rtf';


  Future<void> download(String url, String name, OnProgress onProgress) async{
    String saveAt = await getFilePath(name);
    time('======= #$name starting =======');
    await Dio().download(pdf,saveAt,
        options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            onProgress.call((received / total * 100), name);
          }
        });
    time('======= #$name stop =====');
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName';
    return path;
  }

  void time(String name){
    //DateTime now = DateTime.now();
    //String formattedDate = DateFormat('kk:mm:ss').format(now);
   // print('${name}  timeStamp: ' + DateTime.now().microsecondsSinceEpoch.toString());
  }


}