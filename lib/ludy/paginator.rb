
require 'ludy/kernel/public_send'

module Ludy
  # which was produced by Paginator#page / Paginator#[],
  # representing page that contained target data.
  # it would use lazy fetching, whenever you need the data,
  # the fetcher would be invoked that time. whenever the data
  # was fetched, it won't fetch again. it you need refetch,
  # call Page#fetch
  class Page
    undef_method :to_a if RUBY_VERSION < '1.9.0'
    def initialize pager, page; @pager, @page = pager, page; end
    def next_page; @pager.page(@page+1); end
    def prev_page; @pager.page(@page-1); end
    def == rhs
      @page  == rhs.instance_variable_get('@page' ) and
      @pager == rhs.instance_variable_get('@pager')
    end
    def fetch; @data = @pager.fetcher[@pager.offset(@page), @pager.per_page]; end
    def data; @data ||= fetch; end
    def method_missing msg, *args, &block
      self.data.public_send msg, *args, &block
    end
  end
  class Paginator
    attr_accessor :per_page, :fetcher, :counter
    def initialize fetcher, counter
      @per_page = 20
      @fetcher = fetcher
      @counter = counter
    end
    def == rhs
      self.per_page == rhs.per_page and
      self.fetcher  == rhs.fetcher  and
      self.counter  == rhs.counter
    end
    def page page
      offset = (page-1)*@per_page
      size = @counter.call
      return nil unless page > 0 and offset <= size
      Page.new self, page
    end
    alias_method :[], :page
    def offset page
      (page-1)*@per_page
    end
  end
  class RailsPaginator < Paginator
    attr_reader :model_class
    def initialize model_class
      @model_class = model_class
      super(lambda{ |offset, per_page|
        @model_class.find :all, :offset => offset, :limit => per_page
      }, lambda{
        @model_class.count
      })
    end
  end
  class ArrayPaginator < Paginator
    attr_reader :data
    def initialize data
      @data = data
      super(lambda{ |offset, per_page|
        @data[offset, per_page]
      }, lambda{
        @data.size
      })
    end
  end
end
