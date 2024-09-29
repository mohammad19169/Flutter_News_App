import 'package:flutter/material.dart';
import 'package:news_app/Model/NewsHeadlineModel.dart';
import 'package:news_app/repository/news_repo.dart';
class NewsViewModel{
  final _api= NewsRepo();
  Future<NewsHeadlineModel>FetchNews (String source)async{
    final response=await _api.FetchNews(source);
    return response;


  }
}