import 'package:dio/dio.dart';
import 'package:dio_demo/features/domain/interface/main_repository_base.dart';
import 'package:dio_demo/features/infrastructure/models/main_response.dart';

abstract class Services {
  final MainRepositoryBase _repository;

  Services({
    required MainRepositoryBase repository,
  })  : _repository = repository;

  static Future<MainResponse?> getById(int id) async {
    // final res = await _repository.getById(id);
    try {
      var response = await Dio().get('https://reqres.in/api/users/$id');
      if (response.statusCode == 200) {
        return MainResponse(
          id: response.data['data']['id'],
          name: response.data['data']['first_name'] +
              ' ' +
              response.data['data']['last_name'],
          email: response.data['data']['email'],
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<MainResponse?> createUser(
      String firstName, String lastName, String email) async {
    try {
      var response = await Dio().post('https://reqres.in/api/users', data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      });
      if (response.statusCode == 201) {
        return MainResponse(
            id: int.tryParse(response.data['id'].toString()) ?? 0,
            name:
                response.data['first_name'] + ' ' + response.data['last_name'],
            email: response.data['email']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
