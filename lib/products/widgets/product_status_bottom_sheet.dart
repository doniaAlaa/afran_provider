import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/products/controllers/add_product_controller.dart';
import 'package:afran_provider/products/controllers/edit_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductStatusBottomSheet{


  chooseProductStatus(BuildContext context,dynamic controllerObject,bool addProduct,){
    dynamic controller;
    if(addProduct == true){
      controller  = controllerObject as AddProductController;
    }else{
      controller  = controllerObject as EditProductController;
    }
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: 260,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white,

            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("اختر حالة المنتج",style: text70016,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
                    child:  Container(
                      height: 100,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 2,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: InkWell(
                                onTap: (){
                                  controller.selectProductStatus(index);

                                },
                                child:Obx((){
                                  return  Row(
                                    children: [
                                      Container(
                                        height: 20,width: 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: darkPurple)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 15,width: 15,

                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:controller.selectedProductStatus.value == index? darkPurple:null
                                            ),),
                                        ),
                                      ),
                                      SizedBox(width: 16,),
                                      Text(index == 1? 'متاح':"غير متاح",),
                                    ],
                                  );
                                })
                              ),
                            );
                          }),
                    )
                  )

                ],
              ),
            ),
          ),
        );
      },
    );

  }
}