// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .


//search filter

function filterResults() {
	var categories = [];
	$("#categories .selected").each(function() {
        categories.push($(this).attr('id'));
    }); 
	if(categories.length === 0){
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
	
	console.log("filter", data);
    $.ajax({
    	url: "/search/filter/",
    	data: data,
    	dataType: 'html',
    	success: function(data){
    		$("#results").html(data);
    	}
    });
}
//display or empty part checkboxes
function filterParts(category_id) {  
	if(category_id != null) {
		jQuery.get("/categories/get_parts/" + category_id, function(data){
			//console.log(data);
			$("#parts").empty().hide();
			
			if(data.length != 0){
				$("#parts").empty().show();
				
				$.each(data, function(key, value) {   
					$("<input />")
						.attr({
							id: "ad_parts_ids_",
							type: "checkbox",
							value: value.id,
							name: "ad[part_ids][]"
						})
						.appendTo("#parts");
					$("<label>")
						.attr("for", value.id)
						.html(value.name)
						.appendTo("#parts");
				});
	    	}
			else{
				$("#parts").empty().hide();
			}
			
		});
	}
	else{
		$("#parts").empty().hide();
	}
}

// get subtree and replace selects
function filterCategories(category_id, $category) {  
	if(category_id != "") {
		jQuery.get("/categories/filter_categories/" + category_id, function(data){
			$category.empty().hide();
			if(data[0].children.length != 0){
				$category.empty().show();
				$.each(data[0].children, function(key, value) {   
					$category.append($("<option>", { value : value.id })
	    	        	.text(value.name)
	    	        	.click(function() {
	    	        		//set hidden ad_category_id select
	    	        		$("#ad_category_id").val($(this).val());
	    	        		filterParts(value.id);
		    	        })
					);
				});
				
				//set hidden ad_category_id select to default value
				$("#ad_category_id").val($category.val());
				filterParts($category.val());
	    	}
	    });
	}
	else{
		//set hidden ad_category_id select
		$("#ad_category_id").val($category.val());
		filterParts(); //hide checkboxes
	}
}  

$(function() {
    $(function () {  
        $('.pagination a').live("click", function () {  
            $.ajax({
            	url: this.href,
            	data: null,
            	dataType: 'html',
            	success: function(data){
            		console.log("success", data);
            		$("#results").html(data);
            	}
            });
            return false;  
        });  
    });   
    
	/* search filter */
	$(function($) {
	    $("#searchfilter").live('change', function() {
	    	filterResults();
	    });
	}); 
	
	
	/* change stylesheets and update content when gender tab changes */
	$("#gender_tab li").click(function(){
		if(!$(this).hasClass("selected")){
			var id = $(this).attr("id");
			$("#switch_style").attr("href", "/assets/" + id + ".css");
			$("#gender_tab li").each(function(){
				$(this).toggleClass('selected');
			});
			
			//update content
	        $.ajax({
	        	url: "/gender/" + id + "/",
	            dataType: 'script'});
		}
	});
	

	//miehet/naiset changes
	$("select#category_root").change(function() {
		// get subtree and replace selects
		var category_id = $("select#category_root :selected").val();
	    $("select#category_children1").empty().hide();
		filterCategories(category_id, $("select#category_children1"));
	});
	
	//children of miehet/naiset changes
	$("select#category_children1").change(function() {
	    // get subtree and replace selects
		var category_id = $("select#category_children1 :selected").val();
	});
	
	//if editing and value is already selected
	$("select#category_children1 option").each(function() {
    	$(this).click(function() {
    		//set hidden ad_category_id select
    		$("#ad_category_id").val($(this).val());
    		filterParts($(this).val());
        })
	});
	
	

})