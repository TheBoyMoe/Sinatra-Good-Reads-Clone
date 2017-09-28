require 'spec_helper'

describe 'Review' do

  context 'attributes' do
    review = Review.create(
      rating: 4,
      content: 'a fantasy by a master who is as deft at generating accelerating, almost painful suspense as he is knowledgeable and accurate (and fascinating) about the technical and human details of space flight and exploration'
    )

    it "has a rating" do
      expect(review.rating).to eq(4)
    end

    it "has a book review" do
      expect(review.content).to eq('a fantasy by a master who is as deft at generating accelerating, almost painful suspense as he is knowledgeable and accurate (and fascinating) about the technical and human details of space flight and exploration')
    end
  end
end
