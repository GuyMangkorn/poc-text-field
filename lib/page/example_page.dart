import 'package:flutter/material.dart';
import 'package:poc_masked_text_field/utils/currency_formatter.dart';

class ExamplePage extends StatelessWidget {
  ExamplePage({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POC'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(0, 21, 40, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.upload,
                      size: 48,
                      color: Color.fromRGBO(239, 68, 68, 1),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: FittedBox(
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: controller,
                            style: const TextStyle(
                              fontSize: 44.0,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                            ),
                            expands: false,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 0, bottom: 0),
                              hintStyle: TextStyle(
                                fontSize: 44.0,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                              ),
                              counterText: '',
                              hintText: '0',
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
                    const SizedBox(width: 10),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 28.0,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(100, 116, 139, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
