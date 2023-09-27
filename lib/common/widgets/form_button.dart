import 'package:flutter/material.dart';
import '../constants/sizes.dart';

class FormButton extends StatefulWidget {
  final String? text;
  const FormButton({
    super.key,
    this.text,
    required this.disabled,
  });

  final bool disabled;

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size5),
          color: widget.disabled
              ? Colors.grey.shade300
              : Theme.of(context).primaryColor,
        ),
        duration: const Duration(milliseconds: 500),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500),
          style: TextStyle(
            color: widget.disabled ? Colors.grey.shade400 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          child: Text(
            widget.text ?? 'Next',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
