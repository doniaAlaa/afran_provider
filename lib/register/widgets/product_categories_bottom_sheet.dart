import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/products/controllers/add_product_controller.dart';
import 'package:afran_provider/products/models/size_model.dart';
import 'package:afran_provider/register/controllers/register_controller.dart';
import 'package:afran_provider/register/models/product_category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCategoriesBottomSheet{


  getProductCategories(BuildContext context,RegisterController registerController){
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
            height: 300,
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
                  Text("اختر فئة المنتجات",style: text70016,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
                    child: Obx((){
                      return registerController.categoriesLoading.value? CircularProgressIndicator(color: darkPurple,strokeWidth: 1.6,):

                      Container(
                        height: 180,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: registerController.productCategories.length,
                            itemBuilder: (context,index){
                              List<ProductCategoryModel> categories = registerController.productCategories;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: InkWell(
                                    onTap: (){
                                      registerController.selectedCategoryId.value = categories[index].id??-1;
                                      registerController.productCategoryController.text = categories[index].name.toString();
                                      // print('uuuuuuuuuuuu${addProductController.selectedSizeId.value}');
                                    },
                                    child: Obx((){
                                      return Row(
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
                                                    color:registerController.selectedCategoryId.value == categories[index].id? darkPurple:null
                                                ),),
                                            ),
                                          ),
                                          SizedBox(width: 16,),
                                          Text(categories[index].name??''),
                                        ],
                                      );
                                    })
                                ),
                              );
                            }),
                      );
                    }),
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