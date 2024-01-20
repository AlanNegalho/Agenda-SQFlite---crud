import 'package:crudflutter/funcion_user/service_user.dart';
import 'package:flutter/material.dart';
import '../model/usuario.dart';


// ignore: must_be_immutable
class UserEdit extends StatelessWidget {
  late User user;
  UserEdit({Key? key, required this.user}) : super(key: key);
        
  final _userNameController = TextEditingController();
  final _userDescriptionController = TextEditingController();
  bool _validateName = false;
  
  bool _validateDescription = false;

  final _servicUser = ServicUser();

  void initState() {
    
    _servicUser.readAllUsers().then((users) {
      users.forEach((user) {
        if (user.id == this.user) {
          _userNameController.text = user.name!;
          _userDescriptionController.text = user.description!;
        }
      });
    });
  }

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
                'Editar Usuário',
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
                  controller: _userDescriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Descrição',
                    labelText: 'Descrição',
                    errorText: _validateDescription 
                        ? 'O valor do descrição não pode estar vazio'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                         
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        (() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          
                          _userDescriptionController.text.isEmpty
                              ? _validateDescription = true
                              : _validateDescription = false;
                        });
                        if (_validateName == false &&
                          
                            _validateDescription == false) {
                          // print("Good Data Can Save");
                          var _user = User();
                          _user.id = user.id as int;
                          _user.name = _userNameController.text;
                          _user.description = _userDescriptionController.text;
                          
                          var result = await _servicUser.UpdateUser(_user);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Dados Atualizados',
                      style: TextStyle(color: Colors.white),)),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        shadowColor: const Color.fromARGB(255, 255, 255, 255),
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _userNameController.text = '';
                       
                        _userDescriptionController.text = '';
                      },
                      child: const Text('Limpar Campos',
                      style: TextStyle(color: Colors.white,)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


// class UserEdit extends StatefulWidget {
//   late User  user;
//   UserEdit({Key? key, required this.user}) : super(key: key);

//   @override
//   State createState() => _EditUserState();
// }

// class _EditUserState extends State {
//   var user = User();
//   final id = User().id;
//   var _userNameController = TextEditingController();
//   var _userDescriptionController = TextEditingController();
//   bool _validateNome = false;
//   bool _validateDescricao = false;
//   var _userService = ServicUser();

//   @override
//   void initState() {
//     setState(() {
//       _userNameController.text = user.name ?? '';
//       _userDescriptionController.text = user.description ?? '';
//     });
//     super.initState();
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("SQLite CRUD"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Editar Usuário',
//                 style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.teal,
//                     fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               TextField(
//                   controller: _userNameController,
//                   decoration: InputDecoration(
//                     border: const OutlineInputBorder(),
//                     hintText: 'Nome',
//                     labelText: 'Nome',
//                     errorText: _validateNome
//                         ? 'O valor do nome não pode estar vazio'
//                         : null,
//                   )),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               TextField(
//                   controller: _userDescriptionController,
//                   decoration: InputDecoration(
//                     border: const OutlineInputBorder(),
//                     hintText: 'Descrição',
//                     labelText: 'Descrição',
//                     errorText: _validateDescricao
//                         ? 'O valor do descrição não pode estar vazio'
//                         : null,
//                   )),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 children: [
//                   TextButton(
//                       style: TextButton.styleFrom(
//                           primary: Colors.white,
//                           backgroundColor: Colors.teal,
//                           textStyle: const TextStyle(fontSize: 15)),
//                       onPressed: () async {
//                         setState(() {
//                           _userNameController.text.isEmpty
//                               ? _validateNome = true
//                               : _validateNome = false;
//                           _userDescriptionController.text.isEmpty
//                               ? _validateDescricao = true
//                               : _validateDescricao = false;
//                         });
//                         if (_validateNome == false &&

//                             _validateDescricao == false) {
//                           // print("Good Data Can Save");
//                           var _user = User();
//                           _user.id = id as int;
//                           _user.name = _userNameController.text;
                     
//                           _user.description = _userDescriptionController.text;
//                           var result = await _userService.UpdateUser(_user);
//                           Navigator.pop(context, result);
//                         }
//                       },
//                       child: const Text('Dados Atualizados')),
//                   const SizedBox(
//                     width: 10.0,
//                   ),
//                   TextButton(
//                       style: TextButton.styleFrom(
//                           primary: Colors.white,
//                           backgroundColor: Colors.red,
//                           textStyle: const TextStyle(fontSize: 15)),
//                       onPressed: () {
//                         _userNameController.text = '';
//                         _userDescriptionController.text = '';
//                       },
//                       child: const Text('Limpar Campos'))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }