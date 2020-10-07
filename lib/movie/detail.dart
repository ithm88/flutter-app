import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  MovieDetail({Key key, @required this.id, @required this.title})
      : super(key: key);

  final String id;
  final String title;
  _MovieDetailState createState() {
    return _MovieDetailState();
  }
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    //Text('detail----${widget.id}----${widget.title}')
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Text('电影Id为 ${widget.id}'));
  }
}
