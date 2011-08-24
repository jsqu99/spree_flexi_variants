// until I learn how to magically append functionality to the 'success' path below, i need to forklift & paste from spree proper
jQuery.fn.product_autocomplete = function(){
  $(this).autocomplete("/admin/products.json?authenticity_token=" + $('meta[name=csrf-token]').attr("content"), {
      parse: prep_autocomplete_data,
      formatItem: function(item) {
        return format_autocomplete(item);
      }
    }).result(function(event, data, formatted) {
      if (data){

        if(data['variant']==undefined){
          // product
          $('#add_variant_id').val(data['product']['master']['id']);
        }else{
          // variant
          $('#add_variant_id').val(data['variant']['id']);
        }

        // we might have some flexi-content to load for this product
        $.getScript('/admin/variant_configurations/' + $('#add_variant_id').val());
      } else {
        $('#configurations').hide();
      }
    });
}

