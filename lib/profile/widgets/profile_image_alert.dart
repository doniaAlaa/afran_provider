import 'dart:io';

import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/profile/controllers/user_info_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProfileImageAlert{

  changeProfileImageAlert(BuildContext context,FilePickerResult result,UserInfoController userInfoController ){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 16), // Remove default padding
        contentPadding: EdgeInsets.zero, // Optional: control inner spacing

        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: purple,
                  shape: BoxShape.circle
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.file(File(result.files.single.path!),fit: BoxFit.cover,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(child: Text('هل تريد تغيير الصورة الشخصية؟',style: text70016,)),
              ),
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

                      Navigator.pop(context);
                    }, title: 'موافق'))),

                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );

  }
}