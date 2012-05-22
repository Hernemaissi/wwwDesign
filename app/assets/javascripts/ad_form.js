

// Ad form: display or empty part checkboxes
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

// Ad form: get category subtree and replace selects
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
	
  //Ad form: miehet/naiset dropdown changes
  $("select#category_root").change(function() {
    // get subtree and replace selects
    var category_id = $("select#category_root :selected").val();
      $("select#category_children1").empty().hide();
    filterCategories(category_id, $("select#category_children1"));
  });
  
  //Ad form: dropdown children of miehet/naiset changes
  $("select#category_children1").change(function() {
      // get subtree and replace selects
    var category_id = $("select#category_children1 :selected").val();
  });
  
  //Ad form: if editing and value is already selected
  $("select#category_children1 option").each(function() {
      $(this).click(function() {
        //set hidden ad_category_id select
        $("#ad_category_id").val($(this).val());
        filterParts($(this).val());
        })
  });
 
})