import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helper/show_snack_bar.dart';

class Login extends StatefulWidget {


   Login({super.key});
   static String id = 'login page';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  String? email , password ;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Image.asset(
                  'assets/images/message.png',
                  height: 200,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Let's Talk",
                      style: TextStyle(
                          color: Color.fromARGB(255, 33, 18, 59),
                          fontSize: 32,
                          fontFamily: 'Pacifico'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  children: [
                    Text(
                      " LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  hintText:'enter your email',
                  onChanged: (data) {
                    email = data;
                  },
                  
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  hintText: "enter your password",
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text : "Login",
                  
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'user not found');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'wrong password');
                        }
                      } catch (e) {
                        
                        showSnackBar(context, 'there was an error');
                      }

                      isLoading = false;
                      setState(() {});
                    }
                  },
                  
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);

                          
                        },
                        child: const Text(
                          "   Register",
                          style:
                              TextStyle(color: Color.fromARGB(255, 33, 18, 59)),
                        ))
                  ],
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}

