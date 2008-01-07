# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'ludy'

task :default do
  sh 'rake --tasks'
end

PROJ.name = 'ludy'
PROJ.summary = 'Aims to extend Ruby standard library, providing some useful tools that\'s not existed in the standard library.'
PROJ.authors = 'Lin Jen-Shin (a.k.a. godfat 真常)'
PROJ.email = 'strip number: 135godfat7911@246godfat.890org'
PROJ.url = 'http://ludy.rubyforge.org/'
PROJ.description = paragraphs_of('README', 1).join("\n\n")
PROJ.changes = paragraphs_of('CHANGES', 0..1).join("\n\n")
PROJ.rubyforge_name = 'ludy'

PROJ.version = '0.1.0'
PROJ.exclude << '.DS_Store'
PROJ.dependencies += ['rake']

PROJ.rdoc_main = 'README'
PROJ.rdoc_exclude << 'deprecated' << 'Manifest'
PROJ.rdoc_include << '\w+'

PROJ.spec_opts << '--color'

# EOF
