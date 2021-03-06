import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
class MyAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAccountState();
  }
}

class MyAccountState extends State<MyAccount> {
  String _nom;
  String _prenom;
  String _email;
  String _password;
  String _telephone;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildPrenom() {
    return TextFormField(
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(child:Text('Reservations')),
                Tab(child:Text('Mon compte')),
              ],
            ),
            title: Text('Mon compte',textAlign: TextAlign.center,),

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
                          _buildPrenom(),
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
                               child: Text('Modifier le profil',textAlign: TextAlign.left,)),
                           _buildPrenom(),
                           Padding(padding: EdgeInsets.all(8.0)),
                           _buildNom(),
                           Padding(padding: EdgeInsets.all(8.0)),

                           _buildEmail(),
                           Padding(padding: EdgeInsets.all(8.0)),
                           _buildTelephone(),
                           Text('Mes cartes enregistrées'),
                           Padding(padding: EdgeInsets.all(8.0)),
                           _buildTelephone(),
                           Padding(padding: EdgeInsets.all(8.0)),
                           Text('Mot de passe'),
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
                                   borderRadius: new BorderRadius.circular(10.0),side: BorderSide(color: Colors.red)),
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