import 'package:flutter/material.dart';
import 'events.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          const _SignupBackdrop(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.66),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.82)),
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
                                Icons.person_add_alt_1_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Create your account',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: fallbackBlueMirage,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Join the campus events and timetables network',
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
                              Icon(Icons.verified_user_rounded, color: fallbackBlueMirage),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Use your student details to create a secure campus profile.',
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
                                controller: _fullNameController,
                                textCapitalization: TextCapitalization.words,
                                decoration: const InputDecoration(
                                  labelText: 'Full name',
                                  prefixIcon: Icon(Icons.badge_rounded),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter your full name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _studentIdController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Student ID',
                                  prefixIcon: Icon(Icons.confirmation_number_rounded),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter your student ID';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
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
                                    onPressed: () => setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    }),
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Create a password';
                                  }
                                  if (value.length < 6) {
                                    return 'Use at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: _obscureConfirmPassword,
                                decoration: InputDecoration(
                                  labelText: 'Confirm password',
                                  prefixIcon: const Icon(Icons.lock_reset_rounded),
                                  suffixIcon: IconButton(
                                    onPressed: () => setState(() {
                                      _obscureConfirmPassword = !_obscureConfirmPassword;
                                    }),
                                    icon: Icon(
                                      _obscureConfirmPassword
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm your password';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 8),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                                value: _acceptedTerms,
                                onChanged: (value) => setState(() {
                                  _acceptedTerms = value ?? false;
                                }),
                                title: const Text(
                                  'I agree to receive campus notifications and account updates',
                                  style: TextStyle(height: 1.25),
                                ),
                                activeColor: blueMirage,
                              ),
                              const SizedBox(height: 8),
                              FilledButton(
                                onPressed: () {
                                  if (!(_formKey.currentState?.validate() ?? false)) {
                                    return;
                                  }
                                  if (!_acceptedTerms) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please accept the terms to continue.'),
                                      ),
                                    );
                                    return;
                                  }
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) => const EventsPage()),
                                  );
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
                                  'Create account',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(height: 14),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: TextButton.styleFrom(
                                  foregroundColor: fallbackBlueMirage,
                                ),
                                child: const Text('Already have an account? Sign in'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

class _SignupBackdrop extends StatelessWidget {
  const _SignupBackdrop();

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
            top: -70,
            right: -30,
            child: _AtmosphericOrb(
              size: 210,
              colors: [blueMirage.withOpacity(0.45), blueMirage.withOpacity(0.04)],
            ),
          ),
          Positioned(
            bottom: -80,
            left: -40,
            child: _AtmosphericOrb(
              size: 230,
              colors: [amberSmoke.withOpacity(0.70), amberSmoke.withOpacity(0.10)],
            ),
          ),
          Positioned(
            top: 120,
            left: 28,
            child: _AtmosphericOrb(
              size: 120,
              colors: [fallbackBlueMirage.withOpacity(0.22), fallbackBlueMirage.withOpacity(0.03)],
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
