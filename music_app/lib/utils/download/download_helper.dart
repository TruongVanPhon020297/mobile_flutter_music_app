import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadHelper {

  final ReceivePort port = ReceivePort();

  Future<String> download(String url) async {

    String? path;

    String fileName = '${DateTime.now().microsecond}.mp3';

    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();
      path = baseStorage!.path;
      await FlutterDownloader.enqueue(
        url: url,
        fileName: fileName,
        savedDir: baseStorage.path,
        showNotification: true,
        openFileFromNotification: true,
      );
    }

    return '${path!}/$fileName';

  }

  registerCallback() {
    FlutterDownloader.registerCallback(downloadCallback);
  }


  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status.value, progress]);
  }

  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

}