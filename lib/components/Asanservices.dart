import 'package:flutter/material.dart';
import 'package:onboard_animation/Utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Service {
  final String title;
  final String description;
  final String phoneNumber;
  final String email;
  final IconData icon;

  Service({
    required this.title,
    required this.description,
    required this.phoneNumber,
    required this.email,
    required this.icon,
  });
}

class BudgetCalculatorPage extends StatefulWidget {
  @override
  _BudgetCalculatorPageState createState() => _BudgetCalculatorPageState();
}

class _BudgetCalculatorPageState extends State<BudgetCalculatorPage> {
  final TextEditingController rentController = TextEditingController();
  final TextEditingController utilitiesController = TextEditingController();
  final TextEditingController groceriesController = TextEditingController();
  final TextEditingController otherExpensesController = TextEditingController();

  double calculateTotalBudget() {
    double rent = double.tryParse(rentController.text) ?? 0;
    double utilities = double.tryParse(utilitiesController.text) ?? 0;
    double groceries = double.tryParse(groceriesController.text) ?? 0;
    double otherExpenses = double.tryParse(otherExpensesController.text) ?? 0;

    return rent + utilities + groceries + otherExpenses;
  }

  @override
  void dispose() {
    rentController.dispose();
    utilitiesController.dispose();
    groceriesController.dispose();
    otherExpensesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appgreen,
        title: Text('Budget Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: rentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Rent',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: utilitiesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Utilities',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: groceriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Groceries',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: otherExpensesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Other Expenses',
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.appgreen),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Total Budget'),
                      content: Text(
                          'Your total budget is: \$${calculateTotalBudget().toStringAsFixed(2)}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Calculate Budget',style: TextStyle(color: AppColors.white),),
            ),
          ],
        ),
      ),
    );
  }
}

class ServicesPage extends StatelessWidget {
  final List<Service> services = [
    Service(
      title: 'Tenant Verification',
      description: 'We provide professional tenant verification services.',
      phoneNumber: '03134187877',
      email: 'contact@assanghar.com',
      icon: Icons.security,
    ),
    Service(
      title: 'Karaya Nama',
      description: 'Get assistance with legal karaya nama documentation.',
      phoneNumber: '03134187877',
      email: 'contact@assanghar.com',
      icon: Icons.description,
    ),
    Service(
      title: 'Interior Design',
      description: 'Transform your space with our expert interior designers or with assan ghar AI',
      phoneNumber: '03134187877',
      email: 'contact@assanghar.com',
      icon: Icons.home,
    ),
    Service(
      title: 'Budget Calculator',
      description: 'Calculate and manage your project budget effectively.',
      phoneNumber: '03134187877',
      email: 'contact@assanghar.com',
      icon: Icons.attach_money,
    ),
    Service(
      title: 'Architecture',
      description: 'Experience innovative architectural design solutions.',
      phoneNumber: '03134187877',
      email: 'contact@assanghar.com',
      icon: Icons.architecture,
    ),
    Service(
      title: 'LDA Verification',
      description: 'Verify your LDA documents and records.',
      phoneNumber: '03134187877',
      email: 'contact@assanghar.com',
      icon: Icons.verified_user,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.litegreen,
      appBar: AppBar(
        backgroundColor: AppColors.appgreen,
        title: Text('Our Services'),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return InkWell(
            onTap: () {
              if (service.title == 'Tenant Verification') {
                launch('https://punjabpolice.gov.pk/tenants');
              } else if (service.title == 'Budget Calculator') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BudgetCalculatorPage()),
                );
              } else if (service.title == 'LDA Verification') {
                launch('https://lda.gop.pk/ldaonline/');
              } else {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AnimatedDialog(service: service),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: ScaleTransition(
                          scale: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
            child: Card(
              child: ListTile(
                leading: Icon(service.icon),
                title: Text(
                  service.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  service.description,
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedDialog extends StatefulWidget {
  final Service service;

  AnimatedDialog({required this.service});

  @override
  _AnimatedDialogState createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: AlertDialog(
        title: Text(widget.service.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Text(
                widget.service.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'Phone: ${widget.service.phoneNumber}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'Email: ${widget.service.email}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}