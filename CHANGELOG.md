# Change log

This file records changes to organiccomputer.me that are not corrections: nothing a reader was told
was wrong. A correction to something a reader was told is an entry in the family corrections index,
https://www.it-help.tech/corrections/, and the page links its own entry from its footer.

This file begins with the entry below. Earlier changes are in this repository's history. Newest first.
Each heading gives the day in UTC, and the day in Los Angeles where the two differ.

## 16 November 2026 (UTC; 15 November in Los Angeles): narrow screens

The page no longer scrolls sideways on a phone or a tablet. Measured in Chromium before this change, the
document was 399 px wide in a window 320, 375 or 390 px wide, and 803 px wide in a window 684 to 800 px wide
(eight widths measured). After it, the document is exactly as wide as the window at each of 68 widths from
320 to 1920 px.

Everything that changed is in the page's one style block:

- The specification table needs 373 px as three columns. At 640 px and below, each row takes two lines: the
  parameter beside its value, then the basis. The cells and their order are the same.
- The name and the domain tag in the header take two lines when the window is narrower than the 350 px they
  need together. The header's link row needs 953 px beside the name at full spacing: below 955 px its spacing
  tightens, and below 894 px it wraps to a second line inside the bar. From 955 px up the header is as it was.
- The four project links are full-width rows at 400 px and below.
- The price follows the width at 410 px and below, so its twelve characters stay inside their box. At 375 px
  wide it is set at 36.9 px, where it was 41.6 px and wider than the box.
- Three style rules that no element used were removed: `.resist h2 .strike`, `.hero .frus .red` and `.ohm`.

No word, number, link or image changed: the page's bytes after the style block are identical. Full-page
screenshots at 1080, 1280, 1440 and 1920 px wide are byte-for-byte the same before and after. The style
block's hash changed with the block and is pinned again in the page's own policy and in the response
header policy. This is recorded here and not in the corrections index because nothing a reader was told
changed.

The measurements are from Chromium 141 and Chrome 157. Safari was not measured.

## 16 November 2026 (UTC; 15 November in Los Angeles)

The heading of the Resistance section lost its struck-through first line. It read "Resistance is
futile." (struck through) above "Resistance is the whole point."; it now reads "Resistance is the
whole point." alone, the words that head intellectualresistance.com, with the same two words in gold.

The reason: the United States Patent and Trademark Office lists the struck phrase as registered marks
of CBS Studios Inc. for classes of merchandise. Nothing is concluded here about any use of it.

No statement of fact, claim, status label or link changed, so this is recorded here and not in the
corrections index. The style rule for the struck line is now unused and goes at the next change to the
page's style block, which this change does not touch.
