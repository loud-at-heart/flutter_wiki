import 'networking.dart';

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
  Future<dynamic> searchWiki(String searchQuery) async {
    List<String> list = searchQuery.split(' ');
    searchQuery = list.join('%20');
    var url = '$bookAPIUrl&gpssearch=$searchQuery';
    NetworkHelper networkHelper = NetworkHelper(url);
    var catalogData = await networkHelper.getData();
    return catalogData;
  }
}