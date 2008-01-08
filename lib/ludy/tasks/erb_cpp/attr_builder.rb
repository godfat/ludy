
module Kernel

def accessor type, *pros
  (reader_only type, *pros) +
  (writer_only type, *pros) +
  (member_only type, *pros)
end

def reader type, *pros
  (reader_only type, *pros) +
  (member_only type, *pros)
end

def writer type, *pros
  (writer_only type, *pros) +
  (member_only type, *pros)
end

def reader_only type, *pros
  result = "#{@prefix}public:\n"
  pros.each{ |p|
    # getter
    result << "#{@prefix}#{@indent}#{type} #{p}() const{ return #{p}_; }\n"
  }
  result
end

def writer_only type, *pros
  result = "#{@prefix}public:\n"
  pros.each{ |p|
    # setter
    result << "#{@prefix}#{@indent}#{@class}& #{p}(#{type} const& new_#{p}){ #{p}_ = new_#{p}; return *this; }\n"
  }
  result
end

def member_only type, *pros
  result = "#{@prefix}private:\n"
  result << "#{@prefix}#{@indent}#{type} #{pros.map{|p|"#{p}_"}.join(", ")};\n"
end

end # of ludy
