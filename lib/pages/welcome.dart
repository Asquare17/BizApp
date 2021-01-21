import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    MaterialAccentColor primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Center(
              child: Card(
                elevation: 8.0,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Username or Email",
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Password",
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(30.0),
                        //elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () => {},
                          minWidth: 150.0,
                          height: 50.0,
                          color: primaryColor[700],
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't Have a Account? "),
                Text("  Sign Up",
                    style: TextStyle(
                      color: primaryColor,
                    )),
              ],
            ),
          ],
        ),
      ),
      //GUEST LOGIN
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/selection');
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                      side: BorderSide(color: primaryColor[200])),
                  child: Text(
                    "SKIP SIGN UP FOR NOW",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: primaryColor[700],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
