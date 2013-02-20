module Spree
  module Admin
    BaseHelper.module_eval do
      def link_to_remove_fields(name, f)
        # fixes https://github.com/jsqu99/spree_flexi_variants/issues/52 by reverting back to 'old spree' version
        f.hidden_field(:_destroy) + link_to_with_icon(:delete, name, '#', :class => 'remove_fields')
      end
    end
  end
end
