
class Proc
  # C++ TR1 style bind
  # use _#{n} for placeholders
  #  _1 => 1st arg
  #  _2 => 2nd arg
  #  ...and so on
  def _bind *args
    lambda{ |*new_args|
      self[*(args.map{ |arg|
        if (arg.kind_of? Symbol) && arg.to_s =~ /^_(\d+)$/
          # is placeholder
          new_args[$1.to_i-1]
        else
          # is not placeholder
          arg
        end
      } + new_args).first(self.arity)]
    }
  end
end
