import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_bar.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/home/controllers/home_controller.dart';
import 'package:afran_provider/home/models/product_model.dart';
import 'package:afran_provider/products/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatefulWidget {
  List<ProductModel> products;
   AllProductsScreen({super.key,required this.products});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //     foregroundColor: Colors.white,
        //     backgroundColor: Colors.white,
        //     surfaceTintColor: Colors.white,
        //     // shadowColor: Colors.white,
        //     leading: Icon(Icons.arrow_back_ios,size: 20,color: darkPurple2,),
        //     titleSpacing: 0,
        //     title:  Text('المنتجات',style: text70018.copyWith(color: darkPurple2),)),
        appBar: MainAppBar(title: 'المنتجات'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
            child: Column(
              children: [
                Obx((){
                  return homeController.loading.value? Center(
                    child: Container(
                        height: 40,width: 40,
                        child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.6,)),
                  ):
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: homeController.products.length,
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
                                          children: [
                                            Container(
                                                height: 104,width: 104,
                                                child: Image.asset('assets/images/food1.png')),
                                            SizedBox(width: 16,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(homeController.products[index].name??'',style: text50016,),

                                                SizedBox(height: 4,),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(time),
                                                    SizedBox(width: 4,),
                                                    Text('يستغرق : '+'${homeController.products[index].duration}${homeController.products[index].duration_type}',style: text50012,),

                                                  ],
                                                ),
                                                SizedBox(height: 8,),
                                                Text('المكونات : '+'${homeController.products[index].description}',style: text50012,),
                                                SizedBox(height: 8,),
                                                // Text(products[index].price??'',style: text70016.copyWith(color: darkPurple2),)
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
                                                onPressed: (){}, title: 'حذف'),
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

                      });

                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

