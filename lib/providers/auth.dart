import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/Model/httpException.dart';

class Auth with ChangeNotifier {
     String? _token;
    DateTime? _expiryDate;
   String? _userId;
   Timer? authTimer;


  bool get isAuth{
    return token !=null;
  }

  String?  get token{
    if( _expiryDate!=null && _expiryDate!.isAfter(DateTime.now())&& _token!=null)
    {
      return _token;
    }
    return null;

  }
  String? get userId{
    return _userId;
  }

  Future<void> _authenticate(String email, String password,String urlSegment )async {
    try {
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBOzOrFgq7NvhaHYyeM0EFum1teCZ_t2oA');
      final response = await http.post(url,
          body: json.encode(
              {
                'email': email,
                'password': password,
                'returnSecureToken': true
              }));
      final responseData=json.decode(response.body);
      if( responseData['error'] !=  null){
        throw HttpException(responseData['error']['message']);
      }
      _token=responseData['idToken'];
      _userId=responseData['localId'];
      _expiryDate=DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
      autoLogout();
      notifyListeners();
      final prefs= await SharedPreferences.getInstance();
      final userData=json.encode({'token':_token,'userId':userId,'expiryDate':_expiryDate!.toIso8601String()});
      prefs.setString('userData',userData);

    }
    catch(error){
      throw error;
    }

  }

  Future<void> signUp(String email, String password) async {
   return _authenticate(email,password,'signUp');
  }

  Future<void >Login(String email, String password)async
  {
    return _authenticate(email,password,'signInWithPassword');
  }
  Future<bool>tryAutoLogin()async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      print('hello');
      return false;
    }
    try {
      final extractedUserData = json.decode(
          prefs.getString('userData')!) as Map<String, dynamic>;

      final expiryDate = DateTime.parse(
          extractedUserData['expiryDate'] as String);
      if (expiryDate.isBefore(DateTime.now())) {
        print('hello1');
        return false;
      }
      _token = extractedUserData['token'] as String;
      _userId = extractedUserData['userId'] as String;
      _expiryDate = expiryDate;

      notifyListeners();
      autoLogout();
      print('hello3');
      return true;
    }
    catch(error){
      print(error);
      throw error;

    }
  }



  Future<void> logOut() async{
    _token=null;
    _userId=null;
    _expiryDate=null;
    if(authTimer!= null){
      authTimer!.cancel();
      authTimer=null;
    }
    notifyListeners();
    final prefs= await SharedPreferences.getInstance();
    prefs.clear();
  }
  void autoLogout(){
    if(authTimer !=null){
     authTimer!.cancel();
    }
    int logoutTimer=_expiryDate!.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: logoutTimer),logOut);
  }
}
