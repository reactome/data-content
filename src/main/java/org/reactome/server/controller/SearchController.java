package org.reactome.server.controller;

import org.reactome.server.tools.interactors.model.InteractionResource;
import org.reactome.server.tools.interactors.model.InteractorResource;
import org.reactome.server.tools.interactors.service.InteractionResourceService;
import org.reactome.server.tools.interactors.service.InteractorResourceService;
import org.reactome.server.tools.search.domain.*;
import org.reactome.server.tools.search.exception.EnricherException;
import org.reactome.server.tools.search.exception.SolrSearcherException;
import org.reactome.server.tools.search.service.SearchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("")
class SearchController {


}
