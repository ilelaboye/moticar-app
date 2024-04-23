import 'package:flutter/material.dart';

import 'colors.dart';

// class PinTextField extends StatefulWidget {
//   @override
//   _PinTextFieldState createState() => _PinTextFieldState();
// }

// class _PinTextFieldState extends State<PinTextField> {

//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       children: [
//         PinField(
//             borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(5.0),
//           bottomLeft: Radius.circular(5.0),
//         )),
//         PinField(),
//         PinField(),
//         PinField(),
//         PinField(
//             borderRadius: BorderRadius.only(
//           topRight: Radius.circular(5.0),
//           bottomRight: Radius.circular(5.0),
//         )),
//       ],
//     );
//   }
// }

class PinField extends StatefulWidget {

   final BorderRadius? borderRadius;
  final ValueChanged<String> onChanged;
  final FocusNode? nextFocusNode;

  const PinField({super.key, this.borderRadius, required this.onChanged, this.nextFocusNode});

  @override
  State<PinField> createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
   late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: 50.0,
      height: 64.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: widget.borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            textAlign: TextAlign.center,
            maxLength: 1,
                    controller: _controller,
            focusNode: _focusNode,
            style: const TextStyle(
              fontFamily: "Neulis",
              fontWeight: FontWeight.w500,
              // fontSize: 20,
              color: AppColors.textColor,
            ),
            keyboardType: TextInputType.number,
            // textInputAction: TextInputAction.next,
            onChanged: (value) {
              widget.onChanged(value);
              if (value.isNotEmpty && widget.nextFocusNode != null) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              }
            },
            decoration: const InputDecoration(
                hintText: '0',
                hintStyle: TextStyle(
                  fontFamily: "Neulis",
                  fontWeight: FontWeight.w400,
                  // fontSize: 20,
                  color: AppColors.textGrey,
                ),
                filled: true,
                fillColor: Colors.white,
                counterText: '',
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none)),
          ),
        ],
      ),
    );
  }
}
