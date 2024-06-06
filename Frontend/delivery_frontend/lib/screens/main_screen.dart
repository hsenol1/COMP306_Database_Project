import 'package:delivery_frontend/models/user.dart';
import 'package:delivery_frontend/models/user_info.dart';
import 'package:delivery_frontend/screens/voucher_screen';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'home_content.dart';
import 'search_screen.dart';
import 'profile_screen.dart';
import 'basket_screen.dart';
import '../models/basket.dart';

class MainScreen extends StatefulWidget {
  final User user;
  MainScreen({required this.user});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  Basket _basket = Basket(uid: 0);

  final List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _basket = Basket(uid: widget.user.id);
    _widgetOptions.addAll([
      HomeContent(
        basket: _basket,
      ),
      SearchScreen(
        basket: _basket,
      ),
      ProfileScreen(
        user: widget.user,
      ),
      VoucherScreen(),
    ]);

    _basket.itemsNotifier.addListener(_updateState);
  }

  @override
  void dispose() {
    _basket.itemsNotifier.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openBasket() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BasketScreen(basket: _basket);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gettir'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        actions: [
          if (!_basket.isEmpty)
            IconButton(
              icon: Icon(Icons.shopping_basket),
              onPressed: _openBasket,
              color: Colors.amber[800],
            ),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Voucher',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
