import 'package:afran_provider/constant/app_colors.dart';
import 'package:afran_provider/constant/app_images.dart';
import 'package:afran_provider/home/screens/home_screen.dart';
import 'package:afran_provider/home/widget/product_or_offer_bottom_sheet.dart';
import 'package:afran_provider/models/user_model.dart';
import 'package:afran_provider/products/screens/add_product_screen.dart';
import 'package:afran_provider/products/screens/all_products_screen.dart';
import 'package:afran_provider/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class AppBottomNavBar extends StatefulWidget {
  final UserModel? userModel;
  AppBottomNavBar({this.userModel});
  @override
  _AppBottomNavBarState createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  int _selectedIndex = 0;

  final List<String> icons = [
    home,
    store,
    graph, // This is for the FAB, not used in nav items
    graph,
    userCircle,
  ];

  final List<String> labels = [
    'الرئيسية',
    'المنتجات',
    '',
    'الإحصائيات',
    'حسابي',
  ];

  void _onItemTapped(int index) {
    if (index != 2) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(userModel: widget.userModel,),
      AllProductsScreen(products: []),
      HomeScreen(),
      HomeScreen(),
      ProfileScreen(userModel: widget.userModel,),
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: pages[_selectedIndex],

        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              if (index == 2) {
                return SizedBox(width: 30); // Space for FAB
              }

              return GestureDetector(
                onTap: () => _onItemTapped(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon(
                      //   icons[index],
                      //   color: _selectedIndex == index ? darkPurple : Colors.black54,
                      // ),
                      SvgPicture.asset( icons[index],),
                      Text(
                        labels[index],
                        style: TextStyle(
                          color: _selectedIndex == index ? Colors.purple : Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        floatingActionButton: Container(
          height: 74,width: 74,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(100)
          ),
          child: ClipRRect(
             borderRadius: BorderRadius.circular(100),

          child: FloatingActionButton(
              onPressed: () {

                ProductOrOfferBottomSheet().chooseProductOffer(context);
              },

              child: Icon(Icons.add, size: 32,color: Colors.white,),
              backgroundColor: darkPurple,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
