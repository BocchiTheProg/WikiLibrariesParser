require 'nokogiri'
require 'open-uri'
require 'csv'

# array with libraries names (and region)
libraries = []
url = 'https://en.wikipedia.org/wiki/List_of_Libraries'
# creating Document object
doc = Nokogiri::HTML(URI.open(url))
# going through every h3 element (which is letters in Alphabet) in div element with id="bodyContent"
doc.css('div#bodyContent h3').each do |alphabet_header|
  # searching ul elements after h3
  element = alphabet_header.next_element
  loop do
    # if next element is header move to another h3 element
    break if element.name == 'h3' or element.name == 'h2'
    if element.name == 'ul'
      element.css('li').each do |library|
        # adding libraries to array
        libraries << library.text.strip
      end
    end
    # searching ul elements after h3
    element = element.next_element
  end
end

# output in CSV file
CSV.open('libraries.csv', 'w') do |csv|
  # adding header(title)
  csv << ['ID', 'Library Name (region and country)']
  id = 1
  libraries.each do  |library|
    csv << [id, library]
    id += 1
  end
end