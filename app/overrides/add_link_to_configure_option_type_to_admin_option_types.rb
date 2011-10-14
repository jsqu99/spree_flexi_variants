    Deface::Override.new(:virtual_path => "admin/option_types/_available",
                         :name => "converted_admin_option_types_available_header_821920",
                         :insert_bottom => "[data-hook='option_type_header'], #option_type_header[data-hook]",
                         :text => "<th></th>")

    Deface::Override.new(:virtual_path => "admin/option_types/_available",
                         :name => "converted_admin_option_types_available_row_821920",
                         :insert_bottom => "[data-hook='option_type_row'], #option_type_row[data-hook]",
                         :text => %(
    <td class="actions"><%= link_to icon('add') + ' ' + t('configure_option_type'),
                            url_for(:controller => "admin/option_types",
                                    :id => ot.id,
                                    :product_id => @product.permalink,
                                    :action => "configure",
                                    :option_type_id =>  ot.id),
                                    :remote => true,
                                    :class => 'iconlink' %>
    </td>
)
)


    Deface::Override.new(:virtual_path => "admin/option_types/_selected",
                         :name => "converted_admin_option_types_selected_821920",
                         :insert_after => "#option-types[data-hook]",
                         :text => "<div id='configure-option-type'></div>")


    Deface::Override.new(:virtual_path => "admin/option_types/_selected",
                         :name => "converted_admin_option_types_selected_733808074",
                         :insert_top => "[data-hook='selected_row'] td.actions",
                         :text => %(
<%= link_to icon('add') + ' ' + t('configure_option_type'),
                            url_for(:controller => "admin/option_types",
                                    :id => option_type.id,
                                    :product_id => @product.permalink,
                                    :action => "edit_configuration",
                                    :option_type_id =>  option_type.id),
                                    :class => 'iconlink' %>
)
)
