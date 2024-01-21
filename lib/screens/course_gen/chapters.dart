import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:sample/components/navbar.dart';
import 'package:sample/screens/course.dart';
import 'package:sample/utils/gemini.dart';
import 'package:sample/utils/models/chapter.dart';
import 'package:sample/utils/models/course.dart';
import 'package:sample/utils/models/question.dart';
import 'dart:convert';

import 'package:sample/utils/models/user.dart';
import 'package:sample/utils/mongodb.dart';
import 'package:sample/utils/youtube_api.dart';

class ChapterGenScreen extends StatefulWidget {
  final Course course;
  final User user;
  const ChapterGenScreen({super.key, required this.course, required this.user});
  @override
  State<ChapterGenScreen> createState() =>
      _ChapterGenScreenState(course: course);
}

class _ChapterGenScreenState extends State<ChapterGenScreen> {
  Course course;
  bool loading = true;
  List loadingStates = [];
  List<List<Chapter?>> finalChapters = [];
  late List body;

  _ChapterGenScreenState({required this.course});
  @override
  void initState() {
    super.initState();
    load().then((result) {
      print('result: $result');
      List newLoadingStates = List.generate(result.length,
          (index) => List.generate(result[index]['chapters'].length, (j) => 0));
      setState(() {
        body = result;
        loadingStates = newLoadingStates;
        finalChapters = List.generate(
            result.length,
            (index) =>
                List.generate(result[index]['chapters'].length, (j) => null));
      });
    });
  }

  Future<List> load() async {
    try {
      String unitsString = '';
      for (int i = 0; i < course.units!.length; i++) {
        unitsString += ('${course.units![i].title}, ');
      }
      String response = await GeminiAPI.getGeminiData('''
    $unitsString 
    It is your job to create a course about ${course.title}. 
    The user has requested to create chapters for each of the above units. 
    Then, for each chapter, provide a detailed youtube search query that can be used to find an informative educational video for each chapter.
    Each query should give an educational informative course in youtube. 
    IMPORTANT: Give the response in a JSON array like the example below with the title of each array element corresponding to the unit title and then the chapters for that unit.\n
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
    ]''');
      final body = await json.decode(response);

      for (int i = 0; i < body.length; i++) {
        course.units?[i].chapters = [];
        for (int j = 0; j < body[i]['chapters'].length; j++) {
          Chapter chapter = Chapter(
              id: M.ObjectId().oid,
              title: body[i]['chapters'][j]['chapter_title'],
              query: body[i]['chapters'][j]['youtube_search_query'],
              video: '',
              summary: '');
          course.units?[i].chapters?.add(chapter);
        }
      }
      setState(() {
        loading = false;
      });
      return body;
    } catch (e) {
      print('Retrying...');
      String unitsString = '';
      for (int i = 0; i < course.units!.length; i++) {
        unitsString += ('${course.units![i].title}, ');
      }
      String response = await GeminiAPI.getGeminiData('''
    $unitsString 
    It is your job to create a course about ${course.title}. 
    The user has requested to create chapters for each of the above units. 
    Then, for each chapter, provide a detailed youtube search query that can be used to find an informative educational video for each chapter.
    Each query should give an educational informative course in youtube. 
    Limit to at most 4 chapters per unit.
    IMPORTANT: Give the response in a JSON array like the example below with the title of each array element corresponding to the unit title and then the chapters for that unit.\n
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
    ]''');
      final body = await json.decode(response);

      for (int i = 0; i < course.units!.length; i++) {
        course.units?[i].chapters = [];
        for (int j = 0; j < body[i]['chapters'].length; j++) {
          Chapter chapter = Chapter(
              id: M.ObjectId().oid,
              title: body[i]['chapters'][j]['chapter_title'],
              query: body[i]['chapters'][j]['youtube_search_query'],
              video: '',
              summary: '');
          course.units?[i].chapters?.add(chapter);
        }
      }
      setState(() {
        loading = false;
      });
      return body;
    }
  }

  Future<void> create() async {
    setState(() {
      loadingStates = List.generate(body.length,
          (index) => List.generate(body[index]['chapters'].length, (j) => 1));
    });
    var i = 0;

    for (var unit in body) {
      var j = 0;
      for (var chapter in unit['chapters']) {
        GeminiAPI.getGeminiDataAndPassData('''
        We are creating a course about ${course.title}. 
        One of the chapters of the course is ${chapter['chapter_title']}. 
        Create a short description about the topic. 
        Additionally, create a quiz about the topic.
        The quiz should be multiple choice with 3-5 questions. 
        Each multiple choice question should have only one correct answer.
        IMPORTANT: Give the response in a JSON object like the example below.
        The "answer" field should be the index of the correct answer in the "choices" array. Remember indeces start at 0.
        
        {
          "title": "Battle of Stalingrad",
          "summary": "The Battle of Stalingrad, which took place from August 23, 1942, to February 2, 1943, during World War II, was a pivotal conflict between the Soviet Union and Nazi Germany. Stalingrad (now Volgograd) in southwestern Russia was the battleground. The Soviets successfully defended the city, marking a turning point in the war. The brutal urban warfare, harsh winter conditions, and the encirclement of German forces contributed to significant losses on both sides. The Soviet victory at Stalingrad is considered one of the major milestones leading to the eventual defeat of the Axis powers in the Eastern Front.",
          "quiz": [
            {
              "question": "What was the Battle of Stalingrad?",
              "explanation": "The Battle of Stalingrad was a major battle between the Germans and the Russians. All the other choices are false information.",
              "choices": ["It was a battle between the Germans and the Russians.", "It was a battle between the Germans and the Americans.","It was a battle between the Germans and the British.", "It was a battle between the Germans and the French."],
              "answer": 0
            },
            {
              "question": "What was the outcome of the Battle of Stalingrad?",
              "explanation": "The Germans lost the battle and were forced to retreat. All the other choices are false information.",
              "choices": ["The Germans won the battle.", "The Russians won the battle.","The battle was a draw.", "The battle was never finished."],
              "answer": 1
            },
            {
              "question": "What was the significance of the Battle of Stalingrad?",
              "explanation": "The Battle of Stalingrad was a major turning point in World War II. All the other choices are false information.",
              "choices": ["It was the first battle of World War II.", "It was the last battle of World War II.","It was the most important battle of World War II.", "It was the least important battle of World War II."],
              "answer": 2
            }
          ]
        }
        ''', {'i': i, 'j': j}).then((response) async {
          try {
            var res =
                await json.decode(response['response'].replaceAll(']', '\]'));

            // get yt video
            var video =
                await YouTubeAPI.getVideo(chapter['youtube_search_query']);

            List<Question> questions = [];
            // turn json quiz into list of questions
            for (var question in res['quiz']) {
              questions.add(Question(
                  id: M.ObjectId().oid,
                  text: question['question'],
                  answer: question['answer'],
                  explanation: question['explanation'] ?? 'No explanation',
                  choices: List<String>.from(question['choices'] as List)));
            }

            // update loading state
            var i = response['data']['i'];
            var j = response['data']['j'];
            setState(() {
              loadingStates[i][j] = 2;
              finalChapters[i][j] = Chapter(
                  id: M.ObjectId().oid,
                  title: res['title'],
                  video: video,
                  summary: res['summary'],
                  questions: questions);
            });
          } catch (e) {
            GeminiAPI.getGeminiDataAndPassData('''
        We are creating a course about ${course.title}. 
        One of the chapters of the course is ${chapter['chapter_title']}. 
        Create a short description about the topic. 
        Additionally, create a quiz about the topic.
        The quiz should be multiple choice with 3-5 questions. 
        Each multiple choice question should have only one correct answer.
        IMPORTANT: Give the response in a JSON object like the example below.
        The "answer" field should be the index of the correct answer in the "choices" array. Remember indeces start at 0.
        
        {
          "title": "Battle of Stalingrad",
          "summary": "The Battle of Stalingrad, which took place from August 23, 1942, to February 2, 1943, during World War II, was a pivotal conflict between the Soviet Union and Nazi Germany. Stalingrad (now Volgograd) in southwestern Russia was the battleground. The Soviets successfully defended the city, marking a turning point in the war. The brutal urban warfare, harsh winter conditions, and the encirclement of German forces contributed to significant losses on both sides. The Soviet victory at Stalingrad is considered one of the major milestones leading to the eventual defeat of the Axis powers in the Eastern Front.",
          "quiz": [
            {
              "question": "What was the Battle of Stalingrad?",
              "explanation": "The Battle of Stalingrad was a major battle between the Germans and the Russians. All the other choices are false information.",
              "choices": ["It was a battle between the Germans and the Russians.", "It was a battle between the Germans and the Americans.","It was a battle between the Germans and the British.", "It was a battle between the Germans and the French."],
              "answer": 0
            },
            {
              "question": "What was the outcome of the Battle of Stalingrad?",
              "explanation": "The Germans lost the battle and were forced to retreat. All the other choices are false information.",
              "choices": ["The Germans won the battle.", "The Russians won the battle.","The battle was a draw.", "The battle was never finished."],
              "answer": 1
            },
            {
              "question": "What was the significance of the Battle of Stalingrad?",
              "explanation": "The Battle of Stalingrad was a major turning point in World War II. All the other choices are false information.",
              "choices": ["It was the first battle of World War II.", "It was the last battle of World War II.","It was the most important battle of World War II.", "It was the least important battle of World War II."],
              "answer": 2
            }
          ]
        }
        ''', {'i': i, 'j': j}).then((response) async {
              var res =
                  await json.decode(response['response'].replaceAll(']', '\]'));

              // get yt video
              var video =
                  await YouTubeAPI.getVideo(chapter['youtube_search_query']);

              List<Question> questions = [];
              // turn json quiz into list of questions
              for (var question in res['quiz']) {
                questions.add(Question(
                    id: M.ObjectId().oid,
                    text: question['question'],
                    answer: question['answer'],
                    explanation: question['explanation'] ?? 'No explanation',
                    choices: List<String>.from(question['choices'] as List)));
              }

              // update loading state
              var i = response['data']['i'];
              var j = response['data']['j'];
              setState(() {
                loadingStates[i][j] = 2;
                finalChapters[i][j] = Chapter(
                    id: M.ObjectId().oid,
                    title: res['title'],
                    video: video,
                    summary: res['summary'],
                    questions: questions);
              });
            });
          }
        });
        j++;
      }
      i++;
    }
  }

  Future<void> save() async {
    for (int i = 0; i < course.units!.length; i++) {
      for (int j = 0; j < course.units![i].chapters!.length; j++) {
        course.units![i].chapters![j] = finalChapters[i][j]!;
      }
    }

    print("saving");

    // await MongoDB.addCourse(course);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CourseScreen(course: course)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: (const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Color(0xff009966),
              ),
            )),
          )
        : (Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff009966),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                onPressed: (loadingStates.expand((x) => x).toList())
                            .contains(1) ||
                        (loadingStates.expand((x) => x).toList()).contains(2) ||
                        (loadingStates.expand((x) => x).toList()).contains(3)
                    ? (loadingStates.expand((x) => x).toList()).contains(1) ||
                            (loadingStates.expand((x) => x).toList())
                                .contains(3)
                        ? null
                        : () {
                            save();
                          }
                    : () {
                        create();
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                      (loadingStates.expand((x) => x).toList()).contains(1) ||
                              (loadingStates.expand((x) => x).toList())
                                  .contains(2) ||
                              (loadingStates.expand((x) => x).toList())
                                  .contains(3)
                          ? (loadingStates.expand((x) => x).toList())
                                      .contains(1) ||
                                  (loadingStates.expand((x) => x).toList())
                                      .contains(3)
                              ? "Loading"
                              : "Save & Finish"
                          : "Create Course",
                      style: GoogleFonts.figtree(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      )),
                )),
            body: Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
              floatingActionButton: Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NavBar(user: widget.user, index: 0)),
                      );
                    },
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.close, size: 40.0),
                  )),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 12),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Text(
                              course.title,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.figtree(
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              for (int i = 0; i < body.length; i++)
                                (Column(
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'UNIT ${i + 1}',
                                          style: GoogleFonts.figtree(
                                            color: const Color(0xff888888),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Spacer()
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          body[i]['title'],
                                          style: GoogleFonts.figtree(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800,
                                            color: const Color(0xff000000),
                                          ),
                                        ),
                                        const Spacer()
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    for (int j = 0;
                                        j < body[i]['chapters'].length;
                                        j++)
                                      (Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: const Color(0x000fffff),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                              color: const Color(0xff888888),
                                              width: 1.5,
                                            )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              body[i]['chapters'][j]
                                                  ['chapter_title'],
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.figtree(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                color: const Color(0xff009966),
                                              ),
                                            ),
                                            loadingStates[i][j] == 1
                                                ? const Center(
                                                    child: SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.white,
                                                        color:
                                                            Color(0xff009966),
                                                      ),
                                                    ),
                                                  )
                                                : loadingStates[i][j] == 2
                                                    ? const Icon(
                                                        Icons.check,
                                                        color:
                                                            Color(0xff009966),
                                                        size: 24,
                                                      )
                                                    : loadingStates[i][j] == 3
                                                        ? const Icon(
                                                            Icons.cancel,
                                                            color: Color(
                                                                0xffff5572),
                                                            size: 24,
                                                          )
                                                        : const SizedBox()
                                          ],
                                        ),
                                      )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ))
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            )));
  }
}
