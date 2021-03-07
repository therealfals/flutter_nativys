import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]),
            child: child
        ),
      ),
    );
  }
}
class Data {
  final int id;
  final String data;
  Data({this.data, this.id});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["email"] = this.data;
    return data;
  }
}
class MyAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {


    return MyAccountState();
  }
}

class MyAccountState extends State<MyAccount> {
  String _nom = 'ee';
  String _prenom;
  String _email;
  String _password;
  String _telephone;
  var test  ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   //var token = json.decode ( FlutterSession().get("token").toString());
  @override
  void initstate()  {
    print('ryyy');
    var token =   FlutterSession().get("token");
    setState(() async{
      var sharedPreferences = await SharedPreferences.getInstance();
      test =json.decode(sharedPreferences.getString("token"));
      print(test["data"]["user"]["id"]);
      //test =token["data"]["user"]['email'] ;
print('fghn');
    });
    print('efghj');
    super.initState();
  }
  Widget _buildPrenom() {
   return FutureBuilder<String>(
        future:  getDatas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TextFormField(

              initialValue: snapshot.data,
              decoration: InputDecoration(
                labelText: 'Prenom',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffDEA900))),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Le prenom est obligatoire';
                }

                return null;
              },
              onSaved: (String value) {
                _prenom = value;
              },
            );
            /*return Image(
              image: AdvancedNetworkImage(
                snapshot.data,
                timeoutDuration: Duration(minutes: 1),
                useDiskCache: true,
                cacheRule: CacheRule(maxAge: const Duration(days: 7)),
              ),
              height: mediaQuery.size.width * 0.22,
              width: mediaQuery.size.width * 0.22,
            );*/
          }
          /*else{
            return TextFormField(

            );
          }*/
          return Text("eeeeeeee");
        }

    );

   /* return TextFormField(

      initialValue: getDatas().toString(),
      decoration: InputDecoration(
        labelText: 'Prenom',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffDEA900))),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Le prenom est obligatoire';
        }

        return null;
      },
      onSaved: (String value) {
        _prenom = value;
      },
    );*/
  }
  Widget _buildNom() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nom',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffDEA900))),
      ),
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
  Widget _buildTelephone() {
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
        _telephone = value;
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
  Future<String> getDatas() async{
  var sharedPreferences =  await SharedPreferences.getInstance();
  test =   json.decode(sharedPreferences.getString("token"));
  return  (test["data"]["user"]["id"]).toString();
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Color(0xffDEA900),
              labelColor: Color(0xffDEA900),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(child:Text('Reservations' ,),),
                Tab(child:Text('Mon compte')),
              ],
            ),
            title: Text('Mon compte',style: TextStyle(color: Colors.black),),
            leading: IconButton(
    icon: Icon(
    Icons.arrow_back,
    color: Color(0xffDEA900) ,
    ),onPressed: () async{
              var sharedPreferences = await SharedPreferences.getInstance();
        var t =json.decode(sharedPreferences.getString("token"));
        print(t["data"]["user"]["id"]);
              var token = await FlutterSession().get("token");
          print( test );
             //  UserDetails userDetails = UserDetails.fromJson(jsonDecode(token["data"]));
               //print(userDetails );
            //   var parsedJson = json.decode(token.toString());

              //  print(parsedJson );
            },
    ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Color(0xffDEA900),
                ),
                onPressed: () {
                  // do something
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              Container(
                  margin: EdgeInsets.all(24),
                  padding: const EdgeInsets.only(top: 5, bottom: 0),
                  child:
                  Form(
                    key: _formKey,

                    child: Column(
                        children:[
                          Text('Modifier le profil',textAlign: TextAlign.left,),
                          //_buildPrenom(),
                          Padding(padding: EdgeInsets.all(8.0)),
                          _buildNom(),
                          Padding(padding: EdgeInsets.all(8.0)),

                          _buildEmail(),
                          Padding(padding: EdgeInsets.all(8.0)),
                          _buildTelephone(),

                        ]
                    ),
                  )

              ),
              SingleChildScrollView(
               child:
                 Container(
                     margin: EdgeInsets.all(24),
                     padding: const EdgeInsets.only(top: 5, bottom: 0),
                     child:
                     Column(
                         children:[
                           Container(
                               child: Align(
                                   alignment: Alignment.centerLeft,
                                   child: Text('Modifier le profil', style: TextStyle(fontSize: 18),))),
                           Padding(padding: EdgeInsets.all(8.0)),
                           _buildPrenom(),
                           Padding(padding: EdgeInsets.all(8.0)),
                           _buildNom(),
                           Padding(padding: EdgeInsets.all(8.0)),

                           _buildEmail(),
                           Padding(padding: EdgeInsets.all(8.0)),
                           _buildTelephone(),
                           Padding(padding: EdgeInsets.all(8.0)),

                           Align(
                               alignment: Alignment.centerLeft,
                               child: Text('Mes cartes enregistrées',style: TextStyle(fontSize: 18))),
                           Padding(padding: EdgeInsets.all(8.0)),
                           _buildTelephone(),
                           Padding(padding: EdgeInsets.all(8.0)),
                           Align(
                               alignment: Alignment.centerLeft,
                               child: Text('Mot de passe',style: TextStyle(fontSize: 18))),
                           Padding(padding: EdgeInsets.all(8.0)),

                           _buildPassword(),
                           Padding(padding: EdgeInsets.all(8.0)),

                           ConstrainedBox(
                             constraints: const BoxConstraints(
                                 minWidth:150, minHeight: 40),
                             child: RaisedButton(
                               onPressed: () {
                                 if (!_formKey.currentState.validate()) {
                                   return;
                                 }
                                 _formKey.currentState.save();

                               },
                               color: Color(0xffDEB144),
                               shape: RoundedRectangleBorder(
                                   borderRadius: new BorderRadius.circular(10.0)),
                               child: Text(
                                 "Modifier",
                                 style: TextStyle(fontSize: 16, color: Colors.white),
                               ),
                             ),
                           ),
                           Padding(padding: EdgeInsets.all(8.0)),

                           ConstrainedBox(
                             constraints: const BoxConstraints(
                                 minWidth: double.infinity, minHeight: 40),
                             child: RaisedButton(
                               onPressed: () {
                                 if (!_formKey.currentState.validate()) {
                                   return;
                                 }
                                 _formKey.currentState.save();

                               },
                               color: Colors.white,
                               shape: RoundedRectangleBorder(
                                   borderRadius: new BorderRadius.circular(10.0),side: BorderSide(color: Color(0xffDEB144))),
                               child: Text(
                                 "Deconnexion",
                                 style: TextStyle(fontSize: 16, color: Colors.black),
                               ),
                             ),
                           ),
                         ]
                     )
                 ),

             )
            ],
          ),
        ),
      ),
    );
  }

  Widget makeItem({image, title}) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover
            )
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.2),
                  ]
              )
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
        ),
      ),
    );
  }

/*@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }*/
}