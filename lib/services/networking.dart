import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;


  // TODO: for studing the api workflow then this is the first file from where we need to start to see the work flow



// 0.0 here we are getting the url of the api and then if the
// status code is 200 then we are getting the data from the api
  NetworkHelper({this.url});

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // 0.1 here we are converting the response from the api into JSON format
      // and returning it 
      String data = response.body;
      return jsonDecode(data);
    } else {
      return response.statusCode;
    }
  }
}
