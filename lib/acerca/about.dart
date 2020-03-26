import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final _subjectController = TextEditingController(text: null);

  final _bodyController = TextEditingController(text: null);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: ['is709304@iteso.mx'],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Mensaje Enviado';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        title: Text("Contacto"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              "Creado por: LuCa Hex",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                hintText: "Asunto",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _bodyController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Descripcion...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 24),
            RaisedButton(
              onPressed: send,
              child: Text("Enviar"),
            ),
            Text(
                "App diseñada para la creación de recordatorios\n  y datos acerca de materias escolares"),
          ],
        ),
      ),
    );
  }
}
