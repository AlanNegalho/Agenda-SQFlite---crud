import '../model/crud.dart';
import '../model/usuario.dart';

class ServicUser {
    late FunctionCrud _repository;
  ServicUser() {
    _repository = FunctionCrud();
  }

  SaveUser(User user) async {
    return await _repository.insertData('usuarios', user.userMap());
  }

  readAllUsers() async {
    return await _repository.readData('usuarios');
  }

  UpdateUser(User user) async {
    return await _repository.updateData('usuarios', user.userMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('usuarios', userId);
  }
}
