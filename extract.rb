# Return all the books found in the HTML of the given Nokogiri node
def extract_books(doc)
  book_nodes = doc.css('#kp-notebook-library .kp-notebook-library-each-book')

  book_nodes.map do |node|
    title_node = node.css('h2').first
    title = title_node.text
    asin_json = node.css('[data-get-annotations-for-asin]').first.attr('data-get-annotations-for-asin')
    asin = JSON.parse(asin_json)['asin']
    author_node = title_node.next
    author = author_node.text.sub(/^By: /, '')

    {
      title: title,
      author: author,
      asin: asin
    }
  end
end

# Return all the highlights found in the HTML of the given Nokogiri node
def extract_highlights(doc)
  highlight_nodes = doc.css('#kp-annotation-location').map {|ea| ea.parent.parent.parent }

  highlight_nodes.map do |node|
    id = node['id']

    # Highlights (with or without notes) have #annotationHighlightHeader
    # Freestanding notes have #annotationNoteHeader
    location_node = node.css('#annotationHighlightHeader, #annotationNoteHeader').first
    color_raw, location_raw = location_node.text.split(' | ')
    color = color_raw.gsub('highlight', '').strip.downcase

    location = location_raw.split(':')
    location_type = location[0].downcase.strip
    location_num = location[1].strip.downcase.gsub(/[,[:space:]]/, '')

    highlight_node = node.css('#highlight').first
    highlight_text = highlight_node ? highlight_node.text : nil
    highlight_text = nil if highlight_text && highlight_text.strip.empty?

    note_node = node.css('#note').first
    note_text = note_node ? note_node.text : nil
    note_text = nil if note_text.strip.empty?

    truncated_node = node.css('.kp-notebook-highlight-truncated').first
    is_truncated = !truncated_node.nil?

    {
      id: id,
      color: color,
      position_type: location_type,
      position: location_num,
      highlight: highlight_text,
      truncated: is_truncated,
      note: note_text,
    }
  end
end
