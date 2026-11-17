# Change log

This file records changes to organiccomputer.me that are not corrections: nothing a reader was told
was wrong. A correction to something a reader was told is an entry in the family corrections index,
https://www.it-help.tech/corrections/, and the page links its own entry from its footer.

This file begins with the entry below. Earlier changes are in this repository's history. Newest first.
Each heading gives the day in UTC, and the day in Los Angeles where the two differ.

## 17 November 2026: two sentences repunctuated, and the license note names the drawings

Two sentences on the site changed their punctuation, with the capital letter that follows it, and nothing
else.

- On the page and in `llms-full.txt`, the sentence about a line with no resistor at its end had a spaced
  hyphen after "more signal". It now reads: "And a line with no resistor at its end doesn't carry more
  signal. It rings: the wave reflects, returns over what is still arriving, and the receiver cannot tell
  the message from its own echo."
- On the page shown for a missing address, the sentence about an unchecked signal had a long dash after
  "echo". It now reads: "An unchecked signal can return as its own echo. Let's get you back to signal."

Why: the rule for the site's own words is no long dash, and no spaced hyphen standing in for one. The
substitute is a full stop, a colon, a comma or parentheses. Other long dashes remain on this site and are
not changed here.

`LICENSE.txt` already said that the license does not cover the drawings and marks. It now names them: the
drawings written into `index.html` as inline SVG, what `index.html` draws in CSS, and the files
`favicon.svg` and `bimi-logo.svg`.

No claim changed, so this is recorded here and not as a new entry in the corrections index. The index's
entry for this site, C-20261115-03, quotes both sentences; the change to its quotations is recorded in
that entry, with the earlier punctuation.

## 17 November 2026: narrow screens

In Chromium, the page no longer scrolls sideways at phone or tablet widths. The numbers in this entry are
Chromium's, except in the last paragraph, which says what was measured in Safari and what was not.

Before this change the document was 399 px wide in every window narrower than that (measured at 320, 375,
390 and 398 px) and 803 px wide in a window 681 to 802 px wide. After the change, the document is exactly
as wide as its window at each of 68 widths from 320 to 1920 px.

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

The numbers above are from Chromium 141 and Chrome 157 on macOS. Mobile Safari was measured separately,
before the merge, in the iOS Simulator (iOS 27.0), by comparing a frame of the page at rest with a frame
after a push to the left. In a window 375 points wide the page moved 24 px sideways before this change
and did not move with it. Not measured: a real iPhone, any tablet width in Safari, Safari on a Mac, and
a phone turned on its side.

## 16 November 2026 (UTC; 15 November in Los Angeles)

The heading of the Resistance section lost its struck-through first line. It read "Resistance is
futile." (struck through) above "Resistance is the whole point."; it now reads "Resistance is the
whole point." alone, the words that head intellectualresistance.com, with the same two words in gold.

The reason: the United States Patent and Trademark Office lists the struck phrase as registered marks
of CBS Studios Inc. for classes of merchandise. Nothing is concluded here about any use of it.

No statement of fact, claim, status label or link changed, so this is recorded here and not in the
corrections index. The style rule for the struck line is now unused and goes at the next change to the
page's style block, which this change does not touch.
