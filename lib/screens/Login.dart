import 'package:flutter/material.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';

class login extends StatefulWidget {
  
  final Function redirect;
  login({ this.redirect });

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
 
  final services _authentication = services();
    //text fields for  login
  String email = '';
  String password='';
  @override
  Widget build(BuildContext context) {
        return new Scaffold(
           appBar: AppBar(
        title: Text('Sea World!'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person), 
            label: Text('Register'),
             onPressed: (){
              widget.redirect();
             }
            )
        ],
      ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            child:Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                        'Welcome To SEAWORLD!',
                        style: TextStyle(
                            fontSize: 20.0,fontWeight:FontWeight.bold)
                    )
                ),
                Container(
                   padding: EdgeInsets.fromLTRB(15.0, 150.0, 15.0, 0.0),
                   child: Form(
                     child: Column(
                       children: <Widget>[
                         SizedBox(height:20.0),
                         TextFormField(
                           decoration: InputDecoration(
                               labelText : 'Email',
                             labelStyle : TextStyle(
                               fontFamily : 'Montserrat',
                               fontWeight : FontWeight.bold,
                               color : Colors.black
                             )
                           ),
                           onChanged: (val){
                             setState(()=>email = val);
                           }
                         ),
                         SizedBox(height: 20.0,),
                         TextFormField(
                           decoration: InputDecoration(
                             labelText : 'Password',
                             labelStyle : TextStyle(
                               fontFamily : 'Montserrat',
                               fontWeight : FontWeight.bold,
                               color : Colors.black
                             )
                           ),
                           obscureText: true,
                           onChanged: (val){
                               setState(()=>password = val);
                           },
                         ),
                          SizedBox(height: 20.0,),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius : BorderRadius.circular(20.0),
                            ),
                              color: Colors.lightBlue[400] ,
                              child: Text(
                                'Sign In'
                              ),
                              onPressed: () async{

                              }
                          )
                       ],
                     ),
                   ),
                )
               
              ],
            )
        )
      ],
    ),

  );
  }
}

 