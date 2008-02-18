
require 'ludy/tasks/common'

module Kernel
private
# C/C++ header guard generator, you shold provide the final #endif yourself,
# and you should provide PROJ name for header guard prefix
def header_guard random_suffix = nil, &block
  defined = "_#{Project.name.upcase}_#{@dir.upcase}_#{@class.upcase}_#{random_suffix.nil? ? '' : rand.to_s[2..-1]+'_'}"

  Ludy::erbout "#ifndef #{defined}
#define #{defined}", block.binding
  block.call
  Ludy::erbout '#endif', block.binding
end

end # of Kernel
