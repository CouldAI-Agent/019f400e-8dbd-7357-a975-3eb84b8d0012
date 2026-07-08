import 'package:flutter/material.dart';

void main() {
  runApp(const LogisticsApp());
}

class LogisticsApp extends StatelessWidget {
  const LogisticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logistics Packages',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
      },
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Logistics & Hiring Dashboard'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          const PackageDutyCard(),
                          const SizedBox(height: 16),
                          const EVSedanCard(),
                          const SizedBox(height: 16),
                          const PackageContactsCard(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: const DriverHiringCard(),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const PackageDutyCard(),
                    const SizedBox(height: 16),
                    const EVSedanCard(),
                    const SizedBox(height: 16),
                    const PackageContactsCard(),
                    const SizedBox(height: 16),
                    const DriverHiringCard(),
                  ],
                ),
        ),
      ),
    );
  }
}

class PackageDutyCard extends StatelessWidget {
  const PackageDutyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Package Duty',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.primaryContainer,
                ),
                columns: const [
                  DataColumn(label: Text('Vehicle Type')),
                  DataColumn(label: Text('Model')),
                  DataColumn(label: Text('Package Days')),
                  DataColumn(label: Text('Package Amount\n(Inc. Attnd. Bonus)\nfor 22 days & 88 trips')),
                  DataColumn(label: Text('Mandatory Trips')),
                  DataColumn(label: Text('Mandatory Days')),
                  DataColumn(label: Text('Extra Trip Rate')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('SUV')),
                    DataCell(Text('2023')),
                    DataCell(Text('22')),
                    DataCell(Text('77,000')),
                    DataCell(Text('88')),
                    DataCell(Text('22')),
                    DataCell(Text('800')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Sedan')),
                    DataCell(Text('2023')),
                    DataCell(Text('22')),
                    DataCell(Text('59,000')),
                    DataCell(Text('88')),
                    DataCell(Text('22')),
                    DataCell(Text('600')),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EVSedanCard extends StatelessWidget {
  const EVSedanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Trip rate for EV Sedan',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.primaryContainer,
                ),
                columns: const [
                  DataColumn(label: Text('Vehicle Type')),
                  DataColumn(label: Text('Slab')),
                  DataColumn(label: Text('Vehicle Rate')),
                  DataColumn(label: Text('Variable Cost/KM\n(Non AC)')),
                  DataColumn(label: Text('Variable Cost/KM\n(AC)')),
                  DataColumn(label: Text('Billing As per\nSlab Fix')),
                  DataColumn(label: Text('Variable Cost Total\n(Non AC)')),
                  DataColumn(label: Text('Total')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('EV')),
                    DataCell(Text('0-20 KM')),
                    DataCell(Text('550')),
                    DataCell(Text('5')),
                    DataCell(Text('7')),
                    DataCell(Text('550')),
                    DataCell(Text('100')),
                    DataCell(Text('650')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('EV')),
                    DataCell(Text('21-30 KM')),
                    DataCell(Text('650')),
                    DataCell(Text('5')),
                    DataCell(Text('7')),
                    DataCell(Text('650')),
                    DataCell(Text('150')),
                    DataCell(Text('800')),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Theme.of(context).colorScheme.onTertiaryContainer),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Escort Rate Rs. 100/- per trip is exclusive',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PackageContactsCard extends StatelessWidget {
  const PackageContactsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Please contact for more detail.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                _ContactChip('9845072221'),
                _ContactChip('9916011222'),
                _ContactChip('6364832577'),
                _ContactChip('9900406027'),
                _ContactChip('86187488862'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DriverHiringCard extends StatelessWidget {
  const DriverHiringCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primaryContainer,
              theme.colorScheme.surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.directions_car_filled,
              size: 48,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'DRIVER HIRING',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            _DetailRow(
              icon: Icons.payments_outlined,
              label: 'Salary',
              value: 'Up to ₹27,000 per month',
            ),
            const SizedBox(height: 16),
            _DetailRow(
              icon: Icons.schedule,
              label: 'Duty Hours',
              value: '12 Hours',
            ),
            const SizedBox(height: 32),
            Text(
              'Interested candidate can contact us for more details:',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                _ContactChip('8050754356', primary: true),
                const SizedBox(height: 8),
                _ContactChip('8884214035', primary: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactChip extends StatelessWidget {
  final String number;
  final bool primary;

  const _ContactChip(this.number, {this.primary = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        Icons.phone,
        size: 16,
        color: primary 
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.primary,
      ),
      label: Text(
        number,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: primary 
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      backgroundColor: primary 
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.surface,
      side: BorderSide(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      ),
    );
  }
}
