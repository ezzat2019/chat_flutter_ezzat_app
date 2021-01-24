import 'package:chat_flutter_ezzat_app/provideres/auth_provider.dart';
import 'package:chat_flutter_ezzat_app/screen/auth_screen.dart';
import 'package:chat_flutter_ezzat_app/screen/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp().then((value) =>   runApp(MyApp()));

}

class MyApp extends StatelessWidget {

  bool is_login = false;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  MyApp() {
    firebaseMessaging.configure(onMessage: (msg) {
      print("on messages  $msg");
    }, onResume: (msg) {
      print("on resume  $msg");
    }, onLaunch: (msg) {
      print("on launch  $msg");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark

      ),
      home: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(_,val){
          if (val.connectionState==ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());

          }else
            {
              if (val.data==null) {
                return ChangeNotifierProvider(
                    create: (_)=>AuthProvider(),
                    child: AuthScreen());
              }
              else
                {
                  return ChatScreen();
                }
            }



        }
      ),
    );
  }
}
