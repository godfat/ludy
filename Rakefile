# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'ludy'
require 'ludy/tasks'

task :default do
  Rake.application.options.show_task_pattern = /./
  Rake.application.display_tasks_and_comments
end

PROJ.name = 'ludy'
PROJ.authors = 'Lin Jen-Shin (a.k.a. godfat 真常)'
PROJ.email = 'strip any number: 18god29fat7029 (at] godfat32 -dooot- 20org'
PROJ.url = 'http://ludy.rubyforge.org/'
PROJ.description = PROJ.summary = paragraphs_of('README', 'description').join("\n\n")
PROJ.changes = paragraphs_of('CHANGES', 0..1).join("\n\n")
PROJ.rubyforge_name = 'ludy'

PROJ.version = paragraphs_of('README', 0).first.split("\n").first[7..-1]
PROJ.exclude << '.DS_Store' << '^tmp'
PROJ.dependencies << 'rake'

PROJ.rdoc_main = 'README'
PROJ.rdoc_exclude << 'deprecated' << 'Manifest' << 'Rakefile' << 'tmp$' << '^tmp'
PROJ.rdoc_include << '\w+'
PROJ.rdoc_opts << '--diagram' if !WIN32 and `which dot` =~ %r/\/dot/
PROJ.rdoc_opts << '--charset=utf-8' << '--inline-source' << '--line-numbers' << '--promiscuous'

PROJ.spec_opts << '--color'

# EOF
