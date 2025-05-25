import 'dart:convert';

import 'package:afran_provider/constant/app_apis.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/dio_client.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/home/screens/app_nav_bar.dart';
import 'package:afran_provider/home/screens/home_screen.dart';
import 'package:afran_provider/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  RxBool isLoading = false.obs;

  login(BuildContext context,dynamic data) async{
    isLoading.value = true;
     await DioClient().postAPI(
      loginApi,
        data

    ).then((result) async{
      isLoading.value = false;
       if(result != null && result['status'] == true){
         Map<String, dynamic> userData = result['data']['user'];
         final secureStorage = SecureStorageService();
         await secureStorage.write(userToken,'${result['data']['token']}');
         await secureStorage.write(user, jsonEncode(userData));
         UserModel userModel = UserModel.fromJson(userData);
         String? hh = await secureStorage.read(userToken);

         print('ddddddddddd${hh}');

         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => AppBottomNavBar(userModel: userModel,)),
         );


       }else{
         const snackBar = SnackBar(
             backgroundColor: Colors.red,
             content: Text('يوجد خطأ فى رقم الهاتف أو كلمة المرور'));
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
       }
    }).catchError((error){
      isLoading.value = false;
     });



  }
}