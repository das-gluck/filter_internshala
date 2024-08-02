
import 'dart:convert';

import 'package:filter/Model/model.dart';
import 'package:http/http.dart' as http;

class DataServices{

  String stringResponse = " ";
  Map<dynamic,dynamic> mapResponse = { } ;
  Map<String,dynamic> listResponse = { };
  //Map<dynamic,dynamic> mapp = { };
  List<dynamic> ll = [];
  late Models data;

  Future<Models> fetchData(context) async {
    const String url = 'https://internshala.com/flutter_hiring/search';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {

        mapResponse = jsonDecode(response.body);
        listResponse = mapResponse['internships_meta'];

        data = Models.fromJson(listResponse);

        // ll = listResponse.values.toList();

        print('list items: ${listResponse.length}');
        print("URL HIT");
        //print('Response data: ${ll[1]['location_names']}');
        print(data.items.length);

        data.items.forEach((key, value) {
          value.locationNames.forEach((element) {
            if(element.toLowerCase() == "gurgaon"){
              print("key: $key and value: ${value.title}");
            }
          });
        });

      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response failed : ${response.body}');
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
    }

    return data;

  }
}