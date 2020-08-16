import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/5,),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Reset Password",
                      style: TextStyle(
                          fontSize: 32,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500
                      ),
                    )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/10,),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("New Password",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    )),
              ),
              buildNewPasswordField(context),
              SizedBox(height: MediaQuery.of(context).size.height/20,),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Confirm Password",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    )),
              ),
              buildConfirmPasswordField(context),
              SizedBox(height: MediaQuery.of(context).size.height/10,),
              buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNewPasswordField(BuildContext context){

    void toggle() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Stack(
        children: [
          Theme(
            data: ThemeData(primaryColor: Color(0xff302b6f)),
            child: TextFormField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.lock, color: Colors.grey.shade300,),
                ),
                hintText: 'Password',
              ),
              validator: (value) {
                if (value.length == 0) {
                  return 'Password is compulsary!';
                } else if (value.length < 6) {
                  return 'Password must be more than 6 charecters';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: toggle,
                child: Icon(Icons.remove_red_eye,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildConfirmPasswordField(BuildContext context){

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Theme(
        data: ThemeData(primaryColor: Color(0xff302b6f)),
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(Icons.lock, color: Colors.grey.shade300,),
            ),
            hintText: 'Password',
          ),
          validator: (value) {
            if (value.length == 0) {
              return 'Password is compulsary!';
            } else if (value.length < 6) {
              return 'Password must be more than 6 charecters';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildSaveButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(_formKey.currentState.validate()){
          print("Password successfully changed");
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
        child: Container(
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width / 1.4,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          child: Center(
            child: Text("Save",
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
//variables
bool _obscureText = true;
final _formKey = GlobalKey<FormState>();
