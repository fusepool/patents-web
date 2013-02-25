package eu.fusepool.enhancers.marec.web.fragment;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.clerezza.rdf.core.access.TcManager;
import org.apache.clerezza.rdf.core.serializedform.Serializer;
import org.apache.felix.scr.annotations.Activate;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.References;
import org.apache.felix.scr.annotations.Service;
import org.apache.stanbol.commons.web.base.LinkResource;
import org.apache.stanbol.commons.web.base.NavigationLink;
import org.apache.stanbol.commons.web.base.ScriptResource;
import org.apache.stanbol.commons.web.base.WebFragment;
import org.apache.stanbol.contenthub.servicesapi.store.Store;
import org.apache.stanbol.enhancer.servicesapi.EnhancementJobManager;
import org.osgi.framework.BundleContext;
import org.osgi.service.component.ComponentContext;

import eu.fusepool.enhancers.marec.web.resource.MarecSPARQLRootResource;

/**
 * Statically define the list of available resources and providers to be contributed to the the Stanbol JAX-RS
 * Endpoint.
 */
@Component(immediate = true, metatype = true)
@Service
@References({})
public class MarecSPARQLWebFragment implements WebFragment {

    private static final String NAME = "marec";

    private BundleContext bundleContext;
    
    @Reference
    TcManager tcManager;

    @Reference
    Store store;

    @Reference
    EnhancementJobManager jobManager;

    @Reference
    Serializer serializer;

    @Override
    public String getName() {
        return NAME;
    }

    @Activate
    protected void activate(ComponentContext ctx) {
        this.bundleContext = ctx.getBundleContext();
    }

    @Override
    public Set<Class<?>> getJaxrsResourceClasses() {
        Set<Class<?>> classes = new HashSet<Class<?>>();
        classes.add(MarecSPARQLRootResource.class);
        return classes;
    }

    @Override
    public Set<Object> getJaxrsResourceSingletons() {
        return Collections.emptySet();
    }


//    public String getStaticResourceClassPath() {
//        return STATIC_RESOURCE_PATH;
//    }


//    public TemplateLoader getTemplateLoader() {
//        return new ClassTemplateLoader(getClass(), TEMPLATE_PATH);
//    }

    @Override
    public List<LinkResource> getLinkResources() {
		List<LinkResource> resources = new ArrayList<LinkResource>();
		resources.add(new LinkResource("stylesheet", "css/marec.css",
				this, 0));
		return resources;
    }

    @Override
    public List<ScriptResource> getScriptResources() {
		List<ScriptResource> resources = new ArrayList<ScriptResource>();
		/*
		resources.add(new ScriptResource("text/javascript",
				"js/jquery-1.7.1.js", this, 0));
		
		resources.add(new ScriptResource("text/javascript", "js/xmlfiltering.js",
				this, 1));
		return resources;
		*/
		return Collections.emptyList();
    }

    @Override
    public List<NavigationLink> getNavigationLinks() {
        List<NavigationLink> links = new ArrayList<NavigationLink>();
        links.add(new NavigationLink("marec", "/marec", "/imports/marec-sparql-description.ftl", 50));
        return links;
    }


    public BundleContext getBundleContext() {
        return bundleContext;
    }

}
