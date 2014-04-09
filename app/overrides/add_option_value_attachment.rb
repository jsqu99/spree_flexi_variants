Deface::Override.new(:virtual_path => 'spree/admin/option_types/_option_value_fields',
                         :name => 'add_attachment_to_option_value_form',
                         :insert_before => '[data-hook="option_value"] .actions',
                         :partial => 'spree/admin/option_types/option_value_attachment')


Deface::Override.new(:virtual_path => 'spree/admin/option_types/edit',
                     :name => 'add_attachment_header_to_option_value_form',
                     :insert_before => '[data-hook="option_header"] .actions',
                     :partial => 'spree/admin/option_types/option_value_attachment_header')
