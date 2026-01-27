# Context Diagram — PW_hub

## Cel dokumentu
Ten dokument przedstawia **kontekst systemu PW_hub**: głównych użytkowników, granice systemu oraz zależności zewnętrzne, aby ułatwić analizę architektury i komunikacji między komponentami. \
Opis opiera się na wymaganiach i specyfikacji projektu.

## Kontekst systemu

### Schemat PlantUML

```plantuml
@startuml
title PW_hub - Context Diagram
skinparam shadowing false
skinparam componentStyle rectangle
skinparam defaultFontName Arial
' --- External actors (people / roles) ---
actor "Student" as Student
actor "Przedstawiciel jednostki PW /\nsamorządu / organizacji studenckiej" as Representative
actor "Administrator merytoryczny" as Admin
' --- System under design (single box) ---
rectangle "PW_hub\n(Aplikacja Companion dla PW)" as System
' --- External systems ---
rectangle "CAS USOSweb\n/ Microsoft Entra ID\n(IdP / SSO)" as IdP
rectangle "USOS API" as USOS
rectangle "Systemy CENAGIS (GiK)\n/ Dane mapowe kampusu" as CENAGIS
rectangle "Bramka powiadomień\n(e-mail / SMS / push)\n(np. Mailgun / SMS API)" as Notify
' --- Relationships: describe meaning, not technology ---
Student --> System : przegląda informacje\n(aktualności, wydarzenia, mapa)\nzarządza zapisami i preferencjami
Representative --> System : publikuje i zarządza treściami\n(aktualności, wydarzenia)\nzarządza rolami w jednostce
Admin --> System : moderuje treści\nzarządza zasadami publikacji
System --> IdP : uwierzytelnianie użytkownika\n(logowanie / SSO)
System --> USOS : pobiera informacje uczelniane\n(dane informacyjne / powiązania)\n[zakres wg MVP]
System --> CENAGIS : pobiera dane mapowe\n/ warstwy GIS
System --> Notify : wysyła powiadomienia\n(subskrypcje, zapisy, przypomnienia)
@enduml
```

### PNG for GitHub/GitLab

![PW_hub Context Diagram](assets/context_diagram.png)

## Uwagi
- Aplikacja mobilna komunikuje się z backendem przez REST API.
- Panele webowe są realizowane w Django (DTL) bez warstwy REST API, z bezpośrednim użyciem ORM.
- Integracje zewnętrzne obejmują USOS (tryb informacyjny) oraz systemy mapowe CENAGIS (GIK), przy czym dane mapowe są częściowo utrzymywane lokalnie.
- Logowanie odbywa się przez CAS USOSweb lub Microsoft Entra ID.
