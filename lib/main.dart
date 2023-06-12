import 'package:flutter/material.dart';
import 'package:poc_masked_text_field/page/example_page.dart';
import 'package:poc_masked_text_field/utils/currency_formatter.dart';

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
        home: ExamplePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.grey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_upward, size: 36),
                    Flexible(
                      child: FittedBox(
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: controller,
                            style: const TextStyle(
                                fontSize: 64.0,
                                overflow: TextOverflow.ellipsis),
                            expands: false,
                            decoration: const InputDecoration(
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
                      ),
                    ),
                    const Icon(Icons.arrow_upward, size: 36),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
