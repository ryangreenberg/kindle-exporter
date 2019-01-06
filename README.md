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
