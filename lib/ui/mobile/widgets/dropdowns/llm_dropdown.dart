import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maid/classes/large_language_model.dart';
import 'package:maid/providers/session.dart';
import 'package:provider/provider.dart';

class LlmDropdown extends StatelessWidget {
  const LlmDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Session>(
      builder: (context, session, child) {
        return ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 200, 255),
              Color.fromARGB(255, 255, 80, 200)
            ],
            stops: [0.25, 0.75],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          blendMode: BlendMode
              .srcIn, // This blend mode applies the shader to the text color.
          child: DropdownMenu<LargeLanguageModelType>(
              dropdownMenuEntries: const [
                if (!kIsWeb)
                DropdownMenuEntry<LargeLanguageModelType>(
                  value: LargeLanguageModelType.llamacpp,
                  label: "LlamaCPP",
                ),
                DropdownMenuEntry<LargeLanguageModelType>(
                  value: LargeLanguageModelType.ollama,
                  label: "Ollama",
                ),
                DropdownMenuEntry<LargeLanguageModelType>(
                  value: LargeLanguageModelType.openAI,
                  label: "OpenAI",
                ),
                DropdownMenuEntry<LargeLanguageModelType>(
                  value: LargeLanguageModelType.mistralAI,
                  label: "MistralAI",
                ),
                DropdownMenuEntry<LargeLanguageModelType>(
                  value: LargeLanguageModelType.gemini,
                  label: "Gemini",
                ),
              ],
              onSelected: (LargeLanguageModelType? value) {
                if (value != null) {
                  switch (value) {
                    case LargeLanguageModelType.llamacpp:
                      session.switchLlamaCpp();
                      break;
                    case LargeLanguageModelType.openAI:
                      session.switchOpenAI();
                      break;
                    case LargeLanguageModelType.ollama:
                      session.switchOllama();
                      break;
                    case LargeLanguageModelType.mistralAI:
                      session.switchMistralAI();
                      break;
                    case LargeLanguageModelType.gemini:
                      session.switchGemini();
                      break;
                    default:
                      break;
                  }
                }
              },
              initialSelection: session.model.type,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              width: 175),
        );
      }
    );
  }
}
