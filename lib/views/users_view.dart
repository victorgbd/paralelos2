import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paralelos2/providers/user_provider.dart';
import 'package:paralelos2/user_entity.dart';
import 'package:paralelos2/user_repository.dart';
import 'package:paralelos2/views/user_management_view.dart';

class UsersView extends ConsumerStatefulWidget {
  const UsersView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UsersViewState();
}

class _UsersViewState extends ConsumerState<UsersView> {
  UserRepository repo = UserRepository(http.Client());

  List<User> userIsolate = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userNotifierProvider.notifier).fetchAll();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuarios"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserManagementView(),
                ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            "images/shot-gif.gif",
            height: 125.0,
            width: 125.0,
          ),
          ElevatedButton(
              onPressed: () async {
                ref.read(userNotifierProvider.notifier).fetchAll();
              },
              child: const Text("Hilo principal")),
          Expanded(
            child: userState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: userState.users.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = userState.users[index];
                      return Card(
                        child: Column(children: [
                          Text(user.nombreUsuario!),
                          Text(user.nombreCompleto!)
                        ]),
                      );
                    },
                  ),
          ),
          ElevatedButton(
              onPressed: () async {
                ReceivePort resultPort = ReceivePort();
                await Isolate.spawn(
                  repo.fetchAllIsolate,
                  resultPort.sendPort,
                );

                resultPort.listen((result) {
                  if (result != null) {
                    setState(() {
                      userIsolate = result;
                    });
                  }
                });
              },
              child: const Text("En hilo secundario")),
          Expanded(
            child: Builder(
              builder: (context) {
                return ListView.builder(
                  itemCount: userIsolate.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = userIsolate[index];
                    return Card(
                      child: Column(children: [
                        Text(user.nombreUsuario!),
                        Text(user.nombreCompleto!)
                      ]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
