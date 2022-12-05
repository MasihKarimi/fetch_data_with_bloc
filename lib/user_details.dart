import 'package:fetch_data_from_api_with_bloc/models/User.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome ${user.firstname}")),
      body: Container(
        //height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        child: SizedBox(
          height: 200,
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${user.firstname} ${user.lastname}",
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(color: Colors.blueGrey),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
