import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/user_testing_data.dart' as userTesting;

class GetWareHouseInsightsApiProvider{

  Future getWareHouseInsights(context) async {

    String url = globals.urlSignUp + "getalldata.php";

    http.post(url, body: {

      "sprintID" : home.selectedSprintId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      userTesting.responseArrayGetWareHouseInsights = jsonDecode(response.body);
      print(userTesting.responseArrayGetWareHouseInsights.toString());

      userTesting.responseArrayGetWareHouseInsightsMsg = userTesting.responseArrayGetWareHouseInsights['message'].toString();
      print(userTesting.responseArrayGetWareHouseInsightsMsg);

      if(userTesting.responseArrayGetWareHouseInsightsMsg == "Data Found"){

        userTesting.wareHouseInsightsList = List.generate(userTesting.responseArrayGetWareHouseInsights['data3'].length, (i) => userTesting.responseArrayGetWareHouseInsights['data3'][i]['insightText'].toString());

        print(userTesting.wareHouseInsightsList.toList());

      }else{

        userTesting.wareHouseInsightsList = null;

      }

    });

  }

}