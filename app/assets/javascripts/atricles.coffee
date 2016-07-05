$(document).on "page:change", ->
  jQuery("#add_category").on "ajax:success", (event, data) ->
    jQuery("#categories").append data
    jQuery(this).data "params", { index: jQuery("#categories select").length + 1}

  jQuery(".reply").on "ajax:success", (event, data) ->
    id = (jQuery(this).data "params").id
    comment = "#comment-#{id}"
    jQuery(comment).append data
    jQuery(this).detach()
