
import 'package:flutter/material.dart';
import 'package:Qaeat_Provider/models/home_page.dart';

class CommentsView extends StatefulWidget {
  final List<Rates> rate;

  const CommentsView({Key key, this.rate}) : super(key: key);

  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("قائمة التعليقات"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "#1",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "الاسم",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "التعليقات",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "ألمركز",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.rate.length == 0
                  ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 150),
                    child: Center(
                        child: Text("لا توجد تعليقات"),
                      ),
                  )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.rate.length,
                      itemBuilder: (context, index) {
                        return reviewRow(
                            widget.rate[index].id,
                            widget.rate[index].user.name,
                            widget.rate[index].comment,
                            widget.rate[index].value.toDouble());
                      }),
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewRow(int id, String userName, String comment, double Rate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 10,
              child: Center(
                child: Text(
                  " #${id}",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 5,
              child: Center(
                child: Text(
                  "${userName}",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: Text(
                  comment ?? "لا تعليق",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 6,
              child: Center(
                  child: Text(
                "${Rate}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
