import 'package:flutter/material.dart';
import 'package:whichone/components/vote_tab/post.dart';

class VoteTab extends StatelessWidget {
  const VoteTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text(
            "WhichOne",
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFdc8c97),
          floating: true,
          snap: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            List.generate(
              100,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Post(),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
