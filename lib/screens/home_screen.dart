import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tours_app/bloc/google-sign-in/google_sign_in_bloc.dart';
import 'package:tours_app/bloc/user/user_bloc.dart';
import 'package:tours_app/config/constants.dart';
import 'package:tours_app/config/palette.dart';
import 'package:tours_app/model/tour.dart';
import 'package:tours_app/screens/add_tour_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(FetchAllTours());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: new FloatingActionButton(
            onPressed: () => kRoute(AddTourScreen()),
            child: Icon(Icons.add_a_photo),
          ),
          appBar: AppBar(
            actions: [
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () => BlocProvider.of<GoogleSignInBloc>(context)
                      .add(SignOutUserEvent())),
              SizedBox(width: 10),
            ],
            title: Text("NATOURS"),
            centerTitle: true,
          ),
          body: _handelHomeScreen(state),
        );
      },
    );
  }

  _handelHomeScreen(UserState state) {
    if (state is ToursUserState) {
      if (state.tours != null && state.tours.length != 0)
        return ListView.builder(
            itemCount: state.tours.length,
            itemBuilder: (context, index) {
              return TourCard(tour: state.tours[index]);
            });
      else
        return _noImages();
    } else if (state is LoadingUserState) {
      return Center(
        child: Container(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  _noImages() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_a_photo,
            color: Colors.black26,
            size: 50,
          ),
          Text(
            "Press + to add new tour",
            style: TextStyle(
              color: Colors.black26,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class TourCard extends StatelessWidget {
  final Tour tour;

  TourCard({this.tour});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showDeleteDialogBox(context, tour.uid),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        height: 150,
        width: double.infinity,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: tour.imageUrl,
              height: 150,
              width: 150,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 25,
                      ),
                      Expanded(
                        child: Text(
                          tour.location,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    tour.des,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDeleteDialogBox(context, uid) {
    Alert(context: context, title: "Do you want to delete Image?", buttons: [
      DialogButton(
        color: Palette.mainColor,
        child: Text(
          "YES",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => _handleDeleteButton(context, uid),
        width: 120,
      ),
      DialogButton(
        color: Colors.redAccent,
        child: Text(
          "NO",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
    ]).show();
  }

  _handleDeleteButton(context, uid) async {
    Navigator.pop(context);
    BlocProvider.of<UserBloc>(context).add(DeleteTourData(uid: uid));
  }
}
