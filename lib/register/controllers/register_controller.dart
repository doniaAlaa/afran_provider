import 'dart:convert';

import 'package:afran_provider/constant/app_apis.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/dio_client.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/home/screens/app_nav_bar.dart';
import 'package:afran_provider/models/user_model.dart';
import 'package:afran_provider/register/models/product_category_model.dart';
import 'package:afran_provider/register/screens/register_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:google_maps_flutter/google_maps_flutter.dart';


class RegisterController extends GetxController{
  //////////STEP 1//////////
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmationController = TextEditingController();
  ///////////STEP 2/////////
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController nationalController = TextEditingController();
  TextEditingController commercialController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController taxCertificateController = TextEditingController();
  /////////////STEP 3////////////
  TextEditingController familyNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController familyPhoneController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  RxList<ProductCategoryModel> productCategories  = <ProductCategoryModel>[].obs;

  RxBool categoriesLoading = false.obs;
  RxBool loading = false.obs;
  RxInt selectedCategoryId = (-1).obs;
  //////////LOCATION////////
  LatLng? latLng;
  String? location;









  TimeOfDay? selectedTime;

  Future<void> selectTime(BuildContext context,bool start) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      start ?
      startTimeController.text = picked.format(context):
      endTimeController.text = picked.format(context)
      ;
      // setState(() {
      //   selectedTime = picked;
      // });
    }
  }
  ////GET PRODUCT CATEGORIES///
  getProductCategories() async{
    categoriesLoading.value =true;
    await DioClient().getAPI(
      getProductCategoriesApi,


    ).then((result) async{
      categoriesLoading.value = false;
      if(result != null && result['status'] == true){
        List<dynamic> data = result['data'];
        productCategories.clear();
        data.forEach((e){
          productCategories.add(ProductCategoryModel.fromJson(e));
        });

      }else {}
    }).catchError((error){
      categoriesLoading.value = false;
    });
  }

  ////REGISTER ACCOUNT///
  register(BuildContext context) async{
    print(nameController.text);
    print(phoneController.text);
    print(emailController.text);
    print(passController.text);
    print(ownerNameController.text);
    print(startTimeController.text);
    print(endTimeController.text);
    print(familyPhoneController.text);
    print(selectedCategoryId.value);
    dio.FormData formData = dio.FormData.fromMap({
      "name": nameController.text,
      "phone":phoneController.text,
      "email":emailController.text,
      "password":passController.text,
      "role":'provider',
      "is_active":"0",
      "lat":"29.786005",
      "long":"31.306943",
      "location":"Nasr city",
      "owner":ownerNameController.text,
      "category_id":selectedCategoryId.value,
      "open":startTimeController.text,
      "close":endTimeController.text,

      // "image": await MultipartFile.fromFile(filePath, filename: fileName),

    });
    // loading.value =true;
    await DioClient().postAPI(
      registerApi,
      formData

    ).then((result) async{
      loading.value = false;
      if(result != null && result['status'] == true){
        Map<String, dynamic> userData = result['data']['user'];
        print(result['data']['user'].runtimeType);
        final secureStorage = SecureStorageService();
        //
        await secureStorage.write(userToken,'${result['data']['token'].toString()}');
        await secureStorage.write(user, jsonEncode(userData));
        UserModel userModel = UserModel.fromJson(userData);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterSuccessScreen(userModel: userModel,)),
        );




      }else {
        loading.value = false;

      }
    }).catchError((error){
      loading.value = false;
    });
  }




}