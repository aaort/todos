import 'package:flutter/material.dart';

class Checkbox extends StatelessWidget {
  final bool checked;
  final VoidCallback onTap;

  const Checkbox({super.key, required this.checked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 21,
      width: 21,
      child: RawMaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Colors.blueGrey),
        ),
        fillColor: checked ? Colors.blueGrey : Colors.white,
        onPressed: onTap,
        child: checked
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 17,
                ),
              )
            : null,
      ),
    );
  }
}
