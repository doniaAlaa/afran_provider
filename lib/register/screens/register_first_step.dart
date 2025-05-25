import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_form_validation.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_field.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/login/screen/login_screen.dart';
import 'package:afran_provider/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegisterFirstStep extends StatelessWidget {
  final  Function()? onPressed;
   RegisterFirstStep({
    this.onPressed,
    super.key});
  final _formKey = GlobalKey<FormState>();

  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32,),
            Text('معلومات الحساب',style: text70016.copyWith(color: darkPurple2),),
            SizedBox(height: 16,),
            // Full Name
            AppTextField(
              controller: registerController.nameController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(person,width: 16,height: 16,),
        
              ),

              validator: (value) => FormValidators.validateRequired(value, fieldName: ''),

              fieldLabel:"الاسم كامل",
              hintText:  "أدخل الاسم كامل",
        
            ),
        
            SizedBox(height: 16),
        
            // Phone Number
            AppTextField(
              controller: registerController.phoneController,
              // prefixIcon: Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: SvgPicture.asset(phoneIcon,width: 16,height: 16,),
              // ),
              maxLength: 9,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 50,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: grey2)
                  ),
                  child: Center(child: Text('+966',style: text50014,)),
                ),
              ),
              keyboardType: TextInputType.number,

              inputFormatters:
              [FilteringTextInputFormatter.digitsOnly],
              validator: (value) => FormValidators.validatePhone(value, fieldName: 'Username'),

              fieldLabel: "رقم الهاتف",
              hintText: "أدخل رقم الهاتف",),


            SizedBox(height: 16),
        
            // Password
            AppTextField(
              controller: registerController.passController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
              ),
              keyboardType: TextInputType.number,
              inputFormatters:
              [FilteringTextInputFormatter.digitsOnly],
              validator: (value) => FormValidators.validateRequired(value, fieldName: ''),

              fieldLabel: "كلمة المرور",
              hintText: "أدخل كلمة المرور",),
            SizedBox(height: 16),
            // Confirm Password
        
            AppTextField(
              controller: registerController.passConfirmationController,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
              ),
              keyboardType: TextInputType.number,
              inputFormatters:
              [FilteringTextInputFormatter.digitsOnly],
              validator: (value) => FormValidators.validatePassConfirmation(value,registerController.passController.text ,fieldName: ''),

              fieldLabel: "تأكيد كلمة المرور",
              hintText: "أعد إدخال كلمة المرور",),
        
        
            SizedBox(height: 32,),
            Column(
              children: [
                MainAppButton(onPressed: (){

                  if (_formKey.currentState!.validate()) {
                    onPressed!();
                  }else{
                  }
                }
                , title: 'أكمل إنشاء الحساب'),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "لديك حساب بالفعل؟",
                        style: text50014
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );

                      },
                      child: Text(
                          "تسجيل الدخول",
                          style: text50014.copyWith(color: darkPurple,decoration: TextDecoration.underline)
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32,)
          ],
        ),
      ),
    );
  }
}

