import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_field.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/forget_pass/screens/success_update_pass_screen.dart';
import 'package:afran_provider/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNewPassScreen extends StatefulWidget {
  const AddNewPassScreen({Key? key}) : super(key: key);

  @override
  State<AddNewPassScreen> createState() => _AddNewPassScreenState();
}

class _AddNewPassScreenState extends State<AddNewPassScreen> {
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
                // const SizedBox(height: 24),
                // const Align(
                //   alignment: Alignment.topRight,
                //   child: Icon(Icons.arrow_back_ios_new, size: 20),
                // ),
                const SizedBox(height: 48),
                const Text(
                  'تعيين كلمة مرور جديدة',
                  style: text70020,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'يرجى إدخال كلمة مرور جديدة لحسابك.',
                  style:text50014.copyWith(color: grey3),
                  // textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                AppTextField(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon( Icons.visibility_off_rounded,color: grey3.withOpacity(0.5),)
                  ),
                  fieldLabel: "كلمة المرور الجديدة",
                  hintText: "أدخل كلمة المرور الجديدة",),
                SizedBox(height: 16,),
                AppTextField(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(lockIcon,width: 16,height: 16,),
                  ),
                  suffixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon( Icons.visibility_off_rounded,color: grey3.withOpacity(0.5),)
                  ),
                  fieldLabel: "تأكيد كلمة المرور",
                  hintText: "أعد إدخال كلمة المرور",),
                const SizedBox(height: 32),

                MainAppButton(
                  title: 'تحديث كلمة المرور',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  SuccessUpdatePassScreen()),
                    );
                  },),


              ],
            ),
          ),
        ),
      ),
    );
  }
}