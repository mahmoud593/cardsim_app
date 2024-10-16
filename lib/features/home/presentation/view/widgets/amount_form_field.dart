import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:games_app/features/home/domain/entities/products_entity.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class AmountFormField extends StatefulWidget {
  const AmountFormField(
      {super.key, required this.productsEntity, required this.controller});

  final ProductsEntity productsEntity;
  final TextEditingController controller;

  @override
  State<AmountFormField> createState() => _AmountFormFieldState();
}

class _AmountFormFieldState extends State<AmountFormField> {
  int _counter = 1;

  @override
  void initState() {
    super.initState();
    _counter = widget.productsEntity.quantity?.min ?? 1;
    widget.controller.text = _counter.toString();
  }

  @override
  Widget build(BuildContext context) {
//    var cubit = ProductsCubit.get(context);
    return TextFormField(
      controller: widget.controller,
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
              if (_counter > widget.productsEntity.quantity!.min!) {
                _counter--;
                widget.controller.text = _counter.toString();
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
              if (_counter < widget.productsEntity.quantity!.max!) {
                _counter++;
                widget.controller.text = _counter.toString();
              }
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
}
