import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';


// print(toCurrencyString('123456', leadingSymbol: CurrencySymbols.DOLLAR_SIGN)); // $123,456.00

// /// the values can also be shortened to thousands, millions, billions... 
/// in this case a 1000 will be displayed as 1K, and 1250000 will turn to this 1.25M
final result = toCurrencyString(
    '125000', 
    leadingSymbol: CurrencySymbols.DOLLAR_SIGN,
    shorteningPolicy: ShorteningPolicy.RoundToThousands
); // $125K
