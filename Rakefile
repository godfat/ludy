# encoding: utf-8

require "#{dir = File.dirname(__FILE__)}/task/gemgem"
Gemgem.dir = dir

($LOAD_PATH << File.expand_path("#{Gemgem.dir}/lib" )).uniq!

require 'ludy'
require 'ludy/tasks'

desc 'Generate gemspec'
task 'gem:spec' do
  Gemgem.spec = Gemgem.create do |s|
    s.name        = 'ludy'
    s.version     = Ludy::VERSION
    s.executables = [s.name]
  end

  Gemgem.write
end
