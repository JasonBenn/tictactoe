var play = function() {
  $('.cell').click(function() {
  if ($(this).text() === "") {
    $(this).append(currentPlayer); };
    $.post('/', { 'coordinate':$(this).attr('id'), 'player':currentPlayer } );
    $.get('/check_victory', function(data) {
      if(data.length > 1) { 
        $('#victory').show();
        $('#victory').text(data);
        $('#play-again').slideDown('slow'); 
      };
      if(allMoves.length === 9) {
        $('#play-again').slideDown('slow')
      }
    });
  });
};

$(document).ready(function() {
  $('#play-again').hide();
  $('#victory').hide(); 

  for(var x=0; x < 3; x++) {
    
    if(x===0) { var rowClass = "top-row"; }
    else if(x===2) { var rowClass = "bottom-row"; }
    else { var rowClass = "" };

    for(var y=0; y < 3; y++) {

      if(y===0) { var colClass = "left-col"; }
      else if(y===2) { var colClass = "right-col"; }
      else { var colClass = "" };

      var move = allMoves[x+""+y] || ""
      var cell = $("<div class='cell "+colClass+" "+rowClass+"' id='"+x+y+"'>" + move + "</div>");
      $('#board').append(cell);
    };
  };
  play();
  self.setInterval(function() { location.reload(); }, 2500);
});
