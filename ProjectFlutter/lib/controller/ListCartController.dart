import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ListCart.dart';

class ListCartController {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static Future<void> saveListCart(ListCart listCart) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/saveCarts');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, Object>{
          'foods': listCart.carts,
          'total_price': listCart.totalPrice,
        }));

    if (response.statusCode == 201) {
      print('ListCart saved successfully');
    } else {
      throw Exception('Failed to save ListCart: ${response.statusCode}');
    }
  }

  static Future<List<ListCart>> fetchListCarts() async {
    final url = Uri.parse('$baseUrl/carts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return List<ListCart>.from(list.map((model) => ListCart.fromJson(model)));
    } else {
      throw Exception('Failed to fetch ListCarts: ${response.statusCode}');
    }
  }
}
