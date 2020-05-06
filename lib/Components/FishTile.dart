import 'package:flutter/material.dart';
import 'package:learnafish/Components/FishUpdateForm.dart';
import 'package:learnafish/models/Fish.dart';
import 'package:learnafish/screens/FishView.dart';
import 'package:learnafish/services/fish_crud_and_orther_services/db.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FishTile extends StatefulWidget {
  final Fish fish;
  FishTile({this.fish});

  @override
  _FishTileState createState() => _FishTileState();
}

class _FishTileState extends State<FishTile> {
  String imageUrl;

  @override
  void initState() {
    StorageReference firebaseStorageReference =
        FirebaseStorage.instance.ref().child(widget.fish.docID);
    firebaseStorageReference
        .getDownloadURL()
        .then((iUrl) => setState(() => imageUrl = iUrl));
    super.initState();
  }

  Future<bool> _showDeleteConfirmationPopup() {
    return Alert(
        context: context,
        title: "Are you sure you to delete!!!",
        image: Image.asset("assets/error-alert.png"),
        buttons: [
          DialogButton(
              child: Text('Confirm Delete'),
              onPressed: () {
                dbService().deleteSingleFishData(widget.fish.docID);
                Navigator.pop(context);
              }),
          DialogButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    StorageReference firebaseStorageReference =
        FirebaseStorage.instance.ref().child(widget.fish.docID);
    firebaseStorageReference
        .getDownloadURL()
        .then((iUrl) => setState(() => imageUrl = iUrl));

    void _showFishSettings(Fish fish) {
      showModalBottomSheet(
          backgroundColor: Colors.black45,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 57.0),
              child: FishUpdateForm(fish: fish),
            );
          });
    }

    return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(17.0, 7.0, 17.0, 0.0),
          child: Container(
            height: 80.0,
            child: ListTile(
              leading: SizedBox(
                width: 100.0,
                height: 110.0,
                child: (imageUrl == null)
                    ? Image.asset(
                        'assets/nemo.png',
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                      ),
              ),
              title: Text(widget.fish.comName),
              subtitle: Text(widget.fish.scName),
              onLongPress: () => _showFishSettings(widget.fish),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FishView(fish: widget.fish, imageUrl: imageUrl)),
                );
              },
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _showDeleteConfirmationPopup()),
            ),
          ),
        ));
  }
}
