import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

class GetSprintGoalApiProvider{

  Future<String> getSprintGoal(context) async {

    String url = globals.urlLogin + "getgoals.php";

    http.post(url, body: {

      "sprintID" : home.selectedSprintId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      home.responseArrayGetGoal = jsonDecode(response.body);
      print(home.responseArrayGetGoal);

      home.responseArrayGetGoalMsg = home.responseArrayGetGoal['message'].toString();
      if(statusCode == 200){
        if(home.responseArrayGetGoalMsg == "Data Found"){

          home.sprintGoalList = home.responseArrayGetGoal['data'][0]['goalName'].toString();

          print(home.sprintGoalList);

        }else{

          home.sprintGoalList = null;

        }
      }
    });
  }

}