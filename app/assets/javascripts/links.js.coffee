$ ->
  $tags = $("#tagCloud");
  if $tags.length
    $tags.jQCloud($tags.data('tags'), {
      height: 200
    });