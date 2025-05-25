import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/home/models/product_model.dart';
import 'package:afran_provider/products/controllers/product_details_controller.dart';
import 'package:afran_provider/products/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  ProductDetailsScreen({required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  final PageController _controller = PageController();
  ProductDetailsController productDetailsController = Get.put(ProductDetailsController());

  final List<String> _images = [
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwViDCA89-gGtEOTcCAj2gUQSp8vbpY4nTWg&s'

  ];


  @override
  Widget build(BuildContext context) {
    productDetailsController.getProductDetails(context, widget.product.id??-1);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx((){
          return productDetailsController.loading.value? Center(child: CircularProgressIndicator(color: darkPurple,strokeWidth: 1.8,)) :SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Container(
                    // height: 250,
                    color: grey,
                    child:Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [

                                  InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back_ios, color: darkPurple)),
                                  SizedBox(width: 8,),
                                  Text(
                                    productDetailsController.productModel?.name??'',
                                    style: text70018.copyWith(color: darkPurple2),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  EditProductScreen(product: productDetailsController.productModel!)),
                                  );
                                },
                                child: Container(
                                    height: 40,width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle
                                    ),
                                    child:Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(editPurple,width: 30,height: 30,),
                                    )
                                ),
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 150,
                              child: Image.network(
                                _images[0].toString(),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16,)
                      ],
                    )
                    ,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productDetailsController.productModel?.name??'',
                              style:text70016,
                            ),
                            Text('${productDetailsController.productModel?.price??''}'+' '+'ر.س',style: text70016.copyWith(color: darkPurple2),),

                          ],
                        ),

                        SizedBox(height: 8,),
                        Text(
                            productDetailsController.productModel?.description??'',
                            style: text50014.copyWith(color: grey3)),
                        SizedBox(height: 16,),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              child:  Row(
                                children: [
                                  SvgPicture.asset(star),
                                  SizedBox(width: 4,),
                                  Text('٤',style: text50014,)
                                ],
                              ),
                            ),
                            SizedBox(width: 8,),

                            Row(
                              children: [
                                SvgPicture.asset(time),
                                SizedBox(width: 4,),
                                Text('${productDetailsController.productModel?.duration_type??''} ${productDetailsController.productModel?.duration??''}',style: text50014,)
                              ],
                            ),
                            SizedBox(width: 8,),
                            Row(
                              children: [
                                SvgPicture.asset(pin),
                                SizedBox(width: 4,),
                                Text('data',style: text50014,)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24,),

                        // Size Options
                        Row(
                          children: [
                            Text('الحجم:',style: text50014.copyWith(color: darkGrey),),
                            SizedBox(width: 8,),
                            Container(
                              height: 50,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: SizedBox(
                                        child: DecoratedBox(decoration: BoxDecoration(
                                            color: grey,
                                            borderRadius: BorderRadius.circular(8)
                                        ),child:  Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 9),
                                          child: Text(
                                            index == 0 ?'صغير':index == 1 ?'متوسط':'كبير',
                                            style: text50014,),
                                        ),),
                                      ),
                                    );
                                  }),
                            )

                          ],
                        ),
                        SizedBox(height: 24),

                        // Customization section
                        productDetailsController.productModel?.addons != null && productDetailsController.productModel!.addons!.isNotEmpty?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("خصم طلبك حسب رغبتك",style: text70016.copyWith(color: darkGrey),),
                            SizedBox(height: 16,),
                            ListView.builder(
                              shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: productDetailsController.productModel?.addons?.length,
                                itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: SizedBox(
                                  child: DecoratedBox(decoration: BoxDecoration(
                                      color: grey,
                                      borderRadius: BorderRadius.circular(20)
                                  ),child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Text(productDetailsController.productModel?.addons![index].name??'',style: text50016.copyWith(color: darkGrey),),
                                        Row(
                                          children: [
                                            Text('${productDetailsController.productModel?.addons![index].price??''}'+' '+'ر.س',style: text70014.copyWith(color: darkPurple2),),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),),
                                ),
                              );
                            })


                          ],
                        ):SizedBox(),


                        SizedBox(height: 24,),
                        Text("التقييمات",style: text70016.copyWith(color: darkGrey),),
                        SizedBox(height: 16),

                        // Review
                        Container(
                          decoration: BoxDecoration(
                              color: grey,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 72,width: 72,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child: Image.network(
                                              fit: BoxFit.cover,
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTefdAYZ6uy2rn4ODl9zSL1KwCAhiEPo9Xm-g&s')),
                                    ),
                                    SizedBox(width: 16,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("محمود أحمد",style: text70016),
                                        SizedBox(height: 4,),
                                        Row(
                                          children: List.generate(5, (i) => SvgPicture.asset(star)),
                                        ),
                                        SizedBox(height: 4,),
                                        Text("منذ ٥ دقايق",style: text40010.copyWith(color: grey3,fontSize: 12)),

                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Divider(color: grey2,thickness: 2,),
                                ),
                                Text("الطلب وصل في الوقت المحدد، والطعام كان لذيذًا جدًا. خدمة ممتازة.",style: text40010.copyWith(color: grey3,fontSize: 12)),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(

                          decoration: InputDecoration(
                            hintText: 'عبر عن رأيك',
                            suffixIcon: Column(
                              children: [
                                Container(
                                    height: 30,width: 30,
                                    child: Image.asset(send)),
                              ],
                            ),
                            hintStyle: text50014.copyWith(color: grey3),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: grey2), // Normal border
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: grey2, width: 2), // On focus
                              borderRadius: BorderRadius.circular(12),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),

                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   // height: 140,
                  //   decoration: BoxDecoration(
                  //       color: grey,
                  //       borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text("٨ ر.س",style: text70020.copyWith(color: darkPurple2),),
                  //             Container(
                  //               decoration: BoxDecoration(
                  //                   color: purple,
                  //                   borderRadius: BorderRadius.circular(12)
                  //               ),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 12),
                  //                 child: Row(
                  //                   children: [
                  //                     Container(
                  //                       height: 22,width: 22,
                  //                       decoration: BoxDecoration(
                  //                           color: darkPurple,
                  //                           shape: BoxShape.circle
                  //                       ),
                  //                       child: Icon(Icons.add,color: Colors.white,size: 16,),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //                       child: Text('1',style: text70014.copyWith(color: darkPurple),),
                  //                     ),
                  //                     Container(
                  //                       height: 22,width: 22,
                  //                       decoration: BoxDecoration(
                  //                           color: Colors.white,
                  //                           shape: BoxShape.circle
                  //                       ),
                  //                       child: Icon(Icons.remove,color: darkPurple,size: 16,),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             )
                  //
                  //           ],
                  //         ),
                  //         SizedBox(height: 16,),
                  //         MainAppButton(
                  //             icon: Padding(
                  //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //               child: SvgPicture.asset('assets/images/cart.svg'),
                  //             ),
                  //             onPressed: (){
                  //               // Navigator.push(
                  //               //   context,
                  //               //   MaterialPageRoute(builder: (context) =>  CartStepper()),
                  //               // );
                  //
                  //             }, title: 'أضف إلى السلة')
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        })

      ),
    );
  }
}
