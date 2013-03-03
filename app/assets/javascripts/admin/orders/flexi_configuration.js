// until I learn how to magically append functionality to the 'success' path below, i need to forklift & paste from spree proper
$.fn.product_autocomplete = function(){
  return this.each(function() {
    $(this).autocomplete({
      source: function(request, response) {
        $.get(Spree.routes.product_search + '?' + jQuery.param({ q: $('.product_autocomplete').val(), authenticity_token: encodeURIComponent($('meta[name=csrf-token]').attr("content"))}), function(data) {
          result = prep_product_autocomplete_data(data)
          response(result);
        });
      },
      minLength: 4,
      focus: function(event, ui) {
        $('.product_autocomplete').val(ui.item.label);
        return false;
      },
      select: function(event, ui) {
        $('.product_autocomplete').val(ui.item.label);
        product = ui.item.data;
        if (product['variant'] == undefined) {
          // product
          $('#add_variant_id').val(product['product']['master']['id']);
        } else {
          // variant
          $('#add_variant_id').val(product['variant']['id']);
        }
        // we might have some flexi-content to load for this product
        $.getScript('/admin/variant_configurations/' + $('#add_variant_id').val());
        return false;
      }
    }).data("autocomplete")._renderItem = function(ul, item) {
      $(ul).addClass('ac_results');
      html = format_product_autocomplete(item);
      return $("<li></li>")
              .data("item.autocomplete", item)
              .append("<a>" + html + "</a>")
              .appendTo(ul);
    }

    $(this).data("autocomplete")._resizeMenu = function() {
      var ul = this.menu.element;
      ul.outerWidth(this.element.outerWidth());
    }
  });
}
