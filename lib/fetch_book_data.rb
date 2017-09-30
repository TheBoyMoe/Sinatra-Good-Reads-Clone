=begin

<?xml version="1.0" encoding="UTF-8"?>
<GoodreadsResponse>
  <Request>
    <authentication>true</authentication>
      <key><![CDATA[mWuBIYg5FalGjfc5OaYIw]]></key>
    <method><![CDATA[search_index]]></method>
  </Request>
  <search>
    <query><![CDATA[9780553278224]]></query>
    <results-start>1</results-start>
    <results-end>1</results-end>
    <total-results>1</total-results>
    <source>Goodreads</source>
    <query-time-seconds>0.01</query-time-seconds>
    <results>
      <work>
        <id type="integer">4636013</id>
        <books_count type="integer">273</books_count>
        <ratings_count type="integer">158235</ratings_count>
        <text_reviews_count type="integer">5310</text_reviews_count>
        <original_publication_year type="integer">1950</original_publication_year>
        <original_publication_month type="integer" nil="true"/>
        <original_publication_day type="integer" nil="true"/>
        <average_rating>4.12</average_rating>
        <best_book type="Book">
          <id type="integer">76778</id>
          <title>The Martian Chronicles</title>
          <author>
            <id type="integer">1630</id>
            <name>Ray Bradbury</name>
          </author>
          <image_url>https://images.gr-assets.com/books/1374049948m/76778.jpg</image_url>
          <small_image_url>https://images.gr-assets.com/books/1374049948s/76778.jpg</small_image_url>
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
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    @data = response.body
  end

  def parse_xml
    # call fetch_data

    # parse xml, returning an array of book instances
  end

end
