import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Magic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _bgController;
  late Animation<Color?> _gradient1;
  late Animation<Color?> _gradient2;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _gradient1 = ColorTween(
      begin: const Color(0xFF7F00FF),
      end: const Color(0xFFE100FF),
    ).animate(_bgController);

    _gradient2 = ColorTween(
      begin: const Color(0xFF00B4DB),
      end: const Color(0xFF00F260),
    ).animate(_bgController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.1),
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "Gadget Guru",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _bgController,
        builder: (context, child) {
          return Stack(
            children: [
              // 🌈 Animated Gradient Background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_gradient1.value!, _gradient2.value!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // ✨ Animated Welcome Text
              Center(
                child: Text(
                  'Welcome to Flutter!',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 1000.ms)
                    .scale(duration: 800.ms, curve: Curves.easeOutBack)
                    .slideY(begin: -0.6)
                    .then()
                    .shake(hz: 2),
              ),

              // ⬆️ Enhanced Draggable Bottom Sheet
              DraggableScrollableSheet(
                initialChildSize: 0.12,
                minChildSize: 0.12,
                maxChildSize: 0.65,
                builder: (context, scrollController) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.white.withOpacity(0.85),
                        child: Column(
                          children: [
                            // ✨ Animated Grip Handle
                            Animate(
                              effects: [
                                FadeEffect(duration: 500.ms),
                                ScaleEffect(begin: Offset(0.8, 0.8), end: Offset(1.0, 1.0), curve: Curves.easeOutBack),
                                ShimmerEffect(delay: 1.seconds, duration: 1200.ms),
                              ],
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 12),
                                width: 50,
                                height: 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade300,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade100,
                                      blurRadius: 4,
                                      offset: const Offset(-2, -2),
                                    ),
                                    const BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // 📋 Animated List Items
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: 20,
                                itemBuilder: (context, index) {
                                  return AnimatedListItem(index: index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 700.ms)
                      .slideY(begin: 0.3)
                      .scale(begin: const Offset(0.98, 0.98), curve: Curves.easeOutBack);
                },
              ),
            ],
          );
        },
      ),

      // 🎈 Floating Action Button with bounce + glow
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      )
          .animate()
          .fadeIn(duration: 500.ms)
          .scale(duration: 600.ms)
          .then(delay: 500.ms)
          .shake(hz: 2),
    );
  }
}

// 🧱 Cool Animated List Items
class AnimatedListItem extends StatelessWidget {
  final int index;
  const AnimatedListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped on Item ${index + 1}')),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.star, color: Colors.white),
          ),
          title: Text(
            'Awesome Item ${index + 1}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('Fully animated with flutter_animate!'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      )
          .animate(delay: (100 * index).ms)
          .fadeIn(duration: 600.ms)
          .slideX(begin: 0.3)
          .scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOutBack)
          .blurXY(begin: 8, end: 0, duration: 600.ms),
    );
  }
}
