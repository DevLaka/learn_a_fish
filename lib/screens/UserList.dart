/// ********************************************************************************************************************
/// This project was developed by the below-mentioned developers who are studying for                                  *
/// BSc (Hons) in Information Technology Specializing in Software Engineering at Sri Lanka Institute of                *
/// Information Technology. This project is developed as an assignment for the module Current Trends in                *
/// Software Engineering.                                                                                              *
/// Student Name             IT Number                                                                                 *
/// H.M.Y.L.W.Bandara       IT17250498                                                                                 *
/// D.L.Kodagoda            IT17145008                                                                                 *
///                                                                                                                    *
/// The intellectual and technical concepts contained herein are proprietary to its developers mentioned above         *
/// and Dissemination of this information or reproduction of this material is strictly forbidden unless                *
/// prior written permission is obtained from the above mentioned developers.                                          *
///                                                                                                                    *
///*********************************************************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnafish/Components/Loading.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/services/authentication_services/UserDBService.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/db.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
  
}

class _UserListState extends State<UserList> {
    final _key = GlobalKey<FormState>();
    String error = '';

//store current values
  String _username;
  String _bio;
    bool load = false;
   var email ;
//get current user
getcurrentuser() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
   email = user.email;
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userdata>(context) ?? Userdata(uid: DateTime.now().toIso8601String(), username: 'user', bio: 'biobio');
    print(user.uid);
    getcurrentuser();
      return  load ? Loading() : StreamBuilder<Userdata>(
      stream: UserDBService(uid:user.uid).userdata,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          Userdata data = snapshot.data;
           return Form(
          key: _key,
          child:Column(
          children: <Widget>[
           Text(
              email.toString(),
              style: TextStyle(
                fontSize:18.0,
                fontWeight: FontWeight.bold
              ) ,
            ),
             SizedBox(height:20.0),
             TextFormField(
               initialValue: data.username,
                decoration: InputDecoration(
                 labelText : 'User Name',
                  labelStyle : TextStyle(
                  fontFamily : 'Montserrat',
                  fontWeight : FontWeight.bold,
                  color : Colors.black
                     )
                   ),
                    onChanged: (val){
                       setState(()=>_username = val);
                     }
               ),
                SizedBox(height:20.0),
             TextFormField(
                initialValue: data.bio,
                validator: (val) =>val.isEmpty ? 'Enter your bio' : null,
                decoration: InputDecoration(
                 labelText : 'Bio',
                  labelStyle : TextStyle(
                  fontFamily : 'Montserrat',
                  fontWeight : FontWeight.bold,
                  color : Colors.black
                     )
                   ),
                    onChanged: (val){
                       setState(()=>_bio = val);
                     }
               ),
               
                SizedBox(height:20.0),
                RaisedButton(
                  color: Colors.lightBlue[400] ,
                  child: Text( 'Update'),
                  onPressed: () async{
                    if(_key.currentState.validate()){
                      setState(()=> load = true);
                      dynamic output = await UserDBService(uid: user.uid).updateUser(
                        _username ?? data.username,
                        _bio ?? data.bio

                      );
                      if(output == null)
                      {
                        setState(()
                         {
                          error= 'incorret password or email !';
                          load = false;
                         });
                      }
                    
                    }
                  }
                  ),
                  SizedBox(height:20.0),
                RaisedButton(
                  color: Colors.lightBlue[400] ,
                  child: Text( 'delete'),
                  onPressed: () async{
                      await UserDBService(uid: user.uid).deleteuser().then((_) {
                         setState(() { 
                        load = true;
                        Navigator.pushReplacementNamed(context, '/login');
                         });
                         });
                  }
                  )
          ],
        ));
        }else
        {
          return Container(

          );
        };
    
      }
    );
  }
}