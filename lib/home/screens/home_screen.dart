import 'dart:convert';

import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/home/controllers/home_controller.dart';
import 'package:afran_provider/home/models/product_model.dart';
import 'package:afran_provider/home/widget/chart.dart';
import 'package:afran_provider/home/widget/delete_product_popup.dart';
import 'package:afran_provider/models/user_model.dart';
import 'package:afran_provider/products/screens/all_products_screen.dart';
import 'package:afran_provider/products/screens/edit_product_screen.dart';
import 'package:afran_provider/products/screens/product_details_screen.dart';
import 'package:afran_provider/track_order/screens/track_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeScreen extends StatefulWidget {
  final UserModel? userModel;
  const HomeScreen({super.key,this.userModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

   // UserModel userModel;
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      homeController.getProducts();

    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  // ArabicLineChart(),
                  Row(
                    children: [
                      Container(
                        height: 50,width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: purple

                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.network(
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                return Center(child: Container(
                                  height: 25,width: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: darkPurple,
                                  ),
                                ));
                              },
                              errorBuilder: (BuildContext context, Object exception,
                                  StackTrace? stackTrace) {
                                return Icon(Icons.error,color: darkPurple,size: 30,);
                              },
                              widget.userModel?.image??''),
                        ),

                      ),
                      SizedBox(width: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.userModel?.name??'',style: text70014,),
                          SizedBox(height: 4,),
                          Row(
                            children: [
                              SvgPicture.asset(pin),
                              SizedBox(width: 4,),
                              Text(widget.userModel?.location??'',style: text50012,),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('المنتجات',style: text70018.copyWith(color: darkPurple2),),
                      Obx((){
                        return homeController.products.isNotEmpty? InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AllProductsScreen(products: homeController.products,)),
                              );
                            },
                            child: Text('عرض الكل',style: text50012.copyWith(color: darkPurple,decoration: TextDecoration.underline),)):Container();

                      }),

                    ],
                  ),
                  SizedBox(height: 16,),
                  Obx((){
                    List<ProductModel> products = homeController.products;
                    return
                      homeController.loading.value ? Container(
                          height: 40,width: 40,
                          child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.6,)):
                      products.isEmpty ?

                      Column(
                        children: [
                          SvgPicture.asset(noData),
                          SizedBox(height: 16,),
                          Text('No Products Added Yet',style: text50016.copyWith(color: darkPurple),),
                        ],
                      )
                          :
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: products.length >=2 ? 2 : products.length,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ProductDetailsScreen(product: homeController.products[index],)),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: SizedBox(
                                child: DecoratedBox(decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    height: 104,width: 104,
                                                    child: Image.asset('assets/images/food1.png')),
                                                SizedBox(width: 16,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(products[index].name??'',style: text50016,),

                                                    SizedBox(height: 4,),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(time),
                                                        SizedBox(width: 4,),
                                                        Text('يستغرق : '+'${products[index].duration}${products[index].duration_type}',style: text50012,),

                                                      ],
                                                    ),
                                                    SizedBox(height: 8,),
                                                    Text('المكونات : '+'${products[index].description}',style: text50012,),
                                                    SizedBox(height: 8,),
                                                    Text('${products[index].price??''}'+' '+'ر.س',style: text70016.copyWith(color: darkPurple2),)

                                                  ],
                                                )
                                              ],
                                            ),
                                            Icon(Icons.keyboard_arrow_down_rounded,)
                                          ],
                                        ),
                                        SizedBox(height: 16,),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: MainAppButton(onPressed: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => EditProductScreen(product: homeController.products[index],)),
                                                  );
                                                },
                                                    icon: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                                      child: SvgPicture.asset(editIcon),
                                                    ),
                                                    title: 'تعديل'),
                                              ),
                                            ),
                                            SizedBox(width: 8,),
                                            Expanded(
                                              child: Container(

                                                child: MainAppButton(
                                                    backgroundColor: grey2,
                                                    titleColor: grey3,
                                                    onPressed: () async{
                                                      bool confirmed = await DeleteProductPopup().delete(context,homeController,homeController.products[index].id??-1);
                                                      print('confirmed: $confirmed');
                                                      if (confirmed) {
                                                        // User confirmed
                                                        homeController.deleteProductItem(products[index].id??-1,context);

                                                      } else {
                                                        // User cancelled or dismissed
                                                      }
                                                    }, title: 'حذف'),
                                              ),
                                            ),
                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });

                  }),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0,bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('الطلبات الحالية',style: text70018.copyWith(color: darkPurple2),),
                        Text('عرض الكل',style: text50012.copyWith(color: darkPurple,decoration: TextDecoration.underline),)
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: SizedBox(
                            child: DecoratedBox(decoration: BoxDecoration(
                              color: grey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 104,width: 104,
                                                child: Image.asset('assets/images/food1.png')),
                                            SizedBox(width: 16,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('مشكل مشوى',style: text50016,),
                                                SizedBox(height: 4,),
                                                Text('الأصناف : ٢ المندي بالدجاج',style: text50012.copyWith(color: darkPurple),),
                                                SizedBox(height: 4,),

                                                Text('الوقت : 2:45:30',style: text50012.copyWith(color: grey3),),
                                                SizedBox(height: 4,),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(pin),
                                                    SizedBox(width: 2,),
                                                    Text('العنوان',style: text50012.copyWith(color: grey3),),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Icon(Icons.keyboard_arrow_down_rounded,)
                                      ],
                                    ),
                                    SizedBox(height: 16,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: MainAppButton(onPressed: (){}, title: 'قبول'),
                                          ),
                                        ),
                                        SizedBox(width: 8,),
                                        Expanded(
                                          child: Container(

                                            child: MainAppButton(
                                                backgroundColor: grey2,
                                                titleColor: grey3,
                                                onPressed: (){}, title: 'رفض'),
                                          ),
                                        ),
                                      ],
                                    )

                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0,bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('طلبات جديدة',style: text70018.copyWith(color: darkPurple2),),
                        Text('عرض الكل',style: text50012.copyWith(color: darkPurple,decoration: TextDecoration.underline),)
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: SizedBox(
                            child: DecoratedBox(decoration: BoxDecoration(
                              color: grey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 104,width: 104,
                                                child: Image.asset('assets/images/food1.png')),
                                            SizedBox(width: 16,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('محمد عبد الله',style: text50016,),
                                                SizedBox(height: 4,),
                                                Text('الأصناف : ٢ المندي بالدجاج',style: text50012.copyWith(color: darkPurple),),
                                                SizedBox(height: 4,),

                                                Text('الوقت : 2:45:30',style: text50012.copyWith(color: grey3),),
                                                SizedBox(height: 4,),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(pin),
                                                    SizedBox(width: 2,),
                                                    Text('العنوان',style: text50012.copyWith(color: grey3),),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Icon(Icons.keyboard_arrow_down_rounded,)
                                      ],
                                    ),
                                    SizedBox(height: 16,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: MainAppButton(onPressed: (){}, title: 'قبول'),
                                          ),
                                        ),
                                        SizedBox(width: 8,),
                                        Expanded(
                                          child: Container(

                                            child: MainAppButton(
                                                backgroundColor: grey2,
                                                titleColor: grey3,
                                                onPressed: (){}, title: 'رفض'),
                                          ),
                                        ),
                                      ],
                                    )

                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  SizedBox(height: 50,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

