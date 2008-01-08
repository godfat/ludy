
require 'rubygems'
require 'rake/clean'
require 'ludy'
Ludy.require_all_in 'tasks/erb_cpp'

namespace :erb do

  inputs = FileList['**/*.erb']
  outputs = inputs.ext
  CLEAN.include outputs

  desc 'automaticly translate all *.cpp.erb into *.cpp'
  task :preprocess => [:begin, outputs, :end].flatten
  task :begin do; puts "processing templates: #{inputs.inspect}\n\n"; end
  task :end do; puts "processing done."; end

  require 'erb'
  require 'open-uri'

  inputs.zip(outputs).each{ |input, output|
    file output => input do
      puts "processing... #{output}"
      open output, 'w' do |o|
        @class = output.pathmap '%n'
        @dir = output.pathmap('%-1d')
        @indent = '    '
        @prefix = ''
        PROJ ||= 'please_set_PROJ_for_your_header_name'
        o << ERB.new(open(input).read).result(binding)
      end
    end
  }

end # of namespace erb
