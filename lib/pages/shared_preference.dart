import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_madel.dart';
import '../services/preference_services.dart';

class SharedPreferencePage extends StatefulWidget {
  static String id="shared_preference";
  const SharedPreferencePage({Key? key}) : super(key: key);

  @override
  _SharedPreferencePageState createState() => _SharedPreferencePageState();
}

class _SharedPreferencePageState extends State<SharedPreferencePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

 void _doLogin() async{
   String name = nameController.text;
   String email = emailController.text;
   String phone = phoneController.text;
   String password = passwordController.text;
   String confirmpassword = confirmpasswordController.text;

   AccountUser user = AccountUser(name: name,email: email,phone: phone,password: password,confirmpassword: confirmpassword);
   Preference.storeAccountUser(user);
   AccountUser? data = await Preference.loadAccountUser();
   print(data!.name);
 }

 @override
  void dispose() {
    super.dispose();
     nameController.dispose();
     emailController.dispose();
     phoneController.dispose();
     passwordController.dispose();
     confirmpasswordController.dispose();
  }



 @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Welcome back!",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              Text("Create an account of Q Allure to get all features",style: TextStyle(fontSize: 15),textAlign: TextAlign.center,),
              SizedBox(height: 30,),
              /// #Name
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade200,
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person_outline,),
                    hintText: "Name",
                  ),
                ),
              ),
              SizedBox(height: 10,),
              /// #Email
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade200,
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email_outlined,),
                    hintText: "Shamsun@gmail.com",
                  ),
                ),
              ),
              SizedBox(height: 10,),
              /// #Phone
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade200,
                ),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.phone_android,),
                    hintText: "Phone",
                  ),
                ),
              ),
              SizedBox(height: 10,),
              /// #Password
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade200,
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock_open,),
                    hintText: "Password",
                  ),
                ),
              ),
              SizedBox(height: 10,),
              /// #Confirm Password
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade200,
                ),
                child: TextField(
                  controller: confirmpasswordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock_open,),
                    hintText: "Confirm Password",
                  ),
                ),
              ),
              SizedBox(height: 20,),
              /// #Button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Colors.blue,
                    fixedSize: Size(100,50),
                  ),
                    onPressed: (){
                      setState(() {_doLogin();});
                    },
                 child: Text("CREATE",style: TextStyle(color: Colors.white),),

                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  Text("Login here",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
