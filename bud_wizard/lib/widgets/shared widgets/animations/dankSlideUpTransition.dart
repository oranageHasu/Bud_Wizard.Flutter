import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideUpProvider with ChangeNotifier {
  bool isShow = false;

  void updateState(bool newState) {
    isShow = newState;
    notifyListeners();
  }
}

class SlideUpController {
  SlideUpController._private();

  static final SlideUpController instance = SlideUpController._private();

  factory SlideUpController() => instance;

  BuildContext _providerContext;

  set providerContext(BuildContext context) {
    if (_providerContext != context) {
      _providerContext = context;
    }
  }

  void toggle() {
    if (_providerContext != null) {
      final provider = _providerContext.read<SlideUpProvider>();
      provider.updateState(!provider.isShow);
    } else {
      print('Need init provider context');
    }
  }
}

class DankSlideUpTransition extends StatefulWidget {
  final SlideUpController controller;
  final Widget child;

  const DankSlideUpTransition({
    @required SlideUpController controller,
    @required Widget child,
  })  : this.controller = controller,
        this.child = child;

  @override
  _DankSlideUpTransitionState createState() => _DankSlideUpTransitionState();
}

class _DankSlideUpTransitionState extends State<DankSlideUpTransition> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SlideUpProvider(),
      child: Consumer<SlideUpProvider>(
        builder: (context, provider, child) {
          widget.controller?.providerContext = context;
          return provider.isShow ? widget.child : Container();
        },
      ),
    );
  }
}
