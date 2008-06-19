
module Ludy
  module RailsFieldsFilters
    def rff_filters
      @rff_filters ||= Hash.new{|h,k|h[k]=[]}
    end
    def rff_setup
      rff_filters.each{ |event, tasks|
        tasks.each{ |task|
          fields, filters = task
          __send__ event, lambda{ |record|
            [fields].flatten.each{ |field|
              record.__send__ "#{field}=",
                [filters].flatten.inject(record.__send__(field)){ |result, filter|
                  filter[result]
                }
            }
          }
        }
      }
    end
  end
end
