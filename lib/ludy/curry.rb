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

begin
  require_ludy 'ludy_ext'
rescue NameError
  raise LoadError.new('please require "ludy" first')
end

module Ludy

  module Curry
    def self.included target
      target.module_eval{
        instance_methods.each{ |m|
          next unless m =~ /^\w/
          module_eval <<-END
            def c#{m} *args, &block
              if args.size == method(:#{m}).arity
                self.__send__ :#{m}, *args, &block
              else
                method(:c#{m}).to_proc.curry *args
              end
            end
          END
        }
      }
    end
  end

end
