import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApiProvider {

  Future<String> getProfile(context) async {

    String url = globals.urlLogin + "getprofile.php";

    http.post(url, body: {

      "userID" : profile.userID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      profile.responseArrayProfile = jsonDecode(response.body);
      print(profile.responseArrayProfile);

      profile.email = profile.responseArrayProfile['data']['userEmail'].toString();
      profile.name = profile.responseArrayProfile['data']['userFullname'].toString();

      print(profile.email);

      profile.nameList = profile.name.split(' ');
      print(profile.nameList.toList());

    });
  }

  getSideBarProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profile.userID = prefs.getString("userID").toString();
    print(profile.userID);
  }

}