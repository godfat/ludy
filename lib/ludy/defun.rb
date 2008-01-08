
require 'ludy/kernel/public_send'

module Ludy
  def defun name, *args, &fun
    p self
    Dispatcher.create self, name, *args, &fun
  end
  class ArgList
    def initialize *args
      @arg_list = args
    end
    def hash
      @arg_list.inject(0){ |r, i|
        r + (i.kind_of?(Class) ?
          i.object_id : i.class.object_id)
      }
    end
    def eql? rhs
      self.size == rhs.size &&
      self.hash == rhs.hash
    end
    alias_method :==, :eql?
    def method_missing msg, *args, &block
      @arg_list.public_send msg, *args, &block
    end
  end
  class Dispatcher
    def self.create actor, msg, *args, &fun
      if (@patchers ||= {})[[actor, msg]].nil?
        @patchers[[actor, msg]] = Dispatcher.new actor, msg, *args, &fun
      else
        @patchers[[actor, msg]].push ArgList.new(*args), &fun
      end
    end
    def initialize actor, msg, *args, &fun
      @actor = actor
      @msg = msg
      @map = {}
      self.push ArgList.new(*args), &fun
      @actor.instance_variable_set :@ludy_dispatcher_injection
    end
    def push arg_list, &fun
      @map[arg_list] = fun
      unless @actor.respond_to? @msg
        @actor.define_singleton_method @msg do |*args, &block|
          # cannot see @map...
          fun = @map[ArgList.new(*args)]
          if fun.nil?
            @actor.method_missing @msg, *args, &block
          else
            fun.call(*args, &block)
          end
        end
      end
    end
  end
end

# defun :fact, 0 do |n|
#   1
# end
# 
# defun :fact, Integer do |n|
#   n * fact(n-1)
# end
