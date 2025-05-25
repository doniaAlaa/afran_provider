import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/constant/app_text_field.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:afran_provider/constant/main_app_button.dart';
import 'package:afran_provider/core/dash_line.dart';
import 'package:afran_provider/login/screen/login_screen.dart';
import 'package:afran_provider/register/screens/family_data_screen.dart';
import 'package:afran_provider/register/screens/register_second_step.dart';
import 'package:afran_provider/register/screens/register_first_step.dart';
import 'package:afran_provider/verification/screens/verify_ecreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool agreeToTerms = false;
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final List<String> steps = ['معلومات الحساب', 'الوثائق المطلوبة','أكمل بياناتك'];

  void _onStepTapped(int index) {
    setState(() {
      _currentStep = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget buildStepper() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isEven) {
            int stepIndex = index ~/ 2;
            bool isActive = _currentStep == stepIndex;
            return GestureDetector(
              onTap: () => _onStepTapped(stepIndex),
              child: Column(

                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? darkPurple : grey,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${stepIndex + 1}',
                      style: TextStyle(
                        color: isActive ? Colors.white : grey3,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    steps[stepIndex],
                    style: TextStyle(
                      color: isActive ? darkPurple : grey3,
                      fontSize: 12,
                      fontWeight:
                      isActive ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Expanded(
              child: Container(
                height: 48,

                child: Center(
                  child: DashedLine(
                    height: 1.5,
                    color: grey3,
                    dashWidth: 4,
                    dashSpacing: 2,
                  ),
                ),
              ),

            );
          }
        }),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text('انضم إلينا',style: text70020,),
              SizedBox(height: 8,),
              Text('أنشئ حسابًا جديدًا وابدأ رحلتك كمزوّد في أفران',style: text50014.copyWith(color: grey3),),
              SizedBox(height: 32,),
              buildStepper(),
              // const SizedBox(height: 0),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: steps.length,
                  physics: NeverScrollableScrollPhysics(), // disables user swiping
                  onPageChanged: (index) {
                    setState(() => _currentStep = index);
                  },
                  itemBuilder: (context, index) {
                    return _currentStep == 0?
                    // FirstCartScreen(onPressed:(){
                    //   setState(() => _currentStep = 1);
                    //
                    // } ,)
                    RegisterFirstStep(onPressed: (){
                      setState(() => _currentStep = 1);

                    },)
                        :_currentStep == 1?
                    // SecondCartScreen(onPressed: () {
                    //   setState(() => _currentStep = 2);
                    //
                    // },)
                    RegisterSecondStep(
                      onPressed: (){
                        setState(() => _currentStep = 2);

                      },
                    )
                        :
                        FamilyDataScreen();
                  },
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
