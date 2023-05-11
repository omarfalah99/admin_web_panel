import 'dart:developer';

import 'package:admin_web_panel/add_screen.dart';
import 'package:admin_web_panel/home_screen.dart';
import 'package:admin_web_panel/orders_screen.dart';
import 'package:admin_web_panel/provider.dart';
import 'package:admin_web_panel/report_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_sidebar/simple_sidebar.dart';
import 'package:simple_sidebar/simple_sidebar_item.dart';
import 'package:simple_sidebar/simple_sidebar_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAbVhw0NvEVuPup72Fd1mmdoSEREQKzYDc',
          appId: '1:648832836667:web:e688f6dfef313be865681e',
          messagingSenderId: '648832836667',
          projectId: 'e-commerce-college'));
  runApp(ChangeNotifierProvider(
    create: (context) => FirebaseProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simplesidebar Demo',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color.fromRGBO(246, 121, 82, 0.1),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
        fontFamily: 'Gordita',
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Color.fromRGBO(246, 121, 82, 1),
        ),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(246, 121, 82, 1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<SimpleSidebarItem> sidebarItems = [
    SimpleSidebarItem(
      title: "Home",
      iconFront: Icons.home_outlined,
      child: HomeScreen(),
    ),
    SimpleSidebarItem(
      title: "Add",
      iconFront: FontAwesomeIcons.add,
      child: AddScreen(),
    ),
    SimpleSidebarItem(
      title: "Orders",
      iconFront: FontAwesomeIcons.cartShopping,
      child: OrdersScreen(),
    ),
    SimpleSidebarItem(
      title: "Report",
      iconFront: Icons.report,
      child: ReportScreen(),
    ),
  ];
  final String title;

  MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selected = 0;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            SimpleSidebar(
              simpleSidebarTheme: SimpleSidebarTheme(
                selectedIconColor: Colors.black,
                collapsedBackgroundColor: Color.fromRGBO(246, 121, 82, 1),
                expandedBackgroundColor: Color.fromRGBO(246, 121, 82, 1),
                titleTextTheme: const TextStyle(
                  color: Color.fromRGBO(246, 121, 82, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              titleText: "Hello Admin",
              titleImage: const Icon(Icons.admin_panel_settings),
              initialExpanded: false,
              sidebarItems: widget.sidebarItems,
              onTapped: (value) => onTapped(value),
              toggleSidebar: (value) {
                log("Sidebar is now $value");
              },
            ),
            Expanded(
              child: AnimatedOpacity(
                opacity: isVisible ? 1 : 0,
                duration: const Duration(milliseconds: 400),
                child: Container(
                    margin: const EdgeInsets.all(8),
                    child: widget.sidebarItems.elementAt(selected).child),
              ),
            )
          ],
        ));
  }

  void onTapped(int value) {
    setState(() {
      isVisible = false;
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        selected = value;
      });
    }).then((value) {
      setState(() {
        isVisible = true;
      });
    });
  }
}
