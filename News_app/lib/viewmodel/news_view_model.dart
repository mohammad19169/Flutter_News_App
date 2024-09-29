import 'package:flutter/material.dart';
import 'package:news_app/Model/NewsHeadlineModel.dart';
import 'package:news_app/repository/news_repo.dart';
class NewsViewModel{
  final _api= NewsRepo();
  Future<NewsHeadlineModel>FetchNews ()async{
    final response=await _api.FetchNews();
    return response;


  }
}