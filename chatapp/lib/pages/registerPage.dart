import 'package:chatapp/components/MyButton.dart';
import 'package:chatapp/components/My_text_field.dart';
import 'package:chatapp/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
    });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

    //text controller

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign up user
  void signUp()async{
    if(passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text("Password do not match!")
        )
        );
        return;
    }
    // get auth service
    final authService = Provider.of<AuthServices>(context,listen: false);
    try {
      await authService.signInWithEmailAndPassword(
        emailController.text, passwordController.text
        );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50.0,),
            
                // logo
            
                Icon(Icons.message,
                size: 100,
                color: Colors.blueGrey.shade900,
                ),
                const SizedBox(height: 50.0,),
            
                // create  account massage
            
               const Text("Let's create an account for you!",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.normal
                ),
                ),
                const SizedBox(height: 25.0,),
            
            
                //email text field
            
            
                MyTextField(
                  Controller: emailController , 
                  hintText: "Email", 
                  obscureText: false,
                  ),
                  const SizedBox(height: 10.0,),
            
            
                // password text field

                MyTextField(
                  Controller: passwordController , 
                  hintText: "Password", 
                  obscureText: true ,
                  ),
                  const SizedBox(height: 10.0,),

                  // confirm password text field

                  MyTextField(
                  Controller: confirmPasswordController , 
                  hintText: "Confirm Password", 
                  obscureText: true ,
                  ),




                  const SizedBox(height: 25.0,),
            
            
                // sign Un button

                Mybutton(
                  onTap: signUp,
                   text: 'Sign Up'
                   ),
                   const SizedBox(height: 50.0,),
            
            
                //not a member? register now
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const  Text("Alredy a member?"),
                   const  SizedBox(width:4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login Now",
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    )
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}