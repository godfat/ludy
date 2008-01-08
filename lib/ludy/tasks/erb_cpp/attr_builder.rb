
module Kernel

# just like attr_accessor for c++
def accessor type, *pros
  (reader_only type, *pros) +
  (writer_only type, *pros) +
  (member_only type, *pros)
end

# just like attr_reader for c++
def reader type, *pros
  (reader_only type, *pros) +
  (member_only type, *pros)
end

# just like attr_writer for c++
def writer type, *pros
  (writer_only type, *pros) +
  (member_only type, *pros)
end

# create only reader(getter), no member and no writer(setter)
def reader_only type, *pros
  result = "#{@prefix}public:\n"
  pros.each{ |p|
    # getter
    result << "#{@prefix}#{@indent}#{type} #{p}() const{ return #{p}_; }\n"
  }
  result
end

# create only writer(setter), no member and no reader(getter)
def writer_only type, *pros
  result = "#{@prefix}public:\n"
  pros.each{ |p|
    # setter
    result << "#{@prefix}#{@indent}#{@class}& #{p}(#{type} const& new_#{p}){ #{p}_ = new_#{p}; return *this; }\n"
  }
  result
end

# create only member, no writer(setter) and no reader(getter)
def member_only type, *pros
  result = "#{@prefix}private:\n"
  result << "#{@prefix}#{@indent}#{type} #{pros.map{|p|"#{p}_"}.join(", ")};\n"
end

end # of ludy
