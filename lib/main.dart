import 'package:ecommerce/provider/product.dart';
import 'package:ecommerce/provider/app.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/screens/splash.dart';
import 'package:ecommerce/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: ProductProvider.initialize()),
    ChangeNotifierProvider.value(value: AppProvider()),


  ], child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.white
    ),
    home: ScreensController(),
  ),));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default: return Login();
    }
  }
}




