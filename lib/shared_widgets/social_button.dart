import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
final String text;
final String logoPath;
final VoidCallback onPressed;

const SocialButton({
super.key,
required this.text,
required this.logoPath,
required this.onPressed,
});

@override
Widget build(BuildContext context) {
return SizedBox(
width: double.infinity,
height: 45, 
child: OutlinedButton(
onPressed: onPressed,
style: OutlinedButton.styleFrom(
backgroundColor: Colors.white,
side: const BorderSide(color: Color(0xffB0B0B0), width: 0.5), 
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12), 
),
elevation: 0,
padding: EdgeInsets.zero,
),
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Image.asset(
logoPath,
height: 18,
width: 18,
errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, size: 20),
),
const SizedBox(width: 8),
Text(
text,
style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
),
],
),
),
);
}
}