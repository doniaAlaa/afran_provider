import 'dart:convert';
import 'dart:io';

import 'package:afran_provider/constant/app_apis.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/dio_client.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/home/models/product_model.dart';
import 'package:afran_provider/home/screens/app_nav_bar.dart';
import 'package:afran_provider/models/user_model.dart';
import 'package:afran_provider/products/models/size_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ProductDetailsController extends GetxController{

  RxBool loading = false.obs;
  ProductModel? productModel;


  @override
  void onInit() {
    super.onInit();

    // Your initialization logic here
    print("Controller initialized");
  }
  @override
  void onClose() {
    print('Controller is being disposed!');
    super.onClose();
  }

  getProductDetails(BuildContext context,int productId) async{

    loading.value = true;

    await DioClient().getAPI(
        '$baseUrl/products/$productId?lat=29.787310&long=31.301227',

    ).then((result) async{
      loading.value = false;
      print('vvvvvvvvv${result['data']}');
      if(result != null && result['status'] == true){

        productModel = ProductModel.fromJson(result['data']);

      }else {

      }
    }).catchError((error){
      loading.value = false;
    });
  }








}