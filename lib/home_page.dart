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

  final outputMark =
      "Hi there! From the image you provided, which is an X-ray of a knee joint, here’s a simple summary of what I’m seeing. It looks like there is a notable concern where the arrow is pointing, which likely indicates some degradation or narrowing of the joint space. This can be a sign of wear and tear on the joint, possibly due to conditions like arthritis. It's important to discuss these findings with your doctor to get a full understanding and appropriate treatment.\n\nHere’s a more detailed breakdown for you:\n\n- **Positive Findings:**\n  - The overall bone density looks fairly normal, with clear visibility of the bones without signs of fractures or severe deformities.\n  - There does not appear to be any obvious signs of acute trauma or bone fractures.\n\n- **Potential Issues:**\n  - The arrow points to a narrowing of the joint space between the femur (thigh bone) and tibia (shin bone). This narrowing is often associated with osteoarthritis, where the cartilage that cushions the joint degrades over time.\n  - There may be some mild roughening or irregularity on the surfaces of the bones where they meet at the joint, which can also be indicative of arthritis.\n\n- **Recommended Actions:**\n  - **Consultation:** As always, it's essential to discuss these findings with your healthcare provider. They can perform a clinical examination and possibly recommend further imaging or tests to confirm the diagnosis.\n  - **Symptom Management:** Depending on the severity and your symptoms, treatments ranging from physical therapy, lifestyle modifications, medication to manage pain and inflammation, or even surgical options in more advanced cases might be considered. \n  - **Follow-Up:** Regular monitoring of your condition through follow-up visits and possibly additional X-rays to track any progression of the joint space narrowing.\n\nIn simple terms, it looks like your knee joint might be showing some early signs of wear, typically seen in arthritis. This means the cushioning in your joint could be thinning out, leading to bone rubbing against bone, which can cause pain and stiffness. It’s really important to have a conversation with your doctor about this so they can guide you toward the best ways to manage it and keep you moving comfortably.\n\nRemember, while this offers some insight, only your doctor can provide a true diagnosis and recommend the right treatment plan for you. This explanation aims to help you understand what might be going on with your knee better. Take care, and be sure to reach out to your healthcare provider!";

  final outputMark2 =
      "Hi there! Based on the X-ray image you’ve shared, it looks like you're dealing with a knee joint issue. The arrow points to the space where the cartilage should be cushioning the joint. It seems like there might be some thinning in that space, which could be a sign of osteoarthritis or another joint condition. Please always consult your own doctor for a precise diagnosis and personalized advice.\n\nLet's break it down:\n\n**Positive Findings:**\n- The overall alignment of the knee joint appears relatively preserved, which is a good sign.\n- The bones themselves do not show any obvious fractures or breaks.\n\n**Potential Issues:**\n- The arrow is highlighting a narrowed joint space, which may indicate cartilage wear and tear. This can cause pain, stiffness, and swelling and is commonly associated with conditions like osteoarthritis.\n- There may be some slight changes in the bone density near the joint spaces, which could be a sign of eburnation (a condition often seen in osteoarthritis where the bone becomes polished and dense).\n\n**Recommended Actions:**\n- **Consultation:** See your doctor or a specialist, like a rheumatologist or orthopedic surgeon, for a thorough examination.\n- **Imaging Review:** Your doctor might suggest additional imaging, such as an MRI, to get a clearer view of the soft tissues and cartilage.\n- **Lifestyle Adjustments:** Depending on the diagnosis, physical therapy, weight management, and low-impact exercises like swimming could help manage symptoms.\n- **Medications:** Your doctor may recommend pain relievers or anti-inflammatory medications to manage discomfort.\n\n### Simple Explanation:\nIt looks like there might be some wear and tear in your knee joint, leading to possible thinning of the cushioning cartilage. This is something often seen with aging or joint conditions like arthritis. It’s great to catch this early, and by having a chat with your doctor, you can figure out the best way to keep your knee healthy and manage any symptoms you might be having.\n\nRemember, this analysis is just to help you understand what might be going on, but it's not an official medical report. Your own doctor is the best person to give you a precise diagnosis and treatment plan. Take care and stay proactive about your health!";
  final outMark3 =
      "Hi there!\n\nBased on the X-ray image you've sent, it looks like we're examining a knee joint. The white arrow indicates a specific area of interest where there is a noticeable narrowing of the joint space. This commonly suggests some kind of cartilage degeneration, typical in conditions like osteoarthritis. Still, it's crucial to discuss these findings with your doctor for an accurate diagnosis and treatment plan.\n\n### Detailed Analysis:\n- **Positive Findings:**\n  - The bone structures are clearly visible with no signs of fracture or dislocation.\n  - The alignment of the knee joint looks normal overall.\n\n- **Potential Issues:**\n  - The arrow points to a joint space narrowing, which can be indicative of cartilage wear and tear.\n  - This could be consistent with early stages of osteoarthritis or possibly other degenerative joint diseases.\n\n- **Recommended Actions:**\n  - Schedule a consultation with your doctor to discuss the X-ray findings in detail.\n  - They may recommend further imaging like an MRI, especially if you have symptoms like pain or stiffness.\n  - Conservative management options could include physical therapy, anti-inflammatory medications, or lifestyle modifications.\n  - In more advanced cases, intervention such as injections or even surgery might be considered.\n\n### Simple Explanation:\nIn simple terms, your knee X-ray shows that the space between the bones is a bit smaller than usual in one area. This could mean the cushioning cartilage is wearing down, which often happens with age or heavy use. It’s a good idea to chat with your doctor about what this might mean for you and what can be done to keep your knee healthy and pain-free.\n\nRemember, it's always important to consult your own doctor since they have the complete picture of your health. This analysis aims to help you understand your situation better, but it is not an official medical report.\n\n**This analysis is generated using the Dr.Report App.**";

  final outMark4 =
      "Hi Hannan,\n\nThanks for sharing your dental X-ray image. Here are some positive and negative findings based on what I can see. Remember, while this analysis can give you an initial understanding, it is important to consult your own doctor or dentist for a thorough examination and personalized advice.\n\n**Summary (Easy to Understand):**\n\nYour X-ray shows a clear image of your teeth and jaw. It looks like you have most of your teeth in good alignment. However, there are a few areas to focus on: there's a noticeable dental filling on one of your lower teeth, and some crowding in the lower front teeth area. It's also important to note that your wisdom teeth appear to be present, and might need to be monitored. Please ensure to consult your dentist for a detailed examination.\n\n**Detailed Analysis:**\n\n- **Positive Findings:**\n  - Overall structure of teeth appears intact.\n  - Presence of clear dental filling, indicating previous dental care.\n  - Bone levels around teeth seem to be within normal limits.\n\n- **Potential Issues:**\n  - **Dental Filling:** Present on a lower molar; ensure regular checkups to avoid issues like decay around the filling.\n  - **Crowded Lower Front Teeth:** Could potentially cause issues with oral hygiene and alignments, such as plaque buildup or irregular wear.\n  - **Wisdom Teeth:** Appears to have wisdom teeth, which might need monitoring for potential impaction or misalignment.\n\n- **Recommended Actions:**\n  - **Regular Dental Checkups:** To monitor the condition of the filling and assess any further dental needs.\n  - **Orthodontic Consultation:** Consider consulting an orthodontist to address the crowding of the lower front teeth, which may help in preventing future complications.\n  - **Wisdom Teeth Monitoring:** Your dentist might need to evaluate the wisdom teeth to determine if they pose any threat to adjacent teeth or overall alignment.\n\n**Explanation (Easy to Understand):**\n\nIt's great to see that your teeth generally look healthy and aligned. The dental filling is a common and necessary treatment and seems to be in place correctly. However, the crowding in your lower front teeth may lead to difficulty in cleaning between them, which could potentially cause plaque and other dental issues if not addressed. The presence of your wisdom teeth is something to monitor because, in some cases, they can cause problems if they don't align properly. \n\nAlways remember to see your own dentist regularly to keep an eye on these potential issues and maintain your dental health.\n\nPlease reach out to your dentist for further personalized care.\n\n**This analysis is generated using the Dr.Report App.**";

  final outMark5 =
      "Hi David!\n\nLet's break down your reported results to give you a clearer understanding. Always remember: consulting your own doctor is crucial for an accurate and complete interpretation.\n\n### Summary (Easy to Understand Version)\n\nHey David! Here’s a snapshot of your results. The good news is that many of your tests came back normal, which is great! A few areas, like white blood cells and cholesterol, weren't tested, so make sure to ask your doctor if you need those checked. Your baseline hormones like Estradiol 17 Beta and Testosterone were tested and appear to be covered. It’s great to see that critical elements like glucose, creatinine, and your thyroid profile (T3, T4, TSH) are all being monitored. These are essential indicators for your overall health, especially metabolism and kidney function. Finally, it’s essential to follow up with your doctor to discuss anything not included in this summary to ensure comprehensive care.\n\n### Detailed Analysis\n\n#### Positive Findings\n- **Hemogram:**\n  - Hematíes, Hemoglobina, Hematocrito, Plaquetas, V.S.G are checked, which are all vital for your blood health.\n  \n- **Biochemistry:**\n  - Glucosa, Creatinina, Urea, Ác. Úrico (Uric Acid), Total Cholesterol, Triglycerides, Ferritina, GOT, GPT, GGT are listed – great for evaluating your metabolism, liver, and kidney function.\n\n- **Hormones:**\n  - Estradiol 17 Beta, Testosterona are checked, which provide a good baseline for hormonal health.\n\n- **Thyroid Profile:**\n  - T3, T4, TSH are checked, essential for thyroid function monitoring.\n\n- **Coagulation:**\n  - T. de Hemorragia, T. Coagulation, T. Prothrombin are listed, crucial for understanding your blood clotting status.\n\n- **Antibodies:**\n  - HIV, Hep B, and Hep C were checked, which are significant for overall viral health screening.\n\n- **Others:**\n  - ECG, essential for cardiac health, is checked.\n\n#### Potential Issues\n- **Incomplete Hemogram:**\n  - Leucocitos (white blood cells) and Formúla were not checked; these are important for evaluating your immune response and overall health.\n\n- **Biochemistry Gaps:**\n  - Missing key indicators like HDL, LDL (cholesterol types), Iron, Vitamin B12, and others which can give a broader picture of your nutritional and metabolic health.\n\n- **Hormone Panel Gaps:**\n  - Missing major hormones like FSH, LH, Progesterona, Prolactina, Dihidropriandrosterona, ACTH, Cortisol. These could provide a more comprehensive overview of hormonal balance.\n\n- **Coagulation Gap:**\n  - Act. De Protrrombina (Prothrombin Activity) and Fibrinogen not checked, which are vital for understanding coagulation status deeply.\n\n#### Recommendations\n- **Consult your Doctor:**\n  - Discuss gaps in tests for a comprehensive review of your health.\n- **Possible Additional Tests:**\n  - Consider checking LDL, HDL for a detailed lipid profile.\n  - Iron, Vitamin B12 for nutritional assessment.\n  - Hormone tests not marked could provide a deeper understanding of your endocrinological health.\n- **Health Monitoring:**\n  - Regular follow-ups and possibly additional tests, as advised by your doctor based on your specific health needs.\n\n### Conclusion\n\nTo sum it up, David, your tests show a pretty thorough assessment of critical health markers, but don’t hesitate to follow up on the few gaps mentioned to ensure you’re getting the full picture. Always consult your physician to discuss these findings and chart the best course for your health journey. This isn’t an official medical report, but a way to help you understand your health better!\n\nRemember, this overview is to help you make sense of your tests better, but nothing beats personalized advice from your doctor!\n\n**This analysis is generated using the Dr.Report App.**";

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
            child: Column(
              children: [
                Expanded(
                  child: Markdown(
                    onTapLink: (link, href, title) {},
                    onTapText: () {},
                    controller: controller,
                    selectable: true,
                    data: outMark5,
                    //outMark4,
                    //outMark3,
                    //outputMark2,
                    //outputMark,
                    //markdownData,
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
