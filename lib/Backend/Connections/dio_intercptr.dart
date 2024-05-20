import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Essentials_App/prefs.dart';

class GeneralInterceptor extends Interceptor {
  final AppPreferences appPreferences;

  GeneralInterceptor({required this.appPreferences});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String token = await appPreferences.getUserToken();
    if (token.isNotEmpty) {
      options.headers["authorization"] = "Bearer $token";
      
      try {
        Response response = await Dio().get('https://dummyjson.com/auth/me', 
          options: Options(headers: {'Authorization': 'Bearer $token'})
        );
        int currentUserId = response.data['id'];
        
        // Save token and current user ID in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userToken', token);
        await prefs.setInt('currentUserId', currentUserId);
        
      } catch (e) {
        // ignore: avoid_print
        print('Error fetching current auth user: $e');
      }
    }
    super.onRequest(options, handler);
  }
}
Future<String?> getUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userToken');
}
Future<int?> getCurrentUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('currentUserId');
}
