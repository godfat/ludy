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

module Ludy

  class Lazy
    instance_methods.each{|m| undef_method m unless m =~ /^__/}

    def initialize func = nil, &block
      if block_given? then @func = block
      else
        raise TypeError, "#{func} don't respond to :call" unless func.respond_to? :call
        @func = func
      end
    end

    def method_missing msg, *arg, &block
      (@obj ||= @func.call).__send__ msg, *arg, &block
    end
  end

  def lazy arg = nil, &block
    Lazy.new arg, &block
  end

end # of Ludy
