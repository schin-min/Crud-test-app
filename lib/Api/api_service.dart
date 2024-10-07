import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';

class ApiService {
  static const String API_URL = "https://crudcrud.com/api/def7563d6a6441eaa50acb535da7440c/items";

  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse(API_URL));
    assert(response.statusCode == 200,"Expected status 200 but got ${response.statusCode}");
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((e) => Item.fromJson(e)).toList();
    } else {
      
      throw Exception("Failed to load items");
    }
  }

  Future<Item> createItem(String name) async {
    final response = await http.post(
      Uri.parse(API_URL),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 201) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create item");
    }
  }

  Future<void> updateItem(String id, String name) async {
    final response = await http.put(
      Uri.parse('$API_URL/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update item");
    }
  }

  Future<void> deleteItem(String id) async {
    final response = await http.delete(Uri.parse('$API_URL/$id'));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete item");
    }
  }
}
