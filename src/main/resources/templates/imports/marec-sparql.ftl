<#macro form>


<script language="javascript">
var SparqlQuery =
	"PREFIX pmo: <http://www.patexpert.org/ontologies/pmo.owl#>\n"+
	"PREFIX dcterms: <http://purl.org/dc/terms/>\n"+
	"PREFIX property: <http://example.org/property/>\n"+
	"PREFIX sumo: <http://www.owl-ontologies.com/sumo.owl#>\n"+
	"PREFIX foaf: <http://xmlns.com/foaf/0.1/>\n"+
	"SELECT distinct ?title ?inventor_name\n"+
	"WHERE { "+
	"?invention a sumo:Patent . \n"+
	"?invention dcterms:title ?title . \n"+
	"?invention pmo:inventor ?inventor .\n"+
	"?inventor foaf:name ?inventor_name .\n"+
	"}" ;

var $country="";	//globals as we have callbacks that need this data.
var $xmldata="";	

function loadTable(data){
	//alert(data) ;
	$xmldata=data;					//set our global XML variable to the data from the callback for re-use later.
	$results = $(data).find("results") ;
	$($results).find("result").each(function(){ //find each row in the XML with the country we want to show.		
		var $result=$(this);							//cache result selector 

		var $title ;
		var $inventor ;
		var $country ;
		//$("#datatable").append("trovato result<br/>") ;
		
		$($result).find("binding").each(function() {
			$binding = $(this) ;
			var name = $binding.attr("name") ;
			var literal = $($binding).find("literal") ;
			var value = $(literal).text() ;
			if("title"==name) {
				$title = value ;
				$country = $(literal).attr("xml:lang") ;
			}
			if("inventor_name"==name) 
				$inventor = value ;
	
		}) ;
					
		$("#datatable").append("<tr class='datarow'><td>"+$country+"</td><td>"+$inventor+"</td><td>"+$title+"</td></tr>"); //output table row
	});	
	zebraStripe();
}



function zebraStripe(){
	$("#datatable").each(function(){   
 	var $s=0;
		$(this).find("tr").each(function(){   
			var $t = $(this).children("td");
			$s++; 
			if($s%2==1)
				$t.addClass("stripe"); 
			else
				$t.removeClass("stripe");
		});
  	});
}

</script>


<form id="msparql">
<p><input type="submit" class="submit" value="Run SPARQL query" /></p>
</form>
<table id='datatable' width="100%" cellpadding="7" cellspacing="1">
  <tr id='tableheader'>
    <th>Country</th>
    <th>Inventor Name</th>
    <th>Title</th>
  </tr>
</table>

<script language="javascript">
function init() {
  graphChangeHandler();

  $("#msparql input.submit", this).click(function(e) {
    // disable regular form click
    e.preventDefault();
    
    // clean the result area
    if($(".datarow")!=null)
    	$(".datarow").remove();	
   
    // submit sparql query using Ajax
    $.ajax({
      type: "POST",
      //url: "http://vmyuki.bfh.ch:8080/sparql",
      url: "${it.publicBaseUri}sparql",
      data: {graphuri: "om.go5th.yard.clerezza.01", query: SparqlQuery},
      //dataType: "html",
      cache: false,
      success: loadTable,
      error: function(result) {
        alert('Invalid query.');
      }
    });
  });
  

}
 
function graphChangeHandler() {
  var selectedGraph = $("#graphList").val();
  if(selectedGraph != undefined) {
    $(".graphDetailInvisible").hide();
    $("#" + selectedGraph).toggle();
  }
}
$(document).ready(init);
</script>
</#macro>