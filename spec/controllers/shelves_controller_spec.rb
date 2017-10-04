require 'spec_helper'

describe 'ShelvesController' do

  before do
    Book.destroy_all
    Book.create(title: 'The Martian Chronicles', author: 'Ray Bradbury', average_rating: 4.19, book_shelf_name: 'to_read')
    Book.create(title: 'The Illustrated Man', author: 'Ray Bradbury', average_rating: 4.00, book_shelf_name: 'reading')
    Book.create(title: 'Foundation', author: 'Isaac Asimov', average_rating: 4.23, book_shelf_name: 'to_read')
    Book.create(title: 'Second Foundation', author: 'Isaac Asimov', average_rating: 4.40, book_shelf_name: 'read')
    Book.create(title: 'Contact', author: 'Carl Sagan', average_rating: 4.23, book_shelf_name: 'to_read')
    Book.create(title: 'The Man in the High Castle', author: 'Philip K Dick', average_rating: 4.52, book_shelf_name: 'reading')
  end

  context "when the user logs in and clicks on the 'myBooks' link"
  it "fetches the users books from the database" do
    get '/'
    # TODO
  end

end
