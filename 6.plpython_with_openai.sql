--------------------------------------------------------------------------------------
-- Question Answering using ChatGPT and Greenplum pgvector
--------------------------------------------------------------------------------------

-- 1. enable pgvector extension 
CREATE EXTENSION vector;

-- 2. create a product documentation table with vector data-type 
DROP TABLE IF EXISTS tanzu_documents; 

CREATE TABLE tanzu_documents (
      id bigserial PRIMARY KEY, 
      content TEXT, 
      embedding vector(1536)
) DISTRIBUTED BY (id);


-- insert into tanzu_documents table
INSERT INTO tanzu_documents(content) 
VALUES ('Welcome to VMware Greenplum 7
VMware Greenplum is a massively parallel processing (MPP) database server that supports next generation data warehousing and large-scale analytics processing. By automatically partitioning data and running parallel queries, it allows a cluster of servers to operate as a single database supercomputer performing tens or hundreds times faster than a traditional database. It supports SQL and data volumes ranging from hundreds of gigabytes, to hundreds of terabytes.

Differences Compared to Open Source Greenplum Database
VMware Greenplum 7 includes all of the functionality in the open source Greenplum Database project and adds:

Product packaging and installation script
Support for QuickLZ compression. QuickLZ compression is not provided in the open source version of Greenplum Database due to licensing restrictions.
Support for retrieving query results with a Parallel Retrieve Cursor.
Support for data connectors:
 - Greenplum-NiFi Connector
 - Greenplum-Spark Connector
 - Greenplum-Informatica Connector
 - Greenplum-Kafka Integration
 - Greenplum Streaming Server
Support for Greenplum-sourced or enhanced contrib modules:
 - advanced_password_check
 - diskquota
 - gp_legacy_string_agg
 - gp_sparse_vector
 - greenplum_fdw
 - orafce
Data Direct ODBC/JDBC Drivers
Greenplum PostGIS Extension
gpcopy utility for copying or migrating objects between Greenplum systems
Support for managing Greenplum Database using VMware Greenplum Command Center
Support for full text search and text analysis using VMware Greenplum Text
Greenplum backup plugin for DD Boost
Backup/restore storage plugin API 

reference url: https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/landing-index.html 
');

INSERT INTO tanzu_documents (content) VALUES ('Greenplum Database Best Practices.

Data Model.

Greenplum Database is an analytical MPP shared-nothing database. This model is significantly different from a highly normalized/transactional SMP database. Because of this, the following best practices are recommended.

Greenplum Database performs best with a denormalized schema design suited for MPP analytical processing for example, Star or Snowflake schema, with large fact tables and smaller dimension tables.
Use the same data types for columns used in joins between tables.

reference url: https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/best_practices-schema.html
');

INSERT INTO tanzu_documents (content) VALUES ('Greenplum Database Best Practices

Security

Secure the gpadmin user id and only allow essential system administrators access to it.
Administrators should only log in to Greenplum as gpadmin when performing certain system maintenance tasks (such as upgrade or expansion).
Limit users who have the SUPERUSER role attribute. Roles that are superusers bypass all access privilege checks in Greenplum Database, as well as resource queuing. Only system administrators should be given superuser rights. in the Greenplum Database Administrator Guide.
Database users should never log on as gpadmin, and ETL or production workloads should never run as gpadmin.
Assign a distinct Greenplum Database role to each user, application, or service that logs in.
For applications or web services, consider creating a distinct role for each application or service.
Use groups to manage access privileges.
Protect the root password.
Enforce a strong password password policy for operating system passwords.
Ensure that important operating system files are protected.

reference url: https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/best_practices-security.html
');

INSERT INTO tanzu_documents (content) VALUES ('Greenplum Database Best Practices

Partitioning

Partition large tables only. Do not partition small tables.
Use partitioning only if partition elimination (partition pruning) can be achieved based on the query criteria.
Choose range partitioning over list partitioning.
Partition the table based on a commonly-used column, such as a date column.
Never partition and distribute tables on the same column.
Do not use default partitions.
Do not use multi-level partitioning; create fewer partitions with more data in each partition.
Validate that queries are selectively scanning partitioned tables (partitions are being eliminated) by examining the query EXPLAIN plan.
Do not create too many partitions with column-oriented storage because of the total number of physical files on every segment: physical files = segments x columns x partitions. 

reference url: https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/best_practices-schema.html
');

INSERT INTO tanzu_documents (content) VALUES ('Greenplum Database Best Practices.

Distributions.

Explicitly define a column or random distribution for all tables. Do not use the default.
Use a single column that will distribute data across all segments evenly.
Do not distribute on columns that will be used in the WHERE clause of a query.
Do not distribute on dates or timestamps.
Never distribute and partition tables on the same column.
Achieve local joins to significantly improve performance by distributing on the same column for large tables commonly joined together.
To ensure there is no data skew, validate that data is evenly distributed after the initial load and after incremental loads.

reference url: https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/best_practices-schema.html
');

INSERT INTO tanzu_documents (content) VALUES ('Greenplum Database Best Practices.

Indexes.

In general indexes are not needed in Greenplum Database.
Create an index on a single column of a columnar table for drill-through purposes for high cardinality tables that require queries with high selectivity.
Do not index columns that are frequently updated.
Consider dropping indexes before loading data into a table. After the load, re-create the indexes for the table.
Create selective B-tree indexes.
Do not create bitmap indexes on columns that are updated.
Avoid using bitmap indexes for unique columns, very high or very low cardinality data. Bitmap indexes perform best when the column has a low cardinality—100 to 100,000 distinct values.
Do not use bitmap indexes for transactional workloads.
In general do not index partitioned tables. If indexes are needed, the index columns must be different than the partition columns.

reference url: https://docs.vmware.com/en/VMware-Greenplum/7/greenplum-database/best_practices-schema.html
');

INSERT INTO tanzu_documents (content) VALUES ('Introduction to PXF

The Greenplum Platform Extension Framework (PXF) provides connectors that enable you to access data stored in sources external to your Greenplum Database deployment. These connectors map an external data source to a Greenplum Database external table definition. When you create the Greenplum Database external table, you identify the external data store and the format of the data via a server name and a profile name that you provide in the command.

You can query the external table via Greenplum Database, leaving the referenced data in place. Or, you can use the external table to load the data into Greenplum Database for higher performance.

Supported Platforms
Operating Systems
PXF is compatible with these operating system platforms and Greenplum Database versions:
RHEL 7.x, CentOS 7.x, OEL 7.x, Ubuntu 18.04 LTS, RHEL 8.x

Java
PXF supports Java 8 and Java 11.

Hadoop
PXF bundles all of the Hadoop JAR files on which it depends, and supports the following Hadoop component versions:

Architectural Overview
Your Greenplum Database deployment consists of a coordinator host, a standby coordinator host, and multiple segment hosts. A single PXF Service process runs on each Greenplum Database host. The PXF Service process running on a segment host allocates a worker thread for each segment instance on the host that participates in a query against an external table. The PXF Services on multiple segment hosts communicate with the external data store in parallel. The PXF Service process running on the coordinator and standby coordinator hosts are not currently involved in data transfer; these processes may be used for other purposes in the future.

About Connectors, Servers, and Profiles
Connector is a generic term that encapsulates the implementation details required to read from or write to an external data store. PXF provides built-in connectors to Hadoop (HDFS, Hive, HBase), object stores (Azure, Google Cloud Storage, MinIO, AWS S3, and Dell ECS), and SQL databases (via JDBC).

A PXF Server is a named configuration for a connector. A server definition provides the information required for PXF to access an external data source. This configuration information is data-store-specific, and may include server location, access credentials, and other relevant properties.

The Greenplum Database administrator will configure at least one server definition for each external data store that they will allow Greenplum Database users to access, and will publish the available server names as appropriate.

You specify a SERVER=<server_name> setting when you create the external table to identify the server configuration from which to obtain the configuration and credentials to access the external data store.

The default PXF server is named default (reserved), and when configured provides the location and access information for the external data source in the absence of a SERVER=<server_name> setting.

Finally, a PXF profile is a named mapping identifying a specific data format or protocol supported by a specific external data store. PXF supports text, Avro, JSON, RCFile, Parquet, SequenceFile, and ORC data formats, and the JDBC protocol, and provides several built-in profiles as discussed in the following section.

Creating an External Table
PXF implements a Greenplum Database protocol named pxf that you can use to create an external table that references data in an external data store. The syntax for a CREATE EXTERNAL TABLE command that specifies the pxf protocol follows:

CREATE [WRITABLE] EXTERNAL TABLE <table_name>
        ( <column_name> <data_type> [, ...] | LIKE <other_table> )
LOCATION(pxf://<path-to-data>?PROFILE=<profile_name>[&SERVER=<server_name>][&<custom-option>=<value>[...]])
FORMAT [TEXT|CSV|CUSTOM] (<formatting-properties>);

The LOCATION clause in a CREATE EXTERNAL TABLE statement specifying the pxf protocol is a URI. This URI identifies the path to, or other information describing, the location of the external data. For example, if the external data store is HDFS, the <path-to-data> identifies the absolute path to a specific HDFS file. If the external data store is Hive, <path-to-data> identifies a schema-qualified Hive table name.

You use the query portion of the URI, introduced by the question mark (?), to identify the PXF server and profile names.

PXF may require additional information to read or write certain data formats. You provide profile-specific information using the optional <custom-option>=<value> component of the LOCATION string and formatting information via the <formatting-properties> component of the string. The custom options and formatting properties supported by a specific profile vary; they are identified in usage documentation for the profile.

Table 1. CREATE EXTERNAL TABLE Parameter Values and Descriptions

Keyword     Value and Description
<path‑to‑data>    A directory, file name, wildcard pattern, table name, etc. The syntax of <path-to-data> is dependent upon the external data source.
PROFILE=<profile_name>  The profile that PXF uses to access the data. PXF supports profiles that access text, Avro, JSON, RCFile, Parquet, SequenceFile, and ORC data in Hadoop services, object stores, network file systems, and other SQL databases.
SERVER=<server_name>    The named server configuration that PXF uses to access the data. PXF uses the default server if not specified.
<custom‑option>=<value> Additional options and their values supported by the profile or the server. 
FORMAT <value>    PXF profiles support the TEXT, CSV, and CUSTOM formats.
<formatting‑properties> Formatting properties supported by the profile; for example, the FORMATTER or delimiter.  
Note: When you create a PXF external table, you cannot use the HEADER option in your formatter specification.

reference url: https://docs.vmware.com/en/VMware-Greenplum-Platform-Extension-Framework/6.7/greenplum-platform-extension-framework/intro_pxf.html
');

SELECT * FROM tanzu_documents ORDER BY id LIMIT 10;


-- 3. Greenplum PL/Python function to get OpenAI embeddings
DROP FUNCTION IF EXISTS get_embedding(text);
CREATE OR REPLACE FUNCTION get_embedding(content text) 
RETURNS VECTOR 
AS 
$$
      import openai
      ## hongdon
      openai.api_key = "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"
      ## sanghee
      #openai.api_key = "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"
      
      text = content 
      
      response = openai.Embedding.create(
            model="text-embedding-ada-002", 
            input = text.replace("\n", " ")
            )
            
      embedding = response['data'][0]['embedding']
      
      return embedding
      
$$ LANGUAGE plpython3u;


-- 4. Data loading to Greenplum table
UPDATE tanzu_documents SET embedding = get_embedding(content)
WHERE embedding IS NULL ;

SELECT * FROM tanzu_documents;

WITH cte_question_embedding AS 
  (
SELECT 
      get_embedding(
      'How to create an external table in Greenplum 
         using PXF to read from an Oracle database ?'
         ) 
        AS question_embeddings 
) 
SELECT 
      id
    , content
    , embedding <=> cte_question_embedding.question_embeddings AS distance 
FROM tanzu_documents, cte_question_embedding  
ORDER BY embedding <=> cte_question_embedding.question_embeddings ASC 
LIMIT 1;



