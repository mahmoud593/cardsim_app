import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class AmountFormField extends StatefulWidget {
  const AmountFormField({super.key});

  @override
  State<AmountFormField> createState() => _AmountFormFieldState();
}

class _AmountFormFieldState extends State<AmountFormField> {
  final TextEditingController _controller = TextEditingController();
  int _counter = 1;

  @override
  void initState() {
    super.initState();
    _controller.text = _counter.toString();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        prefixIcon: IconButton(
          color: Colors.white,
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              if (_counter > 0) {
                _counter--;
                _controller.text = _counter.toString();
              }
            });
          },
          icon: const Icon(CupertinoIcons.minus),
        ),
        suffixIcon: IconButton(
          color: Colors.white,
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              _counter++;
              _controller.text = _counter.toString();
            });
          },
          icon: const Icon(CupertinoIcons.plus),
        ),
        border: InputBorder.none,
        fillColor: ColorManager.primary,
        filled: true,
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            _counter = int.tryParse(value) ?? _counter;
          }
        });
      },
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
