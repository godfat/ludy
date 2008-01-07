
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy')
require 'ludy/array/combine'

dir = File.dirname __FILE__
lambda{ |log|
  result = [0]*4
  start = Time.new
  log << "---- Start testing at #{start} ----\n"
  Dir.foreach(dir){ |file|
    next unless file =~ /^test_/
    test = File.join dir, file
    # require test

    # require is so slow...
    # insted, we excute them separately    
    output = `#{test}`
    log << output
    match = output.match /(\d+) tests, (\d+) assertions, (\d+) failures, (\d+) errors/
    # result = result.zip(match[1..4].map(&:to_i)).map{|data| data.inject(&:+)}
    # result = result.zip(match[1..4].map(&:to_i)).map(&:'inject &:+'.to_msg)
    result = result.combine match[1..4].map(&:to_i)
  }
  log << "Total: #{result[0]} tests, #{result[1]} assertions, #{result[2]} failures, #{result[3]} errors\n\n"
  log << "---- End testing in #{Time.new - start} seconds. ----\n\n\n\n\n"
}[STDOUT || $stdout]
