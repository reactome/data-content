[<img src=https://user-images.githubusercontent.com/6883670/31999264-976dfb86-b98a-11e7-9432-0316345a72ea.png height=75 />](https://reactome.org)

# Reactome Data Content 

#### What is the Reactome Data Content Project
Reactome Data Content is a web-based project that offers optimized and high performance results based on Apache SolR and also provides detailed results querying Reactome Graph Database. 

Fully implemented based on Spring WebMVC Application, this project consumes [search-core](https://github.com/reactome/search-core) which provides an API to query SolR documents in order to retrieve
optimized, faceted and grouped results. Spellcheck, suggestions and auto complete are provided to.

#### Installation Guide

* :warning: Pre-Requirement (in the given order)
    1. Maven 3.X - [Installation Guide](http://maven.apache.org/install.html)
    2. Reactome Graph Database - [Installation Guide](https://reactome.org/dev/graph-database/)
    3. Search SolR Index - [search-indexer](https://github.com/reactome/search-indexer)
        * Search Indexer queries Reactome Graph Database, so it must be set up before the SolR indexer
        * Search Indexer guides though SolR installation, core and indexing.
    4. Mail Server (if you don't have a valid SMTP Server, please here to [FakeSMTP](http://nilhcem.com/FakeSMTP/index.html)
    
##### Git Clone

```console
git clone https://github.com/reactome/data-content.git
```

##### Configuring Maven Profile :memo:

Maven Profile is a set of configuration values which can be used to set or override default values of Maven build. Using a build profile, you can customize build for different environments such as Production v/s Development environments.
Add the following code-snippet containing all the Reactome properties inside the tag ```<profiles>``` into your ```~/.m2/settings.xml```. 
Please refer to Maven Profile [Guideline](http://maven.apache.org/guides/introduction/introduction-to-profiles.html) if you don't have settings.xml


```html
<profile>
    <id>DataContent-Local</id>
    <properties>
        <!-- Neo4j Configuration -->
        <neo4j.host>localhost</neo4j.host>
        <neo4j.port>7474</neo4j.port>
        <neo4j.user>neo4j</neo4j.user>
        <neo4j.password>neo4j</neo4j.password>
        
        <!-- SolR Configuration -->
        <solr.host>http://localhost:8983/solr/reactome</solr.host>
        <solr.user>solr</solr.user>
        <solr.password>solr</solr.password>

        <!-- Logging -->
        <logging.dir>/Users/reactome/Reactome/search</logging.dir>
        <logging.level>INFO</logging.level>

        <!-- Mail Configuration, using FakeSMTP -->
        <!-- Properties are ready to use GMail, etc. -->
        <mail.host>localhost</mail.host>
        <mail.port>8081</mail.port>
        <mail.username>username</mail.username>
        <mail.password>password</mail.password>
        <mail.enable.auth>false</mail.enable.auth>
        <mail.error.dest>bug-fixing-team@mycompany.co.uk</mail.error.dest>
        <mail.support.dest>helpdesk@mycompany.co.uk</mail.support.dest>
            
        <!-- Reactome Server to query header and footer -->
        <template.server>https://reactomedev.oicr.on.ca/</template.server>
    </properties>
</profile>
```

##### Running Data-Content activating ```DataContent-Local``` profile
```console
mvn tomcat7:run -P DataContent-Local
```

in case you didn't set up the profile it is still possible to run Reactome Data Content. You may need to add all the properties into a command-line call.
```console
mvn tomcat7:run \ 
    -Dneo4j.user=neo4j -Dneo4j.password=neo4j -Dneo4j.host=localhost -Dneo4j.port=7474 \
    -Dsolr.host=http://localhost:8983/solr/reactome -Dsolr.user=solr -Dsolr.password=solr \
    -Dlogging.dir=/Users/reactome/Reactome/search \
    -Dlogging.level=INFO \
    -Dmail.host=localhost -Dmail.port=8081 -Dmail.username=username -Dmail.password=password \ 
    -Dmail.enable.auth=false -Dmail.error.dest=bug-fixing-team@mycompany.co.uk \
    -Dmail.support.dest=helpdesk@mycompany.co.uk \ 
    -Dtemplate.server=https://reactomedev.oicr.on.ca/
```

Check if Tomcat has been initialised
```rb
[INFO] Using existing Tomcat server configuration at /Users/reactome/data-content/target/tomcat
INFO: Starting ProtocolHandler ["http-bio-8080"]
```

#### Usage 

* :computer: Access your local [installation](http://localhost:8080/)
* On the top right corner the search box retrieves information from SolR documents based on the search term
and organise them in an intuitive way adding the most relevant result always on top of the list. 
Faceting the result by Species, Type, Compartments, etc are also possible. The entry point for all these features is [SearchController.java](https://github.com/reactome/data-content/blob/master/src/main/java/org/reactome/server/controller/SearchController.java) 

![search-result](https://user-images.githubusercontent.com/6883670/35401987-1343df86-01f3-11e8-9f67-28cb32415eba.png)

* After clicking in the entry your are looking for, then another query will be executed in Reactome Graph. The entry point is the [GraphController.java](https://github.com/reactome/data-content/blob/master/src/main/java/org/reactome/server/controller/GraphController.java)

![search-details](https://user-images.githubusercontent.com/6883670/35402019-28fbd22a-01f3-11e8-949a-e4ae2acbb5b2.png)


## Reactome Data Schema

#### What is the Reactome Data Schema
[Reactome Data Schema](https://reactome.org/content/schema/DatabaseObject) traverses through all the classes in the Data Model and provides easy visualisation of Reactome classes hierarchy.

#### Installation

Reactome Data Content already installed together with the Data Content. 

#### Usage

* :computer: Access your local [installation](http://localhost:8080/schema/DatabaseObject)

* By clicking in any class the attributes, type, cardinality and the attribute origin are displayed in a table which helps developers to understand
how Reactome classes are related each other. Referrals of the given instance are also shown.

* By clicking in the number in front of the class all the entries will be retrieved.

* By clicking in one entry a query is performed in Reactome Graph Database which gives the instance. All the raw content of the given object, at this point, if details page is available in this instance a button is present in the right corner. 

From the technical side, note the Reactome Data Schema is built as the page is requested as well as the data retrieval. This has been achieved by extensive usage of Java Reflection, which means every time there is an update in Reactome Data Model the changes are going to be automatically propagated to the Data Schema Page. There isn't any static content. You can find documentation for the Reactome data model [here](https://reactome.org/documentation/data-model/).
Also the entry point class is the [GraphController.java](https://github.com/reactome/data-content/blob/master/src/main/java/org/reactome/server/controller/GraphController.java)

![content-schema](https://user-images.githubusercontent.com/6883670/35402055-3dae5648-01f3-11e8-9bb9-869db7f48628.png)