import 'package:flutter/material.dart';
import '../../components/shared.dart';
import '../../config/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  String _userName = 'Aarya';
  int _userAge = 28;
  int _cycleLength = 28;
  final int _mhsAverage = 85;
  final int _cycleDay = 12;

  late final AnimationController _controller;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _statsFade;
  late final Animation<Offset> _statsSlide;
  late final Animation<double> _menuFade;
  late final Animation<Offset> _menuSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _headerFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _headerSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _statsFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );
    _statsSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _menuFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
      ),
    );
    _menuSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getCyclePhase(int day) {
    if (day <= 5) return 'Menstrual Phase';
    if (day <= 13) return 'Follicular Phase';
    if (day == 14) return 'Ovulation Phase';
    return 'Luteal Phase';
  }

  void _showEditProfileSheet() {
    final nameController = TextEditingController(text: _userName);
    final ageController = TextEditingController(text: _userAge.toString());
    final cycleController = TextEditingController(text: _cycleLength.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: RhythmaColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionHeader(title: 'Edit Profile'),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: cycleController,
                decoration: const InputDecoration(labelText: 'Average Cycle Length (Days)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _userName = nameController.text;
                    _userAge = int.tryParse(ageController.text) ?? _userAge;
                    _cycleLength = int.tryParse(cycleController.text) ?? _cycleLength;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RhythmaGradients.primary,
          ),
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: RhythmaColors.background,
            ),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: RhythmaColors.primary.withValues(alpha: 0.1),
              child: const Icon(
                Icons.person_rounded,
                size: 48,
                color: RhythmaColors.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _userName,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          '$_userAge years old',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: RhythmaColors.mutedFg,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: RhythmaColors.teal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: RhythmaColors.teal.withValues(alpha: 0.25),
              width: 0.8,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.water_drop, color: RhythmaColors.teal, size: 16),
              const SizedBox(width: 4),
              Text(
                'Cycle Day $_cycleDay • ${_getCyclePhase(_cycleDay)}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: RhythmaColors.teal,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TintedIcon(icon: icon, color: color, size: 28),
              Icon(
                Icons.trending_flat_rounded,
                color: color.withValues(alpha: 0.6),
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: RhythmaColors.foreground,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: RhythmaColors.mutedFg,
              height: 1.1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.calendar_month_rounded,
                color: RhythmaColors.rose,
                value: '$_cycleLength days',
                label: 'Avg Cycle Length',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.psychology_rounded,
                color: RhythmaColors.teal,
                value: '$_mhsAverage',
                label: 'Avg Mental Health',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.insights_rounded,
                color: RhythmaColors.coral,
                value: '±1.2 days',
                label: 'Cycle Variability',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.history_toggle_off_rounded,
                color: RhythmaColors.primary,
                value: '27 days',
                label: 'Last Cycle Length',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionMenu() {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildActionTile(
            icon: Icons.edit_rounded,
            color: RhythmaColors.primary,
            title: 'Edit Profile Information',
            onTap: _showEditProfileSheet,
          ),
          const Divider(height: 1, color: RhythmaColors.border),
          _buildActionTile(
            icon: Icons.emergency_rounded,
            color: RhythmaColors.rose,
            title: 'Medical Emergency Contact',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Emergency Contact setup coming soon')),
              );
            },
          ),
          const Divider(height: 1, color: RhythmaColors.border),
          _buildActionTile(
            icon: Icons.settings_rounded,
            color: RhythmaColors.foreground,
            title: 'App Settings',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: TintedIcon(icon: icon, color: color, size: 36),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: const Icon(Icons.chevron_right_rounded, color: RhythmaColors.mutedFg),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20).copyWith(bottom: 100, top: 24),
        children: [
          FadeTransition(
            opacity: _headerFade,
            child: SlideTransition(
              position: _headerSlide,
              child: Column(
                children: [
                  Text(
                    'Profile',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  _buildHeader(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          FadeTransition(
            opacity: _statsFade,
            child: SlideTransition(
              position: _statsSlide,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionHeader(title: 'Quick Stats'),
                  _buildStatsCards(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          FadeTransition(
            opacity: _menuFade,
            child: SlideTransition(
              position: _menuSlide,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionHeader(title: 'Account Settings'),
                  _buildActionMenu(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
