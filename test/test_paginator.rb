
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy/test/helper')
require 'ludy/paginator'

class TestPaginator < Test::Unit::TestCase
  def self.data; @data ||= (0..100).to_a; end
  def for_pager pager
    # assume data.size is 101, data is [0,1,2,3...]
    pager.per_page = 10

    assert_nil pager[0]
    assert_equal((0..9).to_a, pager.page(1).to_a)
    assert_equal((10..19).to_a, pager[2].to_a)
    assert_equal(20, pager.page(3).first)
    assert_equal((90..99).to_a, pager[10].to_a)
    assert_equal([100], pager.page(11).to_a)
    assert_nil(pager.page(12))

    assert_equal(pager[1], pager[2].prev_page)
    assert_equal(pager.page(11), pager[10].next_page)
    assert_nil(pager[1].prev_page)
    assert_nil(pager[10].next_page.next_page)

    assert_equal pager[4].data, pager[4].fetch
  end
  def test_basic
    pager = Ludy::Paginator.new(
    lambda{ |offset, per_page|
      # if for rails,
      # Data.find :all, :offset => offset, :limit => per_page
      TestPaginator.data[offset, per_page]
    }, lambda{
      # if for rails,
      # Data.count
      TestPaginator.data.size
    })
    for_pager pager
  end
  class Topic
    class << self
      def count
        101
      end
      def find all, opts = {}
        TestPaginator.data[opts[:offset], opts[:limit]]
      end
    end
  end
  def test_for_rails
    for_pager Ludy::RailsPaginator.new(Topic)
  end
  def test_for_array
    for_pager Ludy::ArrayPaginator.new(TestPaginator.data)
  end
end
