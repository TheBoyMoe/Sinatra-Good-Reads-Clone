=begin
<?xml version="1.0" encoding="UTF-8"?>
<GoodreadsResponse>
  <Request>
    <authentication>true</authentication>
      <key><![CDATA[mWuBIYg5FalGjfc5OaYIw]]></key>
    <method><![CDATA[search_index]]></method>
  </Request>
  <search>
    <query><![CDATA[the illustrated man]]></query>
      <results-start>1</results-start>
      <results-end>20</results-end>
      <total-results>763</total-results>
      <source>Goodreads</source>
      <query-time-seconds>0.25</query-time-seconds>
      <results>
        <work>
          <id type="integer">1065861</id>
          <books_count type="integer">126</books_count>
          <ratings_count type="integer">58759</ratings_count>
          <text_reviews_count type="integer">2689</text_reviews_count>
          <original_publication_year type="integer">1951</original_publication_year>
          <original_publication_month type="integer">2</original_publication_month>
          <original_publication_day type="integer">1</original_publication_day>
          <average_rating>4.13</average_rating>
          <best_book type="Book">
            <id type="integer">24830</id>
            <title>The Illustrated Man</title>
            <author>
              <id type="integer">1630</id>
              <name>Ray Bradbury</name>
            </author>
            <image_url>https://images.gr-assets.com/books/1374049820m/24830.jpg</image_url>
            <small_image_url>https://images.gr-assets.com/books/1374049820s/24830.jpg</small_image_url>
          </best_book>
        </work>

        <work>
          <id type="integer">69741</id>
          <books_count type="integer">686</books_count>
          <ratings_count type="integer">582848</ratings_count>
          <text_reviews_count type="integer">17026</text_reviews_count>
          <original_publication_year type="integer">1952</original_publication_year>
          <original_publication_month type="integer" nil="true"/>
          <original_publication_day type="integer" nil="true"/>
          <average_rating>3.73</average_rating>
          <best_book type="Book">
            <id type="integer">2165</id>
            <title>The Old Man and the Sea</title>
            <author>
              <id type="integer">1455</id>
              <name>Ernest Hemingway</name>
            </author>
            <image_url>https://images.gr-assets.com/books/1329189714m/2165.jpg</image_url>
            <small_image_url>https://images.gr-assets.com/books/1329189714s/2165.jpg</small_image_url>
          </best_book>
        </work>

        <work>
          <id type="integer">3204877</id>
          <books_count type="integer">517</books_count>
          <ratings_count type="integer">1090663</ratings_count>
          <text_reviews_count type="integer">20384</text_reviews_count>
          <original_publication_year type="integer">1932</original_publication_year>
          <original_publication_month type="integer" nil="true"/>
          <original_publication_day type="integer" nil="true"/>
          <average_rating>3.97</average_rating>
          <best_book type="Book">
            <id type="integer">25601469</id>
            <title>Brave New World (Illustrated)</title>
            <author>
              <id type="integer">3487</id>
              <name>Aldous Huxley</name>
            </author>
            <image_url>https://s.gr-assets.com/assets/nophoto/book/111x148-bcc042a9c91a29c1d680899eff700a03.png</image_url>
            <small_image_url>https://s.gr-assets.com/assets/nophoto/book/50x75-a91bf249278a81aabab721ef782c4a74.png</small_image_url>
          </best_book>
        </work>

      </results>
  </search>
</GoodreadsResponse>

=end

class FetchBookData

  # https://www.goodreads.com/search/index.xml?key=[YOUR API KEY]&q=Ender%27s+Game

  def initialize(query)
    @query = query
  end

  def fetch_data
    base_url = "https://www.goodreads.com/search/index.xml?key="
    url = "#{base_url}#{ENV['GOODREADS_API_KEY']}&q=#{@query}"
    # uri = URI.parse(url)
    # response = Net::HTTP.get_response(uri)
    # @data = response.body
    Nokogiri::XML(open(url))
  end

  def parse_xml
    # parse xml, returning an array of book instances
    doc = fetch_data
    doc.search('results work').collect do |work|
      book = {}
      book[:reviews_count] = work.search('text_reviews_count').text
      book[:ratings_count] = work.search('ratings_count').text
      book[:average_rating] = work.search('average_rating').text
      book[:publication_date] = work.search('original_publication_year').text
      book[:goodreads_id] = work.search('best_book id').text
      book[:title] = work.search('best_book title').text
      book[:author] = work.search('best_book author name').text
      book[:image_url] = work.search('best_book image_url').text
      book
    end
  end

end
