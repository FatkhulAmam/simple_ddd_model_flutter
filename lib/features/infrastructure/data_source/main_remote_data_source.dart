import 'package:dio/dio.dart';
import 'package:dio_demo/infrastructure/models/main_response.dart';

class MainRemoteDataSource {
  Future<MainResponse?> getById(int id) async {
    final res = await Dio().get('https://reqres.in/api/users/$id').catchError((e){
      Exception(e.toString());
    });

    return res.data;

    // try {
    //   var response = await Dio().get('https://reqres.in/api/users/$id');
    //   if (response.statusCode == 200) {
    //     return response.data;
    //   }
    // } catch (e) {
    //   throw Exception(e.toString());
    // }
  }
}