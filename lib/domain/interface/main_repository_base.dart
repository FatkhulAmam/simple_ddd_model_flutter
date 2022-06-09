import '../../infrastructure/models/main_response.dart';

abstract class MainRepositoryBase{
  Future<MainResponse?> getById(int id);
}