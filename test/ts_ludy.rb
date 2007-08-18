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

require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy')
require_ludy 'ludy_ext'

dir = File.dirname __FILE__
File.open('test_result.log', 'a+'){ |log|
  result = [0]*4
  start = Time.new
  log << "---- Start testing at #{start} ----\n"
  Dir.foreach(dir){ |file|
    next unless file =~ /^tc_/
    test = File.join dir, file
    # require test

    # require is so slow...
    # insted, we excute them separately    
    output = `#{test}`
    log << output
    match = output.match /(\d+) tests, (\d+) assertions, (\d+) failures, (\d+) errors/
    # result = result.zip(match[1..4].map(&:to_i)).map{|data| data.inject(&:+)}
    result = result.zip(match[1..4].map(&:to_i)).map(&:'inject(&:+)')
  }
  log << "Total: #{result[0]} tests, #{result[1]} assertions, #{result[2]} failures, #{result[3]} errors\n"
  log << "---- End testing in #{Time.new - start} seconds. ----\n\n\n\n\n"
  puts "see #{log.inspect} for result"
}
