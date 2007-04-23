#!/usr/bin/ruby

$:.unshift File.join(File.dirname(__FILE__))
Dir.foreach(File.dirname(__FILE__)){ |f|
  next if f == '.' || f == '..'
  require f
}
