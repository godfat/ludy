
require 'ludy/tasks/common'

module Kernel
  def debug_include
'#ifndef NDEBUG
#include <iostream>
#endif'
  end
  def debug_hook name, &block
    Ludy::erbout name, block.binding
    block.call
    Ludy::erbout "
#ifndef NDEBUG
std::cerr << \"method #{name} called, for \" << this << \" at #{@file}: #{eval '__LINE__', block.binding}\\n\";
#endif
", block.binding
  end
end
