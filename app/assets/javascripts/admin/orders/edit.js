// overrides spree core's version to include our variant configurations
$(document).ready(function(){

  $("#add_line_item_to_order").on("click", function(){
    if($('#add_variant_id').val() == ''){ return false; }
    update_target = $(this).attr("data-update");
    $.ajax({ dataType: 'script', url: this.href, type: "POST",
        data: {"line_item[variant_id]": $('#add_variant_id').val(),
              "line_item[quantity]": $('#add_quantity').val(),
              "variant_configurations": $('#variant_configurations').serialize()}
    });
    return false;
  });

  $(".product_autocomplete").product_autocomplete();

});
