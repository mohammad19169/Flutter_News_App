import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
class NewsDetailScreen extends StatefulWidget {
  String newsImage,title,newsDate,author,description,content,source;
  NewsDetailScreen({super.key,
    required this.newsImage,required this.title,required this.newsDate,required this.author,required this.description,required this.source,required this.content});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
 // final format = DateFormat('MMMM,yy');
  //DateTime dateTime=DateTime.parse(widget.newsDate);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            child: Container(
              height: height*.45,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(40)
                  ),
                  child: CachedNetworkImage(imageUrl: widget.newsImage,fit: BoxFit.cover,
                  placeholder: (context,ulr)=>Center(child: CircularProgressIndicator()),
                  )),
            ),
          ),
          Container(
            height: height*.6,
            margin: EdgeInsets.only(top: height*.45),
            padding: EdgeInsets.only(top: 20,left: 20,right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),child: ListView(
            children: [
              Text(widget.title,style: GoogleFonts.poppins(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w700),),
              SizedBox(height: height*.02,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(widget.source,style: GoogleFonts.poppins(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600)),
                SizedBox(height: height*.03,),
                Text(widget.description,style: GoogleFonts.poppins(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600)),

              ],)
            ],
          ),
          )
        ],
      ),
    );
  }
}
