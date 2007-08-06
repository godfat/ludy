#!/usr/bin/env ruby

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
raise LoadError.new('you need ruby2ruby gem to use this tool') unless require 'ruby2ruby'
begin
  require_ludy 'ludy_ext'
rescue NameError
  raise LoadError.new('please require "ludy" first')
end

module Ludy

  class Rambda
    def initialize &block
      @this = eval block.to_ruby
      define_instance_method :call, &@this
      alias_instance_method :[], :call
    end
    attr_reader :this
    alias_method :to_proc, :this
  end

  def rambda &block
    Rambda.new &block
  end

end # of Ludy
