import 'package:chat_flutter_ezzat_app/provideres/auth_provider.dart';
import 'package:chat_flutter_ezzat_app/screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AuthScreen extends StatelessWidget {
  final Reference storage = FirebaseStorage.instance.ref("images");
  final email_controler = TextEditingController();
  final user_controler = TextEditingController();
  final pass_controler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<UserCredential> SignIn(
        String email, String password, BuildContext ctx) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          Toast.show("No user found for that email.", context,
              duration: Toast.LENGTH_LONG);
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          Toast.show("Wrong password provided for that user.", context,
              duration: Toast.LENGTH_LONG);
        }
        return null;
      }
    }

    Future<UserCredential> signup(String email, String userName,
        String password, BuildContext ctx) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          print('email-already-in-use');
          Toast.show("email-already-in-use", context,
              duration: Toast.LENGTH_LONG);
        } else if (e.code == 'email-already-in-use') {
          print('email-already-in-use');
          Toast.show("email-already-in-use", context,
              duration: Toast.LENGTH_LONG);
        }
        return null;
      } catch (e) {
        Toast.show(e.toString(), context, duration: Toast.LENGTH_LONG);
        return null;
      }
    }

    final picker = ImagePicker();
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (Provider.of<AuthProvider>(context).is_progress_show)
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          Center(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        if (Provider.of<AuthProvider>(context, listen: true)
                            .is_login)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: CircleAvatar(
                                backgroundImage:
                                Provider.of<AuthProvider>(context)
                                    .finalImage ==
                                    null
                                    ? null
                                    : FileImage(
                                  Provider.of<AuthProvider>(context)
                                      .finalImage,
                                ),
                                backgroundColor: Colors.black12,
                                radius: 50,
                              ),
                            ),
                          ),
                        if (Provider.of<AuthProvider>(context, listen: true)
                            .is_login)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FlatButton.icon(
                                  onPressed: () {
                                    picker
                                        .getImage(
                                            source: ImageSource.camera,
                                            maxWidth: 200,
                                            maxHeight: 200,
                                            imageQuality: 80)
                                        .then((value) {
                                      if (value != null) {
                                        Provider.of<AuthProvider>(context,
                                            listen: false)
                                            .setImage(value.path);
                                      } else {
                                        print('No image selected.');
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  label: Text(
                                    "take image\nby camera",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor),
                                  )),
                              FlatButton.icon(
                                  onPressed: () {
                                    picker
                                        .getImage(
                                            source: ImageSource.gallery,
                                            maxWidth: 200,
                                            maxHeight: 200,
                                            imageQuality: 80)
                                        .then((value) {
                                      if (value != null) {
                                        Provider.of<AuthProvider>(context,
                                            listen: false)
                                            .setImage(value.path);
                                      } else {
                                        print('No image selected.');
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.image,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  label: Text(
                                    "get from \ngallery",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor),
                                  ))
                            ],
                          ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                          child: TextField(
                            controller: email_controler,
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            decoration: InputDecoration(
                                labelText: "Email",
                                hintText: "enter your email",
                                hintStyle: TextStyle(color: Colors.black12)),
                          ),
                        ),
                        if (Provider.of<AuthProvider>(context, listen: true)
                            .is_login)
                          Container(
                            margin:
                            EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: TextField(
                              controller: user_controler,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: "User Name",
                                  hintText: "enter name",
                                  hintStyle: TextStyle(color: Colors.black12)),
                            ),
                          ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                          child: TextField(
                            controller: pass_controler,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                labelText: "Password",
                                hintText: "enter password",
                                hintStyle: TextStyle(color: Colors.black12)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              //FocusScope.of(context).unfocus();
                              String email = email_controler.text.toString();
                              String user = user_controler.text.toString();
                              String pass = pass_controler.text.toString();
                              if (!Provider.of<AuthProvider>(context,
                                  listen: false)
                                  .is_login) {
                                if (email.isEmpty) {
                                  Toast.show(
                                      "please enter  email address first",
                                      context,
                                      duration: Toast.LENGTH_LONG);

                                  return;
                                }
                                if (!email.contains('@')) {
                                  Toast.show(
                                      "please enter correct email address",
                                      context,
                                      duration: Toast.LENGTH_LONG);

                                  return;
                                }

                                if (pass.isEmpty) {
                                  Toast.show(
                                      "please enter  password first", context,
                                      duration: Toast.LENGTH_LONG);

                                  return;
                                }
                                if (pass.length < 6) {
                                  Toast.show(
                                      "The password must at least 6 character",
                                      context,
                                      duration: Toast.LENGTH_LONG);

                                  return;
                                }
                                Provider.of<AuthProvider>(context,
                                    listen: false)
                                    .set_is_progress_show(
                                    !Provider.of<AuthProvider>(context,
                                        listen: false)
                                        .is_progress_show);

                                SignIn(email.trim(), pass.trim(), context)
                                    .then((value) {
                                  if (value == null) {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .set_is_progress_show(
                                            !Provider.of<AuthProvider>(context,
                                                    listen: false)
                                                .is_progress_show);
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .set_is_login(
                                            !Provider.of<AuthProvider>(context,
                                                    listen: false)
                                                .is_login);
                                  } else {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (_) {
                                          Provider.of<AuthProvider>(context,
                                              listen: false)
                                              .set_is_progress_show(
                                              !Provider.of<AuthProvider>(
                                                  context,
                                                  listen: false)
                                                  .is_progress_show);

                                          return ChatScreen();
                                        }));
                                  }
                                });
                              } else {
                                if (email.isEmpty) {
                                  Toast.show(
                                      "please enter  email address first",
                                      context,
                                      duration: Toast.LENGTH_LONG);
                                  return;
                                }
                                if (!email.contains('@')) {
                                  Toast.show(
                                      "please enter correct  email address ",
                                      context,
                                      duration: Toast.LENGTH_LONG);

                                  return;
                                }
                                if (user.isEmpty) {
                                  Toast.show(
                                      "please enter  user name first", context,
                                      duration: Toast.LENGTH_LONG);

                                  return;
                                }

                                if (pass.isEmpty) {
                                  Toast.show(
                                      "please enter  password first", context,
                                      duration: Toast.LENGTH_LONG);
                                  return;
                                }
                                if (pass.length < 6) {
                                  Toast.show(
                                      "The password must at least 6 character",
                                      context,
                                      duration: Toast.LENGTH_LONG);

                                  return;
                                }
                                if (Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .finalImage ==
                                    null) {
                                  Toast.show(
                                      "please scelect image first", context,
                                      duration: Toast.LENGTH_LONG);

                                  return;
                                }
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .set_is_progress_show(
                                        !Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .is_progress_show);
                                storage
                                    .child(DateTime.now().toString())
                                    .putFile(Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .finalImage)
                                    .catchError((err) {
                                  Toast.show(err.toString(), context);
                                }).then((value) {
                                  value.ref.getDownloadURL().then((value) {
                                    String img_url = value;
                                    signup(email.trim(), user.trim(),
                                            pass.trim(), context)
                                        .then((value) {
                                      if (value != null) {
                                        FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(value.user.uid)
                                            .set({
                                          "email": email,
                                          "name": user,
                                          "img": img_url
                                        }).then((vv) {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(builder: (_) {
                                            Provider.of<AuthProvider>(context,
                                                    listen: false)
                                                .set_is_progress_show(
                                                    !Provider.of<AuthProvider>(
                                                            context,
                                                            listen: false)
                                                        .is_progress_show);

                                            return ChatScreen();
                                          }));
                                        }).catchError((e) {
                                          Toast.show(e.toString(), context);
                                        });
                                      }
                                    });
                                  });
                                });
                              }
                            },
                            textColor: Colors.white,
                            child: Text(
                              Provider.of<AuthProvider>(context, listen: false)
                                  .is_login
                                  ? "Sign up"
                                  : "Login",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            bool val = !Provider.of<AuthProvider>(context,
                                listen: false)
                                .is_login;
                            Provider.of<AuthProvider>(context, listen: false)
                                .set_is_login(val);
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                !Provider.of<AuthProvider>(context,
                                    listen: false)
                                    .is_login
                                    ? "Create new account"
                                    : "I have already have an account",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
