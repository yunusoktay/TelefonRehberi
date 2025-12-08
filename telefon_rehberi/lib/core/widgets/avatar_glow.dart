import 'dart:io';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AvatarGlow extends StatefulWidget {
  final String? imagePath;
  final Widget child;
  final double size;

  const AvatarGlow({
    super.key,
    required this.imagePath,
    required this.child,
    this.size = 120,
  });

  @override
  State<AvatarGlow> createState() => _AvatarGlowState();
}

class _AvatarGlowState extends State<AvatarGlow> {
  static final Map<String, Color> _colorCache = {};
  Color? _glowColor;

  @override
  void didUpdateWidget(covariant AvatarGlow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imagePath != oldWidget.imagePath) {
      _extractColor();
    }
  }

  @override
  void initState() {
    super.initState();
    _extractColor();
  }

  Future<void> _extractColor() async {
    if (widget.imagePath == null) {
      if (mounted) setState(() => _glowColor = null);
      return;
    }

    if (_colorCache.containsKey(widget.imagePath)) {
      if (mounted) {
        setState(() {
          _glowColor = _colorCache[widget.imagePath];
        });
      }
      return;
    }

    try {
      ImageProvider imageProvider;
      if (widget.imagePath!.startsWith('http')) {
        imageProvider = CachedNetworkImageProvider(widget.imagePath!);
      } else {
        imageProvider = FileImage(File(widget.imagePath!));
      }

      imageProvider = ResizeImage(imageProvider, width: 100, height: 100);

      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        imageProvider,
        size: const Size(100, 100),
        maximumColorCount: 20,
      );

      if (paletteGenerator.dominantColor?.color != null) {
        _colorCache[widget.imagePath!] = paletteGenerator.dominantColor!.color;
      }

      if (mounted) {
        setState(() {
          _glowColor = paletteGenerator.dominantColor?.color;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _glowColor = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: _glowColor != null
            ? [
                BoxShadow(
                  color: _glowColor!.withValues(alpha: 0.6),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: _glowColor!.withValues(alpha: 0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ]
            : [],
      ),
      child: widget.child,
    );
  }
}
