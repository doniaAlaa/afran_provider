
import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isOtpComplete = false;

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
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.arrow_back_ios, size: 20),
                ),
                const SizedBox(height: 48),
                const Text(
                  'تأكيد رقم الهاتف',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                    children: [
                      Text(
                         'أرسلنا رمز التحقق إلى ',
                        style: TextStyle(color: Color(0xFF666666,),fontSize: 14,fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '+966 5X XXX XXXX',
                        style: text70014.copyWith(color: darkPurple),
                      ),

                    ],

                ),
                Text(
                  '\n(سيصلك خلال 30 ثانية)',
                  style: text50014.copyWith(color: grey3),
                ),
                const SizedBox(height: 32),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34.0),
                    child: Form(
                      key: formKey,
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        controller: otpController,
                        keyboardType: TextInputType.number,

                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderWidth: 0.4,
                          borderRadius: BorderRadius.circular(16),
                          fieldHeight: 62,
                          fieldWidth: 62,
                          activeFillColor: Color(0xFFF6F6F6),
                          inactiveFillColor:Color(0xFFF6F6F6),
                          selectedFillColor: Colors.white,
                          activeColor: Color(0xFFF6F6F6),
                          selectedColor: Color(0xFFA866A7),
                          inactiveColor: Color(0xFFF6F6F6),
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        onChanged: (value) {
                          setState(() {
                            isOtpComplete = value.length == 4;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isOtpComplete ? () {
                      // Handle confirmation
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) =>  ForgotPasswordScreen()),
                      // );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) =>  HomePageScreen()),
                      // );


                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isOtpComplete ?darkPurple : Colors.grey.shade300,
                      foregroundColor: isOtpComplete ? Colors.white : Colors.black26,
                      disabledBackgroundColor: Colors.grey.shade300,
                      disabledForegroundColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('تأكيد', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                      child: Text(
                        
                        'الوقت: --:--',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لم تصلك الرسالة؟ ',
                        style: text50014,

                      ),
                      Text(
                        'إعادة الإرسال',
                        style:text50014.copyWith(color: purple2),
                      ),
                    ],
                  )


              ],
            ),
          ),
        ),
      ),
    );
  }
}