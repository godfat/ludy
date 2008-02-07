
require File.join(File.dirname(__FILE__), '..', 'helper')
require 'ludy/paginator'
require 'ludy/symbol/to_proc' if RUBY_VERSION < '1.9.0'

class TestPaginator < Test::Unit::TestCase
  def self.data; @data ||= (0..100).to_a; end
  def for_pager pager
    # assume data.size is 101, data is [0,1,2,3...]
    pager.per_page = 10
    assert_equal 11, pager.size

    assert_nil pager[0]
    assert_equal((0..9).to_a, pager.page(1).to_a)
    assert_equal((10..19).to_a, pager[2].to_a)
    assert_equal(20, pager.page(3).first)
    assert_equal((90..99).to_a, pager[10].to_a)
    assert_equal([100], pager.page(11).to_a)
    assert_nil(pager.page(12))

    assert_equal(pager[1], pager[2].prev)
    assert_equal(pager.page(11), pager[10].next)
    assert_nil(pager[1].prev)
    assert_nil(pager[10].next.next)

    assert_equal pager[4].data, pager[4].fetch
    assert_equal(pager[1], pager.pages.first)
    assert_equal(pager[2], pager.to_a[1])
    assert_equal(5050, pager.inject(0){|r, i| r += i.inject(&:+) })

    assert_equal 4, pager[4].page

    assert_equal 10, pager[2].begin
    assert_equal 19, pager[2].end
    assert_equal 100, pager[11].end
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
  def test_offset_bug
    a = (0..9).to_a
    pager = ArrayPaginator.new a
    pager.per_page = 5
    assert_equal 5, pager[1].size
    assert_equal 5, pager[2].size
    assert_nil pager[3]
  end
  class Topic
    class << self
      def count opts = {}
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
