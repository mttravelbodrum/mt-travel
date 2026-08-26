This site uses Google Fonts (Plus Jakarta Sans + Inter), loaded via a
CDN link in the <head> of every page — see assets/css/variables.css for
the font names and any page's <head> for the <link> tag.

This folder exists (as requested in the project structure) for anyone
who later wants to self-host the font files instead — for example for
GDPR reasons, offline use, or to shave off the external request. To do
that: download the .woff2 files for Plus Jakarta Sans and Inter, place
them here, add an @font-face block to variables.css, and remove the
Google Fonts <link> tags from each page's <head>.
