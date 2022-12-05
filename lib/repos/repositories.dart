import 'dart:convert';

import 'package:http/http.dart';

import '../models/User.dart';

class UserRepository {
  // from where we are going to fetch data
  String endPoint = "https://reqres.in/api/users?page=2";

  // this function is responsible for fetching data from the above endPoint with the help of http package

  Future <List<UserModel>> getUsers() async {
    Response response = await get(Uri.parse(endPoint));
    // check response
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      // pass result to UserModel and convert to a List
      return result.map((e) => UserModel.fromJson(e)).toList();

    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
