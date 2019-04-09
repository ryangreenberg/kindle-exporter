# kindle-exporter

This is a tool to scrape highlights from your [Kindle notebook](https://read.amazon.com/notebook).

## Usage

It would be nice if this script could accept your Amazon username and password and sign in automatically. However, sign in sometimes requires a CAPTCHA which I have been unable to handle simply in this script. Instead you must copy your cookie and user agent from a browser session.

1. Using Google Chrome, go to https://read.amazon.com/notebook and sign in
2. In the Network tab, check "Preserve Log" and reload the page.
3. Right click the request for "notebook", select Copy —> Copy as cURL
4. Save the request to a file, like `amazon_session`

Run `bin/export --session <your file>`

The output is stored in a directory with one JSON file per book. The source HTML is also saved for debugging.

## SQLite DB

Use `bin/sqlite` to convert the JSON highlights to a SQLite database.

## Format

Each output file will include the book's title, author, ASIN number, and a list of highlights. Highlights have the following format:

```
{
  // Arbitrary identifier
  "id": "QTMwMlUyS0pTS0Y4VU86QjAwQVlRTlI0NjozMDQ1MDpISUdITElHSFQ6YTFLSEtLODJWM0JYS1o",

  // Color of the highlight, or "note" if the entry is a freestanding note with no highlighted text
  "color": "yellow",

  // "location" or "page", depending on what the book supports
  "position_type": "location",

  // where the highlight is found
  "position": "204",

  // the highlighted text
  // will be null if the entry is a freestanding note
  "highlight": "The first step in acquiring any new skill is not being able to do your own thing but being able to reproduce what other people have done before you. This is the quickest way to mastering a skill.",

  // user-entered text about the highlight
  // will be null if there is no note associated with the highlighted text
  "note": null
},
```
