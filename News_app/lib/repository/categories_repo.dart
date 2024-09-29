import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/CategoriesModel.dart';
class CategoriesRepo{
  Future<CategoriesModel>FetchCategory(String category) async{
    var url='https://newsapi.org/v2/everything?q=$category&apiKey=59230694269248109595af0463606154';
    final response=await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      return CategoriesModel.fromJson(body);
    }
    throw Exception('No Data!');
  }

}