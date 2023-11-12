require 'nokogiri'
require 'open-uri'
require 'csv'

puts "Hello Nokogiri parser"
libraries = []
url = 'https://en.wikipedia.org/wiki/List_of_Libraries'
doc = Nokogiri::HTML(URI.open(url))
doc.css('div#bodyContent h3').each do |alphabet_header|
  element = alphabet_header.next_element
  loop do
    break if element.name == 'h3' or element.name == 'h2'
    if element.name == 'ul'
      element.css('li').each do |library|
        libraries << library.text.strip
      end
    end
    element = element.next_element
  end
end

puts libraries.size
puts libraries

CSV.open('libraries.csv', 'w') do |csv|
  libraries.each { |library| csv << [library]}
end