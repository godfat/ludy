
module Kernel

def header_guard random_suffix = nil
  defined = "_#{PROJ.upcase}_#{@dir.upcase}_#{@class.upcase}_#{random_suffix.nil? ? '' : rand.to_s[2..-1]+'_'}"
"#ifndef #{defined}
#define #{defined}"
end

end
