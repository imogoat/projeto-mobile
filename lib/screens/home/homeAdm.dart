import 'package:flutter/material.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/components/drawerAdm.dart';
import 'package:imogoat/components/navigationBarAdm.dart';
import 'package:imogoat/screens/home/mainHome.dart';
import 'package:imogoat/screens/user/campaignPage.dart';
import 'package:imogoat/screens/user/contactsPage.dart';


class HomePageAdm extends StatefulWidget {
  const HomePageAdm({super.key});

  @override
  State<HomePageAdm> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageAdm> {
  int _page = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBarCliente(),
      drawer: DrawerAdm(),
      bottomNavigationBar: CustomCurvedNavigationBarAdm(
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1F7C70),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {}
      ),
      body: PageView(
            controller: _pageController,
            onPageChanged: (value) => setState(() {
              _page = value;
            }),
            scrollDirection: Axis.horizontal,
            children: [
              MainHome(),
              ContactsPage(),
            ],
          )
    );
  }
}
