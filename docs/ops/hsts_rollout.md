# Wdrożenie i Walidacja HSTS (HTTP Strict Transport Security)

Dokument opisuje plan bezpiecznego, stopniowego podnoszenia wartości nagłówka `Strict-Transport-Security` (HSTS) w środowisku produkcyjnym PW_hub.

## Cel
Zwiększenie bezpieczeństwa poprzez wymuszenie na przeglądarkach łączenia się z domeną wyłącznie przez HTTPS. Docelowa wartość `max-age` to 1 rok (31536000 sekund).

## Konfiguracja
Wartość HSTS jest sterowana zmienną środowiskową w konfiguracji Django (`production.py`).

| Zmienna | Domyślnie | Opis |
|---------|-----------|------|
| `DJANGO_SECURE_HSTS_SECONDS` | `60` | Czas w sekundach (max-age). Ustaw `0` aby wyłączyć. |
| `DJANGO_SECURE_HSTS_INCLUDE_SUBDOMAINS` | `True` | Czy obejmować subdomeny. Wymaga weryfikacji wszystkich subdomen. |
| `DJANGO_SECURE_HSTS_PRELOAD` | `True` | Czy zezwalać na preload (wymaga długiego max-age i subdomains). |

## Harmonogram Wdrożenia (Rollout)

Ze względu na ryzyko ("klejenie się" HSTS w cache przeglądarki), wartość podnosimy etapami. Przejście do kolejnego etapu następuje po weryfikacji braku błędów (mixed content, problemy z certyfikatami).

1.  **Etap A (Start):** 60 sekund (weryfikacja mechanizmu). Czas trwania: 24-48h.
2.  **Etap B:** 1 godzina (`3600`). Czas trwania: 3-7 dni.
3.  **Etap C:** 1 dzień (`86400`). Czas trwania: 1-2 tygodnie.
4.  **Etap D:** 1 tydzień (`604800`). Czas trwania: 2-4 tygodnie.
5.  **Etap E:** 30 dni (`2592000`). Czas trwania: 4-8 tygodni.
6.  **Etap F (Docelowy):** 1 rok (`31536000`).

## Procedura Weryfikacji (Checklist)

Przed każdym podniesieniem wartości wykonaj:

1.  **Test HTTPS:**
    ```bash
    curl -I https://hub.pw.edu.pl
    ```
    Oczekiwany nagłówek: `Strict-Transport-Security: max-age=...; includeSubDomains; preload`

2.  **Brak HTTP:** Upewnij się, że ruch na porcie 80 jest przekierowywany (301/308) na HTTPS.
3.  **Subdomeny:** Zweryfikuj, czy wszystkie subdomeny (jeśli istnieją i są objęte certyfikatem wildcard lub SAN) działają poprawnie po HTTPS.
4.  **Mixed Content:** Sprawdź konsolę przeglądarki pod kątem błędów ładowania zasobów (skrypty, style, obrazy) po HTTP.

## Ryzyka i Rollback

*   **Ryzyko:** Jeśli HSTS zostanie włączony z długim czasem, a certyfikat wygaśnie lub wystąpi problem z konfiguracją SSL, użytkownicy nie będą mogli wejść na stronę przez ten czas (brak możliwości kliknięcia "Zaawansowane -> Kontynuuj").
*   **Rollback:** Zmniejszenie `DJANGO_SECURE_HSTS_SECONDS` do `0` lub małej wartości.
    *   *Uwaga:* Użytkownicy, którzy już odwiedzili stronę, będą mieli zachowaną starą (długą) wartość do czasu jej wygaśnięcia lub wyczyszczenia cache. Dlatego powolny rollout jest kluczowy.

## Kontakt
Właścicielem infrastruktury i procesu wdrożenia jest CI PW. Wszelkie zmiany wartości należy konsultować z zespołem DevOps.
