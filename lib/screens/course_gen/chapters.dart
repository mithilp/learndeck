import 'package:flutter/material.dart';
import 'package:sample/utils/gemini.dart';
import 'package:sample/utils/models/course.dart';
import 'dart:convert';

class ChapterGenScreen extends StatefulWidget {
  final Course course;
  const ChapterGenScreen({super.key, required this.course});
  @override
  State<ChapterGenScreen> createState() => _ChapterGenScreenState(course: course);
}

class _ChapterGenScreenState extends State<ChapterGenScreen> {
  Course course;
  bool loading = false;
  late List body;
  _ChapterGenScreenState({required this.course});
  void initState() {
    super.initState();
    load().then((result) {
      print("result: ${result}");
      body = result;
    });
  }
  Future<List> load() async {
    String unitsString = "";
    for (int i = 0; i < course.units.length; i++) {
      unitsString += course.units[i].title + ", ";
    };
    print(unitsString);
    String response = await GeminiAPI.getGeminiData("""
    ${unitsString} 
    It is your job to create a course about ${course.title}. The user has requested to create chapters for each of the above units. Then, for each chapter, provide a detailed youtube search query that can be used to find an informative educational video for each chapter. Each query should give an educational informative course in youtube. IMPORTANT: Give the response in a JSON array like the example below with the title of each array element corresponding to the unit title and then the chapters for that unit.\n
    [
      {
        "title": "World War II Battles",
        "chapters": [
          {
          "youtube_search_query": "all about important battles in WW2",
          "chapter_title": "Important Battles"
          },
          {
          "youtube_search_query": "battle strategies in WW2",
          "chapter_title": "Battle Strategies"
          },
          {
          "youtube_search_query": "Battle of Stalingrad short explanation",
          "chapter_title": "Battle of Stalingrad"
          } etc...
        ]
      },
      {
        "title": "World War II Alliances",
        "chapters": [
          {
          "youtube_search_query": "all about the allied powers in WW2",
          "chapter_title": "Allied Powers"
          },
          {
          "youtube_search_query": "all about the axis powers in WW2",
          "chapter_title": "Axis Powers"
          },
          {
          "youtube_search_query": "netural powers and their roles in WW2",
          "chapter_title": "Neutral Powers"
          } etc...
        ]
      }
    ]""");
    final body = json.decode(response);
    if(response != null) {
      setState(() {
        loading = false;
      });
    }
    return body;
  }
  @override
  Widget build(BuildContext context) {
    print(body);
    return loading ? Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: (
        Center(
          
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Color(0xff009966),
          ),
        )
      ),
    ) : (
      Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () {},
          child: Container(
            child: Text('submit')
          )
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18.0),
                  child: Text(
                    course.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
            
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [

                      for (int i = 0; i < body.length; i++) (
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Text(
                                  'UNIT ${i+1}',
                                  style: TextStyle(
                                    color: Color(0xff888888),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Text(
                                  body[i]['title'],
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff000000),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                            SizedBox(height: 10,),
                            for(int j = 0; j < body[i]['chapters'].length; j++) (
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xfffff),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Color(0xff888888),
                                    width: 1.5,
                                  )
                                ),
            
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      body[i]['chapters'][j]['chapter_title'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
            
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff009966),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),
                            SizedBox(height: 20,),
                          ],
                        )
                      )
                    ],
                  ),
          
            
              ]
            ),
          ),
        )
      )
    );
  }
}
