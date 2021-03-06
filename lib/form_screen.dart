import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _name;
  String _email;
  String _password;
  String _url;
  String _phoneNumber;
  String _calories;
  String _path = 'https://api.nativys.com/api/v1/login';
  String _isConnected = 'true';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

/*  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    return stringValue;
  }*/
  void login(email, password) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    var params = {
      "email": email,
      "password": password,
    };
    // Response response;
    var response = await Dio().post(_path,
        options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
        data: params);
    if (response.statusCode == 201) {
      //  print(response.toString());
      //    var roken = response.data as String;
      var r = jsonDecode(response.toString());
      // prefs.setString('token', r);
      await FlutterSession().set("token", response.toString());
      final snackBar = SnackBar(content: Text("Login Successful"));
      scaffoldKey.currentState.showSnackBar(snackBar);
    } else if (response.statusCode == 401) {
      final snackBar =
          SnackBar(content: Text("Login ou mot de passe incorrect"));
      scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
      ),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDEA900))),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'L\'email est obligatoire';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Veuilez saisir un email valide';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Mot de passe',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDEA900))),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Le mot de passe est obligatoire';
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _builURL() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Url'),
      keyboardType: TextInputType.url,
      validator: (String value) {
        if (value.isEmpty) {
          return 'URL is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _url = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _url = value;
      },
    );
  }

  Widget _buildCalories() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Calories'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int calories = int.tryParse(value);

        if (calories == null || calories <= 0) {
          return 'Calories must be greater than 0';
        }

        return null;
      },
      onSaved: (String value) {
        _calories = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: RichText(
            text: TextSpan(
                text: "S'identifier avec son compte NA",
                style: TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'T',
                      style: TextStyle(color: Color(0xffD5B705)),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'IVYS', style: TextStyle(color: Colors.black))
                      ])
                ]),
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          padding: const EdgeInsets.only(top: 60, bottom: 0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: "NA",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'T',
                            style: TextStyle(color: Color(0xffD5B705)),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'IVYS',
                                  style: TextStyle(color: Colors.black))
                            ])
                      ]),
                ),
                // SizedBox(height: 50),
                Padding(padding: EdgeInsets.all(32.0)),
                // _buildName(),
                _buildEmail(),
                Padding(padding: EdgeInsets.all(15.0)),

                _buildPassword(),
                Padding(padding: EdgeInsets.all(15.0)),
                Text(
                  "Vous avez oublié votre mot de passe ?",
                  style: TextStyle(color: Color(0xffD5B705), fontSize: 16),
                ),
                Padding(padding: EdgeInsets.all(15.0)),

                ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: double.infinity, minHeight: 60),
                  child: RaisedButton(
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      // var b =getStringValuesSF();
                      // print(b);
                      login(_email, _password);
                      if (_isConnected == 'true') {
                        child:
                        Text("Login ou mot de passe incorrect",
                            style: TextStyle(fontSize: 16, color: Colors.red));

                        print(
                            'rrrrttttttttttttttttttttttttttttttttttttttttttttttttttttt');
                        // Text("",style:  TextStyle(fontSize: 16,color: Colors.red));
                      }
                    },
                    color: Color(0xffDEB144),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    child: Text(
                      "Se connecter",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(15.0)),
                Text(
                  "Vous n'avez pas de compte ?",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormScreenRegisterState()));
                  },
                  child: new Text("Inscription",
                      style: TextStyle(color: Color(0xffDEB144), fontSize: 16)),
                ),
                // Text("Inscription",style: TextStyle(color: Color(0xffDEB144),fontSize: 16)),
                // _builURL(),
                // _buildPhoneNumber(),
                // _buildCalories(),
                SizedBox(height: 100),
                /**  RaisedButton(
                    child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onPressed: () {
                    if (!_formKey.currentState.validate()) {
                    return;
                    }

                    _formKey.currentState.save();

                    print(_name);
                    print(_email);
                    print(_phoneNumber);
                    print(_url);
                    print(_password);
                    print(_calories);

                    //Send to API
                    },
                    )**/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormScreenRegisterState extends StatelessWidget {
  String _name;
  String _email;
  String _password;
  String _passwordConfirm;
  String _url;
  String _nom;
  String _phoneNumber;
  String _calories;

  void register(email, password, phone, prenom, nom, password_confirm) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String _path = 'https://api.nativys.com/api/v1/signup-client';

    var params = {
      "prenom": prenom,
      "nom": nom,
      "phone": phone,
      "email": email,
      "password": password,
      "confirm_password": password_confirm
    };
    // Response response;
    var response = await Dio().post(_path,
        options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
        data: params);
    print(params);
    print(response);

    if (response.statusCode == 201) {
      //  print(response.toString());
      //    var roken = response.data as String;
      var r = jsonDecode(response.toString());
      // prefs.setString('token', r);
      await FlutterSession().set("token", response.toString());
      final snackBar = SnackBar(content: Text("Compte créé avec succés"));
      scaffoldKey.currentState.showSnackBar(snackBar);
    } else if (response.statusCode == 401) {
      final snackBar = SnackBar(
          content: Text("Veuillez remplir correctement tout les champs!"));
      scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Prenom',
        border: OutlineInputBorder(),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Le prenom est obligatoire';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDEA900))),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'L\'email est obligatoire';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Veuilez saisir un email valide';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Mot de passe',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDEA900))),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Le mot de passe est obligatoire';
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildPasswordConfirm() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Confirmer Mot de passe',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDEA900))),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Le mot de passe est obligatoire';
        }

        return null;
      },
      onSaved: (String value) {
        _passwordConfirm = value;
      },
    );
  }

  Widget _builNom() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Nom',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDEA900))),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Le nom est obligatoire';
        }

        return null;
      },
      onSaved: (String value) {
        _nom = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Telephone',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDEA900))),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Le telephone est obligatoire';
        }

        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }

  /*Widget _buildCalories() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Calories'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int calories = int.tryParse(value);

        if (calories == null || calories <= 0) {
          return 'Calories must be greater than 0';
        }

        return null;
      },
      onSaved: (String value) {
        _calories = value;
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: RichText(
            text: TextSpan(
                text: "Creer un compte",
                style: TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: '',
                      style: TextStyle(color: Color(0xffD5B705)),
                      children: <TextSpan>[
                        TextSpan(
                            text: '', style: TextStyle(color: Colors.black))
                      ])
                ]),
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          padding: const EdgeInsets.only(top: 5, bottom: 0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: "NA",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'T',
                            style: TextStyle(color: Color(0xffD5B705)),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'IVYS',
                                  style: TextStyle(color: Colors.black))
                            ])
                      ]),
                ),
                // SizedBox(height: 50),
                Padding(padding: EdgeInsets.all(8.0)),
                // _buildName(),
                _buildName(),
                Padding(padding: EdgeInsets.all(8.0)),

                _builNom(),
                Padding(padding: EdgeInsets.all(8.0)),

                _buildEmail(),
                Padding(padding: EdgeInsets.all(8.0)),
                _buildPhoneNumber(),
                Padding(padding: EdgeInsets.all(8.0)),

                _buildPassword(),
                Padding(padding: EdgeInsets.all(8.0)),
                _buildPasswordConfirm(),
                Padding(padding: EdgeInsets.all(8.0)),

                Text(
                  "En continuant, vous acceptez nos Termes et Conditions?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),

                Padding(padding: EdgeInsets.all(8.0)),

                ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: double.infinity, minHeight: 60),
                  child: RaisedButton(
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      // var b =getStringValuesSF();
                      // print(b);
                      register(_email, _password, _phoneNumber, _name, _nom,
                          _passwordConfirm);
                      dynamic token = await FlutterSession().get("token");
                      print('------------');
                      print(token);
                      print('------------');
                    },
                    color: Color(0xffDEB144),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    child: Text(
                      "Creer votre compte",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(5.0)),

                // _builURL(),
                // _buildPhoneNumber(),
                // _buildCalories(),
                /**  RaisedButton(
                    child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onPressed: () {
                    if (!_formKey.currentState.validate()) {
                    return;
                    }

                    _formKey.currentState.save();

                    print(_name);
                    print(_email);
                    print(_phoneNumber);
                    print(_url);
                    print(_password);
                    print(_calories);

                    //Send to API
                    },
                    )**/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuBottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final List<String> _listItem = [
      'assets/images/clock.png',
      'assets/images/clock.png',
      'assets/images/clock.png',
      'assets/images/clock.png',
      'assets/images/clock.png',
      'assets/images/clock.png',
      'assets/images/clock.png',
      'assets/images/clock.png',
      'assets/images/clock.png',

    ];

    double Height = MediaQuery.of(context).size.height;

    return Scaffold(
      //  backgroundColor: color: Color(00fxD5B705);

        appBar: AppBar(
          title: const Text('BottomNavigationBar Sample'),
        ),
        /* body: Container(
       child: (
        ListView(
          children: [
            Container(child: Image(image: AssetImage('assets/images/background.png'), fit: BoxFit.fill,)),
           /* GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: <Widget>[
            Container(color: Colors.blue,margin: EdgeInsets.all(5.0),)
            ],
           ),*/

          //  Image(image: AssetImage('assets/images/background.png')),
          ],
        )




    )
     ),*/
      /**  body: Container(
          child: Container(
            child: Container(
              child: Column(

                children: <Widget>[

               Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 200,
                          color: Colors.red,
                        ),
                        Container(
                          width: 200,
                          color: Colors.red,
                        ),
                        Container(
                          width: 200,
                          color: Colors.red,
                        ),
                        Container(
                          width: 200,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                height: 200,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 100,
                          color: Colors.blue,
                        ),
                        Container(
                          width: 50,
                          height: 100,
                          color: Colors.blue,
                        ),
                        Container(
                          width: 50,
                          height: 100,
                          color: Colors.green,
                        ),
                        Container(
                          width: 50,
                          height: 100,
                          color: Colors.red,
                        ),
                        Container(
                          width: 50,
                          height: 100,
                          color: Colors.yellowAccent,
                        ),
                        Container(
                          width: 50,
                          height: 100,
                          color: Colors.blue,
                        ),
                        Container(
                          width: 50,
                          height: 100,
                          color: Colors.green,
                        ),
                        Container(
                          width: 50,
                          height: 100,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                  Container(
                     height: 500,

                    child: Center(

                      child: GridView.count(

                      //  scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        children: List.generate(50, (index) {
                          return Container(
                            child: Card(
                              color: Colors.amber,
                            ),
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),**/

        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage('assets/images/clock.png'),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(.4),
                              Colors.black.withOpacity(.2),
                            ]
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Réservez votre moment de bien etre rien que pour vous !", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(height: 30,),
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                          ),
                          child: Center(
                              child: TextFormField()
                              //Text("Shop Now", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)
                          ),
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                       children: _listItem.map((item) => Card(
                        color: Colors.red,
                        elevation: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage(item),
                                  fit: BoxFit.cover
                              )
                          ),
                          child: Transform.translate(
                            offset: Offset(0, 70),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 63),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                              ),
                             // child: Icon(Icons.bookmark_border, size: 15,),
                              child: Text('Salon de beautébe autébeauté',textAlign:TextAlign.center, style: TextStyle(fontSize: 15),),
                            ),
                          ),
                        ),
                      )).toList(),
                    )
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
          /* currentIndex: _selectedIndex,
    selectedItemColor: Colors.amber[800],
    onTap: _onItemTapped,*/
        )
    );
  }
}
