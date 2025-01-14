import 'package:flutter/material.dart';
import 'package:imogoat/components/navigationBarCliente.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/components/drawerCliente.dart';
import 'package:imogoat/screens/home/mainHome.dart';
import 'package:imogoat/screens/user/campaignPage.dart';
import 'package:imogoat/screens/user/contactsPage.dart';
import 'package:imogoat/screens/user/favoritePage.dart';
import 'package:imogoat/styles/color_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: AppBarCliente(),
        // drawer: DrawerCliente(),
        bottomNavigationBar: CustomCurvedNavigationBar(
          currentIndex: _page,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _page = index;
            });
          },
          scrollDirection: Axis.horizontal,
          children: [
            MainHome(),
            FavoritePage(),
            CampaignPage(),
            ContactsPage(),
          ],
        ));
  }
}
