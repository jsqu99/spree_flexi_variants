module Spree
  module Admin
    BaseHelper.module_eval do
      #renders hidden field and link to remove record using nested_attributes
      def link_to_remove_nested_fields(name, f, options = {})
        name = '' if options[:no_text]
        options[:class] = '' unless options[:class]
        options[:class] += 'no-text with-tip' if options[:no_text]
        options[:nest] = '' unless options[:nest]
        url = f.object.persisted? ? [:admin, options[:nest], f.object] : '#'
        link_to_with_icon('icon-trash', name, url, :class => "remove_fields #{options[:class]}", :data => {:action => 'remove'}, :title => t(:remove)) + f.hidden_field(:_destroy)
      end
    end
  end
end