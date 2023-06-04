import 'package:faidanepal/util/dimensions.dart';
import 'package:faidanepal/util/styles.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData suffixIcon;
  final Function iconPressed;
  final Color filledColor;
  final Function onSubmit;
  final Function onChanged;
  SearchField(
      {@required this.controller,
      @required this.hint,
      @required this.suffixIcon,
      @required this.iconPressed,
      this.filledColor,
      this.onSubmit,
      this.onChanged});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: SyneRegular.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            color: Colors.white),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.black,
        isDense: true,
        suffixIcon: IconButton(
          onPressed: widget.iconPressed,
          icon: Icon(widget.suffixIcon,
              color: Colors.white),
        ),
      ),
      onSubmitted: widget.onSubmit,
      onChanged: widget.onChanged,
    );
  }
}
