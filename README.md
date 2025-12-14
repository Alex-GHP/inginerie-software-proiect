# Proiect Inginerie Software

## Tema: Clasificarea Ideologiei si Pozitiei Politice utilizand tehnici avansate de NLP

### Student: [Numele Studentului]
### Curs: Inginerie Software
### An Universitar: 2024-2025

---

## Descriere Proiect

Acest proiect reprezinta documentatia completa pentru sistemul de clasificare automata a ideologiei si pozitiei politice din texte, utilizand tehnici avansate de Procesare a Limbajului Natural (NLP).

Sistemul permite:
- Clasificarea textelor pe spectrul politic stanga-dreapta
- Identificarea pozitiei pe axe multiple (economic, social, autoritar-libertarian)
- Extragerea cuvintelor cheie din textele analizate
- Vizualizarea rezultatelor prin grafice interactive

---

## Structura Proiectului

```
inginerie-software-proiect/
├── documentatie.md              # Documentatia principala
├── README.md                    # Acest fisier
│
├── diagrams/                    # Diagrame UML
│   ├── use-cases/              # Diagrame cazuri de utilizare
│   │   ├── main-use-cases.puml
│   │   └── requirements-diagram.puml
│   │
│   ├── activity/               # Diagrame de activitate
│   │   ├── text-classification-activity.puml
│   │   ├── authentication-activity.puml
│   │   └── batch-processing-activity.puml
│   │
│   ├── class/                  # Diagrame de clase
│   │   ├── analysis-class-diagram.puml
│   │   └── detailed-class-diagram.puml
│   │
│   ├── interaction/            # Diagrame de interactiune
│   │   ├── classification-sequence.puml
│   │   └── authentication-communication.puml
│   │
│   ├── state-machine/          # Diagrame de stare
│   │   ├── analysis-state.puml
│   │   └── user-state.puml
│   │
│   ├── bpmn/                   # Diagrame BPMN
│   │   ├── main-analysis-process.puml
│   │   └── user-onboarding.puml
│   │
│   ├── component/              # Diagrama de componente
│   │   └── component-diagram.puml
│   │
│   ├── deployment/             # Diagrama de desfasurare
│   │   └── deployment-diagram.puml
│   │
│   └── sequence/               # Diagrame de secventa
│       ├── full-classification-sequence.puml
│       ├── authentication-sequence.puml
│       └── export-sequence.puml
│
├── database/                   # Design baza de date
│   ├── er-diagram.puml
│   └── schema.sql
│
└── ui-mockups/                 # Mockup-uri interfata
    ├── login.html
    ├── dashboard.html
    ├── classification.html
    ├── results.html
    └── history.html
```

---

## Instructiuni de Vizualizare

### Diagrame PlantUML

Toate diagramele UML sunt create in format PlantUML (.puml). Pentru a le vizualiza:

1. **Online**: Folositi [PlantUML Web Server](http://www.plantuml.com/plantuml/uml/)
   - Copiati continutul fisierului .puml
   - Lipiti-l in editor
   - Diagrama se va genera automat

2. **VS Code**: Instalati extensia "PlantUML"
   - Deschideti fisierul .puml
   - Apasati Alt+D pentru preview

3. **Export local**: Instalati PlantUML si Java
   ```bash
   plantuml diagrams/**/*.puml
   ```

### Mockup-uri UI

Mockup-urile sunt create ca fisiere HTML standalone. Pentru vizualizare:
1. Deschideti fisierele .html direct in browser
2. Necesita conexiune internet pentru Tailwind CSS CDN

---

## Diagrame Incluse

### 1. Prezentarea Sistemului
- Descrierea generala a sistemului
- Specificarea cerintelor (requirements-diagram.puml)
- Diagrame detaliate ale cazurilor de utilizare (main-use-cases.puml)
- Descrierea textuala a cazurilor de utilizare

### 2. Analiza Sistemului
- Diagrame de activitate (3 diagrame)
- Diagrama de clase - nivel analiza
- Diagrame de interactiune (secventa + comunicare)
- Diagrame de stare (2 diagrame)
- Diagrame BPMN (2 diagrame)

### 3. Proiectarea Sistemului
- Diagrama de clase detaliata (arhitectura pe straturi)
- Proiectarea bazei de date (ER + Schema SQL)
- Proiectarea interfetelor utilizator (5 mockup-uri)
- Diagrama de componente
- Diagrama de desfasurare

### 4. Implementarea Sistemului
- Sequence diagram complet
- Tehnologii utilizate
- Prezentarea functionalitatii

---

## Tehnologii Utilizate in Sistem

### Backend
- Python 3.11+
- FastAPI
- PyTorch / Transformers
- PostgreSQL
- Redis

### Frontend
- Next.js 14
- React 18
- TypeScript
- Tailwind CSS
- Chart.js

### DevOps
- Docker
- Kubernetes
- GitHub Actions

---

## Contact

Pentru intrebari sau clarificari:
- Email: [email student]
- Profesor coordonator: marius.rogobete@yahoo.com

---

*Proiect realizat pentru cursul de Inginerie Software*

