import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Model/CategoriesModel.dart';
import 'package:news_app/viewmodel/news_view_model.dart';

class Categoriesview extends StatefulWidget {
  Categoriesview({super.key});

  @override
  State<Categoriesview> createState() => _CategoriesviewState();
}

class _CategoriesviewState extends State<Categoriesview> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM,yyyy');

  String name = 'General';
  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(  // Wrap the body in SingleChildScrollView
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          name = categoriesList[index];
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: name == categoriesList[index]
                              ? Colors.blue
                              : Colors.grey.shade400,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                categoriesList[index].toString(),
                                style: GoogleFonts.adamina(
                                    fontSize: 10, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<CategoriesModel>(
              future: newsViewModel.fetchCategory(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.articles!.isEmpty) {
                  return Center(child: Text("No articles found"));
                }

                return ListView.builder(
                  shrinkWrap: true,  // Allow ListView to take up only needed space
                  physics: NeverScrollableScrollPhysics(),  // Disable scrolling for this ListView
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    DateTime datetime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: CachedNetworkImage(
                                height: height * 0.18,
                                width: width * 0.3,
                                imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => spinkit2,
                                errorWidget: (context, url, error) => Icon(Icons.error_outline_outlined, color: Colors.red),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 15, right: 10),
                              height: height * 0.18,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                                children: [
                                  Text(
                                    snapshot.data!.articles![index].title.toString(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].source!.name.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          format.format(datetime),
                                          maxLines: 3,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.blue,
  size: 50,
);
