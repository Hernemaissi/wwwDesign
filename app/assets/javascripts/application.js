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
					//no subchildren
					if(value.children.length === 0){
						$category.append($("<option>", { value : value.id })
		    	        	.text(value.name)
		    	        	.click(function() {
		    	        		//set hidden ad_category_id select
		    	        		$("#ad_category_id").val($(this).val());
		    	        		filterParts(value.id);
			    	        })
						);
					}
					//subchildren, e.g. kengät
					else{
						$category.append($("<option>", { value : value.id })
			    	        .text(value.name));
						filterParts(); //hide checkboxes
					}
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
	/*  */
	$(function($) {
	    $("#searchfilter #parts input").change(function() {
	        $.ajax({url: '<%= url_for :action => 'action_name', :id => ' $(this).val() '%>',
	        data: 'selected=' + this.value,
	        dataType: 'script'})
	    });
	});
	
	/* change stylesheets when gender tab changes, should be moved to sessions/change_gender */
	$("#gender_tab li").click(function(){
		if(!$(this).hasClass("selected")){
			var id = $(this).attr("id");
			$("#switch_style").attr("href", "/assets/" + id + ".css");
			$("#gender_tab li").each(function(){
				$(this).toggleClass('selected');
			});
		}
	});
	

	//miehet/naiset changes
	$("select#category_root").change(function() {
		// get subtree and replace selects
		var category_id = $("select#category_root :selected").val();
	    $("select#category_children2").empty().hide();
	    $("select#category_children1").empty().hide();
		filterCategories(category_id, $("select#category_children1"));
		
		
	});
	
	//children of miehet/naiset changes
	$("select#category_children1").change(function() {
	    // get subtree and replace selects
		var category_id = $("select#category_children1 :selected").val();
		filterCategories(category_id, $("select#category_children2"));
	});
	
	//if editing and value is already selected
	$("select#category_children1 option").each(function() {
    	$(this).click(function() {
    		//set hidden ad_category_id select
    		$("#ad_category_id").val($(this).val());
    		filterParts($(this).val());
        })
        //TODO kun ollaan edit näkymässä niin kengät ei toimi
	});

})