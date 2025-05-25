import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_text_style.dart';
import 'package:flutter/material.dart';



class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => Size.fromHeight(56);// 56 is default AppBar height you can modify.

  @override
  Widget build(BuildContext context) {
    return   AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leadingWidth: 60,
        // shadowColor: Colors.white,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: darkPurple2,)),
        titleSpacing: 0,
        title:  Text(title,style: text70018.copyWith(color: darkPurple2),));
  }
}
//NOTE: You can return not only AppBar but any widget with this setup.
// Define once, use it any where you want especially in appBars.
