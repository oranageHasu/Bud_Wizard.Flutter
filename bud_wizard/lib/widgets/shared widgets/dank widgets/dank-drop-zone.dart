import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:bud_wizard/classes/app-theme.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:flutter/material.dart';

enum _DragState {
  dragging,
}

class DankDropZone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DankDropZoneState();
  }
}

class _DankDropZoneState extends State<StatefulWidget> {
  final StreamController<Point<double>> _pointStreamController =
      new StreamController<Point<double>>.broadcast();
  final StreamController<_DragState> _dragStateStreamController =
      new StreamController<_DragState>.broadcast();
  StreamSubscription<MouseEvent> _onDragOverSubscription;
  StreamSubscription<MouseEvent> _onDropSubscription;
  List<File> _files = <File>[];

  @override
  void initState() {
    super.initState();
    _onDropSubscription = document.body.onDrop.listen(_onDrop);
    _onDragOverSubscription = document.body.onDragOver.listen(_onDragOver);
  }

  @override
  void dispose() {
    super.dispose();

    this._onDropSubscription.cancel();
    this._onDragOverSubscription.cancel();
    this._pointStreamController.close();
    this._dragStateStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 250.0,
        width: 600.0,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: appBaseColor,
            width: 2.0,
          ),
        ),
        child: Center(
          child: DankLabel(
            displayText: 'Drag & Drop Images Here',
            textStyle: appHeaderFontStyle.copyWith(fontSize: 35.0),
          ),
        ),
      ),
    );
  }

  void _onDrop(MouseEvent value) {
    value.stopPropagation();
    value.preventDefault();

    _pointStreamController.sink.add(null);

    _addFiles(value.dataTransfer.files);
  }

  void _addFiles(List<File> newFiles) {
    this.setState(() {
      _files = _files..addAll(newFiles);

      for (File file in _files) {
        print(file.name);
      }
    });
  }

  void _onDragOver(MouseEvent value) {
    value.stopPropagation();
    value.preventDefault();

    this
        ._pointStreamController
        .sink
        .add(Point<double>(value.layer.x.toDouble(), value.layer.y.toDouble()));

    this._dragStateStreamController.sink.add(_DragState.dragging);
  }
}
