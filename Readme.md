![logo](https://cloud.githubusercontent.com/assets/6883670/22938783/bbef4474-f2d4-11e6-92a5-07c1a6964491.png)
# Reactome Data Content 

#### What is the Reactome Data Content Project
Reactome Data Content is a web-based project that offers optimized and high performance results based on Apache SolR and also provides detailed results querying Reactome Graph Database. 

Fully implemented based on Spring WebMVC Application, this project consumes [search-core](http://github.com/reactome/search-core) which provides an API to query SolR documents in order to retrieve 
optimized, faceted and grouped results. Spellcheck, suggestions and auto complete are provided to.

#### Requirement

* SolR Index - [search-indexer](http://github.com/reactome/search-indexer)
* Reactome Graph Database - [Download](http://www.reactome.org/download/current/reactome.graphdb.tgz)
* Maven

#### Usage

* Open [Reactome.org](http://reactome.org/)
* On the top right corner the search box retrieves information from SolR documents based on the search term
and organise them in an intuitive way adding the most relevant result always on top of the list. 
Faceting the result by Species, Type, Compartments, etc are also possible

![search-result](https://cloud.githubusercontent.com/assets/6883670/22934396/b33930be-f2c6-11e6-80cb-43ef3574e856.png)

* After clicking in the entry your are looking for, then another query will be executed in Reactome Graph

![search-details](https://cloud.githubusercontent.com/assets/6883670/22936053/3cc78dee-f2cc-11e6-9b53-d4f3a9a14e1d.png)

## Reactome Data Schema

#### What is the Reactome Data Schema
[Reactome Data Schema](http://www.reactome.org/content/schema/DatabaseObject) traverses through all the classes in the Data Model and provides easy visualisation of the hierarchy Reactome classes.

* By clicking in any class the attributes, type, cardinality and the attribute origin are displayed in a table which helps developers to understand
how Reactome classes are related each other. Referrals of the given instance are also shown.

* By clicking in the number in front of the class all the entries will be retrieved.

* By clicking in one entry a query is performed in Reactome Graph Database which gives the instance. All the raw content of the given object, at this point, if details page is available in this instance a button is present in the right corner. 

From the technical side, note the Reactome Data Schema is built as the page is requested as well as the data retrieval. This has been achieved by extensive usage of Java Reflection, which means every time there is an update in Reactome Data Model the changes are going to be automatically propagated to the Data Schema Page. There isn't any static content. You can find documentation for the Reactome data model [here](http://www.reactome.org/pages/documentation/data-model/).
