import 'package:dio/dio.dart';
import '../models/index.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';
  
  final Dio _dio;

  ApiService({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('فشل تحميل المنتجات');
      }
    } on DioException catch (e) {
      throw Exception('خطأ في الاتصال: ${e.message}');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('/products/$id');
      
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('فشل تحميل تفاصيل المنتج');
      }
    } on DioException catch (e) {
      throw Exception('خطأ في الاتصال: ${e.message}');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }
}
