import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_strings.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/constant/secure_storage.dart';
import 'package:afran_provider/login/screen/login_screen.dart';
import 'package:flutter/material.dart';

class LogoutPopup{

  logout(BuildContext context){
   return showDialog(
      context: context,
       barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 16), // Remove default padding
        contentPadding: EdgeInsets.zero, // Optional: control inner spacing
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('هل أنت متأكد أنك تريد تسجيل الخروج؟',style: text70016,)),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8,),
              Text('سيتم إنهاء الجلسة الحالية، ويمكنك تسجيل الدخول مرة أخرى في أي وقت.',
                textAlign: TextAlign.end,
                style: text50014.copyWith(color: semiBlack,),),
              SizedBox(height: 20,),

              SizedBox(

                width: MediaQuery.of(context).size.width ,  // custom width
                height: 60, // custom height
                child: Row(
                  children: [
                    Expanded(child: Container(child: MainAppButton(
                        backgroundColor: grey2,
                        titleColor: grey3,
                        onPressed: (){
                          Navigator.pop(context);
                        }, title: 'إلغاء'))),
                     SizedBox(width: 16,),
                    Expanded(child: Container(child: MainAppButton(onPressed: ()async{
                      final secureStorage = SecureStorageService();
                      await secureStorage.delete(user);
                      await secureStorage.delete(userToken);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }, title: 'موافق'))),

                  ],
                ),
              ),
            ],
          ),
        ),
        // actions: [
        //   TextButton(
        //     child: Text('إلغاء'),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        //   TextButton(
        //     child: Text('موافق'),
        //     onPressed: () {
        //       // Do something
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ],
      ),
    );

  }
}