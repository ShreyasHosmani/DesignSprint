import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/user_testing_data.dart' as userTesting;

class InsightsApiProvider{

  Future<String> addInsights(context) async {

    String url = globals.urlSignUp + "createinsight.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,
      "text" : userTesting.painPointController.text,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      userTesting.responseArrayAddInsights = jsonDecode(response.body);
      print(userTesting.responseArrayAddInsights);

      userTesting.responseArrayAddInsightsMsg = userTesting.responseArrayAddInsights['message'].toString();
      print(userTesting.responseArrayAddInsightsMsg);
      if(statusCode == 200){
        if(userTesting.responseArrayAddInsightsMsg == "Insights Added Successfully"){
          print("Insight saved");
          userTesting.uploadedInsightsList.add(userTesting.painPointController.text);
          print(userTesting.uploadedInsightsList.toList());
          userTesting.painPointController.clear();
        }else{
          print("error");
        }
      }
    });
  }

}