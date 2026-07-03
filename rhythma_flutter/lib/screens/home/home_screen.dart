import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythma/l10n/app_localizations.dart';
import '../../config/theme.dart';
import '../../components/shared.dart';
import '../../components/charts.dart';
import '../../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeProvider>();
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 8, 2, 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeGreeting,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: RhythmaColors.foreground,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.homePhaseDesc,
                        style: TextStyle(
                          fontSize: 13,
                          color: RhythmaColors.mutedFg,
                        ),
                      ),
                    ],
                  ),
                ),
                _HeaderIcon(icon: Icons.language_rounded),
                const SizedBox(width: 8),
                _HeaderIcon(icon: Icons.shield_outlined),
              ],
            ),
          ),

          // ── Cycle ring + prediction ──────────────────────────
          GlassCard(
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RhythmaGradients.primary,
                    ),
                    // ignore: use_decorated_box
                  ).opacity(0.22),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const CycleRing(day: 14, total: 28, size: 88),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.homeNextPeriod,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: RhythmaColors.mutedFg,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '14',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                      color: RhythmaColors.foreground,
                                      height: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    l10n.homeDaysLabel,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: RhythmaColors.mutedFg,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: RhythmaColors.foreground,
                                  ),
                                  children: [
                                    TextSpan(text: l10n.homeFertileWindow),
                                    TextSpan(
                                      text: l10n.homeHighEnergy,
                                      style: TextStyle(
                                        color: RhythmaColors.rose,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 1,
                      color: RhythmaColors.border,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _StatCell(label: 'MHS', value: '82', color: RhythmaColors.primary),
                        _StatDivider(),
                        _StatCell(label: 'CVI', value: 'Low', color: RhythmaColors.teal),
                        _StatDivider(),
                        _StatCell(label: 'Sleep', value: '7.2h', color: RhythmaColors.coral),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── AI Assistant CTA ────────────────────────────────
          GradientBox(
            padding: const EdgeInsets.all(18),
            child: Stack(
              children: [
                Positioned(
                  right: -8,
                  top: -8,
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    size: 80,
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome_rounded,
                            size: 14, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          l10n.homeAiTitle,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.homeAiSubtitle,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.chat_bubble_outline_rounded,
                                    size: 15,
                                    color: Colors.white.withOpacity(0.9)),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.homeAiPrompt,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.mic_rounded,
                              size: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Today's log ────────────────────────────────────
          SectionHeader(
            title: l10n.homeFeelingTitle,
            action: l10n.homeLogAll,
          ),
          Row(
            children: [
              _LogButton(
                icon: Icons.water_drop_outlined,
                label: l10n.homeLogFlow,
                color: RhythmaColors.rose,
              ),
              const SizedBox(width: 10),
              _LogButton(
                icon: Icons.favorite_border_rounded,
                label: l10n.homeLogMood,
                color: RhythmaColors.coral,
              ),
              const SizedBox(width: 10),
              _LogButton(
                icon: Icons.bedtime_outlined,
                label: l10n.homeLogSleep,
                color: RhythmaColors.primary,
              ),
              const SizedBox(width: 10),
              _LogButton(
                icon: Icons.air_rounded,
                label: l10n.homeLogStress,
                color: RhythmaColors.teal,
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ── Insight card ───────────────────────────────────
          GlassCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeWeeklyInsightLabel,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: RhythmaColors.teal,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.homeWeeklyInsightTitle,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: RhythmaColors.foreground,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.homeWeeklyInsightDesc,
                        style: TextStyle(
                          fontSize: 13,
                          color: RhythmaColors.mutedFg,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right_rounded,
                    color: RhythmaColors.mutedFg),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Education cards ────────────────────────────────
          SectionHeader(title: l10n.homeLearnTitle),
          SizedBox(
            height: 128,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _LearnCard(title: l10n.homeLearnPcos, color: RhythmaColors.rose, label: l10n.homeArticle),
                const SizedBox(width: 10),
                _LearnCard(title: l10n.homeLearnHormones, color: RhythmaColors.primary, label: l10n.homeArticle),
                const SizedBox(width: 10),
                _LearnCard(title: l10n.homeLearnIron, color: RhythmaColors.coral, label: l10n.homeArticle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Small helpers ──────────────────────────────────────────────────────────────

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  const _HeaderIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      borderRadius: 20,
      child: SizedBox(
        width: 38,
        height: 38,
        child: Icon(icon, size: 18, color: RhythmaColors.foreground),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCell({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  color: RhythmaColors.mutedFg,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 3),
          Text(value,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color)),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: 1,
        height: 28,
        color: RhythmaColors.border,
      );
}

class _LogButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _LogButton(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 6),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: RhythmaColors.foreground)),
          ],
        ),
      ),
    );
  }
}

class _LearnCard extends StatelessWidget {
  final String title;
  final Color color;
  final String label;

  const _LearnCard({required this.title, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: 152,
      decoration: BoxDecoration(
        gradient: isDark
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, Color.lerp(color, RhythmaColors.primary, 0.5)!],
              ),
        color: isDark ? color.withOpacity(0.15) : null,
        border: isDark ? Border.all(color: color.withOpacity(0.3)) : null,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.75),
                letterSpacing: 1),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

extension on Widget {
  Widget opacity(double value) =>
      Opacity(opacity: value, child: this);
}
