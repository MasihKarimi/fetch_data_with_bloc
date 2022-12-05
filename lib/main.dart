import 'package:fetch_data_from_api_with_bloc/models/User.dart';
import 'package:fetch_data_from_api_with_bloc/repos/repositories.dart';
import 'package:fetch_data_from_api_with_bloc/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/user_bloc.dart';
// import 'bloc/user_state.dart';
// import 'bloc/user_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(RepositoryProvider.of<UserRepository>(context))
            ..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Fetch Data App"),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ));
            }
            if (state is UserLoadedState) {
              List<UserModel> users = state.users;
              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UserDetails(user: users[index]))),
                      child: Card(
                        color: Colors.blue,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                users[index].avatar,
                              ),
                              radius: 50,
                            ),
                            minLeadingWidth: 30,
                            title: Text(
                              "${users[index].firstname} ${users[index].lastname}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            trailing: const Icon(
                              Icons.forward,
                              color: Colors.white,
                            )),
                      ),
                    );
                  });
            }
            if (state is UserLoadingErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
