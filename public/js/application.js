$(document).ready(function() {

  $("#createButton").click(function(){
    event.preventDefault();
    $("#createForm").attr("hidden", false)
    
  });

  $("#createEvent").submit(function(){
    event.preventDefault();
    var inputs = $("#createEvent input").serialize();
    $.post('/create', inputs, function(response) {
      $("#eventsList").append(response);
    });
    $("#createEvent input").val('');
    
  });

});