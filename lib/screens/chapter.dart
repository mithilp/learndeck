import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/components/quiz.dart';
import 'package:sample/utils/models/chapter.dart';
import 'package:sample/utils/models/question.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChapterScreen extends StatelessWidget {
  final Chapter chapterData;
  final int unit;
  final int chapter;
  ChapterScreen({
    super.key,
    required this.chapterData,
    required this.unit,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: chapterData.video,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // open modal to ask question and chatbot

        },
        label: Text('Ask', style: GoogleFonts.figtree(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ) ),
        icon: Icon(Icons.chat, color: Colors.white,),
        backgroundColor: const Color(0xff009966),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:10.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints:
                              BoxConstraints(minWidth: 100, maxWidth: 450),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Unit ${unit + 1} - Chapter ${chapter + 1}',
                                    style: GoogleFonts.figtree(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800)),
                                Text('title',
                                    style: GoogleFonts.figtree(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                          )),
                      SizedBox(height: 10),
                      Container(
                        child: YoutubePlayer(
                          controller: _controller,
                          onReady: () {
                            print('Player is ready.');
                          },
                          showVideoProgressIndicator: true,
                          progressIndicatorColor:  const Color(0xff009966),
                          progressColors: ProgressBarColors(
                            playedColor:  const Color(0xff009966),
                            handleColor:  const Color(0xff096043),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Topic Summary',
                              style: GoogleFonts.figtree(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              chapterData.summary,
                              style: GoogleFonts.figtree(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Ready for a Quiz?',
                              style: GoogleFonts.figtree(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 10),
                            QuizComponent(quiz: chapterData.questions as List<Question>,)
                          ],
                        ),
                      ),
                    ],
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
