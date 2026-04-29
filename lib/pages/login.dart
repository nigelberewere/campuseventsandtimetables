import 'package:flutter/material.dart';
import 'events.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
	const LoginPage({super.key});

	@override
	State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
	final _formKey = GlobalKey<FormState>();
	final _emailController = TextEditingController();
	final _passwordController = TextEditingController();
	bool _obscurePassword = true;

	@override
	void dispose() {
		_emailController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		const amberSmoke = Color(0xFFF2E0D0);
		const blueMirage = Color(0xFF5E88B0);
		const fallbackBlueMirage = Color(0xFF5C6D7C);

		return Scaffold(
			body: Stack(
				children: [
					const _LoginBackdrop(),
					SafeArea(
						child: Center(
							child: SingleChildScrollView(
								padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
								child: ConstrainedBox(
									constraints: const BoxConstraints(maxWidth: 460),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.stretch,
										children: [
											Container(
												padding: const EdgeInsets.all(22),
												decoration: BoxDecoration(
													color: Colors.white.withOpacity(0.64),
													borderRadius: BorderRadius.circular(30),
													border: Border.all(color: Colors.white.withOpacity(0.8)),
													boxShadow: [
														BoxShadow(
															color: const Color(0xFF8B6B50).withOpacity(0.12),
															blurRadius: 36,
															offset: const Offset(0, 18),
														),
													],
												),
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													children: [
														Row(
															children: [
																Container(
																	width: 54,
																	height: 54,
																	decoration: BoxDecoration(
																		color: blueMirage,
																		borderRadius: BorderRadius.circular(18),
																	),
																	child: const Icon(
																		Icons.school_rounded,
																		color: Colors.white,
																		size: 30,
																	),
																),
																const SizedBox(width: 14),
																Expanded(
																	child: Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: const [
																			Text(
																				'campuseventsandtimetables',
																				style: TextStyle(
																					fontSize: 18,
																					fontWeight: FontWeight.w800,
																					color: fallbackBlueMirage,
																					letterSpacing: 0.2,
																				),
																			),
																			SizedBox(height: 4),
																			Text(
																				'Sign in to manage campus events and schedules',
																				style: TextStyle(
																					fontSize: 12.5,
																					height: 1.3,
																					color: Color(0xFF7D6A59),
																				),
																			),
																		],
																	),
																),
															],
														),
														const SizedBox(height: 24),
														Container(
															padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
															decoration: BoxDecoration(
																color: amberSmoke.withOpacity(0.55),
																borderRadius: BorderRadius.circular(18),
															),
															child: const Row(
																children: [
																	Icon(Icons.event_available_rounded, color: fallbackBlueMirage),
																	SizedBox(width: 10),
																	Expanded(
																		child: Text(
																			'Access timetables, events, and your student profile from one place.',
																			style: TextStyle(
																				color: fallbackBlueMirage,
																				height: 1.35,
																				fontWeight: FontWeight.w600,
																			),
																		),
																	),
																],
															),
														),
														const SizedBox(height: 24),
														Form(
															key: _formKey,
															child: Column(
																children: [
																	TextFormField(
																		controller: _emailController,
																		keyboardType: TextInputType.emailAddress,
																		decoration: const InputDecoration(
																			labelText: 'Student email',
																			prefixIcon: Icon(Icons.alternate_email_rounded),
																		),
																		validator: (value) {
																			if (value == null || value.trim().isEmpty) {
																				return 'Enter your email';
																			}
																			if (!value.contains('@')) {
																				return 'Enter a valid email address';
																			}
																			return null;
																		},
																	),
																	const SizedBox(height: 16),
																	TextFormField(
																		controller: _passwordController,
																		obscureText: _obscurePassword,
																		decoration: InputDecoration(
																			labelText: 'Password',
																			prefixIcon: const Icon(Icons.lock_rounded),
																			suffixIcon: IconButton(
																				onPressed: () {
																					setState(() {
																						_obscurePassword = !_obscurePassword;
																					});
																				},
																				icon: Icon(
																					_obscurePassword
																							? Icons.visibility_rounded
																							: Icons.visibility_off_rounded,
																				),
																			),
																		),
																		validator: (value) {
																			if (value == null || value.isEmpty) {
																				return 'Enter your password';
																			}
																			if (value.length < 6) {
																				return 'Use at least 6 characters';
																			}
																			return null;
																		},
																	),
																	const SizedBox(height: 14),
																	Row(
																		children: [
																			Expanded(
																				child: TextButton(
																					onPressed: () {},
																					style: TextButton.styleFrom(
																						foregroundColor: fallbackBlueMirage,
																					),
																					child: const Text('Forgot password?'),
																				),
																			),
																		],
																	),
																	const SizedBox(height: 8),
																	FilledButton(
																		onPressed: () {
																			if (_formKey.currentState?.validate() ?? false) {
																			Navigator.of(context).pushReplacement(
																				MaterialPageRoute(builder: (_) => const EventsPage()),
																			);
																			}
																		},
																		style: FilledButton.styleFrom(
																			minimumSize: const Size.fromHeight(54),
																			backgroundColor: blueMirage,
																			foregroundColor: Colors.white,
																			shape: RoundedRectangleBorder(
																				borderRadius: BorderRadius.circular(18),
																			),
																		),
																		child: const Text(
																			'Sign In',
																			style: TextStyle(fontWeight: FontWeight.w700),
																		),
																	),
																	const SizedBox(height: 18),
																	OutlinedButton(
																		onPressed: () {
																		Navigator.of(context).push(
																			MaterialPageRoute(builder: (_) => SignupPage()),
																		);
																	},
																		style: OutlinedButton.styleFrom(
																			minimumSize: const Size.fromHeight(54),
																			foregroundColor: fallbackBlueMirage,
																			side: const BorderSide(color: Color(0xFFD6C2B0)),
																			shape: RoundedRectangleBorder(
																				borderRadius: BorderRadius.circular(18),
																			),
																		),
																		child: const Text(
																			'Create an account',
																			style: TextStyle(fontWeight: FontWeight.w700),
																		),
																	),
																],
															),
														),
													],
												),
											),
											const SizedBox(height: 18),
											Center(
												child: Text(
													'Design: Material',
													style: TextStyle(
														color: fallbackBlueMirage.withOpacity(0.75),
														fontWeight: FontWeight.w600,
														letterSpacing: 0.6,
													),
												),
											),
										],
									),
								),
							),
						),
					),
				],
			),
		);
	}
}

class _LoginBackdrop extends StatelessWidget {
	const _LoginBackdrop();

	@override
	Widget build(BuildContext context) {
		const amberSmoke = Color(0xFFF2E0D0);
		const blueMirage = Color(0xFF5E88B0);
		const fallbackBlueMirage = Color(0xFF5C6D7C);

		return Container(
			decoration: const BoxDecoration(
				gradient: LinearGradient(
					begin: Alignment.topLeft,
					end: Alignment.bottomRight,
					colors: [Color(0xFFFFF8F0), Color(0xFFF7EFE7), Color(0xFFF1E6DA)],
				),
			),
			child: Stack(
				children: [
					Positioned(
						top: -60,
						left: -30,
						child: _AtmosphericOrb(
							size: 180,
							colors: [amberSmoke.withOpacity(0.72), amberSmoke.withOpacity(0.12)],
						),
					),
					Positioned(
						top: 80,
						right: -50,
						child: _AtmosphericOrb(
							size: 220,
							colors: [blueMirage.withOpacity(0.55), blueMirage.withOpacity(0.04)],
						),
					),
					Positioned(
						bottom: -70,
						left: 40,
						child: _AtmosphericOrb(
							size: 240,
							colors: [fallbackBlueMirage.withOpacity(0.34), fallbackBlueMirage.withOpacity(0.03)],
						),
					),
					Positioned.fill(
						child: CustomPaint(
							painter: _LoginPatternPainter(
								lineColor: fallbackBlueMirage.withOpacity(0.08),
								dotColor: amberSmoke.withOpacity(0.16),
							),
						),
					),
				],
			),
		);
	}
}

class _AtmosphericOrb extends StatelessWidget {
	const _AtmosphericOrb({required this.size, required this.colors});

	final double size;
	final List<Color> colors;

	@override
	Widget build(BuildContext context) {
		return Container(
			width: size,
			height: size,
			decoration: BoxDecoration(
				shape: BoxShape.circle,
				gradient: RadialGradient(colors: colors),
			),
		);
	}
}

class _LoginPatternPainter extends CustomPainter {
	_LoginPatternPainter({required this.lineColor, required this.dotColor});

	final Color lineColor;
	final Color dotColor;

	@override
	void paint(Canvas canvas, Size size) {
		final linePaint = Paint()
			..color = lineColor
			..strokeWidth = 1.2
			..style = PaintingStyle.stroke;

		final dotPaint = Paint()
			..color = dotColor
			..style = PaintingStyle.fill;

		final path = Path()
			..moveTo(size.width * 0.05, size.height * 0.24)
			..quadraticBezierTo(size.width * 0.33, size.height * 0.08, size.width * 0.52, size.height * 0.18)
			..quadraticBezierTo(size.width * 0.74, size.height * 0.29, size.width * 0.95, size.height * 0.12);
		canvas.drawPath(path, linePaint);

		final accentPath = Path()
			..moveTo(size.width * 0.10, size.height * 0.82)
			..quadraticBezierTo(size.width * 0.36, size.height * 0.70, size.width * 0.60, size.height * 0.86)
			..quadraticBezierTo(size.width * 0.78, size.height * 0.96, size.width * 0.94, size.height * 0.78);
		canvas.drawPath(accentPath, linePaint);

		for (final point in <Offset>[
			Offset(size.width * 0.16, size.height * 0.18),
			Offset(size.width * 0.83, size.height * 0.23),
			Offset(size.width * 0.23, size.height * 0.74),
			Offset(size.width * 0.77, size.height * 0.83),
		]) {
			canvas.drawCircle(point, 3.5, dotPaint);
		}
	}

	@override
	bool shouldRepaint(covariant _LoginPatternPainter oldDelegate) {
		return oldDelegate.lineColor != lineColor || oldDelegate.dotColor != dotColor;
	}
}
