import 'package:flutter/material.dart';
import 'package:news_app/Model/CategoriesModel.dart';
import 'package:news_app/Model/NewsHeadlineModel.dart';
import 'package:news_app/repository/categories_repo.dart';
import 'package:news_app/repository/news_repo.dart';
class NewsViewModel{
  final _api= NewsRepo();
  Future<NewsHeadlineModel>FetchNews (String source)async{
    final response=await _api.FetchNews(source);
    return response;
  }
  final _api_new=CategoriesRepo();
  Future<CategoriesModel>fetchCategory(String category)async{
    final response=await _api_new.FetchCategory(category);
    return response;
  }
}