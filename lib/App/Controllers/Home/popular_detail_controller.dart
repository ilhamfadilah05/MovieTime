import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopularDetailController extends GetxController {
  var date = DateTime.now().obs;
  var biography = "".obs;
  var birthday = "".obs;
  var departement = "".obs;
  var name = "".obs;
  var placeBirthday = "".obs;
  var profilePath = "".obs;
  var isLoading = false.obs;

  void getData() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("idPeople")!;
    var request = http.Request(
        'GET',
        Uri.parse('https://api.themoviedb.org/3/person/' +
            id +
            '?api_key=d6d6da69c088ce5c38ae7a00582ad1c4&language=en-US'));

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    final dataa = json.decode(responseString);
    if (response.statusCode == 200) {
      biography.value = dataa['biography'];
      birthday.value = dataa['birthday'];
      departement.value = dataa['known_for_department'];
      name.value = dataa['name'];
      placeBirthday.value = dataa['place_of_birth'];
      profilePath.value = dataa['profile_path'];
      isLoading.value = false;
      date.value = DateTime.parse(birthday.value);
      birthday.value = DateFormat("dd MMMM yyyy").format(date.value).toString();
    } else {
      print("ERROR !");
    }
  }
}
