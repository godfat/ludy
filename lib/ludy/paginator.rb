
require 'ludy/version'
require 'ludy/kernel/public_send'
require 'singleton'

module Ludy
  # which was produced by Paginator#page / Paginator#[],
  # representing page that contained target data.
  # it would use lazy fetching, whenever you need the data,
  # the fetcher would be invoked that time. whenever the data
  # was fetched, it won't fetch again. it you need refetch,
  # call Page#fetch
  class Page
    undef_method :to_a if Ludy::ruby_before '1.9.0'
    # pager to get the original pager; page to get the number of this page
    attr_reader :pager, :page
    # don't create a page instance yourself unless you have to
    def initialize pager, page; @pager, @page = pager, page; end
    # return a null page that stubs anything to 0
    def self.null; NullPage.instance; end
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
    def fetch; @data = @pager.fetcher[self.begin, @pager.per_page]; end
    # get the data fetched from pager
    def data; @data ||= fetch; end
    # the real beginning index
    def begin; @pager.offset @page; end
    # the real ending index (need fetch, because we don't know the size)
    def end; self.begin + self.size - 1; end
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
    def initialize fetcher, counter, per_page = 20
      @per_page = per_page
      @fetcher = fetcher
      @counter = counter
    end
    # return a null pager that stubs anything to 0
    def self.null; NullPaginator.instance; end
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
      return nil unless page > 0 and offset < count
      Page.new self, page
    end
    # return the amount of pages
    def size; (count/@per_page.to_f).ceil; end
    # simply call @counter.call
    def count; @counter.call; end
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
  class RailsPaginator < Paginator
    # the model class that you passed in this paginator
    attr_reader :model_class
    def initialize model_class, per_page = 20, opts = {}
      @model_class = model_class
      super(lambda{ |offset, per_page|
        @model_class.find :all, opts.merge(:offset => offset, :limit => per_page)
      }, lambda{
        @model_class.count opts
      })
    end
    # it simply call super(page.to_i), so RailsPaginator also eat string.
    def page page; super page.to_i; end
    alias_method :[], :page
  end
  # array paginator would just simply assume your data is an array,
  # and create pages simply for your_data[offset, per_page]
  # if your data is much more complex, use Paginator instead of this
  class ArrayPaginator < Paginator
    # data that you passed in this paginator
    attr_reader :data
    def initialize data, per_page = 20
      @data = data
      super(lambda{ |offset, per_page|
        @data[offset, per_page]
      }, lambda{
        @data.size
      }, per_page)
    end
  end

  # a null page that stubs anything to 0 or [], etc.
  class NullPage < Page
    include Singleton
    def initialize; super(NullPaginator.instance, 0); end
  end
  # a null paginator that stubs any page into a null page.
  class NullPaginator < Paginator
    include Singleton
    def initialize; super(lambda{|*a|[]}, lambda{0}); end
    def page page; page == 0 ? NullPage.instance : nil; end
  end
end
