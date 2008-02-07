
require 'ludy/tasks/common'

module Kernel
  # it simply output:
  #  #ifndef NDEBUG
  #  #include <iostream>
  #  #endif
  def debug_include
'#ifndef NDEBUG
#include <iostream>
#endif'
  end
  # example usage:
  #  void <% debug_hook 'C::f' do %>(){
  #    <% end %>
  #    std::cout << "hello" << std::endl;
  #  }
  # became:
  #  void C::f(){
  #    #ifndef NDEBUG
  #    std::cerr << "method C::f called, for " << this << " at c.cpp: 12\n"
  #    #endif
  #    std::cout << "hello" << std::endl;
  #  }
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
