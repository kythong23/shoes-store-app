import 'package:flutter/material.dart';
import 'package:lab8_9_10/datamodel/cartcounter.dart';
import 'package:lab8_9_10/datamodel/cartviewmodel.dart';
import 'package:lab8_9_10/page/home.dart';
import 'package:lab8_9_10/page/mycart.dart';
import 'package:lab8_9_10/page/profile.dart';
import 'package:provider/provider.dart';

class Bottom_NavigationWidget extends StatefulWidget {
  String token;
   Bottom_NavigationWidget({super.key,required this.token});

  @override
  State<Bottom_NavigationWidget> createState() => _Bottom_NavigationWidgetState();
}

class _Bottom_NavigationWidgetState extends State<Bottom_NavigationWidget> {
  int _selectedIndex = 0 ;
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }_loadWidget (int index){
    switch (index){
      case 0:
        return HomeWidget(token: widget.token,);
      case 1:
        return CartWidget();
      case 2:
        {
          return ProfileWidget();
        }
      default:
        {
          return HomeWidget(token: widget.token,);
        }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadWidget(_selectedIndex),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items:  <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: _selectedIndex == 0
                      ? const Icon(Icons.home, color: Colors.white)
                      : const Icon(Icons.home_outlined, color: Color.fromARGB(
                      107, 107, 107, 100)),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon:new SizedBox(
                    child:  Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _selectedIndex == 1
                            ? const Icon(Icons.shopping_bag, color: Colors.white)
                            : const Icon(Icons.shopping_bag, color: Color.fromARGB(
                            107, 107, 107, 100)),
                        Positioned(
                          top: -10,
                          left: 0,
                          right: -20,
                          child: Consumer<CartVM>(
                            builder: (context,value,child)=>CartCounter(count: value.lst.length.toString())
                            ,
                          ),
                        )
                      ],
                    ),
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 2
                      ? const Icon(Icons.person, color: Colors.white)
                      : const Icon(Icons.person_outline, color: Color.fromARGB(
                      107, 107, 107, 100)),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color.fromARGB(
                  107, 107, 107, 100),
              backgroundColor:Color.fromRGBO(49, 49, 49, 1),
              onTap: _onItemTapped,
            ),
          ),
        ),
      )
    );
  }
}
