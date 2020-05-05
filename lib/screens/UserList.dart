import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnafish/Components/Loading.dart';
import 'package:learnafish/models/user.dart';
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
    final user = Provider.of<Userdata>(context);
    getcurrentuser();
      return  load ? Loading() : StreamBuilder<Userdata>(
      stream: dbService(uid:user.uid).userdata,
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
                      dynamic output = await dbService(uid: user.uid).updateUser(
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
                      await dbService(uid: user.uid).deleteuser().then((_) {
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