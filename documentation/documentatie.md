# Documentație Proiect Inginerie Software

## Tema: Clasificarea Ideologiei și Poziției Politice utilizând tehnici avansate de NLP

### Student: Morariu Alexandru-Gabriel
### An universitar: 2025-2026

---

## Cuprins

1. [Prezentarea Sistemului](#1-prezentarea-sistemului)
   - 1.1 Descrierea generală a sistemului informatic
   - 1.2 Specificarea cerințelor
   - 1.3 Diagrame detaliate ale cazurilor de utilizare
   - 1.4 Descrierea textuală a cazurilor de utilizare

2. [Analiza Sistemului - Model Analist](#2-analiza-sistemului---model-analist)
   - 2.1 Diagrame de activitate
   - 2.2 Diagrama de clase
   - 2.3 Diagrame de interacțiune
   - 2.4 Diagrame de stare (State Machine)
   - 2.5 Rafinarea diagramelor UML
   - 2.6 Diagrame de procese și colaborare în BPMN

3. [Proiectarea Sistemului](#3-proiectarea-sistemului)
   - 3.1 Diagrama de clase detaliată
   - 3.2 Proiectarea bazei de date
   - 3.3 Proiectarea interfețelor utilizator
   - 3.4 Diagrama de componente
   - 3.5 Diagrama de desfășurare

4. [Implementarea Sistemului](#4-implementarea-sistemului)
   - 4.1 Tehnologii utilizate în implementare
   - 4.2 Prezentarea pe scurt a funcționalității sistemului
   - 4.3 Sequence Diagram

---

## 1. Prezentarea Sistemului

### 1.1 Descrierea Generală a Sistemului Informatic

#### Context și Motivație

Sistemul propus reprezintă o aplicație de clasificare automată a ideologiei și poziției politice din texte, utilizând tehnici avansate de Procesare a Limbajului Natural (NLP). În contextul actual al polarizării politice și al cantității uriașe de informații disponibile online, acest sistem oferă instrumente pentru analiza obiectivă a discursului politic.

#### Scopul Sistemului

Sistemul are ca scop principal:
- **Clasificarea automată** a textelor politice pe spectrul ideologic (stânga-dreapta)
- **Identificarea poziției** pe axe multiple (economic, social, autoritar-libertarian)
- **Analiza sentimentului** și a tonului discursului politic
- **Detectarea bias-ului** în articole de presă și discursuri politice
- **Vizualizarea rezultatelor** prin grafice și rapoarte detaliate

#### Beneficiari

1. **Cercetători** în științe politice și sociale
2. **Jurnaliști** pentru verificarea obiectivității conținutului
3. **Organizații non-guvernamentale** pentru monitorizarea discursului public
4. **Instituții academice** pentru studii și analize
5. **Cetățeni informați** interesați de analiza discursului politic

#### Funcționalități Principale

| Funcționalitate | Descriere |
|-----------------|-----------|
| Clasificare Text | Clasificarea automată a textelor pe spectrul ideologic |
| Analiză Multi-dimensională | Evaluare pe multiple axe politice |
| Procesare Batch | Analiza simultană a mai multor documente |
| Vizualizare Rezultate | Grafice interactive și rapoarte |
| Export Date | Exportul rezultatelor în formate CSV, JSON, PDF |
| Istoric Analize | Salvarea și compararea analizelor anterioare |
| API REST | Interfață programatică pentru integrări externe |

### 1.2 Specificarea Cerințelor

#### Cerințe Funcționale

| ID | Cerință | Prioritate | Descriere |
|----|---------|------------|-----------|
| CF01 | Autentificare utilizatori | Obligatoriu | Sistemul trebuie să permită autentificarea utilizatorilor |
| CF02 | Încărcare text | Obligatoriu | Utilizatorii pot încărca texte pentru analiză |
| CF03 | Clasificare ideologică | Obligatoriu | Sistemul clasifică textele pe spectrul stânga-dreapta |
| CF04 | Analiză multi-axă | Obligatoriu | Clasificare pe axe: economic, social, autoritar-libertarian |
| CF05 | Vizualizare rezultate | Obligatoriu | Afișarea grafică a rezultatelor clasificării |
| CF06 | Export rezultate | Important | Exportul rezultatelor în diverse formate |
| CF07 | Istoric analize | Important | Salvarea analizelor pentru consultare ulterioară |
| CF08 | Procesare batch | Important | Analiza simultană a mai multor documente |
| CF09 | API REST | Opțional | Interfață API pentru integrări externe |
| CF10 | Comparare texte | Opțional | Compararea ideologică a mai multor texte |

#### Cerințe Non-Funcționale

| ID | Cerință | Descriere |
|----|---------|-----------|
| CNF01 | Performanță | Timpul de clasificare < 5 secunde pentru texte de până la 5000 cuvinte |
| CNF02 | Scalabilitate | Suport pentru minim 100 utilizatori concurenți |
| CNF03 | Disponibilitate | Uptime de minim 99.5% |
| CNF04 | Securitate | Criptare date sensibile, HTTPS obligatoriu |
| CNF05 | Acuratețe | Precizie clasificare > 85% pe dataset-ul de testare |
| CNF06 | Usabilitate | Interfață intuitivă, timp de învățare < 15 minute |
| CNF07 | Compatibilitate | Suport browsere moderne (Chrome, Firefox, Safari, Edge) |
| CNF08 | Multilingv | Suport pentru limba română și engleză |

#### Diagrama Cerințelor

```
Vezi fișierul: diagrams/use-cases/requirements-diagram.puml
```

### 1.3 Diagrame Detaliate ale Cazurilor de Utilizare

#### Actori Principali

| Actor | Descriere |
|-------|-----------|
| Utilizator Anonim | Poate accesa funcționalități de bază fără autentificare |
| Utilizator Autentificat | Are acces la toate funcționalitățile sistemului |
| Administrator | Gestionează utilizatorii și configurația sistemului |
| Sistem NLP | Componentă externă care procesează textele |

#### Cazuri de Utilizare Principale

```
Vezi fișierul: diagrams/use-cases/main-use-cases.puml
```

### 1.4 Descrierea Textuală a Cazurilor de Utilizare

#### UC01: Clasificare Text

| Element | Descriere |
|---------|-----------|
| **Nume** | Clasificare Text |
| **Actor Principal** | Utilizator Autentificat |
| **Precondiții** | Utilizatorul este autentificat în sistem |
| **Postcondiții** | Textul este clasificat și rezultatele sunt afișate |
| **Scenariu Principal** | 1. Utilizatorul accesează pagina de clasificare<br>2. Utilizatorul introduce/încarcă textul<br>3. Utilizatorul selectează opțiunile de analiză<br>4. Sistemul procesează textul cu modelul NLP<br>5. Sistemul afișează rezultatele clasificării<br>6. Utilizatorul vizualizează graficele și rapoartele |
| **Scenarii Alternative** | 3a. Textul este prea scurt: Sistemul afișează eroare<br>4a. Eroare procesare: Sistemul notifică utilizatorul |
| **Excepții** | Serviciul NLP indisponibil: Afișare mesaj de eroare |

#### UC02: Autentificare Utilizator

| Element | Descriere |
|---------|-----------|
| **Nume** | Autentificare Utilizator |
| **Actor Principal** | Utilizator Anonim |
| **Precondiții** | Utilizatorul are un cont creat în sistem |
| **Postcondiții** | Utilizatorul este autentificat și redirecționat la dashboard |
| **Scenariu Principal** | 1. Utilizatorul accesează pagina de login<br>2. Utilizatorul introduce credențialele<br>3. Sistemul validează credențialele<br>4. Sistemul creează sesiunea<br>5. Utilizatorul este redirecționat la dashboard |
| **Scenarii Alternative** | 3a. Credențiale invalide: Afișare mesaj eroare<br>3b. Cont blocat: Afișare mesaj și instrucțiuni |
| **Excepții** | Serviciu indisponibil: Afișare mesaj de eroare |

#### UC03: Vizualizare Istoric Analize

| Element | Descriere |
|---------|-----------|
| **Nume** | Vizualizare Istoric Analize |
| **Actor Principal** | Utilizator Autentificat |
| **Precondiții** | Utilizatorul este autentificat și are analize anterioare |
| **Postcondiții** | Utilizatorul vizualizează lista analizelor anterioare |
| **Scenariu Principal** | 1. Utilizatorul accesează secțiunea "Istoric"<br>2. Sistemul afișează lista analizelor<br>3. Utilizatorul poate filtra și căuta<br>4. Utilizatorul selectează o analiză<br>5. Sistemul afișează detaliile analizei |
| **Scenarii Alternative** | 2a. Nu există analize: Afișare mesaj informativ |

#### UC04: Export Rezultate

| Element | Descriere |
|---------|-----------|
| **Nume** | Export Rezultate |
| **Actor Principal** | Utilizator Autentificat |
| **Precondiții** | Există rezultate de clasificare disponibile |
| **Postcondiții** | Fișierul exportat este descărcat |
| **Scenariu Principal** | 1. Utilizatorul vizualizează rezultatele unei analize<br>2. Utilizatorul selectează opțiunea "Export"<br>3. Utilizatorul alege formatul (PDF/CSV/JSON)<br>4. Sistemul generează fișierul<br>5. Fișierul este descărcat automat |
| **Scenarii Alternative** | 4a. Eroare generare: Afișare mesaj și retry |

#### UC05: Administrare Utilizatori

| Element | Descriere |
|---------|-----------|
| **Nume** | Administrare Utilizatori |
| **Actor Principal** | Administrator |
| **Precondiții** | Administratorul este autentificat |
| **Postcondiții** | Modificările sunt salvate în sistem |
| **Scenariu Principal** | 1. Administratorul accesează panoul de administrare<br>2. Administratorul vizualizează lista utilizatorilor<br>3. Administratorul selectează un utilizator<br>4. Administratorul modifică datele/permisiunile<br>5. Sistemul salvează modificările |
| **Scenarii Alternative** | 4a. Ștergere utilizator: Confirmare și ștergere |

---

## 2. Analiza Sistemului - Model Analist

### 2.1 Diagrame de Activitate

#### AD01: Proces de Clasificare Text

Diagrama de activitate pentru procesul principal de clasificare a textului:

```
Vezi fișierul: diagrams/activity/text-classification-activity.puml
```

**Descriere:**
1. Utilizatorul introduce textul
2. Sistemul validează input-ul
3. Textul este pre-procesat (tokenizare, normalizare)
4. Modelul NLP efectuează clasificarea
5. Rezultatele sunt post-procesate
6. Rezultatele sunt afișate utilizatorului

#### AD02: Proces de Autentificare

```
Vezi fișierul: diagrams/activity/authentication-activity.puml
```

#### AD03: Proces de Procesare Batch

```
Vezi fișierul: diagrams/activity/batch-processing-activity.puml
```

### 2.2 Diagrama de Clase (Analiză)

#### Clase Principale Identificate

| Clasă | Responsabilitate |
|-------|------------------|
| User | Gestionarea datelor utilizatorului |
| TextAnalysis | Reprezentarea unei analize de text |
| ClassificationResult | Rezultatele clasificării |
| NLPModel | Interfața cu modelul de machine learning |
| PoliticalSpectrum | Reprezentarea spectrului politic |
| AnalysisHistory | Istoricul analizelor unui utilizator |

```
Vezi fișierul: diagrams/class/analysis-class-diagram.puml
```

### 2.3 Diagrame de Interacțiune

#### Diagrama de Secvență - Clasificare Text

```
Vezi fișierul: diagrams/interaction/classification-sequence.puml
```

#### Diagrama de Comunicare - Autentificare

```
Vezi fișierul: diagrams/interaction/authentication-communication.puml
```

### 2.4 Diagrame de Stare (State Machine)

#### SM01: Stările unei Analize

| Stare | Descriere |
|-------|-----------|
| Inițializată | Analiza a fost creată |
| În Procesare | Textul este procesat de NLP |
| Completată | Clasificarea s-a finalizat cu succes |
| Eșuată | A apărut o eroare în procesare |
| Arhivată | Analiza a fost arhivată |

```
Vezi fișierul: diagrams/state-machine/analysis-state.puml
```

#### SM02: Stările Utilizatorului

```
Vezi fișierul: diagrams/state-machine/user-state.puml
```

### 2.5 Rafinarea Diagramelor UML

În această secțiune sunt prezentate versiunile rafinate ale diagramelor anterioare, cu detalii suplimentare și optimizări:

- Adăugarea atributelor și metodelor complete în clasele
- Specificarea tipurilor de date
- Definirea multiplicităților pentru asocieri
- Adăugarea stereotipurilor

```
Vezi fișierele din: diagrams/class/refined/
```

### 2.6 Diagrame de Procese și Colaborare în BPMN

#### BPMN01: Proces Principal de Analiză

```
Vezi fișierul: diagrams/bpmn/main-analysis-process.bpmn
```

#### BPMN02: Proces de Onboarding Utilizator

```
Vezi fișierul: diagrams/bpmn/user-onboarding.bpmn
```

---

## 3. Proiectarea Sistemului

### 3.1 Diagrama de Clase Detaliată

#### Arhitectura pe Straturi

Sistemul folosește o arhitectură pe 3 straturi:
1. **Stratul de Prezentare** - Interfața utilizator (React/Next.js)
2. **Stratul de Business Logic** - API și servicii (Python/FastAPI)
3. **Stratul de Date** - Baza de date și modele ML

```
Vezi fișierul: diagrams/class/detailed-class-diagram.puml
```

#### Clase Detaliate

##### User
```
- id: UUID
- email: String
- password_hash: String
- name: String
- role: UserRole
- created_at: DateTime
- last_login: DateTime
+ authenticate(password): Boolean
+ updateProfile(data): User
+ getAnalysisHistory(): List<TextAnalysis>
```

##### TextAnalysis
```
- id: UUID
- user_id: UUID
- text: String
- language: String
- created_at: DateTime
- status: AnalysisStatus
- result: ClassificationResult
+ process(): ClassificationResult
+ export(format): File
+ archive(): void
```

##### ClassificationResult
```
- id: UUID
- analysis_id: UUID
- left_right_score: Float
- auth_lib_score: Float
- economic_score: Float
- social_score: Float
- confidence: Float
- keywords: List<String>
+ getSpectrum(): PoliticalSpectrum
+ toJSON(): String
+ toPDF(): File
```

##### NLPService
```
- model: TransformerModel
- tokenizer: Tokenizer
+ classify(text): ClassificationResult
+ preprocess(text): ProcessedText
+ postprocess(raw_result): ClassificationResult
+ batchClassify(texts): List<ClassificationResult>
```

### 3.2 Proiectarea Bazei de Date

#### Diagrama Entitate-Relație

```
Vezi fișierul: database/er-diagram.puml
```

#### Schema Bazei de Date

##### Tabela: users
| Coloană | Tip | Constrângeri |
|---------|-----|--------------|
| id | UUID | PRIMARY KEY |
| email | VARCHAR(255) | UNIQUE, NOT NULL |
| password_hash | VARCHAR(255) | NOT NULL |
| name | VARCHAR(100) | NOT NULL |
| role | ENUM | DEFAULT 'user' |
| created_at | TIMESTAMP | DEFAULT NOW() |
| last_login | TIMESTAMP | |

##### Tabela: text_analyses
| Coloană | Tip | Constrângeri |
|---------|-----|--------------|
| id | UUID | PRIMARY KEY |
| user_id | UUID | FOREIGN KEY → users |
| text_content | TEXT | NOT NULL |
| language | VARCHAR(10) | DEFAULT 'ro' |
| status | ENUM | DEFAULT 'pending' |
| created_at | TIMESTAMP | DEFAULT NOW() |
| updated_at | TIMESTAMP | |

##### Tabela: classification_results
| Coloană | Tip | Constrângeri |
|---------|-----|--------------|
| id | UUID | PRIMARY KEY |
| analysis_id | UUID | FOREIGN KEY → text_analyses |
| left_right_score | DECIMAL(5,4) | |
| auth_lib_score | DECIMAL(5,4) | |
| economic_score | DECIMAL(5,4) | |
| social_score | DECIMAL(5,4) | |
| confidence | DECIMAL(5,4) | |
| keywords | JSONB | |
| created_at | TIMESTAMP | DEFAULT NOW() |

##### Tabela: analysis_history
| Coloană | Tip | Constrângeri |
|---------|-----|--------------|
| id | UUID | PRIMARY KEY |
| user_id | UUID | FOREIGN KEY → users |
| analysis_id | UUID | FOREIGN KEY → text_analyses |
| accessed_at | TIMESTAMP | DEFAULT NOW() |

#### Script SQL pentru Creare Tabele

```
Vezi fișierul: database/schema.sql
```

### 3.3 Proiectarea Interfețelor Utilizator

#### Wireframes

1. **Pagina de Login** - `ui-mockups/login.png`
2. **Dashboard Principal** - `ui-mockups/dashboard.png`
3. **Pagina de Clasificare** - `ui-mockups/classification.png`
4. **Vizualizare Rezultate** - `ui-mockups/results.png`
5. **Istoric Analize** - `ui-mockups/history.png`
6. **Panou Administrare** - `ui-mockups/admin.png`

#### Descrierea Interfețelor

##### Pagina de Login
- Câmp email
- Câmp parolă
- Buton "Autentificare"
- Link "Am uitat parola"
- Link "Creare cont nou"

##### Dashboard Principal
- Header cu navigare și profil utilizator
- Statistici rezumative (număr analize, ultima analiză)
- Acces rapid la funcționalități principale
- Analize recente

##### Pagina de Clasificare
- Zona de input text (textarea sau upload fișier)
- Selector limbă
- Opțiuni avansate (colapsabile)
- Buton "Analizează"
- Indicator de progres

##### Vizualizare Rezultate
- Grafic radar pentru scoruri multi-dimensionale
- Poziție pe compas politic
- Lista cuvintelor cheie identificate
- Nivel de încredere
- Opțiuni de export

```
Vezi fișierele din: ui-mockups/
```

### 3.4 Diagrama de Componente

#### Componente Principale

| Componentă | Descriere |
|------------|-----------|
| Web Frontend | Aplicație React/Next.js |
| API Gateway | Punct de intrare pentru toate request-urile |
| Auth Service | Serviciu de autentificare și autorizare |
| Analysis Service | Serviciu principal de analiză |
| NLP Engine | Motor de procesare NLP |
| Database | PostgreSQL pentru persistență |
| Cache | Redis pentru caching |
| File Storage | Stocare fișiere exportate |

```
Vezi fișierul: diagrams/component/component-diagram.puml
```

### 3.5 Diagrama de Desfășurare (Deployment)

#### Infrastructură

Sistemul este proiectat pentru deployment în cloud (AWS/Azure/GCP):

| Nod | Componente |
|-----|------------|
| Load Balancer | Distribuție trafic, SSL termination |
| Web Server (x2) | Frontend Next.js |
| API Server (x2) | FastAPI backend |
| ML Server | Model NLP, GPU enabled |
| Database Server | PostgreSQL primary + replica |
| Cache Server | Redis cluster |
| Storage | S3/Blob storage pentru fișiere |

```
Vezi fișierul: diagrams/deployment/deployment-diagram.puml
```

---

## 4. Implementarea Sistemului

### 4.1 Tehnologii Utilizate în Implementare

#### Backend

| Tehnologie | Versiune | Scop |
|------------|----------|------|
| Python | 3.11+ | Limbaj de programare principal |
| FastAPI | 0.104+ | Framework web API |
| PyTorch | 2.1+ | Framework machine learning |
| Transformers | 4.35+ | Modele NLP pre-antrenate |
| SQLAlchemy | 2.0+ | ORM pentru baza de date |
| Pydantic | 2.5+ | Validare date |
| Redis | 7.2+ | Caching și sesiuni |
| PostgreSQL | 16+ | Bază de date relațională |

#### Frontend

| Tehnologie | Versiune | Scop |
|------------|----------|------|
| TypeScript | 5.3+ | Limbaj de programare |
| Next.js | 14+ | Framework React |
| React | 18+ | Bibliotecă UI |
| TailwindCSS | 3.4+ | Stilizare |
| Chart.js | 4.4+ | Vizualizări grafice |
| Axios | 1.6+ | Client HTTP |

#### DevOps

| Tehnologie | Scop |
|------------|------|
| Docker | Containerizare |
| Docker Compose | Orchestrare locală |
| GitHub Actions | CI/CD |
| AWS/Azure | Cloud hosting |

### 4.2 Prezentarea pe Scurt a Funcționalității Sistemului

#### Fluxul Principal

1. **Autentificare**: Utilizatorul se autentifică în sistem
2. **Input Text**: Utilizatorul introduce sau încarcă textul pentru analiză
3. **Procesare**: Sistemul procesează textul prin pipeline-ul NLP
4. **Clasificare**: Modelul clasifică textul pe multiple dimensiuni politice
5. **Vizualizare**: Rezultatele sunt afișate grafic și textual
6. **Export**: Utilizatorul poate exporta rezultatele

#### Arhitectura Sistemului

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Frontend  │────▶│  API Gateway │────▶│  Services   │
│  (Next.js)  │     │  (FastAPI)  │     │ (NLP, Auth) │
└─────────────┘     └─────────────┘     └─────────────┘
                                               │
                    ┌─────────────┐     ┌──────▼──────┐
                    │    Cache    │◀────│  Database   │
                    │   (Redis)   │     │ (PostgreSQL)│
                    └─────────────┘     └─────────────┘
```

#### Modelul NLP

Sistemul utilizează un model Transformer (BERT/RoBERTa) fine-tuned pentru:
- Clasificare ideologică stânga-dreapta
- Clasificare autoritar-libertarian
- Analiză sentiment politic
- Extragere cuvinte cheie

### 4.3 Sequence Diagram - Implementare

#### SD01: Flux Complet de Clasificare

```
Vezi fișierul: diagrams/sequence/full-classification-sequence.puml
```

#### SD02: Proces de Autentificare

```
Vezi fișierul: diagrams/sequence/authentication-sequence.puml
```

#### SD03: Export Rezultate

```
Vezi fișierul: diagrams/sequence/export-sequence.puml
```

---

## Anexe

### A. Glosar de Termeni

| Termen | Definiție |
|--------|-----------|
| NLP | Natural Language Processing - Procesarea Limbajului Natural |
| Spectru politic | Reprezentare a poziționării ideologice |
| Transformer | Arhitectură de rețea neuronală pentru NLP |
| Fine-tuning | Adaptarea unui model pre-antrenat |
| Tokenizare | Împărțirea textului în unități de procesare |

### B. Referințe

1. Vaswani et al., "Attention Is All You Need", 2017
2. Devlin et al., "BERT: Pre-training of Deep Bidirectional Transformers", 2019
3. Political Compass Methodology
4. UML 2.5 Specification, OMG

### C. Lista Fișierelor Proiect

```
inginerie-software-proiect/
├── documentatie.md
├── diagrams/
│   ├── use-cases/
│   │   ├── main-use-cases.puml
│   │   └── requirements-diagram.puml
│   ├── activity/
│   │   ├── text-classification-activity.puml
│   │   ├── authentication-activity.puml
│   │   └── batch-processing-activity.puml
│   ├── class/
│   │   ├── analysis-class-diagram.puml
│   │   ├── detailed-class-diagram.puml
│   │   └── refined/
│   ├── interaction/
│   │   ├── classification-sequence.puml
│   │   └── authentication-communication.puml
│   ├── state-machine/
│   │   ├── analysis-state.puml
│   │   └── user-state.puml
│   ├── bpmn/
│   │   ├── main-analysis-process.bpmn
│   │   └── user-onboarding.bpmn
│   ├── component/
│   │   └── component-diagram.puml
│   ├── deployment/
│   │   └── deployment-diagram.puml
│   └── sequence/
│       ├── full-classification-sequence.puml
│       ├── authentication-sequence.puml
│       └── export-sequence.puml
├── database/
│   ├── er-diagram.puml
│   └── schema.sql
├── ui-mockups/
│   ├── login.html
│   ├── dashboard.html
│   ├── classification.html
│   ├── results.html
│   └── history.html
└── README.md
```

---

*Document generat pentru proiectul de Inginerie Software*
*Tema: Clasificarea Ideologiei și Poziției Politice utilizând tehnici avansate de NLP*

