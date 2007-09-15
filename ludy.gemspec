#!/usr/bin/ruby

#    Copyright (c) 2007, Lin Jen-Shin（a.k.a. godfat 真常）
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

require 'rubygems'

spec = Gem::Specification.new{|s|
  s.name     = 'ludy'
  s.version  = '0.0.6'
  s.author   = 'Lin Jen-Shin(a.k.a. godfat)'
  s.email    = 'strip number: 135godfat7911@246godfat.890org'
  s.homepage = 'http://ludy.rubyforge.org/'
  s.platform = Gem::Platform::RUBY
  s.summary  = 'Aims to extend Ruby standard library, providing some useful tools that\'s not existed in the standard library.'
  candidates = Dir.glob '{bin,doc,lib,test}/**/*'
  candidates+= Dir.glob '*'
  s.files    = candidates.delete_if{|item|
                 item.include?('rdoc') || File.extname(item) == '.gem'
               }

  s.require_path = 'lib'
  s.autorequire  = 'ludy'
  s.test_file    = 'test/ts_ludy.rb'
  s.has_rdoc     = false
  # s.extra_rdoc_files = []
  # s.add_dependency 'multi', '>=0.1'
}

if $0 == __FILE__
  Gem::manage_gems
  Gem::Builder.new(spec).build
end
