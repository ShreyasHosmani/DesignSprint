import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UploadDigitalPersona {

  Future<String> uploadIdeaImage(context) async {

    String url = globals.urlSignUp + "test.php";

    ideation.base64ideaImage = base64Encode(ideation.imageOne.readAsBytesSync());

    ideation.ideaImageName = ideation.imageOne.path.split("/").last;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('test_image', ideation.imageOne.path);

    http.post(url, body: {

      "image" : ideation.base64ideaImage,
      "name": ideation.ideaImageName,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      print(response.body.toString());

    });
  }

}