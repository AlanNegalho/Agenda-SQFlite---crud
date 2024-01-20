import 'package:crudflutter/funcion_user/service_user.dart';
import 'package:crudflutter/screens/user_add.dart';
import 'package:crudflutter/screens/user_edit.dart';
import 'package:crudflutter/screens/user_list.dart';
import 'package:flutter/material.dart';
import 'model/usuario.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  late List _userList = [];
  final _userService = ServicUser();

  getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    _userList = [];
    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.description = user['description'];
        _userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Tem certeza que deseja excluir',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _userService.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
                      _showSuccessSnackBar('Usuário Deletado com Sucesso');
                    }
                  },
                  child: const Text('Deletar',
                      style: TextStyle(color: Colors.white))),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Fechar',
                      style: TextStyle(color: Colors.white)))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQFLite CRUD Agenda'),
        backgroundColor: Color.fromARGB(255, 202, 209, 230),
        actions: [
          IconButton(
              onPressed: () async {
                await getAllUserDetails();
                _showSuccessSnackBar('Lista de Usuários Atualizada');
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/agenda.jpg",),
                scale: 0.2, 
                ),
                ),
        child: Padding(
          padding:  const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: _userList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserView(
                                    user: _userList[index],
                                  ),
                                  ),
                                  );
                    },
                    leading: const Icon(Icons.person),
                    title: Text(_userList[index].name ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [ IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserEdit(
                                            user: _userList[index],
                                          ))).then((data) {
                                if (data != null) {
                                  getAllUserDetails();
                                  _showSuccessSnackBar(
                                      'Usuário Alterado com Sucesso');
                                }
                              });
                              
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.teal,
                            )),
                      
                        IconButton(
                            onPressed: () {
                              _deleteFormDialog(context, _userList[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UserAdd()))
              .then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar('Usuário Adicionado com Sucesso');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}