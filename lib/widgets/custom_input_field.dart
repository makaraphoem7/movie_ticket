import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final FormFieldValidator<String> validator;

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.validator,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> with SingleTickerProviderStateMixin {
  bool _isObscured = true;
  bool _isFocusedOrHasText = false;
  bool _isError = false;
  late AnimationController _animationController;
  late Animation<double> _labelAnimation;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _labelAnimation = Tween<double>(begin: 0, end: -16).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    widget.controller.addListener(_updateLabelState);
  }

  void _updateLabelState() {
    setState(() {
      _isFocusedOrHasText = widget.controller.text.isNotEmpty;
      _isFocusedOrHasText ? _animationController.forward() : _animationController.reverse();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.controller.removeListener(_updateLabelState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocusedOrHasText = hasFocus || widget.controller.text.isNotEmpty;
          _isFocusedOrHasText ? _animationController.forward() : _animationController.reverse();
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Animated Floating Label
          AnimatedBuilder(
            animation: _labelAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _labelAnimation.value),
                child: Text(
                  widget.hintText,
                  style: TextStyle(
                    color: _isFocusedOrHasText
                        ? AppConstants.secondaryColor
                        : Colors.grey[600],
                    fontSize: _isFocusedOrHasText ? 12 : 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),

          // Input Field
          TextFormField(
            controller: widget.controller,
            obscureText: _isObscured,
            style: TextStyle(color: AppConstants.whiteColor, fontSize: 16),
            validator: (value) {
              final error = widget.validator(value);
              if (error != null) {
                setState(() => _isError = true); // Set error state
              } else {
                setState(() => _isError = false); // Remove error state
              }
              return error;
            },
            cursorColor: AppConstants.secondaryColor,
            decoration: InputDecoration(
              prefixIcon: Icon(widget.icon, color: AppConstants.secondaryColor),
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey[500],
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : null,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: _isError ? AppConstants.secondaryColor : Colors.grey[500]!,
                  width: 1,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: _isError
                      ? AppConstants.secondaryColor
                      : Colors.grey[500]!, // Focused border color
                  width: 2,
                ),
              ),
              errorText: _isError ? 'Invalid input' : null,
            ),
          ),
        ],
      ),
    );
  }
}
