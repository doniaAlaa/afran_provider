import 'dart:convert';

import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/models/user_model.dart';
import 'package:afran_provider/profile/screens/faq_screen.dart';
import 'package:afran_provider/profile/screens/favorite_screen.dart';
import 'package:afran_provider/profile/screens/my_orders_screen.dart';
import 'package:afran_provider/profile/screens/payment_methods.dart';
import 'package:afran_provider/profile/screens/privacy_policy_screen.dart';
import 'package:afran_provider/profile/screens/reviews_screen.dart';
import 'package:afran_provider/profile/screens/setting_notifications_screen.dart';
import 'package:afran_provider/profile/widgets/logout_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'user_info_screen.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel? userModel;
  const ProfileScreen({super.key,this.userModel});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 64,width: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: grey
            
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image.network(
                                fit: BoxFit.cover,
                                'https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fHww',
                                //
                                // loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                //   return Center(child: Container(
                                //     height: 25,width: 25,
                                //     child: CircularProgressIndicator(
                                //       strokeWidth: 1,
                                //       color: darkPurple,
                                //     ),
                                //   ));
                                // },
                            ),
                          ),
            
                        ),
                        SizedBox(width: 16,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userModel?.name??'',style: text70016,),
                            SizedBox(height: 4,),
                            Row(
                              children: [
                                SvgPicture.asset(pin),
                                Text(userModel?.location??'',style: text50014,),
                              ],
                            ),
                          ],
                        )
            
                      ],
                    ),
                    InkWell(
                      onTap: () async{
                        final secureStorage = SecureStorageService();
                        //
                        String? userData = await secureStorage.read(user);
                        UserModel userModel = UserModel.fromJson(jsonDecode(userData!));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  UserInfoScreen(userModel: userModel,)),
                        );
                      },
                      child: Container(
                        height: 40,width: 40,
                        decoration: BoxDecoration(
                          color: darkPurple,
                          shape: BoxShape.circle
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(editIcon),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24,),
                Container(
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(16),
            
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async{
                            final secureStorage = SecureStorageService();
                            //
                            String? userData = await secureStorage.read(user);
                            UserModel userModel = UserModel.fromJson(jsonDecode(userData!));
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  UserInfoScreen(userModel: userModel,)),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,width: 40,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: darkPurple
                                    ),child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(userInterface),
                                    ),),
            
                                  ),
                                  SizedBox(width: 16,),
                                  Text('بياناتي',style: text50014,)
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_sharp,color: darkPurple,size: 18,),
                            ],
                          ),
                        ),
                        SizedBox(height: 16,),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  OrdersScreen()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,width: 40,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: darkPurple
                                    ),child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(orders),
                                    ),),
                                  ),
                                  SizedBox(width: 16,),
                                  Text('الطلبات',style: text50014,)
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_sharp,color: darkPurple,size: 18,),
                            ],
                          ),
                        ),

                        SizedBox(height: 16,),
                        InkWell(
                          onTap: (){

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  ReviewsScreen()),
                            );
                          },
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,width: 40,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: darkPurple
                                    ),child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(review),
                                    ),),
                                  ),
                                  SizedBox(width: 16,),
                                  Text('أراء المستخدم',style: text50014,)
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_sharp,color: darkPurple,size: 18,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                Container(
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          index == 0?
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  SettingNotificationsScreen()),
                          ):
                          index == 1?

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  FaqScreen()),
                          ):Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  PrivacyPolicyScreen()));
            
                        },
                        child: Padding(
                          padding:  EdgeInsets.only( bottom:(index < 4) ? 16.0:0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,width: 40,
                                    child: DecoratedBox(decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: darkPurple
                                    ),child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                          index == 0 ? settings :
                                          index == 1? question :
                                              index == 2? privacy:
                                              index == 3?contact:share
            
                                      ),
                                    ),),
                                  ),
                                  SizedBox(width: 16,),
                                  Text(
                                    index == 0 ?
                                    'إعدادات التطبيق':
                                    index == 1 ? 'الأسئلة شائعة':
                                    index == 2 ? 'سياسة الخصوصية': index == 3 ? 'تواصل معنا': 'شارك التطبيق',
            
                                    style: text50014,)
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_sharp,color: darkPurple,size: 18,),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 24,)    ,
                InkWell(
                  onTap: ()  {

                    LogoutPopup().logout(context);

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(16),

                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 40,width: 40,
                            child: DecoratedBox(decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFDE382C)
                            ),child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(logout),
                            ),),

                          ),
                          SizedBox(width: 16,),
                          Text('تسجيل الخروج',style: text50014,)
                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

