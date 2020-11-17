import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/warehouse_ivsf_and_selected_ideas_data.dart' as ratingsWH;
import 'dart:convert';

class WareHouseratingsWHRatingsApiProvider{

  Future<String> getImpactAndFeasibilityRatings(context) async {

    String url = globals.urlSignUp + "getWareHouseImpactsAndFeasibilityRatings.php";

    http.post(url, body: {

      "sprintID": home.selectedSprintId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ratingsWH.responseArrayGetWareHouseIvsF = jsonDecode(response.body);
      print(ratingsWH.responseArrayGetWareHouseIvsF);

      ratingsWH.responseArrayGetWareHouseIvsFMsg = ratingsWH.responseArrayGetWareHouseIvsF['message'].toString();
      print(ratingsWH.responseArrayGetWareHouseIvsFMsg);
      if(statusCode == 200){
        if(ratingsWH.responseArrayGetWareHouseIvsFMsg == "Painpoint Data Found"){

          ratingsWH.impactRatingsList = List.generate(ratingsWH.responseArrayGetWareHouseIvsF['data'].length, (i) => ratingsWH.responseArrayGetWareHouseIvsF['data'][i]['ifImpact'].toString());
          ratingsWH.feasibilityRatingsList = List.generate(ratingsWH.responseArrayGetWareHouseIvsF['data'].length, (i) => ratingsWH.responseArrayGetWareHouseIvsF['data'][i]['ifFeasibility'].toString());
          ratingsWH.ideaImagesList = List.generate(ratingsWH.responseArrayGetWareHouseIvsF['data'].length, (i) => ratingsWH.responseArrayGetWareHouseIvsF['data'][i]['iiImgpath'].toString());

          print(ratingsWH.impactRatingsList.toList());
          print(ratingsWH.feasibilityRatingsList.toList());
          print(ratingsWH.ideaImagesList.toList());

        }else{

          ratingsWH.impactRatingsList = null;

        }
      }
    });
  }

  Future<String> getIdeaImagesByStatus(context) async {

    String url = globals.urlSignUp + "getideaimagesbystatus.php";

    http.post(url, body: {

      "sprintID" : home.selectedSprintId.toString(),
      "status" : "2",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ratingsWH.responseArrayGetAllIdeaImagesByStatus = jsonDecode(response.body);
      print(ratingsWH.responseArrayGetAllIdeaImagesByStatus);

      ratingsWH.responseArrayGetAllIdeaImagesByStatusMsg = ratingsWH.responseArrayGetAllIdeaImagesByStatus['message'].toString();
      print(ratingsWH.responseArrayGetAllIdeaImagesByStatusMsg);

      if(ratingsWH.responseArrayGetAllIdeaImagesByStatusMsg == "Painpoint Data Found"){

        ratingsWH.ideaAllImagesOfStatusTwo = List.generate(ratingsWH.responseArrayGetAllIdeaImagesByStatus['data'].length, (i) => ratingsWH.responseArrayGetAllIdeaImagesByStatus['data'][i]['iiImgpath'].toString());

        print(ratingsWH.ideaAllImagesOfStatusTwo.toList());

      }else{

        ratingsWH.ideaAllImagesOfStatusTwo = null;

      }

    });
  }

}