
require 'rubygems'
require 'rake/clean'
require 'ludy'
Ludy.require_all_in 'tasks/preprocess_cpp'
require 'erb'
require 'open-uri'
require 'ostruct'

Project = OpenStruct.new

namespace :preprocess do

  erb_inputs = FileList['**/*.erb']
  erb_outputs = erb_inputs.ext

  task :erb_begin do; puts "processing templates: #{erb_inputs.inspect}\n\n"; end
  task :end do; puts "processing done."; end

  desc 'automaticly translate all *.cpp.erb into *.cpp'
  task :erb => [:erb_begin, erb_outputs, :end].flatten

  def preprocess template_engine, input, output
    puts "processing... #{output}"
    open output, 'w' do |o|
      @class = output.pathmap '%n'
      @dir = output.pathmap('%-1d')
      @indent = '    '
      @prefix = ''
      Project.name ||= 'please_set_Project_name_for_your_header_name'
      o << template_engine.new(input).result(binding)
    end
  end

  erb_inputs.zip(erb_outputs).each{ |input, output|
    file output => input do
      preprocess ERB, open(input).read, output
    end
  }

  erubis_outputs = [] # for people don't have erubis
  begin
    require 'erubis'
    erubis_inputs = FileList['**/*.eruby']
    erubis_outputs = erubis_inputs.ext

    task :erubis_begin do; puts "processing templates: #{erubis_inputs.inspect}\n\n"; end
    task :end do; puts "processing done."; end

    desc 'automaticly translate all *.cpp.eruby into *.cpp'
    task :erubis => [:erubis_begin, erubis_outputs, :end].flatten

    erubis_inputs.zip(erubis_outputs).each{ |input, output|
      file output => input do
        class ErboutEruby < Erubis::Eruby; include Erubis::ErboutEnhancer; end
        preprocess ErboutEruby, open(input).read, output
      end
    }
  rescue LoadError; end # no erubis

  outputs = erb_outputs + erubis_outputs
  CLEAN.include outputs

end # of namespace preprocess

desc 'run all preprocessing stuffs'
task :preprocess => ['preprocess:erb','preprocess:erubis']
