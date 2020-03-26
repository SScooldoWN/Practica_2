import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Details extends StatefulWidget {
  final String imageUrl;
  final String materia;
  final String descripcion;
  Details({
    Key key,
    @required this.imageUrl,
    @required this.materia,
    @required this.descripcion,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del apunte"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              height: 240,
              child: ClipRect(
                child: PhotoView.customChild(
                  child: Container(
                    child: Image.network(widget.imageUrl, fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
            Container(
                child: Text(
              widget.materia,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
            Container(child: Text(widget.descripcion))
          ],
        ),
      ),
    );
  }
}
