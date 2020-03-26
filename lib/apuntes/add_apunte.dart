import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/apuntes_bloc.dart';

class AddApunte extends StatefulWidget {
  AddApunte({Key key}) : super(key: key);

  @override
  _AddApunteState createState() => _AddApunteState();
}

class _AddApunteState extends State<AddApunte> {
  File _choosenImage;
  bool _isLoading = false;
  TextEditingController _materiaController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  ApuntesBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ApuntesBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Agregar apunte")),
      body: BlocProvider(
          create: (context) => ApuntesBloc(),
          child: BlocBuilder<ApuntesBloc, ApuntesState>(
            builder: (context, state) {
              if (state is CloudStoreImage) {
                _choosenImage = state.image;
              }
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: FractionalOffset.center,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _choosenImage != null
                              ? Image.file(
                                  _choosenImage,
                                  width: 150,
                                  height: 150,
                                )
                              : Container(
                                  height: 150,
                                  width: 150,
                                  child: Placeholder(
                                    fallbackHeight: 150,
                                    fallbackWidth: 150,
                                  ),
                                ),
                          SizedBox(height: 48),
                          IconButton(
                            icon: Icon(Icons.image),
                            onPressed: () {
                              _bloc.add(ImageEvent());
                            },
                          ),
                          SizedBox(height: 48),
                          TextField(
                            controller: _materiaController,
                            decoration: InputDecoration(
                              hintText: "Nombre de la materia",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: _descripcionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Notas para el examen...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  child: Text("Guardar"),
                                  onPressed: () {
                                    _bloc.add(SaveDataEvent(
                                      materia: _materiaController.text,
                                      descripcion: _descripcionController.text,
                                    ),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      _isLoading ? CircularProgressIndicator() : Container(),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
