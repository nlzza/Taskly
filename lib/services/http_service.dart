import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../models/app_config.dart';

class HTTPService {
  final Dio dio = Dio();

  late AppConfig _appConfig;
  late String baseUrl;

  HTTPService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    baseUrl = _appConfig.COIN_API_BASE_URL;
  }

  Future<Response?> get(String path) async {
    try {
      return await dio.get(baseUrl + path);
    } catch (e) {
      print("HTPPService: Unable to perform the request");
      print(e);
    }
  }
}
