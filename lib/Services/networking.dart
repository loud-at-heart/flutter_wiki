import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getDataFromURL(String fileName, bool onSubmitted) async {
    /*
    * Data is fetched using url if there is no json related
    * Once the data is fetched it strored in local directory as cache result
    */
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      if (onSubmitted) {
        var tempDir = await getTemporaryDirectory();
        File file = new File(tempDir.path + "/" + fileName);
        file.writeAsString(data, flush: true, mode: FileMode.write);
        print('Saved to Cache');
      }
      return jsonDecode(data);
    } else
      print(response.statusCode);
  }

  //Data is fetched using local cached Json file
  Future<dynamic> getDataFromJson() async {
    return jsonDecode(url);
  }
}
