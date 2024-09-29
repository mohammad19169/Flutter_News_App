import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/NewsHeadlineModel.dart';
class NewsRepo{
  Future<NewsHeadlineModel>FetchNews() async{
  var url='https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=59230694269248109595af0463606154';
  final response=await http.get(Uri.parse(url));
  if(response.statusCode==200){
  var body=jsonDecode(response.body);
  return NewsHeadlineModel.fromJson(body);
}
  throw Exception('No Data!');
  }

}