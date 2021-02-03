import 'package:bud_wizard/classes/appTheme.dart';
import 'package:bud_wizard/classes/enumerations.dart';
import 'package:bud_wizard/models/grow%20system/grow.dart';
import 'package:bud_wizard/models/grow%20system/growPrivacy.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-checkbox.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-label.dart';
import 'package:bud_wizard/widgets/shared%20widgets/dank%20widgets/dank-radio-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PrivacySelector extends StatefulWidget {
  final Grow grow;
  final Function(GrowPrivacy) selectionChanged;

  PrivacySelector({
    @required Grow grow,
    @required Function(GrowPrivacy) selectionChanged,
  })  : this.selectionChanged = selectionChanged,
        this.grow = grow;

  @override
  _PrivacySelectorState createState() => _PrivacySelectorState();
}

class _PrivacySelectorState extends State<PrivacySelector> {
  GrowPrivacy _privacySettings = GrowPrivacy(
    privacySetting: GrowPrivacySetting.DoNotShare,
  );

  @override
  void initState() {
    if (widget.grow != null && widget.grow.privacySettings != null) {
      _privacySettings = widget.grow.privacySettings;
    }

    super.initState();
  }

  @override
  void didUpdateWidget(PrivacySelector oldWidget) {
    if (widget.grow != null && widget.grow.privacySettings != null) {
      _privacySettings = widget.grow.privacySettings;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DankLabel(
          displayText: 'Share this grow with others?',
          textStyle: appLabelFontStyle,
          textAlign: TextAlign.start,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 15.0,
                  ),
                  DankRadioButton(
                    id: GrowPrivacySetting.DoNotShare.index,
                    currentIndex: _privacySettings.privacySetting.index,
                    displayText: 'Keep Private',
                    onTapped: _privacySelectionChanged,
                  ),
                  Container(
                    width: 15.0,
                  ),
                  DankRadioButton(
                    id: GrowPrivacySetting.Share.index,
                    currentIndex: _privacySettings.privacySetting.index,
                    displayText: 'Allow others to see my grow',
                    onTapped: _privacySelectionChanged,
                  ),
                ],
              ),
            ),
            Visibility(
              child: _buildSharingOptions(),
              visible: _privacySettings.privacySetting.index ==
                  GrowPrivacySetting.Share.index,
            ),
          ],
        ),
        DankLabel(
          displayText: 'Allow Bud Wizard to analyze my grow data?',
          textStyle: appLabelFontStyle,
          textAlign: TextAlign.start,
          padding: EdgeInsets.only(
            top: 15.0,
          ),
        ),
        Container(
          height: 35.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 15.0,
              ),
              DankRadioButton(
                id: 0,
                currentIndex: (_privacySettings.allowML) ? 1 : 0,
                displayText: 'No',
                onTapped: _mlSelectionChanged,
              ),
              Container(
                width: 15.0,
              ),
              DankRadioButton(
                id: 1,
                currentIndex: (_privacySettings.allowML) ? 1 : 0,
                displayText: 'Allow data analysis',
                onTapped: _mlSelectionChanged,
              ),
            ],
          ),
        ),
        DankLabel(
          displayText: 'Turn on Bud Wizard notifications?',
          textStyle: appLabelFontStyle,
          textAlign: TextAlign.start,
          padding: EdgeInsets.only(
            top: 15.0,
          ),
        ),
        Container(
          height: 35.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 15.0,
              ),
              DankRadioButton(
                id: 0,
                currentIndex: (_privacySettings.allowNotifications) ? 1 : 0,
                displayText: 'No',
                onTapped: _mlSelectionChanged,
              ),
              Container(
                width: 15.0,
              ),
              DankRadioButton(
                id: 1,
                currentIndex: (_privacySettings.allowNotifications) ? 1 : 0,
                displayText: 'Allow notifications',
                onTapped: _allowNotificationsSelectionChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSharingOptions() {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 30.0),
      child: Row(
        children: [
          _buildCheckbox(
            _shareImagesChanged,
            'Share Photos',
            _privacySettings.sharePhotos,
            isFirst: true,
          ),
          _buildCheckbox(
            _shareJournalChanged,
            'Share Journal',
            _privacySettings.shareJournal,
          ),
          _buildCheckbox(
            _allowCommentsChanged,
            'Allow Public Comments',
            _privacySettings.allowComments,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(
    Function(bool) onChanged,
    String labelText,
    bool currentValue, {
    bool isFirst = false,
  }) {
    return Row(
      children: [
        DankLabel(
          displayText: labelText,
          textStyle: appLabelFontStyle.copyWith(
            fontSize: 12.0,
            color: (currentValue)
                ? (currentTheme.currentTheme() == ThemeMode.dark)
                    ? appBaseWhiteTextColor
                    : appBaseBlackTextColor
                : (currentTheme.currentTheme() == ThemeMode.dark)
                    ? appBaseWhiteTextColor.withOpacity(0.7)
                    : appBaseBlackTextColor.withOpacity(0.7),
          ),
          padding: EdgeInsets.only(
            right: 10.0,
            left: (!isFirst) ? 20.0 : 0.0,
          ),
        ),
        DankCheckbox(
          onChanged: onChanged,
          value: currentValue,
        ),
      ],
    );
  }

  void _shareImagesChanged(bool value) {
    setState(() {
      _privacySettings.sharePhotos = value;
    });

    widget.selectionChanged(
      _privacySettings,
    );
  }

  void _shareJournalChanged(bool value) {
    setState(() {
      _privacySettings.shareJournal = value;
    });

    widget.selectionChanged(
      _privacySettings,
    );
  }

  void _allowCommentsChanged(bool value) {
    setState(() {
      _privacySettings.allowComments = value;
    });

    widget.selectionChanged(
      _privacySettings,
    );
  }

  void _mlSelectionChanged(int value) {
    setState(() {
      _privacySettings.allowML = (value == 1);
    });

    widget.selectionChanged(
      _privacySettings,
    );
  }

  void _allowNotificationsSelectionChanged(int value) {
    setState(() {
      _privacySettings.allowNotifications = (value == 1);
    });

    widget.selectionChanged(
      _privacySettings,
    );
  }

  void _privacySelectionChanged(int value) {
    setState(() {
      _privacySettings.privacySetting =
          GrowPrivacySetting.values.firstWhere((e) => e.index == value);

      _privacySettings.sharePhotos =
          _privacySettings.privacySetting == GrowPrivacySetting.Share;
      _privacySettings.shareJournal =
          _privacySettings.privacySetting == GrowPrivacySetting.Share;
      _privacySettings.allowComments =
          _privacySettings.privacySetting == GrowPrivacySetting.Share;
    });

    widget.selectionChanged(
      _privacySettings,
    );
  }
}
