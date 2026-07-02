import 'package:flutter/material.dart';
import '../../components/shared.dart';
import '../../config/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'Aarya';
  int _userAge = 28;
  int _cycleLength = 28;
  int _mhsAverage = 85;

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
              backgroundColor: RhythmaColors.primary.withOpacity(0.1),
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
            color: RhythmaColors.teal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.water_drop, color: RhythmaColors.teal, size: 16),
              const SizedBox(width: 4),
              Text(
                'Active Cycle',
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

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: GlassCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TintedIcon(icon: Icons.calendar_month, color: RhythmaColors.rose, size: 32),
                const SizedBox(height: 12),
                Text(
                  '$_cycleLength Days',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Avg Cycle Length',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GlassCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TintedIcon(icon: Icons.psychology, color: RhythmaColors.teal, size: 32),
                const SizedBox(height: 12),
                Text(
                  '$_mhsAverage',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Avg Mental Health',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
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
          const SizedBox(height: 32),
          const SectionHeader(title: 'Quick Stats'),
          _buildStatsCards(),
          const SizedBox(height: 32),
          const SectionHeader(title: 'Account Settings'),
          _buildActionMenu(),
        ],
      ),
    );
  }
}
