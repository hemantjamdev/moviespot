import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';
import 'package:moviespot/model/people_model.dart';

class PersonProvider extends ChangeNotifier {
  PeopleModel peopleModel = PeopleModel();

  Future<PeopleModel> getPersonDetail(int personId) async {
    final res=await API.getPersonDetails(personId);
   return peopleModel =  PeopleModel.fromJson(
       res as Map<String, dynamic>);
  }
}
