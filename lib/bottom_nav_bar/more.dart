import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:Qaeat_Provider/bottom_nav_bar/setting.dart';
import 'package:Qaeat_Provider/components/animated_widget.dart';

class More extends StatefulWidget {
  final Function callback;

  const More({Key key, this.callback}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {

    Widget item(Widget icon, String lable) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
          topLeft: Radius.circular(20)),
        ),
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              icon,
              Text(
                "${lable}",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: <Widget>[
          AnimatedWidgets(
            duration: 1,
            horizontalOffset: 400,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/backgroundassets.jpeg"),
                      fit: BoxFit.fitWidth)),
            ),
          ),
          AnimatedWidgets(
              duration: 1,
              virticaloffset: 400,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                radius: 50,
              )),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: AnimationLimiter(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 7,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: 3,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: index == 0
                                ? item(
                                    Icon(
                                      Icons.image,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                    "??????????")
                                : index == 1
                                    ? item(
                                        Icon(
                                          Icons.content_cut,
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                        "??????????????")
                                    :index == 3
                                            ? item(
                                                Icon(
                                                  Icons.list,
                                                  size: 60,
                                                  color: Colors.white,
                                                ),
                                                "??????????????")
                                            : index == 4
                                                ? item(
                                                    Icon(
                                                      Icons.attach_money,
                                                      size: 60,
                                                      color: Colors.white,
                                                    ),
                                                    "????????????????")
                                                : index == 5
                                                    ? item(
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Setting()));
                                                          },
                                                          child: Icon(
                                                            Icons.person,
                                                            size: 60,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        "?????????? ????????????")
                                                    : item(
                                                        Icon(
                                                          Icons.arrow_forward,
                                                          size: 60,
                                                          color: Colors.white,
                                                        ),
                                                        "?????????? ????????????")),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
