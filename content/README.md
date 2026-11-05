# Website content

Everything in this folder is markdown that ends up on the website.
Add a file and it appears on the site after the next push to `main`. No HTML needed.

| What | Where | Order on the page |
|---|---|---|
| Steering committee member | `committee/NN-name.md` | by number (`01-`, `02-`, …) |
| News item | `news/YYYY-MM-DD-slug.md` | newest first (by file name) |
| Event | `events/YYYY-MM-DD-slug.md` | newest first (by file name) |
| Mission text | `mission.md` | — |

Images go in `website/images/` and are referenced as `images/file.png`.

## New committee member — `committee/13-jane.md`

```markdown
---
id: jane                      # unique, letters only
name: Dr Jane Doe             # shown on the card
short_name: Jane Doe          # shown as popup heading and image alt text
role: Education
institution: Some University, Country
image: images/JaneDoe.jpg
---

Bio text in markdown. *Italics*, [links](https://example.org), lists etc. all work.
```

## News item — `news/2026-11-05-something.md`

```markdown
---
title: Something happened
date: 5th November 2026       # displayed as written
---

The news text.
```

## Event — `events/2026-12-03-seminar.md`

```markdown
---
title: RN4CB Seminar December 2026
---

Details, registration link, times…

![Flyer description](images/DecemberFlyer.png)
```

Raw HTML is allowed inside markdown if you need something special.

## Preview locally

Requires [pandoc](https://pandoc.org/installing.html). From the repository root:

```sh
./build.sh          # writes _site/index.html
```

and open `_site/index.html` in a browser.
The page layout itself lives in `website/index.html` (plain HTML; lines like
`<!-- each content/news/*.md templates/news.html -->` mark where markdown is inserted)
and the card/popup HTML in `templates/`.
