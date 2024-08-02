import 'package:filter/Services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/model.dart';

class SProvider extends ChangeNotifier {

  Models data = Models(items: {}) ;
  DataServices dataServices = DataServices();
  List<List> l = [];

  getPostData(context) async{
    data = await dataServices.fetchData(context);
    data.items.forEach((key, value) {
      List sublist = [value.title , value.duration , value.locationNames.toString() ];
      //sublist.addAll(value.locationNames);
      l.add(sublist);
    });
    notifyListeners();
  }

}