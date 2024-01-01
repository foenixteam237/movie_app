import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/app_config.dart';

class HTTPService {
  final dio = Dio();
  final GetIt getIt = GetIt.instance;

  String? _base_url;
  String? _api_key;

  HTTPService() {
    AppConfig _config = getIt.get<AppConfig>();
    _base_url = _config.BASE_URL;
    _api_key = _config.API_KEY;
  }

  // ignore: no_leading_underscores_for_local_identifiers
  Future<Response> get(String _path, {Map<String, dynamic>? query}) async {
    try {
      String _url = '$_base_url$_path';
      Map<String, dynamic> _query = {'api_key': _api_key, 'langage': 'en-US'};
      if (query != null) {
        _query.addAll(query);
      }

      return await dio.get(_url, queryParameters: _query);
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
