import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:moviespot/constants/api.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/view/pages/category.dart';
import 'package:moviespot/view/pages/favorite_page.dart';
import 'package:moviespot/view/pages/search_page.dart';
import 'package:provider/provider.dart';

import '../../utils/inernet_connectivity.dart';
import '../../provider/theme_provider.dart';
import 'movie_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Widget> _pages = [
    const MovieList(),
    const SearchPage(),
    const FavoritePage(),
    const CategoryPage(),
  ];
  final List<Tab> _tabs = const [
    Tab(icon: Icon(Icons.home), text: 'Home'),
    Tab(icon: Icon(Icons.search), text: 'Search'),
    Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
    Tab(icon: Icon(Icons.category), text: 'Categories'),
  ];

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm exit'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    log("---> home page build <-------");
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(

        floatingActionButton:FloatingActionButton(
          onPressed: (){
           // API.testApi(154);
          },
        ) ,
        bottomNavigationBar: TabBar(
          controller: tabController,
          tabs: _tabs,
          indicatorColor: Colors.transparent,
        ),
        appBar: AppBar(
          title: Text(
            Strings.appTitle,
            style: TextStyle(fontFamily: GoogleFonts.aBeeZee().fontFamily),
          ),
          actions: [
            Consumer(
              builder: (context, AppTheme theme, child) {
                return IconButton(
                  onPressed: () {
                    theme.changeTheme(!theme.isDarkTheme);
                  },
                  icon: theme.isDarkTheme
                      ? const Icon(Icons.light_mode)
                      : const Icon(Icons.dark_mode),
                );
              },
            )
          ],
        ),
        body: Consumer<ConnectivityProvider>(
            builder: (context, ConnectivityProvider provider, child) {
          if (provider.isConnected) {
            return TabBarView(controller: tabController, children: _pages);
          } else {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Lottie.asset(Strings.noInternet),
            );
          }
        }),
      ),
    );
  }
}
