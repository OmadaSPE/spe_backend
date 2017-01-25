require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "The description" do
    image = Image.create(:id => 1, :description => "Picture of a cat")
    image = Image.find(1)
    assert (image.description == "Picture of a cat")
  end

  test "Query" do
    image = Image.create(id: 1, description: "Picture of a cat", media_id: 1)
    Tag.create(images: [image], tag_name: "cat")
    images = Image.joins(:tags).where("tag_name = :tag_name", {tag_name: "cat"})
    assert (images.length == 1)
    assert (images.first.id == 1)
  end

end
