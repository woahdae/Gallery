$(function () {
  if (!$('body').hasClass('categories')) return;

  // Sortable Categories
  $('#categories ul').sortable({
    connectWith: "#categories ul"
  , placeholder: "ui-state-highlight"
  , update: function(event, ui) {
      var mylist = $(this).sortable('serialize')
      var finalstring = ''
      $(mylist.split("&")).each(function(index) {
        string2 = this.split("[")
        type = string2[0]
        string3 = string2[1].split("]")
        id = string3[0]
        fragments = this.split('=')
        var parent_id = fragments[1]
        finalstring = finalstring + type + '[' + index + ']' + '[id]=' + id + '&' + type + '[' + index + '][parent_id]=' + parent_id + '&' + type + '[' + index + '][position]=' + index + '&'
      })

      $.post("/admin/categories/sort", finalstring)
    }
  })

  // Initialize the jQuery File Upload widget:
  $('#fileupload').fileupload({sequentialUploads: true})

  // Load existing files
  $.getJSON($('#fileupload').prop('action'), function (files) {
    var fu = $('#fileupload').data('fileupload'), 
      template
    fu._adjustMaxNumberOfFiles(-files.length)
    template = fu._renderDownload(files)
      .appendTo($('#fileupload .files'))
    // Force reflow:
    fu._reflow = fu._transition && template.length &&
      template[0].offsetWidth
    template.addClass('in')
    $('#loading').remove()
  })
})
