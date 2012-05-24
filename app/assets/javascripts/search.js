//search filter

function filterResults() {
	var categories = [];
	$("#categories .selected").each(function() {
        categories.push($(this).attr('id'));
    }); 
	if(categories[0] === "0"){
		$("#categories a").each(function(){
			categories.push(this.id);
		});
	}
	
	var parts = [];
	$("#parts input:checked").each(function(){
		parts.push(this.value);
	});
	
	var available = false;
	if($("#available input").attr('checked')){
		var available = true;
	}
	
	var price_lower;
	var price_higher; 
	if($("#price_lower")){
		price_lower = $("#price_lower").val();
	}
	if($("#price_higher")){
		price_higher = $("#price_higher").val();
	}
	
	var condition = $("#condition select").val();
	
	var color = $("#color select").val();
	
	var data = {
		'categories': categories,
		'parts': parts,
		'available': available,
		'price_higher': price_higher,
		'price_lower': price_lower,
		'condition': condition,
		'color': color
	}
	
	//console.log("filter", data);
    $.ajax({
    	url: "/search/filter/",
    	data: data,
    	dataType: 'html',
    	success: function(data){
    		$("#results").html(data);
    	}
    });
}



$(function() {
	filterResults();
	
	/* pagination for search results */ 
    $('.pagination a').live("click", function () {  
        $.ajax({
        	url: this.href,
        	data: null,
        	dataType: 'html',
        	success: function(data){
        		//console.log("success", data);
        		$("#results").html(data);
        	}
        });
        return false;  
    });  
 
    
	/* search filter */
    $("#searchfilter").live('change', function() {
    	filterResults();
	}); 
})