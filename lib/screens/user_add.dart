
import 'package:crudflutter/funcion_user/service_user.dart';
import 'package:crudflutter/model/usuario.dart';
import 'package:flutter/material.dart';

class UserAdd extends StatefulWidget {
  const UserAdd({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AddUserState();
  }
}

class _AddUserState extends State {
  final _userNameController = TextEditingController();
  final _userDescricaoController = TextEditingController();
  bool _validateName = false;

  bool _validateDescricao = false;
  final _ServicUser = ServicUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite CRUD"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Adicionar novo usuário',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Nome',
                    labelText: 'Nome',
                    errorText: _validateName
                        ? 'O valor do nome não pode estar vazio'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userDescricaoController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Descrição',
                    labelText: 'Descrição',
                    errorText: _validateDescricao
                        ? 'O valor do descrição não pode estar vazio'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          ),
                      onPressed: () {
                        _userNameController.text = '';
                        _userDescricaoController.text = '';
                      },
                      child: const Text('Limpar Dados',
                          style: TextStyle(color: Colors.white))),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;

                          _userDescricaoController.text.isEmpty
                              ? _validateDescricao = true
                              : _validateDescricao = false;
                        });
                        if (_validateName == false &&
                            _validateDescricao == false) {
                          var user = User();
                          user.name = _userNameController.text;
                          user.description = _userDescricaoController.text;
                          var result = await _ServicUser.SaveUser(user);
                          if (result > 0) {Navigator.pop(context);
                          }
                        }
                      },
                      child: const Text('Salvar', style: TextStyle(
                        color: Colors.white, fontSize: 15
                      ),
                      ),),
                  const SizedBox(
                    width: 10.0,
                  ),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}