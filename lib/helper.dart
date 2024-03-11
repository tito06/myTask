import 'package:shared_preferences/shared_preferences.dart';

class Helper {

  static String userid = "";


  Future<bool> saveUserid(value) async{

    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userid, value);
  }



  static Future getUserid(value) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return  sharedPreferences.getString(userid);
  }

  
}