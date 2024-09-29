import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Model/NewsHeadlineModel.dart';
import 'package:news_app/viewmodel/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum filterList {BBC,ARY,AlJazeera,CNN,reuters}
class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format=DateFormat('MMMM dd,yyyy');
filterList ? selectedMenu;
String name='bbc';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .sizeOf(context)
        .height;
    final width = MediaQuery
        .sizeOf(context)
        .width;
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<filterList>(
              initialValue: selectedMenu,
                icon: Icon(Icons.more_vert,color: Colors.black,),
                onSelected: (filterList item){
                if(filterList.BBC.name==item.name){
                  name='bbc-news';
                }
                if(filterList.ARY.name==item.name){
                  name='ary-news';
                }
                if(filterList.AlJazeera.name==item.name){
                  name='al-jazeera-english';
                }
                if(filterList.CNN.name==item.name){
                  name='cnn';
                }
                if(filterList.reuters.name==item.name){
                  name='reuters';
                }
                setState(() {
                  selectedMenu=item;
                });
                },
                itemBuilder: (BuildContext context)=><PopupMenuEntry<filterList>>[
                  PopupMenuItem<filterList>(
                    value: filterList.BBC,
                    child: Text('BBC News'),
                  ),
                  PopupMenuItem<filterList>(
                    value: filterList.ARY,
                    child: Text('ARY News'),
                  ),
                  PopupMenuItem<filterList>(
                    value: filterList.AlJazeera,
                    child: Text('Al-Jazeera'),
                  ),
                  PopupMenuItem<filterList>(
                    value: filterList.CNN,
                    child: Text('CNN News'),
                  ),
                  PopupMenuItem<filterList>(
                    value: filterList.reuters,
                    child: Text('Reuter News'),
                  ),
            ]
            )],
          leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/category_icon.png',
              height: 25,
              width: 25,
            ),
          ),
          title: Center(
              child: Text('NEWS',
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.w700))),
        ),
        body: ListView(
          children: [
            SizedBox(height: height * 0.55, width: width,
              child: FutureBuilder<NewsHeadlineModel>(
                  future: newsViewModel.FetchNews(name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime datetime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                            return Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          height: height*0.55,
                                          width: width*0.8,
                                          imageUrl: snapshot.data!.articles![index]
                                              .urlToImage.toString(),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(child: spinkit2,),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error_outline_outlined,
                                                color: Colors.red,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom:20,
                                    child: Card(
                                      elevation:5,
                                      color:Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        alignment:Alignment.bottomCenter,
                                        height:height*0.22,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width*0.7,
                                              child: Padding(
                                                padding: const EdgeInsets.all(15),
                                                child: Text(snapshot.data!.articles![index].title.toString(),style: GoogleFonts.poppins(
                                                  fontSize: 17,fontWeight: FontWeight.w700
                                                ),maxLines: 3,overflow: TextOverflow.ellipsis,),
                                              ),

                                            ),
                                            Spacer(),
                                            Container(
                                              width:width*0.7,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(snapshot.data!.articles![index].author.toString()),
                                                  Text(format.format(datetime)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ));
  }
}

const spinkit2 = SpinKitFadingCircle(color: Colors.blue, size: 50,);