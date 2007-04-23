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

File.open('test_log.log', 'a'){ |log|
  log << "\nstart testing at #{Time.new}\n\n"
  Dir.foreach('test'){ |f|
    next if f == '.' || f == '..'
    IO.popen("test/#{f}"){ |p|
      log << "\n----------running #{f}----------\n\n"
      log << p.read << "\n"
    }
  }
  log << "\nstop testing at #{Time.new}\n\n"
}
