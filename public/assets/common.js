$(document).ready(function(){
console.log("Ready");
$('#toggler')
  .bind("ajax:success", function(data){
    console.log("Here I am");
    $('#available').empty();
  });

});