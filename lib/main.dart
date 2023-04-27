import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:poc_masked_text_field/utils/currency_formatter.dart';
import 'package:poc_masked_text_field/widget/custom_text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  static const _locale = 'th';
  String _formatNumber(String s) {
    if (s.contains('.')) {
      return NumberFormat.currency(
              customPattern: '###,###.##', decimalDigits: 2, locale: 'th')
          .format(s);
    }
    return NumberFormat.decimalPattern(_locale).format(int.parse(s));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            child: AutoSizeTextField(
              key: Key('test'),
              controller: controller,
              maxLines: 1,
              maxLength: 10,
              decoration: const InputDecoration(
                  hintText: '0', counterText: '', border: InputBorder.none),
              style: const TextStyle(fontSize: 35),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [CustomCurrencyTextInputFormatter()],
            ),
          ),
          IntrinsicWidth(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                  fontSize: 64.0, overflow: TextOverflow.ellipsis),
              expands: false,
              maxLength: 10,
              decoration: const InputDecoration(
                constraints: BoxConstraints.tightFor(width: 200),
                counterText: '',
                hintText: '0.0',
                border: InputBorder.none,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                CustomCurrencyTextInputFormatter(),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       const Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 10),
          //         child: Icon(Icons.arrow_upward, size: 34),
          //       ),
          //       TextField(
          //         controller: controller,
          //         style: const TextStyle(fontSize: 24.0),
          //         scrollPhysics: const NeverScrollableScrollPhysics(),
          //         decoration: const InputDecoration(
          //           constraints: BoxConstraints.tightFor(width: 200),
          //           hintText: '0.0',
          //           border: InputBorder.none,
          //         ),
          //         keyboardType: const TextInputType.numberWithOptions(
          //           decimal: true,
          //         ),
          //         inputFormatters: [
          //           CustomCurrencyTextInputFormatter(),
          //         ],
          //       ),
          //       const Text(
          //         '\$',
          //         style: TextStyle(fontSize: 24),
          //       )
          //     ],
          //   ),
          // )
          // TextField(
          //   controller: _controller2,
          //   textAlign: TextAlign.right,
          //   // keyboardType: const TextInputType.numberWithOptions(decimal: true),
          //   decoration:
          //       const InputDecoration(hintText: '0.0', labelText: 'Lib'),
          //   inputFormatters: [CurrencyInputFormatter()],
          // ),
          // TextField(
          //   keyboardType: const TextInputType.numberWithOptions(decimal: true),
          //   controller: _controller,
          //   onChanged: (string) {
          //     string = '${_formatNumber(string.replaceAll(',', ''))}';
          //     _controller.value = TextEditingValue(
          //       text: string,
          //       selection: TextSelection.collapsed(offset: string.length),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
