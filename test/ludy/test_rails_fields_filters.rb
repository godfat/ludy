# -*- coding: utf-8 -*-

require './test/helper'
require 'ludy/rails_fields_filters'
require 'ludy/xhtml_formatter'

require 'rubygems'
require 'active_record'

File.delete 'tmp.sqlite3' if File.exists? 'tmp.sqlite3'

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'tmp.sqlite3'
)

ActiveRecord::Schema.define(:version => 1) do
  create_table "articles", :force => true do |t|
    t.string   "content"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end

class Article < ActiveRecord::Base
  extend Ludy::RailsFieldsFilters
  rff_filters[:before_save] << [:content, Ludy::XhtmlFormatter.method(:format_autolink)]
  rff_filters[:before_save] << [:author, :titleize.to_proc]

  rff_filters[:after_save] << [:author, [:reverse.to_proc, :downcase.to_proc]]

  rff_filters[:after_save] << [
    [:content, :author],
    [lambda{ |input|
      Ludy::XhtmlFormatter.format_article input,
        :a, :pre, :object, :img, :b, :strong, :em, :li, :ul, :ol, :i
    }, :append_id]
  ]

  rff_setup

  def append_id content
    "#{content} #{id}"
  end
end

Article.create :author => 'lin jen-shin',
               :content => '今天是我一歲生日 http://godfat.org/ 真的嗎？'

class ArticleTest < Test::Unit::TestCase
  def test_article_fixture
    target = '今天是我一歲生日 <a href="http://godfat.org/" title="http://godfat.org/">http://godfat.org/</a> 真的嗎？'

    Article.find(:first).save
    assert_equal target, Article.find(:first).content
    assert Article.find_by_content(target).id == Article.find(:first).id

    article = Article.find(:first)
    assert_equal 'Lin Jen Shin', article.author

    article.save
    assert_equal 'nihs nej nil 1', article.author
    assert_equal "#{target} 1", article.content
  end
end
