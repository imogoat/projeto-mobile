import 'package:flutter/material.dart';
import 'package:imogoat/components/navigationBarCliente.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/components/drawerCliente.dart';
import 'package:imogoat/screens/home/mainHome.dart';
import 'package:imogoat/screens/user/campaignPage.dart';
import 'package:imogoat/screens/user/contactsPage.dart';
import 'package:imogoat/screens/user/favoritePage.dart';


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
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBarCliente(),
      drawer: DrawerCliente(),
      bottomNavigationBar: CustomCurvedNavigationBar(
        currentIndex: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
          _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
        },
      ),
      body: PageView(
            controller: _pageController,
            onPageChanged: (value) => setState(() {
              _page = value;
            }),
            scrollDirection: Axis.horizontal,
            children: [
              MainHome(),
              FavoritePage(),
              ContactsPage(),
              CampaignPage(),
            ],
          )
    );
  }
}
