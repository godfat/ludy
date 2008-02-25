
# module Ludy
#   def use_module mod
#     user = self.class
#     mod.constants.each{ |const|
#       target = mod.const_get const
#       if user.const_defined? const
#         origin = user.const_get const
#         if origin.kind_of? Class and target.kind_of? Class
#           # TODO: don't just override it!
#           target.instance_methods.sort.each{ |method|
#             origin.class.module_eval do
#               # define_method method, target.instance_method(method)
#             end
#           }
#         else
#           # TODO: don't just override it!
#           user.__send__ :remove_const, const
#           user.const_set const, target
#         end
#       else
#         user.const_set const, target
#       end
#     }
#   end
#   def unuse_module mod
#     mod.constants.each{ |const|
#       self.class.__send__ :remove_const, const
#     }
#   end
# end
# 
# module Std
#   N = 29
#   class Array
#     def orz
#       puts 'orz'
#     end
#   end
# end
# 
# # module M
# #   Ludy::using_module Std
# # end
# 
# require 'test/unit'
# class ContantsTest < Test::Unit::TestCase
#   include Ludy
#   def test_a_global
#     assert_raise NameError do
#       N
#     end
#   end
#   def test_b_std
#     assert_equal 29, Std::N
#   end
#   def test_c_using_std
#     use_module Std
#     assert_equal 29, N
#     assert [].respond_to?(:orz)
#   end
#   def test_d_using_nil
#     unuse_module Std
#     assert 29, Std::N
#   end
#   def test_e_global
#     assert_raise NameError do
#       N
#     end
#   end
# end
