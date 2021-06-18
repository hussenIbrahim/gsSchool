import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/widgets.dart';

class _CkbWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const _CkbWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'ku' && locale.countryCode == "ckb";
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) async {
    // const String localeName = "kur_ckb";
    // await intl.initializeDateFormatting(localeName, null);
    return SynchronousFuture<WidgetsLocalizations>(
      CkbWidgetLocalizations(),
    );
  }

  @override
  bool shouldReload(_CkbWidgetsLocalizationsDelegate old) => true;
}

class CkbWidgetLocalizations extends WidgetsLocalizations {
  static const LocalizationsDelegate<WidgetsLocalizations> delegate =
      _CkbWidgetsLocalizationsDelegate();
  @override
  TextDirection get textDirection => TextDirection.rtl;
}

class _CkbMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _CkbMaterialLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'ku' && locale.countryCode == "ckb";
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return SynchronousFuture<MaterialLocalizations>(
      CkbMaterialLocalizations(
        localeName: "ku",
        fullYearFormat: intl.DateFormat('y'),
        shortDateFormat: intl.DateFormat('MM/DD/YY'),
        compactDateFormat: intl.DateFormat('EEE, MMM d'),
        shortMonthDayFormat: intl.DateFormat('MM/DD'),
        mediumDateFormat: intl.DateFormat('EEE, MMM d'),
        longDateFormat: intl.DateFormat('EEEE, MMMM d, y'),
        yearMonthFormat: intl.DateFormat('MMMM y'),
        decimalFormat: intl.NumberFormat('#,##0.###'),
        twoDigitZeroPaddedFormat: intl.NumberFormat('00'),
      ),
    );
  }

  @override
  bool shouldReload(_CkbMaterialLocalizationsDelegate old) => false;
}

class CkbMaterialLocalizations extends GlobalMaterialLocalizations {
  const CkbMaterialLocalizations({
    String localeName = 'ku',
    @required intl.DateFormat fullYearFormat,
    @required intl.DateFormat shortDateFormat,
    @required intl.DateFormat compactDateFormat,
    @required intl.DateFormat shortMonthDayFormat,
    @required intl.DateFormat mediumDateFormat,
    @required intl.DateFormat longDateFormat,
    @required intl.DateFormat yearMonthFormat,
    @required intl.NumberFormat decimalFormat,
    @required intl.NumberFormat twoDigitZeroPaddedFormat,
  }) : super(
            localeName: localeName,
            shortDateFormat: shortDateFormat,
            compactDateFormat: compactDateFormat,
            shortMonthDayFormat: shortMonthDayFormat,
            fullYearFormat: fullYearFormat,
            mediumDateFormat: mediumDateFormat,
            longDateFormat: longDateFormat,
            yearMonthFormat: yearMonthFormat,
            decimalFormat: decimalFormat,
            twoDigitZeroPaddedFormat: twoDigitZeroPaddedFormat);

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _CkbMaterialLocalizationsDelegate();

  @override
  String get aboutListTileTitleRaw => r'لەبارەی $applicationName';

  @override
  String get alertDialogLabel => r'وریاکەرەوە';

  @override
  String get anteMeridiemAbbreviation => r'ب';

  @override
  String get backButtonTooltip => r'گەڕانەوە';
  @override
  String get cancelButtonLabel => r'پەشیمانبوونەوە';

  @override
  String get closeButtonLabel => r'داخستن';

  @override
  String get closeButtonTooltip => r'داخستن';

  @override
  String get collapsedIconTapHint => r'گەورەکردن';

  @override
  String get continueButtonLabel => r'بەردەوامبە';

  @override
  String get copyButtonLabel => r'لەبەرگرتنەوە';

  @override
  String get cutButtonLabel => r'بڕین';

  @override
  String get deleteButtonTooltip => r'سڕینەوە';

  @override
  String get dialogLabel => r'دایالۆگ';

  @override
  String get drawerLabel => r'مێنو';

  @override
  String get expandedIconTapHint => r'داخستن';

  @override
  String get hideAccountsLabel => r'شاردنەوەی هەژمارەکان';

  @override
  String get licensesPageTitle => r'مۆڵەت';

  @override
  String get modalBarrierDismissLabel => r'لابردن';

  @override
  String get nextMonthTooltip => r'مانگی داهاتوو';

  @override
  String get nextPageTooltip => r'لاپەڕەی داهاتوو';

  @override
  String get okButtonLabel => r'باشە';

  @override
  String get openAppDrawerTooltip => r'مێنو بکەرەوە';

  @override
  String get pageRowsInfoTitleRaw => r'$firstRow–$lastRow of $rowCount';

  @override
  String get pageRowsInfoTitleApproximateRaw =>
      r'$firstRow–$lastRow of about $rowCount';

  @override
  String get pasteButtonLabel => r'دانان';

  @override
  String get popupMenuLabel => r'Popup مێنو';

  @override
  String get postMeridiemAbbreviation => r'د.ن';

  @override
  String get previousMonthTooltip => r'مانگی پێشوو';

  @override
  String get previousPageTooltip => r'لاپەڕەی پێشوو';

  @override
  String get refreshIndicatorSemanticLabel => r'تازەکردنەوە';

  @override
  String get remainingTextFieldCharacterCountFew => null;

  @override
  String get remainingTextFieldCharacterCountMany => null;

  @override
  String get remainingTextFieldCharacterCountOne => r'١ پیت ماوە';

  @override
  String get remainingTextFieldCharacterCountOther =>
      r'$remainingCount پیت ماوە';

  @override
  String get remainingTextFieldCharacterCountTwo => null;

  @override
  String get remainingTextFieldCharacterCountZero => r'هیچ پیت نەماوە';

  @override
  String get reorderItemDown => r'بڕۆ خوارەوە';

  @override
  String get reorderItemLeft => r'بڕۆ بۆلای چەپ';

  @override
  String get reorderItemRight => r'بڕۆ بۆلای ڕاست';

  @override
  String get reorderItemToEnd => r'بڕۆ بۆ کۆتایی';

  @override
  String get reorderItemToStart => r'بڕۆ بۆ سەرەتا';

  @override
  String get reorderItemUp => r'بڕۆ سەرەوە';

  @override
  String get rowsPerPageTitle => r'ڕیز بۆ هەر لاپەڕەیەک:';

  @override
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  String get searchFieldLabel => r'گەڕان';

  @override
  String get selectAllButtonLabel => r'هەموی دیاری بکە';

  @override
  String get selectedRowCountTitleFew => null;

  @override
  String get selectedRowCountTitleMany => null;

  @override
  String get selectedRowCountTitleOne => r'١ دانە دیاریکراوە';

  @override
  String get selectedRowCountTitleOther => r'$selectedRowCount دانە دیاریکراوە';

  @override
  String get selectedRowCountTitleTwo => null;

  @override
  String get selectedRowCountTitleZero => r'هیچ دیارینەکراوە';

  @override
  String get showAccountsLabel => r'هەژمارەکان پیشاندبدە';

  @override
  String get showMenuTooltip => r'مێنو پیشانبدە';

  @override
  String get signedInLabel => r'داخڵبووە';

  @override
  String get tabLabelRaw => r'Tab $tabIndex of $tabCount';

  @override
  TimeOfDayFormat get timeOfDayFormatRaw => TimeOfDayFormat.h_colon_mm_space_a;

  @override
  String get timePickerHourModeAnnouncement => r'کاتژمێر دیاریبکە';

  @override
  String get timePickerMinuteModeAnnouncement => r'خولەک دیاریبکە';
  @override
  String get viewLicensesButtonLabel => r'مۆڵەتەکان ببینە';
  @override
  List<String> get narrowWeekdays =>
      const <String>['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  @override
  int get firstDayOfWeekIndex => 0;
  @override
  String get calendarModeButtonLabel => r"هەڵبژارتنی رێکەوت";
  @override
  String get dateHelpText => r"هەڵبژارتنی رێکەوت";
  @override
  String get dateInputLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get dateOutOfRangeLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get datePickerHelpText => r"هەڵبژارتنی رێکەوت";

  @override
  String get dateRangeEndDateSemanticLabelRaw => r"هەڵبژارتنی رێکەوت";

  @override
  String get dateRangeEndLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get dateRangePickerHelpText => r"هەڵبژارتنی رێکەوت";

  @override
  String get dateRangeStartDateSemanticLabelRaw => r"هەڵبژارتنی رێکەوت";

  @override
  String get dateRangeStartLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get dateSeparator => r"هەڵبژارتنی رێکەوت";

  @override
  String get dialModeButtonLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get inputDateModeButtonLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get inputTimeModeButtonLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get invalidDateFormatLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get invalidDateRangeLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get invalidTimeLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get licensesPackageDetailTextOther => r"هەڵبژارتنی رێکەوت";

  @override
  String get moreButtonTooltip => r"هەڵبژارتنی رێکەوت";

  @override
  String get saveButtonLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get selectYearSemanticsLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get timePickerDialHelpText => r"هەڵبژارتنی رێکەوت";

  @override
  String get timePickerHourLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get timePickerInputHelpText => r"هەڵبژارتنی رێکەوت";

  @override
  String get timePickerMinuteLabel => r"هەڵبژارتنی رێکەوت";

  @override
  String get unspecifiedDate => r"هەڵبژارتنی رێکەوت";

  @override
  String get unspecifiedDateRange => r"هەڵبژارتنی رێکەوت";

  @override
   String get firstPageTooltip => r"هەڵبژارتنی رێکەوت";

  @override
  String get lastPageTooltip => r"هەڵبژارتنی رێکەوت";
}
