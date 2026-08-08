To read the article, simply open [index.pdf].

If you're in the dark or use a small screen, you may prefer one of these:

|            |    A4 format   |     A5 format     |
| ---------- | -------------- | ----------------- |
| Light mode | [index.pdf]      | [index.A5.pdf]      |
| Dark mode  | [index.dark.pdf] | [index.dark.A5.pdf] |

To compile all versions, run

```
typst c index.typ index.pdf
typst c index.typ index.dark.pdf --input dark=1
typst c index.typ index.A5.pdf --input a5=1
typst c index.typ index.dark.A5.pdf --input a5=1 --input dark=1
```
