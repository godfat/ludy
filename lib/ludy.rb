# $Id$

# Equivalent to a header guard in C/C++
# Used to prevent the class/module from being loaded more than once
unless defined? LudyHeaderGuard

module LudyHeaderGuard # :nodoc:
end

module Ludy

  # :stopdoc:
  VERSION = '0.1.15'
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
  $LOAD_PATH << LIBPATH
  # :startdoc:

  # Returns the version string for the library.
  #
  def self.version
    VERSION
  end

  # Returns the library path for the module. If any arguments are given,
  # they will be joined to the end of the libray path using
  # <tt>File.join</tt>.
  #
  def self.libpath( *args )
    args.empty? ? LIBPATH : ::File.join(LIBPATH, *args)
  end

  # Returns the lpath for the module. If any arguments are given,
  # they will be joined to the end of the path using
  # <tt>File.join</tt>.
  #
  def self.path( *args )
    args.empty? ? PATH : ::File.join(PATH, *args)
  end

  # Utility method used to rquire all files ending in .rb that lie in the
  # directory below this file that has the same name as the filename passed
  # in. Optionally, a specific _directory_ name can be passed in such that
  # the _filename_ does not have to be equivalent to the directory.
  #
  def self.require_all_libs_relative_to( fname, dir = nil )
    dir ||= ::File.basename(fname, '.*')
    search_me = ::File.expand_path(
        ::File.join(::File.dirname(fname), dir, '**', '*.rb'))

    Dir.glob(search_me).sort.each {|rb| require rb}
  end

  # require all files in the dir, only work for ludy.
  # i.e., Ludy.require_all_in 'proc' => require 'ludy/proc/*.rb'
  def self.require_all_in dir
    require 'rubygems'
    require 'rake'
    Dir.glob("#{LIBPATH}ludy/#{dir}/*.rb").each{ |i|
      require(if dir == '.'
                i.pathmap('ludy/%n')
              else
                i.pathmap("ludy/#{dir}/%n")
              end)
    }
  end

end  # module Ludy

# Ludy.require_all_libs_relative_to __FILE__

end  # unless defined?

# EOF
