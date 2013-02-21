<#macro form>
<fieldset>
  <legend>Registered TripleCollections</legend>
  <#-- graph list -->
  <#if it.tripleCollectionList?size &gt; 0>
    <select id="graphList" onChange='javascript:graphChangeHandler();'>
    	<#list it.tripleCollectionList as tcInfo>
    		<option value="${tcInfo.graphUri}">${tcInfo.graphUri}</option>
    	</#list>
    </select>
  <#else>
    There is no registered TripleCollection.
  </#if>
</fieldset>

<#if it.tripleCollectionList?size &gt; 0>
  <fieldset>
    <legend>Details of Selected Graph</legend>
    <#list it.tripleCollectionList as tcInfo>
    	<ul id="${tcInfo.graphUri}" class="graphDetailInvisible">
    		<li>Graph Name: ${tcInfo.graphName}</li>
    		<li>Graph Description: ${tcInfo.graphDescription}</li>
    	</ul>
    </#list>
  </fieldset>
</#if>

<form id="sparql">
<textarea class="query" rows="11" name="query">
PREFIX pmo: &lt;http://www.patexpert.org/ontologies/pmo.owl#&gt;
PREFIX dcterms: &lt;http://purl.org/dc/terms/&gt;
PREFIX property: &lt;http://example.org/property/&gt;
PREFIX sumo: &lt;http://www.owl-ontologies.com/sumo.owl#&gt;
PREFIX foaf: &lt;http://xmlns.com/foaf/0.1/&gt; 
SELECT distinct ?title ?inventor_name
WHERE { 
	?invention a sumo:Patent . 
	?invention dcterms:title ?title . 
	?invention pmo:inventor ?inventor .
	?inventor foaf:name ?inventor_name .
}
</textarea>
<p><input type="submit" class="submit" value="Run SPARQL query" /></p>
<pre class="prettyprint result" style="max-height: 200px; display: none" disabled="disabled">
</pre>
</form>
<script language="javascript">
function init() {
  graphChangeHandler();

  $("#sparql input.submit", this).click(function(e) {
    // disable regular form click
    e.preventDefault();
    
    // clean the result area
    $("#sparql textarea.result").text('');
   
    // submit sparql query using Ajax
    $.ajax({
      type: "POST",
      url: "${it.publicBaseUri}sparql",
      data: {graphuri: $("#graphList").val(), query: $("#sparql textarea.query").val()},
      dataType: "html",
      cache: false,
      success: function(result) {
        $("#sparql pre.result").text(result).css("display", "block");
        prettyPrint();
      },
      error: function(result) {
        $("#sparql pre.result").text('Invalid query.').css("display", "block");
      }
    });
  });
  
  // set graph combo box change handler
  $('#graphList').onchange(graphChangeHandler);
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