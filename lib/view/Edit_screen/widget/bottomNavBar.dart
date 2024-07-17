import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:kyla_task/utlis/colors_constant.dart';
import 'package:kyla_task/view/HomeScreen/homescreen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedindex = 0;
  List Screens = [
    Homescreen(),
    Homescreen(),
    Homescreen(),
    Homescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Material(
        elevation: 100,
        child: BottomNavigationBar(
          selectedItemColor: Colorsconstant.mygreen,
          unselectedItemColor: Colors.grey,
          
          onTap: (value) {
            setState(() {
              selectedindex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedindex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(IconlyBold.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 24,
                width: 24,
                child: Image.asset(
                  "assets/icons/Calendar.png",
                  color:
                      selectedindex == 1 ? Colorsconstant.mygreen : Colors.grey,
                ),
              ),
              label: "Appointment",
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 24,
                width: 24,
                child: Image.asset(
                  "assets/icons/Icon_Prescription.png",
                  color:
                      selectedindex == 2 ? Colorsconstant.mygreen : Colors.grey,
                ),
              ),
              label: "Prescription",
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 24,
                width: 24,
                child: Image.asset(
                  "assets/icons/Icon_Menu.png",
                  color:
                      selectedindex == 3 ? Colorsconstant.mygreen : Colors.grey,
                ),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: Screens.elementAt(selectedindex),
    );
  }
}
