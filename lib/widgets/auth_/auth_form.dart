

import 'dart:io';

import 'package:chat/widgets/auth_/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

   
  bool isLoading;
final void Function(
     String email,
   String password,
   String username,
    File image,
   bool islogin,
   
   BuildContext ctx,
   ) sumbitFunc;
  AuthForm({required this.sumbitFunc,required this.isLoading});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  
  final _formKey = GlobalKey<FormState>(); 
    bool _isLogin = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
   TextEditingController _username = TextEditingController();
    File ?_userImageFile;


   void _pickedImage(File pickedImage){
     _userImageFile = pickedImage;
     
   }
  
  


  void _sumbit(){
   final  isValid = _formKey.currentState!.validate();
   FocusScope.of(context).unfocus();
   if(_userImageFile == null){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('please pick an image'),
              backgroundColor: Theme.of(context).errorColor,
              
              )
            );
      return;

   }

   
  
   if(isValid){
     _formKey.currentState!.save();
     widget.sumbitFunc(
       _email.text.trim(),_password.text,_username.text,_userImageFile!,_isLogin,context,
     );
   }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_isLogin)
                  Column(
                    children: [
                      UserImagePicker(imagePickFn: _pickedImage,),
                      
                      
                    ],
                  ),

                  TextFormField(
                    controller: _email,
                    validator: (val){
                      if(val!.isEmpty || !val.contains('@')){
                        return 'Please enter avalid email address';

                      }
                     

                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(

                      labelText: 'Emali Address'
                    ),
                  ),
                  if(!_isLogin)
                  

                      TextFormField(
                       
                  controller: _username,
                    validator: (val){
                      if(val!.isEmpty || val.length <4){
                        return 'Please enter at least 4 characters';

                      }
                      return null;
                     

                    },
                    // onSaved: (val)=> _username =val!,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(

                      labelText: 'Username'
                    ),
                  ),


                      TextFormField(
                    controller: _password,
                    obscureText: true,
                    validator: (val){
                      if(val!.isEmpty ||val.length <7){
                        return 'Password must be at least 7 characters';

                      }
                     

                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(

                      labelText: 'Password'
                    ),
                  ),
                  SizedBox(height: 12,),
                  if(widget.isLoading)
                  CircularProgressIndicator(),
                   if(!widget.isLoading)
                  Container(
                   
                    decoration: BoxDecoration(
                       color:Colors.pink,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: MaterialButton(
                      
                      onPressed:_sumbit,
                      child: Text(_isLogin? 'Login' : 'Singup',style: TextStyle(color: Colors.white),),
                      ),
                  ),
                   if(!widget.isLoading)
                  TextButton(onPressed: (){
                    
                    setState(() {
                      _isLogin =!_isLogin;
                    });
                  },
                   child: Text(
                     (_isLogin?'Create new account'
                      :'I  already have an account'), // Text)
                   ))



                ],
              ),
            )
          ),
        ),
      ),
    );
  }

 
}