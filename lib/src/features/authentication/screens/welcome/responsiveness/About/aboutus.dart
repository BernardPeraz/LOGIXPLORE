import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("About Us"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: isDesktop ? 800 : double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MAIN TITLE
                Text(
                  "About Us — LogiXplore",
                  style: TextStyle(
                    fontSize: isDesktop ? 32 : 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                buildParagraph(
                  context,
                  "LogiXplore comes from the words “Logic” and “Explore,” symbolizing our mission to make the world of digital logic easier to understand, explore, and master. The platform serves as a learning space where students can discover logic gates step-by-step using visuals, exercises, and interactive tools.",
                  isDesktop,
                ),

                sectionTitle("What Is LogiXplore?", isDesktop),
                buildParagraph(
                  context,
                  "LogiXplore is an educational website created to simplify the study of digital logic. Logic gates are essential in digital circuits, computing, and electronics—yet the topic can be confusing for beginners. LogiXplore offers a modern, interactive learning environment with clear explanations anyone can follow.",
                  isDesktop,
                ),

                sectionTitle("What We Offer", isDesktop),
                subSectionTitle("Logic Gate Lessons", isDesktop),
                buildBulletList([
                  "AND",
                  "OR",
                  "NOT",
                  "NAND",
                  "NOR",
                  "XOR",
                  "XNOR",
                  "Buffer",
                ], isDesktop),

                subSectionTitle("Multiple-Choice Quizzes", isDesktop),
                buildBulletList([
                  "Topic-based quizzes",
                  "Randomized questions",
                  "AI-generated questions",
                  "Instant feedback",
                ], isDesktop),

                subSectionTitle("Diagram & Truth Table Exercises", isDesktop),
                buildBulletList([
                  "Truth table completion",
                  "Symbol identification",
                ], isDesktop),

                sectionTitle("Our Mission", isDesktop),
                buildParagraph(
                  context,
                  "To make digital logic accessible, understandable, and engaging for every learner by removing complexity and providing strong learning tools.",
                  isDesktop,
                ),

                sectionTitle("Our Vision", isDesktop),
                buildParagraph(
                  context,
                  "To become a trusted educational platform for digital logic, empowering all learners with knowledge and confidence.",
                  isDesktop,
                ),

                sectionTitle("Who LogiXplore Is For", isDesktop),
                buildParagraph(
                  context,
                  "LogiXplore is built for beginners, students studying logic gates for the first time, and anyone who wants clear and guided logic explanations.",
                  isDesktop,
                ),

                sectionTitle("Why We Created LogiXplore", isDesktop),
                buildParagraph(
                  context,
                  "We believe learning should be simple, clear, and interactive. Traditional materials can be confusing—so we built LogiXplore as a modern, visually rich, and AI-supported learning tool.",
                  isDesktop,
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- Helper Widgets -----------

  Widget sectionTitle(String text, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isDesktop ? 24 : 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget subSectionTitle(String text, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isDesktop ? 20 : 17,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildParagraph(BuildContext context, String text, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isDesktop ? 16 : 14,
          height: 1.55,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildBulletList(List<String> items, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("•  "),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: isDesktop ? 16 : 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
