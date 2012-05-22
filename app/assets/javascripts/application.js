// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui


$(function() {
    
/* change stylesheets and update content when gender tab changes */
	$("#gender_tab li").click(function(){
		if(!$(this).hasClass("selected")){
			var id = $(this).attr("id");
	
			$("#gender_tab li").each(function(){
				$(this).toggleClass('selected');
			});
			
			//update content
			$.ajax({
			url: "/gender/" + id + "/",
			dataType: 'script'});
		}
	});
	
	/* replace broken images */
	$("img").error(function () {
		$(this).unbind("error").attr("src", "/assets/not_found.png");
		$(this).addClass("broken");
	});

})