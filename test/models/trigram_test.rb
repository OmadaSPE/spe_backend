require 'test_helper'

class TrigramTest < ActiveSupport::TestCase
  test "fuzzy" do
      Tag.create(tag_name: "crazy cat")
      print Tag.find_by_fuzzy_tag_name('cray')
  end
end
