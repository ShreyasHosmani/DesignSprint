import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/warehouse_pain_points_data.dart' as painPointWH;
import 'dart:convert';

class WareHousePainPointApiProvider{

  Future<String> getAllPainPoints(context) async {

    String url = globals.urlSignUp + "getwarehousecrazydocuments.php";

    http.post(url, body: {

      "sprintID": home.selectedSprintId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      painPointWH.responseArrayWHPainPoints = jsonDecode(response.body);
      print(painPointWH.responseArrayWHPainPoints);

      painPointWH.responseArrayWHPainPointsMsg = painPointWH.responseArrayWHPainPoints['message'].toString();
      print(painPointWH.responseArrayWHPainPointsMsg);
      if(statusCode == 200){
        if(painPointWH.responseArrayWHPainPointsMsg == "Painpoint Data Found"){

          painPointWH.responseArrayWHPainPointsIdsList = List.generate(painPointWH.responseArrayWHPainPoints['data'].length, (i) => painPointWH.responseArrayWHPainPoints['data'][i]['ppID'].toString());
          painPointWH.responseArrayWHPainPointsList = List.generate(painPointWH.responseArrayWHPainPoints['data'].length, (i) => painPointWH.responseArrayWHPainPoints['data'][i]['ppName'].toString());

          print(painPointWH.responseArrayWHPainPointsIdsList.toList());
          print(painPointWH.responseArrayWHPainPointsList.toList());

        }else{

          painPointWH.responseArrayWHPainPointsList = "1";

        }
      }
    });
  }

  Future<String> getIdeaImagesPainPointWise(context) async {

    String url = globals.urlSignUp + "getwarehouseideas.php";

    http.post(url, body: {

      "painpointiD": painPointWH.selectedPainPointIdForIdeaImage.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      painPointWH.responseArrayWareHouseIdeaImages = jsonDecode(response.body);
      print(painPointWH.responseArrayWareHouseIdeaImages);

      painPointWH.responseArrayWareHouseIdeaImagesMsg = painPointWH.responseArrayWareHouseIdeaImages['message'].toString();
      print(painPointWH.responseArrayWareHouseIdeaImagesMsg);
      if(statusCode == 200){
        if(painPointWH.responseArrayWareHouseIdeaImagesMsg == "Painpoint Data Found"){

          painPointWH.wareHouseIdeaImagesList = List.generate(painPointWH.responseArrayWareHouseIdeaImages['data'].length, (i) => painPointWH.responseArrayWareHouseIdeaImages['data'][i]['iiImgpath'].toString());
          print(painPointWH.wareHouseIdeaImagesList.toList());

        }else{

          painPointWH.wareHouseIdeaImagesList = "1";

        }
      }
    });
  }

}