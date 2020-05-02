import 'package:flutter/material.dart';
import 'package:learnafish/models/user.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/db.dart';
import 'package:provider/provider.dart';

class usermanagement extends StatefulWidget {
  @override
  _usermanagementState createState() => _usermanagementState();
}

class _usermanagementState extends State<usermanagement> {
  final _key = GlobalKey<FormState>();
  String error = '';

//store current values
  String _username;
  String _bio;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<usermodel>(context);
    
    return StreamBuilder<Userdata>(
      stream: dbService(uid:user.userid).userdata,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          Userdata data = snapshot.data;
           return Form(
          key: _key,
          child:Column(
          children: <Widget>[
            Text(
              'User Managemet',
              style: TextStyle(fontSize:20.0),
            ),
             SizedBox(height:20.0),
             TextFormField(
               initialValue: data.username,
                validator: (val) =>val.isEmpty ? 'Enter a user name' : null,
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
                      await dbService(uid: user.userid).updateUser(
                        _username ?? data.username,
                        _bio ?? data.bio

                      );
                      Navigator.pop(context);
                    }
                  }
                  )
          ],
        ));
        }else
        {
          
        }
    
      }
    );
  }
}
