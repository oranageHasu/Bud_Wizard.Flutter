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
  final Function(List<File>) onAddFiles;

  DankDropZone({
    @required Function(List<File>) onAddFiles,
  }) : this.onAddFiles = onAddFiles;

  @override
  State<StatefulWidget> createState() {
    return _DankDropZoneState(
      this.onAddFiles,
    );
  }
}

class _DankDropZoneState extends State<StatefulWidget> {
  final Function(List<File>) onAddFiles;
  final StreamController<Point<double>> _pointStreamController =
      new StreamController<Point<double>>.broadcast();
  final StreamController<_DragState> _dragStateStreamController =
      new StreamController<_DragState>.broadcast();
  StreamSubscription<MouseEvent> _onDragOverSubscription;
  StreamSubscription<MouseEvent> _onDropSubscription;
  List<File> _files = new List<File>();

  _DankDropZoneState(
    this.onAddFiles,
  );

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
    return Container(
      height: 180.0,
      width: 600.0,
      child: Center(
        child: (_files.length == 0)
            ? DankLabel(
                displayText: 'Drag & Drop Images Here',
                textStyle: appHeaderFontStyle.copyWith(fontSize: 35.0),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (File file in _files)
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.attach_file,
                            size: 35.0,
                            color: appBaseWhiteTextColor.withOpacity(0.4),
                          ),
                          DankLabel(
                            displayText: file.name,
                            textStyle: appInputFontStyle,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  void _onDrop(MouseEvent value) {
    value.stopPropagation();
    value.preventDefault();

    _pointStreamController.sink.add(null);

    if (onAddFiles != null) {
      this.setState(() {
        _files = _files..addAll(value.dataTransfer.files);
      });

      onAddFiles(value.dataTransfer.files);
    }
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
