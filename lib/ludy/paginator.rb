
require 'ludy/kernel/public_send' if RUBY_VERSION < '1.9.0'

module Ludy
  # which was produced by Paginator#page / Paginator#[],
  # representing page that contained target data.
  # it would use lazy fetching, whenever you need the data,
  # the fetcher would be invoked that time. whenever the data
  # was fetched, it won't fetch again. it you need refetch,
  # call Page#fetch
  class Page
    undef_method :to_a if RUBY_VERSION < '1.9.0'
    attr_reader :pager, :page
    # don't create a page instance yourself unless you have to
    def initialize pager, page; @pager, @page = pager, page; end
    # return the page instance next to this page
    def next; @pager.page(@page+1); end
    # return the page instance prev to this page
    def prev; @pager.page(@page-1); end
    # if the page numbers and the pagers are equal,
    # then the pages are equal.
    def == rhs
      @page  == rhs.instance_variable_get('@page' ) and
      @pager == rhs.instance_variable_get('@pager')
    end
    # explicitly fetch the data from pager
    def fetch; @data = @pager.fetcher[@pager.offset(@page), @pager.per_page]; end
    # get the data fetched from pager
    def data; @data ||= fetch; end
    # any other method call would delegate to the data,
    # e.g., each, to_a, map, first, method_you_defined, etc.
    def method_missing msg, *args, &block
      self.data.public_send msg, *args, &block
    end
  end
  # paginator is something help you paginate the data,
  # through the fetcher and counter you pass in.
  # e.g., for a array, the fetcher would be array[offset, per_page],
  # the counter would be array.size. and for rails' model,
  # fetcher would be Model.find :all, :offset => offset, :limit => per_page.
  # see ArrayPaginator and RailsPaginator, if you just simply need them or
  # have a look at the source code for example usage for Paginator.
  class Paginator
    include Enumerable
    attr_accessor :per_page, :fetcher, :counter
    #  fetcher is function that fetch the data,
    #  counter is function that count the data.
    # the default per_page is 20. you can reset per_page property later.
    def initialize fetcher, counter
      @per_page = 20
      @fetcher = fetcher
      @counter = counter
    end
    # if two paginators are equal, then the properties of
    # per_page, fetcher, counter are all equal.
    def == rhs
      self.per_page == rhs.per_page and
      self.fetcher  == rhs.fetcher  and
      self.counter  == rhs.counter
    end
    # for each page...
    def each; 1.upto(size){ |i| yield page(i) }; end
    # return all pages in an array
    def to_a; map{|e|e}; end
    alias_method :pages, :to_a
    # create page instance by page number.
    # if page number you specified was not existed,
    # nil would be returned. note, page start at 1, not zero.
    def page page
      offset = (page-1)*@per_page
      size = @counter.call
      return nil unless page > 0 and offset <= size
      Page.new self, page
    end
    # return the number of pages
    def size
      (@counter.call/@per_page.to_f).ceil
    end
    alias_method :[], :page
    # get the offset property about the page.
    # it is simply (page-1)*@per_page
    def offset page
      (page-1)*@per_page
    end
  end
  # rails paginator was provided for convenience,
  # it wraps Paginator for you, and you can just pass the model class to it.
  # you don't have to care about the fetcher and counter.
  # additionally, you can pass other options to rails paginator,
  # they would be used in find options. e.g.,
  #  RailsPaginator.new Model, :order => 'created_at DESC'
  # would invoke Model.find :all, :offset => ?, :limit => ?, order => 'created_at DESC'
  # TODO: conditions/options invoker...
  class RailsPaginator < Paginator
    attr_reader :model_class
    def initialize model_class, opts = {}
      @model_class = model_class
      super(lambda{ |offset, per_page|
        @model_class.find :all, opts.merge(:offset => offset, :limit => per_page)
      }, lambda{
        @model_class.count
      })
    end
  end
  # array paginator would just simply assume your data is an array,
  # and create pages simply for your_data[offset, per_page]
  # if your data is much more complex, use Paginator instead of this
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