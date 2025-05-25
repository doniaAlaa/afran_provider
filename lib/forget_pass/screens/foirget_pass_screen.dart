import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_text_field.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/forget_pass/screens/add_new_pass_screen.dart';
import 'package:afran_provider/login/screen/login_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 48),
                const Text(
                  'نسيت كلمة المرور؟',
                  style: text70020,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                 Text(
                  'لا تقلق! فقط أدخل بريدك الإلكتروني أو رقم هاتفك وسنرسل لك رابطًا لإعادة تعيين كلمة المرور',
                  style:text50014.copyWith(color: grey3),
                  // textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                AppTextField(

                  fieldLabel: 'البريد الإلكتروني أو رقم الهاتف',
                  hintText: "أدخل البريد الإلكتروني أو رقم الهاتف",),
                const SizedBox(height: 32),

                MainAppButton(
                  title: 'إرسال',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AddNewPassScreen()),
                    );
                  },),
                const SizedBox(height: 32),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Navigate to Register Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  LoginPage()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "تذكرت كلمة المرور؟",
                            style: text50014
                        ),
                        Text(
                            "تسجيل الدخول",
                            style: text50014.copyWith(color: darkPurple,decoration: TextDecoration.underline)
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}