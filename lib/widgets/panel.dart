import 'package:flutter/material.dart';
import 'package:project_a/config/config.dart';

class PanelWidget extends StatefulWidget {
  final String? photo;
  final int flex;
  final Widget? child;
  final EdgeInsets margin;
  final Function()? onTap;

  const PanelWidget(
      {super.key,
      this.photo,
      this.flex = 1,
      this.child,
      this.margin = const EdgeInsets.only(top: 10, left: 10, right: 10),
      this.onTap});

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return decideIfBodyIsExpandedOrNot();
  }

  Widget decideIfBodyIsExpandedOrNot() {
    if (widget.onTap == null) {
      return Expanded(
        flex: widget.flex,
        child: panelBody(),
      );
    } else {
      return panelBody();
    }
  }

  InkWell panelBody() {
    return InkWell(
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            margin: widget.margin,
            height: double.infinity,
            decoration: BoxDecoration(
              image: widget.photo != null
                  ? DecorationImage(
                      image: AssetImage(widget.photo!),
                      fit: BoxFit.cover,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(185, 255, 255, 255),
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
            ),
            child: widget.child,
          ),
          showWidgetIfHover(),
        ],
      ),
    );
  }

  Widget showWidgetIfHover() {
    if (isHover) {
      return Center(
        child: Icon(
          Icons.touch_app_rounded,
          color: enfasisColor.withOpacity(0.5),
        ),
      );
    } else {
      return Container();
    }
  }
}
