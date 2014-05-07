#' @param q Query terms.
#' @param facet.query This param allows you to specify an arbitrary query in the 
#' Lucene default syntax to generate a facet count. By default, faceting returns 
#' a count of the unique terms for a "field", while facet.query allows you to 
#' determine counts for arbitrary terms or expressions. This parameter can be 
#' specified multiple times to indicate that multiple queries should be used as 
#' separate facet constraints. It can be particularly useful for numeric range 
#' based facets, or prefix based facets -- see example below (i.e. price:[* TO 500] 
#' and  price:[501 TO *]).
#' @param facet.field This param allows you to specify a field which should be 
#' treated as a facet. It will iterate over each Term in the field and generate a 
#' facet count using that Term as the constraint. This parameter can be specified 
#' multiple times to indicate multiple facet fields. None of the other params in 
#' this section will have any effect without specifying at least one field name 
#' using this param.
#' @param facet.prefix Limits the terms on which to facet to those starting with 
#' the given string prefix. Note that unlike fq, this does not change the search 
#' results -- it merely reduces the facet values returned to those beginning with 
#' the specified prefix. This parameter can be specified on a per field basis.
#' @param facet.sort See \code{\link[solr]{solr_facet}}. 
#' @param facet.limit This param indicates the maximum number of constraint counts 
#' that should be returned for the facet fields. A negative value means unlimited. 
#' Default: 100. Can be specified on a per field basis.
#' @param facet.offset This param indicates an offset into the list of constraints 
#' to allow paging. Default: 0. This parameter can be specified on a per field basis.
#' @param facet.mincount This param indicates the minimum counts for facet fields 
#' should be included in the response. Default: 0. This parameter can be specified 
#' on a per field basis.
#' @param facet.missing Set to "true" this param indicates that in addition to the 
#' Term based constraints of a facet field, a count of all matching results which 
#' have no value for the field should be computed. Default: FALSE. This parameter 
#' can be specified on a per field basis.
#' @param facet.method See \code{\link[solr]{solr_facet}}.
#' @param facet.enum.cache.minDf This param indicates the minimum document frequency 
#' (number of documents matching a term) for which the filterCache should be used 
#' when determining the constraint count for that term. This is only used when 
#' facet.method=enum method of faceting. A value greater than zero will decrease 
#' memory usage of the filterCache, but increase the query time. When faceting on 
#' a field with a very large number of terms, and you wish to decrease memory usage, 
#' try a low value of 25 to 50 first. Default: 0, causing the filterCache to be used 
#' for all terms in the field. This parameter can be specified on a per field basis.
#' @param facet.threads This param will cause loading the underlying fields used in 
#' faceting to be executed in parallel with the number of threads specified. Specify 
#' as facet.threads=# where # is the maximum number of threads used. Omitting this 
#' parameter or specifying the thread count as 0 will not spawn any threads just as 
#' before. Specifying a negative number of threads will spin up to Integer.MAX_VALUE 
#' threads. Currently this is limited to the fields, range and query facets are not 
#' yet supported. In at least one case this has reduced warmup times from 20 seconds 
#' to under 5 seconds.
#' @param facet.date Specify names of fields (of type DateField) which should be 
#' treated as date facets. Can be specified multiple times to indicate multiple 
#' date facet fields.
#' @param facet.date.start The lower bound for the first date range for all Date 
#' Faceting on this field. This should be a single date expression which may use 
#' the DateMathParser syntax. Can be specified on a per field basis.
#' @param facet.date.end The minimum upper bound for the last date range for all 
#' Date Faceting on this field (see facet.date.hardend for an explanation of what 
#' the actual end value may be greater). This should be a single date expression 
#' which may use the DateMathParser syntax. Can be specified on a per field basis.
#' @param facet.date.gap The size of each date range expressed as an interval to 
#' be added to the lower bound using the DateMathParser syntax. Eg: 
#' facet.date.gap=%2B1DAY (+1DAY). Can be specified on a per field basis. 
#' @param facet.date.hardend A Boolean parameter instructing Solr what to do in the 
#' event that facet.date.gap does not divide evenly between facet.date.start and 
#' facet.date.end. If this is true, the last date range constraint will have an 
#' upper bound of facet.date.end; if false, the last date range will have the smallest 
#' possible upper bound greater then facet.date.end such that the range is exactly 
#' facet.date.gap wide. Default: FALSE. This parameter can be specified on a per 
#' field basis.
#' @param facet.date.other See \code{\link[solr]{solr_facet}}.
#' @param facet.date.include See \code{\link[solr]{solr_facet}}.
#' @param facet.range Indicates what field to create range facets for. Example: 
#' facet.range=price&facet.range=age
#' @param facet.range.start The lower bound of the ranges. Can be specified on a 
#' per field basis. Example: f.price.facet.range.start=0.0&f.age.facet.range.start=10
#' @param facet.range.end The upper bound of the ranges. Can be specified on a per 
#' field basis. Example: f.price.facet.range.end=1000.0&f.age.facet.range.start=99
#' @param facet.range.gap The size of each range expressed as a value to be added 
#' to the lower bound. For date fields, this should be expressed using the 
#' DateMathParser syntax. (ie: facet.range.gap=%2B1DAY ... '+1DAY'). Can be specified 
#' on a per field basis. Example: f.price.facet.range.gap=100&f.age.facet.range.gap=10
#' @param facet.range.hardend A Boolean parameter instructing Solr what to do in the 
#' event that facet.range.gap does not divide evenly between facet.range.start and 
#' facet.range.end. If this is true, the last range constraint will have an upper 
#' bound of facet.range.end; if false, the last range will have the smallest possible 
#' upper bound greater then facet.range.end such that the range is exactly 
#' facet.range.gap wide. Default: FALSE. This parameter can be specified on a 
#' per field basis.
#' @param facet.range.other See \code{\link[solr]{solr_facet}}.
#' @param facet.range.include See \code{\link[solr]{solr_facet}}.
#' @param start Record to start at, default to beginning.
#' @param rows Number of records to return.
#' @param key API key, if needed.
#' @param url URL endpoint
#' @param callopts Call options passed on to httr::GET
#' @param ... Further args.