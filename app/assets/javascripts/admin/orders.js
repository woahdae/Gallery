$(function () {
  if (!$('body').hasClass('orders')) return;

  $('#orders').dataTable({
    bProcessing:     true,
    bServerSide:     true,
    sAjaxSource:     $('#orders').data('source'),
    sDom:            "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    sPaginationType: "bootstrap",
    aaSorting: [[ 0, "desc" ]]
  });
});
