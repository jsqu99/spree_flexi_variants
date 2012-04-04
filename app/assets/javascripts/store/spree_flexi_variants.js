//= require jquery.formatCurrency-1.4.0.min
//= require i18n/jquery.formatCurrency.all
//= require_self

$(function () {
  // set up the 'reset' functionality on file uploads
  $("#cart-form form input[type=file]").each(function () {
  // make a clone of the original in case the user wants to undo an upload
    var orig = $(this);
    var clone = $(orig).clone();
    attachFileInputSwap(orig, clone);
  });
  // image customizations need multipart
  $("#cart-form form").attr("enctype","multipart/form-data");
  $("#cart-form form").validate();
});
// 'replacement' is always a pure, empty file input
function attachFileInputSwap(current, replacement) {
  $(current).siblings("a").click(function (event) {
    event.preventDefault();
    $(current).replaceWith(replacement);
    // need to reattach
    var clone = $(replacement).clone();
    attachFileInputSwap(replacement, clone);
  });
}
