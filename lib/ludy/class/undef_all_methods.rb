
class Class
  # undefine all instance methods, used for delegation class
  def undef_all_methods
    instance_methods.each{ |m|
      undef_method m unless (m =~ /^__/ || m.to_sym == :object_id || m.to_sym == :public_send )
    }
  end
end
