# Veröffentlichung und Achievements

Das GitLab-Repository ist `ashwite/archivments`. Erstelle zusätzlich auf GitHub ein leeres Repository ohne automatisch erzeugte README. Wähle bewusst, ob der Quellcode öffentlich sichtbar sein soll. Für GitHub Discussions aktiviere unter **Settings → General → Features** die Option **Discussions** und richte die Kategorie **Q&A** ein.

Im Projektordner:

```sh
git init -b main
git add .
git commit -m "Set up CI Bridge"
git remote add origin https://github.com/DEIN-NAME/ci-bridge.git
git remote add gitlab https://gitlab.com/ashwite/archivments.git
git push -u origin main
git push gitlab main
```

Prüfe anschließend **Actions** auf GitHub und **Build → Pipelines** auf GitLab. GitLab benötigt einen verfügbaren Runner mit Container-Unterstützung. Für spätere Änderungen kannst du GitHub als Hauptrepo verwenden und denselben Stand nach GitLab pushen.

## GitHub

- **Pull Shark** erreichst du laut Community nach zwei gemergten eigenen PRs. Die ersten zwei Aufgaben in CONTRIBUTING.md eignen sich als separate Beiträge.
- **Pair Extraordinaire** kannst du mit einem gemeinsam geschriebenen und gemergten Commit angehen. Frag jemanden, ob ihr eine der Aufgaben zusammen umsetzt.
- **Galaxy Brain** setzt laut Community zwei akzeptierte Antworten voraus. Aktiviere Q&A und hilf bei Fragen, die bei echten Migrationen auftauchen.
- **Starstruck** beginnt laut Community bei 16 Stars auf einem eigenen Repository. Das Beispiel im README gibt Interessierten einen schnellen Einstieg.
- **Quickdraw** ist laut Community möglich, wenn du ein frisch eröffnetes Issue oder einen PR innerhalb von fünf Minuten schließt, etwa bei einem versehentlichen Duplikat.
- **YOLO** ist laut Community bei einem ohne Review gemergten eigenen PR möglich. Wenn die Regeln es erlauben, bietet sich eine kleine echte README-Korrektur an.
- **Public Sponsor** kannst du unabhängig von diesem Projekt über ein öffentliches GitHub-Sponsoring angehen.

[GitHub Community zu den Achievements](https://github.com/orgs/community/discussions/176080)

## GitLab

Maintainer oder Owner einer GitLab-Gruppe können eigene Profil-Achievements erstellen und vergeben. Für dieses Projekt passen etwa **Erste Migration**, **Erster gemergter MR** und **Neue CI-Funktion beigetragen**. Lege Kriterien fest und vergib die Auszeichnungen nach dem jeweiligen Beitrag. Empfänger müssen die Auszeichnung gegebenenfalls annehmen. Für ein Achievement einer anderen Gruppe ist deren Vergabe entscheidend.

[GitLab-Dokumentation zu Achievements](https://docs.gitlab.com/user/profile/achievements/)
