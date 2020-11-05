import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'showdatascreen.dart';
import 'constant.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  SharedPreferences sharedPreferences;
  bool checkvalue;// initialized first time.
  _onChanged() async {

    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
        sharedPreferences.setBool("check", checkvalue);
        sharedPreferences.setString("username", emailcontroller.text);
        sharedPreferences.setString("password", passcontroller.text);
        // sharedPreferences.commit();
        getCredential();

    });
  }
  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkvalue = sharedPreferences.getBool("check");
      if (checkvalue != null) {
        if (checkvalue)
        {
          emailcontroller.text = sharedPreferences.getString("username");
          passcontroller.text = sharedPreferences.getString("password");
          String email = sharedPreferences.getString("username");
          String pass = sharedPreferences.getString("password");
        } else {
          emailcontroller.text = "";
          emailcontroller.text = "";
          sharedPreferences.clear();
          print('empty shows all field');
        }
      }
      else {
        checkvalue = false;
        print('checkvalue null');
      }
    });
  }
  @override
  void initState() {
    super.initState();
    print('init state is called');
    getCredential();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body : Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          padding: EdgeInsets.only(top: 10),
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: new TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      // filled: true,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                ],
              ),
            SizedBox(height: 20),
            new TextField(
              // obscureText: !this._showPassword,
              controller: passcontroller,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,

              padding: EdgeInsets.all(16.0),
              splashColor: Colors.blueAccent,
              onPressed: ()
              {
                if (emailcontroller.text.length>0 && passcontroller.text.length>0)
                  {
                    checkvalue = true;
                    _onChanged();
                  }
                else
                  {
                    checkvalue = false;
                    print('something is missing');
                  }

              },
              child: Text(
                "Create Account",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

// void showModelBottomSheet({BuildContext context, Container Function(BuildContext context) builder}) {}
}
