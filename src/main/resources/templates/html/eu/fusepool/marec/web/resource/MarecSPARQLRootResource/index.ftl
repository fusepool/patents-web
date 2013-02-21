<#import "/imports/common.ftl" as common>
<#import "/imports/marec-sparql-description.ftl" as description>
<#import "/imports/sparql.ftl" as sparql>
<#escape x as x?html>
<@common.page title="MAREC SPARQL Endpoint" hasrestapi=false>


	<p><@description.marec/></p>
	
  <p><a href="http://en.wikipedia.org/wiki/Sparql">SPARQL</a> is the
    standard query language the most commonly used to provide interactive
    access to semantic knowledge bases.</p>
    
  <p>A SPARQL endpoint is a standardized HTTP access to perform SPARQL queries.
    Developers of REST clients will find all the necessary documentation in the
    official <a href="http://www.w3.org/TR/rdf-sparql-protocol/#query-bindings-http">W3C
    page for the RDF SPARQL protocol</a>.
	
  <p>The Stanbol enhancer SPARQL endpoint gives access to all graphs registered to OSGi environment. 
    For details please see Javadocs of <a href="http://svn.apache.org/repos/asf/incubator/stanbol/trunk/commons/web/sparql/src/main/java/org/apache/stanbol/commons/web/sparql/resource/SparqlEndpointResource.java">SparqlEndpointResource</a>.
  </p>

  <@sparql.form/>

</@common.page>

</#escape>
