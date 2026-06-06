import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/theme.dart';
import 'components/bottom_nav.dart';
import 'screens/home/home_screen.dart';
import 'screens/cycle/cycle_screen.dart';
import 'screens/assistant/assistant_screen.dart';
import 'screens/insights/insights_screen.dart';
import 'services/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables (.env is in gitignore; .env.example is provided)
  await dotenv.load(fileName: '.env').catchError((_) {
    // .env may be absent in CI or during first clone — that's fine
    debugPrint('No .env file found. Using defaults / demo mode.');
  });

  // Initialise local offline storage
  await LocalStorageService.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const RhythmaApp());
}

class RhythmaApp extends StatelessWidget {
  const RhythmaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rhythma',
      theme: RhythmaTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const RhythmaShell(),
    );
  }
}

class RhythmaShell extends StatefulWidget {
  const RhythmaShell({Key? key}) : super(key: key);

  @override
  State<RhythmaShell> createState() => _RhythmaShellState();
}

class _RhythmaShellState extends State<RhythmaShell> {
  int _currentIndex = 0;

  static const _screens = [
    HomeScreen(),
    CycleScreen(),
    AssistantScreen(),
    InsightsScreen(),
    _ProfilePlaceholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFDF8FF), Color(0xFFF8EEF8)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
        ),
        bottomNavigationBar: RhythmaBottomNav(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
    );
  }
}

class _ProfilePlaceholder extends StatelessWidget {
  const _ProfilePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: RhythmaGradients.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_rounded,
                color: Colors.white, size: 36),
          ),
          const SizedBox(height: 14),
          const Text('Aarya',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: RhythmaColors.foreground)),
          const SizedBox(height: 6),
          Text('Profile coming soon',
              style: TextStyle(fontSize: 14, color: RhythmaColors.mutedFg)),
        ],
      ),
    );
  }
}
