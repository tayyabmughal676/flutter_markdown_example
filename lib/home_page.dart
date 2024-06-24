import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController controller = ScrollController();

  // Example JSON data
  final String jsonString = '''
  {
    "data": "# Hola, \\"NAME\\".\\n\\nParece que este es un informe oftalmológico pediátrico de una revisión que te realizaron en el Hospital Universitario Puerta de Hierro. Aquí te explico en detalle lo que dice el informe:\\n\\n## Resumen General:\\n\\n- Este informe es el resultado de una consulta oftalmológica de rutina. No se han encontrado problemas médicos o quirúrgicos importantes. No has requerido tratamientos especiales y no has tenido ingresos hospitalarios recientes.\\n- Tu agudeza visual es normal en ambos ojos.\\n- Tienes hipermetropía, que significa que puedes ver mejor los objetos lejanos que los cercanos.\\n\\n## Análisis Detallado:\\n\\n- Agudeza visual:\\n  - OD (ojo derecho): 1.0 (visión normal)\\n  - OI (ojo izquierdo): 1.0 (visión normal)\\n- Refracción clínica:\\n  - OD: +1,50, 0,12 a 78°\\n  - OI: +1,50, 0,12 a 17°\\n  - Estos valores indican hipermetropía ligera en ambos ojos.\\n- Motilidad ocular:\\n  - Convergencia buena, sin signos de tortícolis o nistagmus.\\n- Examen de estructuras internas del ojo:\\n  - Papilas ópticas (discos ópticos) y máculas están en buen estado, con reflejos foveales normales.\\n"
  }
  ''';

  String example = """
  # Hola, "NAME".
  Parece que este es un informe oftalmológico pediátrico de una revisión que te realizaron en el Hospital Universitario Puerta de Hierro. Aquí te explico en detalle lo que dice el informe:
  
  ## Resumen General:
  
  - Este informe es el resultado de una consulta oftalmológica de rutina. No se han encontrado problemas médicos o quirúrgicos importantes. No has requerido tratamientos especiales y no has tenido ingresos hospitalarios recientes.
  - Tu agudeza visual es normal en ambos ojos.
  - Tienes hipermetropía, que significa que puedes ver mejor los objetos lejanos que los cercanos.
  
  ## Análisis Detallado:
  
  - Agudeza visual:
    - OD (ojo derecho): 1.0 (visión normal)
    - OI (ojo izquierdo): 1.0 (visión normal)
  - Refracción clínica:
    - OD: +1,50, 0,12 a 78°
    - OI: +1,50, 0,12 a 17°
    - Estos valores indican hipermetropía ligera en ambos ojos.
  - Motilidad ocular:
    - Convergencia buena, sin signos de tortícolis o nistagmus.
  - Examen de estructuras internas del ojo:
    - Papilas ópticas (discos ópticos) y máculas están en buen estado, con reflejos foveales normales.
  
  """;

  String downloaded = """
            # Flutter Markdown Example

            This is an example of how to use the `flutter_markdown` package in a Flutter app.

            - It supports basic text formatting like *italic* and **bold**.
            - You can create lists:
              1. Item 1
              2. Item 2
            - Links are clickable: [OpenAI](https://www.openai.com)

            ## Give it a try!

            You can experiment with different Markdown content here.
            """;

  // List of JSON strings
  final List<String> jsonStrings = [
    '''
    {
      "data": "# Hola, \\"NAME\\".\\n\\nParece que este es un informe oftalmológico pediátrico de una revisión que te realizaron en el Hospital Universitario Puerta de Hierro. Aquí te explico en detalle lo que dice el informe:\\n\\n## Resumen General:\\n\\n- Este informe es el resultado de una consulta oftalmológica de rutina. No se han encontrado problemas médicos o quirúrgicos importantes. No has requerido tratamientos especiales y no has tenido ingresos hospitalarios recientes.\\n- Tu agudeza visual es normal en ambos ojos.\\n- Tienes hipermetropía, que significa que puedes ver mejor los objetos lejanos que los cercanos.\\n\\n## Análisis Detallado:\\n\\n- Agudeza visual:\\n  - OD (ojo derecho): 1.0 (visión normal)\\n  - OI (ojo izquierdo): 1.0 (visión normal)\\n- Refracción clínica:\\n  - OD: +1,50, 0,12 a 78°\\n  - OI: +1,50, 0,12 a 17°\\n  - Estos valores indican hipermetropía ligera en ambos ojos.\\n- Motilidad ocular:\\n  - Convergencia buena, sin signos de tortícolis o nistagmus.\\n- Examen de estructuras internas del ojo:\\n  - Papilas ópticas (discos ópticos) y máculas están en buen estado, con reflejos foveales normales.\\n"
    }
    ''',
    '''
    {
      "data": "# Hola, \\"NAME\\".\\n\\nEste es otro informe oftalmológico pediátrico de una revisión en el Hospital Universitario La Paz. Aquí te explico en detalle lo que dice el informe:\\n\\n## Resumen General:\\n\\n- Este informe es el resultado de una consulta oftalmológica de rutina. No se han encontrado problemas médicos o quirúrgicos importantes. No has requerido tratamientos especiales y no has tenido ingresos hospitalarios recientes.\\n- Tu agudeza visual es normal en ambos ojos.\\n- Tienes miopía, que significa que puedes ver mejor los objetos cercanos que los lejanos.\\n\\n## Análisis Detallado:\\n\\n- Agudeza visual:\\n  - OD (ojo derecho): 1.0 (visión normal)\\n  - OI (ojo izquierdo): 0.8 (visión ligeramente reducida)\\n- Refracción clínica:\\n  - OD: -2.00, 0.50 a 90°\\n  - OI: -2.25, 0.50 a 85°\\n  - Estos valores indican miopía moderada en ambos ojos.\\n- Motilidad ocular:\\n  - Convergencia buena, sin signos de tortícolis o nistagmus.\\n- Examen de estructuras internas del ojo:\\n  - Papilas ópticas (discos ópticos) y máculas están en buen estado, con reflejos foveales normales.\\n"
    }
    '''
    // Add more JSON strings as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Parse JSON data
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final String markdownData = jsonData['data'] as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Markdown"),
      ),
      body: Container(
        color: Colors.black12,
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Markdown(
              onTapLink: (link, href, title) {},
              onTapText: () {},
              controller: controller,
              selectable: true,
              data: markdownData,
              //example,
              imageDirectory: "https://raw.githubusercontent.com",
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(color: Colors.black),
                h1: const TextStyle(color: Colors.black),
                h2: const TextStyle(color: Colors.black),
                h3: const TextStyle(color: Colors.black),
                h4: const TextStyle(color: Colors.black),
                h5: const TextStyle(color: Colors.black),
                h6: const TextStyle(color: Colors.black),
              ),
              extensionSet: md.ExtensionSet(
                md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                <md.InlineSyntax>[
                  md.EmojiSyntax(),
                  ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
