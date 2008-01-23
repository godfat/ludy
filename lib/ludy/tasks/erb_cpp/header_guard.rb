
require 'ludy/tasks/common'

module Kernel

# C/C++ header guard generator, you shold provide the final #endif yourself,
# and you should provide PROJ name for header guard prefix
def header_guard random_suffix = nil, &block
  defined = "_#{PROJ.upcase}_#{@dir.upcase}_#{@class.upcase}_#{random_suffix.nil? ? '' : rand.to_s[2..-1]+'_'}"

  Ludy::eout "#ifndef #{defined}
#define #{defined}", block.binding
  Ludy::eout block.call, block.binding
  Ludy::eout '#endif', block.binding
end

end # of ludy
