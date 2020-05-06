import 'package:flutter/material.dart';
import 'package:learnafish/services/authentication_services/AuthenticationService.dart';
import 'package:learnafish/models/Fish.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/db.dart';
import 'package:provider/provider.dart';
import 'package:learnafish/Components/FishList.dart';

class Home extends StatelessWidget {
  final services _homeAuthentication = services();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Fish>>.value(
      value: dbService().fishStream,
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/background.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'HOME',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add_box,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/fishInsert');
                  },
                ),
                //navigate to user management
                IconButton(
                  icon: Icon(
                    Icons.people_outline,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/UserManagementview');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    await _homeAuthentication.SignOut();
                  },
                ),
              ],
            ),
            body: FishList(),
          ),
        ],
      ),
    );
  }
}
