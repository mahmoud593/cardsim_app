import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/domain/entities/products_entity.dart';
import 'package:games_app/features/home/presentation/controller/request_cubit/request_cubit.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';

import '../../../../../styles/colors/color_manager.dart';

class PlayerIdSearchSection extends StatefulWidget {
  const PlayerIdSearchSection({
    super.key,
    required this.productsEntity,
    required this.formKey,
  });

  final ProductsEntity productsEntity;
  final GlobalKey<FormState> formKey;

  @override
  State<PlayerIdSearchSection> createState() => _PlayerIdSearchSectionState();
}

class _PlayerIdSearchSectionState extends State<PlayerIdSearchSection> {
  TextEditingController idController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    idController.addListener(() {
      setState(() {
        isButtonEnabled = idController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestCubit, RequestState>(
      builder: (context, state) {
        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: widget.productsEntity.field!.name,
                      style: TextStyles.textStyle14Medium,
                    ),
                    TextSpan(
                      text: ' (إجباري)',
                      style: TextStyles.textStyle14Medium
                          .copyWith(color: Colors.red),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: idController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: widget.productsEntity.field!.name,
                        hintStyle: const TextStyle(
                          color: Color(0xFF949D9E),
                        ),
                        border: InputBorder.none,
                        fillColor: ColorManager.primary,
                        filled: true,
                      ),
                    ),
                  ),
                  if (widget.productsEntity.field!.fieldCheck == true) ...[
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () {
                              context.read<RequestCubit>().checkIdField(
                                  idController.text,
                                  widget.productsEntity.field!.fieldCheckType!);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isButtonEnabled
                            ? ColorManager.primary
                            : Colors.grey,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        'ابحث',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ]
                ],
              ),
              if (widget.productsEntity.field!.fieldCheckType != '') ...[
                const SizedBox(
                  height: 8,
                ),
                if (widget.productsEntity.field!.fieldCheckRequired ==
                    true) ...[
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'يرجى التحقق من رقم اللاعب قبل إرسال الطلب',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
                if (state is CheckFieldLoading)
                  const Center(child: LinearProgressIndicator()),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: state is CheckFieldSuccess
                        ? state.checkFieldEntity.result == 'success'
                            ? state.checkFieldEntity.playerName
                            : state.checkFieldEntity.message
                        : '',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    fillColor: ColorManager.primary,
                    filled: true,
                    enabled: false,
                  ),
                )
              ]
            ],
          ),
        );
      },
    );
  }
}
