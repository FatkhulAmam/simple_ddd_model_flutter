import 'package:dio/dio.dart';
import 'package:dio_demo/infrastructure/models/main_response.dart';

class MainRemoteDataSource {
  Future<MainResponse?> getById(int id) async {
    try {
      var response = await Dio().get('https://reqres.in/api/users/$id');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}