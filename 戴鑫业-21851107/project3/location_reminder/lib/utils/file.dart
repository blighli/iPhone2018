import "package:path_provider/path_provider.dart";
import "dart:io";

class MyFile {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> write(String contents) async {

    final file = await _localFile;
    // Write the file
    print("MyFile: 写入文件: \r $contents");
    return file.writeAsString('$contents');
  }

  Future<String> read() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If we encounter an error, return 0
      return "";
    }
  }
}
