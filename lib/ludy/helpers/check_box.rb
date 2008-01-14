
module Ludy
  # check box helper for html view generation.
  #  require 'ludy/helpers/check_box'
  #  module ApplicationHelper
  #    include Ludy::CheckBox
  #  end
  module CheckBox
    # create a link respond to onclick and <em>check</em> all check_box for all
    # specified elements.
    #  id_and_or_class, e.g., #form_inviting input.check_box_friend
    #                         ^^^^^id  elements^^^ ^^^^^^^^^^^class
    def check_all text, id_and_or_class
      "<a href=\"#\" onclick=\"$$('#{id_and_or_class}').each(function(box){box.checked='checked'});return false;\">#{text}</a>"
    end
    # create a link respond to onclick and <em>uncheck</em> all check_box for all
    # specified elements.
    #  id_and_or_class, e.g., #form_inviting input.check_box_friend
    #                         ^^^^^id  elements^^^ ^^^^^^^^^^^class
    def uncheck_all text, id_and_or_class
      "<a href=\"#\" onclick=\"$$('#{id_and_or_class}').each(function(box){box.checked=''});return false;\">#{text}</a>"
    end
  end
end
