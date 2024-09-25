import 'package:flutter/material.dart';
import 'package:imogoat/components/navigationBarCliente.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/components/drawerCliente.dart';
import 'package:imogoat/screens/home/mainHome.dart';


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

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Favorite Page'));
  }
}

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Contacts Page'));
  }
}
class CampaignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Campaign Page'));
  }
}

