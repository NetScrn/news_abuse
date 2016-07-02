$ ->
  jQuery("#add_category").on "ajax:success", (event, data) ->
    jQuery("#categories").append data
    jQuery(this).data "params", { index: jQuery("#categories select").length + 1}
