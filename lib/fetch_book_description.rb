=begin
<GoodreadsResponse>
  <Request>
    <authentication>true</authentication>
    <key>
    <![CDATA[ mWuBIYg5FalGjfc5OaYIw ]]>
    </key>
    <method>
    <![CDATA[ book_show ]]>
    </method>
  </Request>
  <book>
    <id>24830</id>
    <title>The Illustrated Man</title>
    <isbn>...</isbn>
    <isbn13>...</isbn13>
    <asin>...</asin>
    <kindle_asin>...</kindle_asin>
    <marketplace_id>...</marketplace_id>
    <country_code>...</country_code>
    <image_url>...</image_url>
    <small_image_url>...</small_image_url>
    <publication_year>2002</publication_year>
    <publication_month>8</publication_month>
    <publication_day/>
    <publisher>Voyager Classics / Harper Collins</publisher>
    <language_code>eng</language_code>
    <is_ebook>false</is_ebook>
    <description>...</description>
    <work>...</work>
    <average_rating>4.13</average_rating>
    <num_pages>...</num_pages>
    <format>...</format>
    <edition_information>...</edition_information>
    <ratings_count>...</ratings_count>
    <text_reviews_count>...</text_reviews_count>
    <url>...</url>
    <link>...</link>
    <authors>...</authors>
    <reviews_widget>...</reviews_widget>
    <popular_shelves>...</popular_shelves>
    <book_links>...</book_links>
    <buy_links>...</buy_links>
    <series_works></series_works>
    <similar_books>...</similar_books>
  </book>
</GoodreadsResponse>
=end

class FetchBookDescription

  # https://www.goodreads.com/book/show/[GOODREADS_ID].xml?key=[YOUR_API_KEY ]

  def initialize(goodreads_id)
    @id = goodreads_id
  end

  def fetch_data

  end

  def parse_xml
    # return string of book description
  end

  def save_description
    # update Book instance
  end

end
