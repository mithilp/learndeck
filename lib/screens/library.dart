import 'package:flutter/material.dart';
import 'package:sample/utils/models/course.dart';
import 'package:sample/utils/models/unit.dart';
import 'package:sample/utils/models/user.dart';
import 'package:sample/utils/mongodb.dart';
import 'package:sample/components/thumbnail.dart';

class LibraryPage extends StatefulWidget {
  final User user;
  const LibraryPage({super.key, required this.user});

  @override
  State<LibraryPage> createState() => _LibraryPageState(user: user);
}

class _LibraryPageState extends State<LibraryPage> {
  List<dynamic> library = [];
  bool loading = true;

  User user;
  _LibraryPageState({required this.user});
  void initState() {
    super.initState();
    load().then((result) {
      setState(() {
        loading = false;
      });
    });
  }

  Future<void> load() async {
    print('sending to d');
    library = await MongoDB.getStarred(widget.user.username);
    print('library ${library}');
  }
  @override
  Widget build(BuildContext context) {
    bool large = true;
    if(library.length > 3) {
      large = false;
    }

    return
      SafeArea(
        child: loading ?
        Center(
          child: CircularProgressIndicator(
            color: Color(0xff009966),
          ),
        ) : Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    for(int i = 0; i < library.length; i++)
                      Column(
                      children: [
                        Thumbnail(
                            course: library[i],
                            large: large
                        ),
                        SizedBox(height: 10)
                      ],
                    )
                  ],
                ),

              ]
            ),
          ),
        ),
      );
  }
}