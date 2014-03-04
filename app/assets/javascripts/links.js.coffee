$ ->
  tags = $("#tagCloud").data('tags');
  $("#tagCloud").jQCloud(tags, {
    height: 200
  });