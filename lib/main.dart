import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:userpost/model/news_model.dart';

import 'Webpage.dart';
import 'network/news_network.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 46, 89, 128),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    ),
    home: MyWidget(),
  ));
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  Future<News>? businessNews;
  Future<News>? sportsNews;
  Future<News>? entertainmentNews;
  Future<News>? healthNews;
  Future<News>? scienceNews;
  @override
  void initState() {
    super.initState();
    businessNews = news_network().getnews("business");
    sportsNews = news_network().getnews("Sports");
    entertainmentNews = news_network().getnews("entertainment");
    healthNews = news_network().getnews("health");
    scienceNews = news_network().getnews("science");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("News today"),
            Text(
              cdate,
              style: const TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
      body: FutureBuilder<News>(
          future: sportsNews,
          builder: (context, AsyncSnapshot<News> abc) {
            if (abc.hasData) {
              int len = abc.data!.articles!.length;
              return Column(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Latest News",
                            style: TextStyle(
                                color: Color.fromARGB(255, 46, 89, 128),
                                fontSize: 20),
                          ),
                          const Text(
                            "ghjk",
                            style: TextStyle(color: Colors.grey),
                          ),
                          abc.data!.articles![0].urlToImage != null
                              ? Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${abc.data!.articles![0].urlToImage}"),
                                          fit: BoxFit.cover)),
                                )
                              : Container(
                                  width: 100,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpoXiz9X5ik2C8CBpQnljol4y2M7_Sm1iEwMa1Z3Db&s"),
                                          fit: BoxFit.cover)),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        itemCount: len,
                        itemBuilder: ((context, index) {
                          return Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  Text(
                                    "${abc.data!.articles![index].title}",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 46, 89, 128),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.link,
                                        color: Colors.grey,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => webpage(
                                                      abc.data!.articles![index]
                                                          .url)),
                                            );
                                          },
                                          child: Text(
                                            "${abc.data!.articles![index].source?.name}.com",
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          )),
                                    ],
                                  )
                                ],
                              )),
                              Column(
                                children: [
                                  abc.data!.articles![index].urlToImage != null
                                      ? Container(
                                          width: 100,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "${abc.data!.articles![index].urlToImage}"),
                                                  fit: BoxFit.cover)),
                                        )
                                      : Container(
                                          width: 100,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: const DecorationImage(
                                                  image: NetworkImage(
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpoXiz9X5ik2C8CBpQnljol4y2M7_Sm1iEwMa1Z3Db&s"),
                                                  fit: BoxFit.cover)),
                                        ),
                                ],
                              )
                            ],
                          );
                        })),
                  ),
                ],
              );
            } else if (abc.hasError) {
              return Text(" ${abc.error}");
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
