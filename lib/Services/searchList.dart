import 'dart:io';
import 'networking.dart';
import 'package:path_provider/path_provider.dart';

const bookAPIUrl = 'https://en.wikipedia.org//w/api.php?'
    'action=query'
    '&format=json'
    '&prop=extracts%7Cpageimages%7Cpageterms%7Cinfo'
    '&inprop=url'
    '&generator=prefixsearch'
    '&formatversion=2'
    '&piprop=thumbnail'
    '&pithumbsize=50'
    '&wbptterms=description'
    '&exsentences=5'
    '&exintro=1'
    '&explaintext=1'
    '&gpslimit=50';

class CatalogService {
  deleteAllCache() async {
    //Deleting the cache files which is stored in the temporary directory
    var cacheDir = (await getTemporaryDirectory()).path;
    Directory(cacheDir).delete(recursive: true);
  }

  Future<dynamic> searchWiki(String searchQuery, bool onSubmitted) async {
    String fileName = "$searchQuery.json";
    var cacheDir = await getTemporaryDirectory();
    if (await File(cacheDir.path + "/" + fileName).exists()) {
      //If the files are available in cache then the files will be viewd here
      print('Reading from Cache');
      var jsonData = File(cacheDir.path + "/" + fileName).readAsStringSync();
      NetworkHelper networkHelper = NetworkHelper(jsonData);
      var catalogData = await networkHelper.getDataFromJson();
      return catalogData;
    } else {
      print('Getting from API');
      List<String> list = searchQuery.split(' ');
      searchQuery = list.join('%20');
      var url = '$bookAPIUrl&gpssearch=$searchQuery';
      NetworkHelper networkHelper = NetworkHelper(url);
      var catalogData =
          await networkHelper.getDataFromURL(fileName, onSubmitted);
      return catalogData;
    }
  }
}
