import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/data/shared_preferences_repository.dart';
import 'package:simple_beautiful_checklist_exercise/src/features/statistics/widgets/task_counter_card.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int currentTaskCount = 0;
  int deletedCount = 0;

  void loadItemCount() async {
    int taskCount = await widget.repository.getItemCount();

    if (taskCount != currentTaskCount) {
      setState(() {
        currentTaskCount = taskCount;
      });
    }
  }

  void loadStats() async {
    int taskCount = await widget.repository.getItemCount();
    int delCount = 0;
    if (widget.repository is SharedPreferencesRepository) {
      delCount = await (widget.repository as SharedPreferencesRepository)
          .getDeletedCount();
    }
    setState(() {
      currentTaskCount = taskCount;
      deletedCount = delCount;
    });
  }

  @override
  void initState() {
    super.initState();
    loadStats();
  }



  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task-Statistik"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            TaskCounterCard(taskCount: currentTaskCount),
            const SizedBox(height: 20),
            Text('Gelöschte Aufgaben: $deletedCount'),

          ],
        ),
      ),
    );
  }
}
