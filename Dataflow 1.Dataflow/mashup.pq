[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Query_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Query = let
  Source = Json.Document(Web.Contents("https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&chart=mostPopular&maxResults=50&regionCode=IN&key=AIzaSyCue0k5kmtY5hX96XUUlSNlUuXt1zER-aA")),
  #"Converted to table" = Table.FromRecords({Source}),
  #"Expanded items" = Table.ExpandListColumn(#"Converted to table", "items"),
  #"Expanded items1" = Table.ExpandRecordColumn(#"Expanded items", "items", {"kind", "etag", "id", "snippet", "statistics"}, {"items.kind", "items.etag", "items.id", "items.snippet", "items.statistics"}),
  #"Expanded items.snippet" = Table.ExpandRecordColumn(#"Expanded items1", "items.snippet", {"publishedAt", "channelId", "title", "description", "thumbnails", "channelTitle", "tags", "categoryId", "liveBroadcastContent", "defaultLanguage", "localized", "defaultAudioLanguage"}, {"items.snippet.publishedAt", "items.snippet.channelId", "items.snippet.title", "items.snippet.description", "items.snippet.thumbnails", "items.snippet.channelTitle", "items.snippet.tags", "items.snippet.categoryId", "items.snippet.liveBroadcastContent", "items.snippet.defaultLanguage", "items.snippet.localized", "items.snippet.defaultAudioLanguage"}),
  #"Expanded items.snippet.thumbnails" = Table.ExpandRecordColumn(#"Expanded items.snippet", "items.snippet.thumbnails", {"default", "medium", "high", "standard", "maxres"}, {"items.snippet.thumbnails.default", "items.snippet.thumbnails.medium", "items.snippet.thumbnails.high", "items.snippet.thumbnails.standard", "items.snippet.thumbnails.maxres"}),
  #"Expanded items.snippet.thumbnails.default" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails", "items.snippet.thumbnails.default", {"url", "width", "height"}, {"items.snippet.thumbnails.default.url", "items.snippet.thumbnails.default.width", "items.snippet.thumbnails.default.height"}),
  #"Expanded items.snippet.thumbnails.medium" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.default", "items.snippet.thumbnails.medium", {"url", "width", "height"}, {"items.snippet.thumbnails.medium.url", "items.snippet.thumbnails.medium.width", "items.snippet.thumbnails.medium.height"}),
  #"Expanded items.snippet.thumbnails.high" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.medium", "items.snippet.thumbnails.high", {"url", "width", "height"}, {"items.snippet.thumbnails.high.url", "items.snippet.thumbnails.high.width", "items.snippet.thumbnails.high.height"}),
  #"Expanded items.snippet.thumbnails.standard" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.high", "items.snippet.thumbnails.standard", {"url", "width", "height"}, {"items.snippet.thumbnails.standard.url", "items.snippet.thumbnails.standard.width", "items.snippet.thumbnails.standard.height"}),
  #"Expanded items.snippet.thumbnails.maxres" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.standard", "items.snippet.thumbnails.maxres", {"url", "width", "height"}, {"items.snippet.thumbnails.maxres.url", "items.snippet.thumbnails.maxres.width", "items.snippet.thumbnails.maxres.height"}),
  #"Expanded items.snippet.localized" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.maxres", "items.snippet.localized", {"title", "description"}, {"items.snippet.localized.title", "items.snippet.localized.description"}),
  #"Expanded items.statistics" = Table.ExpandRecordColumn(#"Expanded items.snippet.localized", "items.statistics", {"viewCount", "likeCount", "favoriteCount", "commentCount"}, {"items.statistics.viewCount", "items.statistics.likeCount", "items.statistics.favoriteCount", "items.statistics.commentCount"}),
  #"Expanded pageInfo" = Table.ExpandRecordColumn(#"Expanded items.statistics", "pageInfo", {"totalResults", "resultsPerPage"}, {"pageInfo.totalResults", "pageInfo.resultsPerPage"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Expanded pageInfo", {{"items.id", type text}, {"items.snippet.publishedAt", type datetime}, {"items.snippet.channelId", type text}, {"items.snippet.title", type text}, {"items.snippet.description",type text},{"items.snippet.channelTitle", type text}, {"items.snippet.categoryId", Int64.Type}, {"items.snippet.liveBroadcastContent", type text}, {"items.snippet.defaultLanguage", type text}, {"items.snippet.localized.title", type text}, {"items.snippet.localized.description", type text}, {"items.statistics.viewCount", Int64.Type}, {"items.statistics.likeCount", Int64.Type}, {"items.statistics.commentCount", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"items.id", "ID"}}),
  #"Removed other columns" = Table.SelectColumns(#"Renamed columns", {"ID", "items.snippet.publishedAt", "items.snippet.title", "items.snippet.description", "items.statistics.commentCount", "items.statistics.likeCount", "items.statistics.viewCount", "items.snippet.channelTitle", "items.snippet.localized.title"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed other columns", {{"items.snippet.publishedAt", "publishedAt"}, {"items.snippet.title", "Title"}, {"items.snippet.description", "Description"}, {"items.statistics.commentCount", "commentCount"}, {"items.statistics.likeCount", "likeCount"}, {"items.statistics.viewCount", "viewCount"}, {"items.snippet.channelTitle", "channelTitle"}, {"items.snippet.localized.title", "localized.title"}}),
  #"Removed columns" = Table.RemoveColumns(#"Renamed columns 1", {"localized.title"}),
  #"Added custom" = Table.TransformColumnTypes(Table.AddColumn(#"Removed columns", "Country_code", each "IN(India)"), {{"Country_code", type text}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Added custom", {"Description"})
in
  #"Removed columns 1";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Query (2)_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"Query (2)" = let
  Source = Json.Document(Web.Contents("https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&chart=mostPopular&maxResults=50&regionCode=US&key=AIzaSyCue0k5kmtY5hX96XUUlSNlUuXt1zER-aA")),
  #"Converted to table" = Table.FromRecords({Source}),
  #"Expanded items" = Table.ExpandListColumn(#"Converted to table", "items"),
  #"Expanded items1" = Table.ExpandRecordColumn(#"Expanded items", "items", {"kind", "etag", "id", "snippet", "statistics"}, {"items.kind", "items.etag", "items.id", "items.snippet", "items.statistics"}),
  #"Expanded items.snippet" = Table.ExpandRecordColumn(#"Expanded items1", "items.snippet", {"publishedAt", "channelId", "title", "description", "thumbnails", "channelTitle", "tags", "categoryId", "liveBroadcastContent", "defaultLanguage", "localized", "defaultAudioLanguage"}, {"items.snippet.publishedAt", "items.snippet.channelId", "items.snippet.title", "items.snippet.description", "items.snippet.thumbnails", "items.snippet.channelTitle", "items.snippet.tags", "items.snippet.categoryId", "items.snippet.liveBroadcastContent", "items.snippet.defaultLanguage", "items.snippet.localized", "items.snippet.defaultAudioLanguage"}),
  #"Expanded items.snippet.thumbnails" = Table.ExpandRecordColumn(#"Expanded items.snippet", "items.snippet.thumbnails", {"default", "medium", "high", "standard", "maxres"}, {"items.snippet.thumbnails.default", "items.snippet.thumbnails.medium", "items.snippet.thumbnails.high", "items.snippet.thumbnails.standard", "items.snippet.thumbnails.maxres"}),
  #"Expanded items.snippet.thumbnails.default" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails", "items.snippet.thumbnails.default", {"url", "width", "height"}, {"items.snippet.thumbnails.default.url", "items.snippet.thumbnails.default.width", "items.snippet.thumbnails.default.height"}),
  #"Expanded items.snippet.thumbnails.medium" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.default", "items.snippet.thumbnails.medium", {"url", "width", "height"}, {"items.snippet.thumbnails.medium.url", "items.snippet.thumbnails.medium.width", "items.snippet.thumbnails.medium.height"}),
  #"Expanded items.snippet.thumbnails.high" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.medium", "items.snippet.thumbnails.high", {"url", "width", "height"}, {"items.snippet.thumbnails.high.url", "items.snippet.thumbnails.high.width", "items.snippet.thumbnails.high.height"}),
  #"Expanded items.snippet.thumbnails.standard" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.high", "items.snippet.thumbnails.standard", {"url", "width", "height"}, {"items.snippet.thumbnails.standard.url", "items.snippet.thumbnails.standard.width", "items.snippet.thumbnails.standard.height"}),
  #"Expanded items.snippet.thumbnails.maxres" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.standard", "items.snippet.thumbnails.maxres", {"url", "width", "height"}, {"items.snippet.thumbnails.maxres.url", "items.snippet.thumbnails.maxres.width", "items.snippet.thumbnails.maxres.height"}),
  #"Expanded items.snippet.localized" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.maxres", "items.snippet.localized", {"title", "description"}, {"items.snippet.localized.title", "items.snippet.localized.description"}),
  #"Expanded items.statistics" = Table.ExpandRecordColumn(#"Expanded items.snippet.localized", "items.statistics", {"viewCount", "likeCount", "favoriteCount", "commentCount"}, {"items.statistics.viewCount", "items.statistics.likeCount", "items.statistics.favoriteCount", "items.statistics.commentCount"}),
  #"Expanded pageInfo" = Table.ExpandRecordColumn(#"Expanded items.statistics", "pageInfo", {"totalResults", "resultsPerPage"}, {"pageInfo.totalResults", "pageInfo.resultsPerPage"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Expanded pageInfo", {{"items.id", type text}, {"items.snippet.publishedAt", type datetime}, {"items.snippet.channelId", type text}, {"items.snippet.title", type text}, {"items.snippet.description",type text},{"items.snippet.channelTitle", type text}, {"items.snippet.categoryId", Int64.Type}, {"items.snippet.liveBroadcastContent", type text}, {"items.snippet.defaultLanguage", type text}, {"items.snippet.localized.title", type text}, {"items.snippet.localized.description", type text}, {"items.statistics.viewCount", Int64.Type}, {"items.statistics.likeCount", Int64.Type}, {"items.statistics.commentCount", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"items.id", "ID"}}),
  #"Removed other columns" = Table.SelectColumns(#"Renamed columns", {"ID", "items.snippet.publishedAt", "items.snippet.title", "items.snippet.description", "items.statistics.commentCount", "items.statistics.likeCount", "items.statistics.viewCount", "items.snippet.channelTitle", "items.snippet.localized.title"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed other columns", {{"items.snippet.publishedAt", "publishedAt"}, {"items.snippet.title", "Title"}, {"items.snippet.description", "Description"}, {"items.statistics.commentCount", "commentCount"}, {"items.statistics.likeCount", "likeCount"}, {"items.statistics.viewCount", "viewCount"}, {"items.snippet.channelTitle", "channelTitle"}, {"items.snippet.localized.title", "localized.title"}}),
  #"Removed columns" = Table.RemoveColumns(#"Renamed columns 1", {"localized.title"}),
  #"Added custom" = Table.TransformColumnTypes(Table.AddColumn(#"Removed columns", "Country_code", each "US(United State of America)"), {{"Country_code", type text}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Added custom", {"Description"})
in
  #"Removed columns 1";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Query (3)_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"Query (3)" = let
  Source = Json.Document(Web.Contents("https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&chart=mostPopular&maxResults=50&regionCode=GB&key=AIzaSyCue0k5kmtY5hX96XUUlSNlUuXt1zER-aA")),
  #"Converted to table" = Table.FromRecords({Source}),
  #"Expanded items" = Table.ExpandListColumn(#"Converted to table", "items"),
  #"Expanded items1" = Table.ExpandRecordColumn(#"Expanded items", "items", {"kind", "etag", "id", "snippet", "statistics"}, {"items.kind", "items.etag", "items.id", "items.snippet", "items.statistics"}),
  #"Expanded items.snippet" = Table.ExpandRecordColumn(#"Expanded items1", "items.snippet", {"publishedAt", "channelId", "title", "description", "thumbnails", "channelTitle", "tags", "categoryId", "liveBroadcastContent", "defaultLanguage", "localized", "defaultAudioLanguage"}, {"items.snippet.publishedAt", "items.snippet.channelId", "items.snippet.title", "items.snippet.description", "items.snippet.thumbnails", "items.snippet.channelTitle", "items.snippet.tags", "items.snippet.categoryId", "items.snippet.liveBroadcastContent", "items.snippet.defaultLanguage", "items.snippet.localized", "items.snippet.defaultAudioLanguage"}),
  #"Expanded items.snippet.thumbnails" = Table.ExpandRecordColumn(#"Expanded items.snippet", "items.snippet.thumbnails", {"default", "medium", "high", "standard", "maxres"}, {"items.snippet.thumbnails.default", "items.snippet.thumbnails.medium", "items.snippet.thumbnails.high", "items.snippet.thumbnails.standard", "items.snippet.thumbnails.maxres"}),
  #"Expanded items.snippet.thumbnails.default" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails", "items.snippet.thumbnails.default", {"url", "width", "height"}, {"items.snippet.thumbnails.default.url", "items.snippet.thumbnails.default.width", "items.snippet.thumbnails.default.height"}),
  #"Expanded items.snippet.thumbnails.medium" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.default", "items.snippet.thumbnails.medium", {"url", "width", "height"}, {"items.snippet.thumbnails.medium.url", "items.snippet.thumbnails.medium.width", "items.snippet.thumbnails.medium.height"}),
  #"Expanded items.snippet.thumbnails.high" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.medium", "items.snippet.thumbnails.high", {"url", "width", "height"}, {"items.snippet.thumbnails.high.url", "items.snippet.thumbnails.high.width", "items.snippet.thumbnails.high.height"}),
  #"Expanded items.snippet.thumbnails.standard" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.high", "items.snippet.thumbnails.standard", {"url", "width", "height"}, {"items.snippet.thumbnails.standard.url", "items.snippet.thumbnails.standard.width", "items.snippet.thumbnails.standard.height"}),
  #"Expanded items.snippet.thumbnails.maxres" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.standard", "items.snippet.thumbnails.maxres", {"url", "width", "height"}, {"items.snippet.thumbnails.maxres.url", "items.snippet.thumbnails.maxres.width", "items.snippet.thumbnails.maxres.height"}),
  #"Expanded items.snippet.localized" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.maxres", "items.snippet.localized", {"title", "description"}, {"items.snippet.localized.title", "items.snippet.localized.description"}),
  #"Expanded items.statistics" = Table.ExpandRecordColumn(#"Expanded items.snippet.localized", "items.statistics", {"viewCount", "likeCount", "favoriteCount", "commentCount"}, {"items.statistics.viewCount", "items.statistics.likeCount", "items.statistics.favoriteCount", "items.statistics.commentCount"}),
  #"Expanded pageInfo" = Table.ExpandRecordColumn(#"Expanded items.statistics", "pageInfo", {"totalResults", "resultsPerPage"}, {"pageInfo.totalResults", "pageInfo.resultsPerPage"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Expanded pageInfo", {{"items.id", type text}, {"items.snippet.publishedAt", type datetime}, {"items.snippet.channelId", type text}, {"items.snippet.title", type text}, {"items.snippet.description",type text},{"items.snippet.channelTitle", type text}, {"items.snippet.categoryId", Int64.Type}, {"items.snippet.liveBroadcastContent", type text}, {"items.snippet.defaultLanguage", type text}, {"items.snippet.localized.title", type text}, {"items.snippet.localized.description", type text}, {"items.statistics.viewCount", Int64.Type}, {"items.statistics.likeCount", Int64.Type}, {"items.statistics.commentCount", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"items.id", "ID"}}),
  #"Removed other columns" = Table.SelectColumns(#"Renamed columns", {"ID", "items.snippet.publishedAt", "items.snippet.title", "items.snippet.description", "items.statistics.commentCount", "items.statistics.likeCount", "items.statistics.viewCount", "items.snippet.channelTitle", "items.snippet.localized.title"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed other columns", {{"items.snippet.publishedAt", "publishedAt"}, {"items.snippet.title", "Title"}, {"items.snippet.description", "Description"}, {"items.statistics.commentCount", "commentCount"}, {"items.statistics.likeCount", "likeCount"}, {"items.statistics.viewCount", "viewCount"}, {"items.snippet.channelTitle", "channelTitle"}, {"items.snippet.localized.title", "localized.title"}}),
  #"Removed columns" = Table.RemoveColumns(#"Renamed columns 1", {"localized.title"}),
  #"Added custom" = Table.TransformColumnTypes(Table.AddColumn(#"Removed columns", "Country_code", each "UK(United Kingdom)"), {{"Country_code", type text}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Added custom", {"Description"})
in
  #"Removed columns 1";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Query (4)_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"Query (4)" = let
  Source = Json.Document(Web.Contents("https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&chart=mostPopular&maxResults=50&regionCode=DE&key=AIzaSyCue0k5kmtY5hX96XUUlSNlUuXt1zER-aA")),
  #"Converted to table" = Table.FromRecords({Source}),
  #"Expanded items" = Table.ExpandListColumn(#"Converted to table", "items"),
  #"Expanded items1" = Table.ExpandRecordColumn(#"Expanded items", "items", {"kind", "etag", "id", "snippet", "statistics"}, {"items.kind", "items.etag", "items.id", "items.snippet", "items.statistics"}),
  #"Expanded items.snippet" = Table.ExpandRecordColumn(#"Expanded items1", "items.snippet", {"publishedAt", "channelId", "title", "description", "thumbnails", "channelTitle", "tags", "categoryId", "liveBroadcastContent", "defaultLanguage", "localized", "defaultAudioLanguage"}, {"items.snippet.publishedAt", "items.snippet.channelId", "items.snippet.title", "items.snippet.description", "items.snippet.thumbnails", "items.snippet.channelTitle", "items.snippet.tags", "items.snippet.categoryId", "items.snippet.liveBroadcastContent", "items.snippet.defaultLanguage", "items.snippet.localized", "items.snippet.defaultAudioLanguage"}),
  #"Expanded items.snippet.thumbnails" = Table.ExpandRecordColumn(#"Expanded items.snippet", "items.snippet.thumbnails", {"default", "medium", "high", "standard", "maxres"}, {"items.snippet.thumbnails.default", "items.snippet.thumbnails.medium", "items.snippet.thumbnails.high", "items.snippet.thumbnails.standard", "items.snippet.thumbnails.maxres"}),
  #"Expanded items.snippet.thumbnails.default" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails", "items.snippet.thumbnails.default", {"url", "width", "height"}, {"items.snippet.thumbnails.default.url", "items.snippet.thumbnails.default.width", "items.snippet.thumbnails.default.height"}),
  #"Expanded items.snippet.thumbnails.medium" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.default", "items.snippet.thumbnails.medium", {"url", "width", "height"}, {"items.snippet.thumbnails.medium.url", "items.snippet.thumbnails.medium.width", "items.snippet.thumbnails.medium.height"}),
  #"Expanded items.snippet.thumbnails.high" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.medium", "items.snippet.thumbnails.high", {"url", "width", "height"}, {"items.snippet.thumbnails.high.url", "items.snippet.thumbnails.high.width", "items.snippet.thumbnails.high.height"}),
  #"Expanded items.snippet.thumbnails.standard" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.high", "items.snippet.thumbnails.standard", {"url", "width", "height"}, {"items.snippet.thumbnails.standard.url", "items.snippet.thumbnails.standard.width", "items.snippet.thumbnails.standard.height"}),
  #"Expanded items.snippet.thumbnails.maxres" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.standard", "items.snippet.thumbnails.maxres", {"url", "width", "height"}, {"items.snippet.thumbnails.maxres.url", "items.snippet.thumbnails.maxres.width", "items.snippet.thumbnails.maxres.height"}),
  #"Expanded items.snippet.localized" = Table.ExpandRecordColumn(#"Expanded items.snippet.thumbnails.maxres", "items.snippet.localized", {"title", "description"}, {"items.snippet.localized.title", "items.snippet.localized.description"}),
  #"Expanded items.statistics" = Table.ExpandRecordColumn(#"Expanded items.snippet.localized", "items.statistics", {"viewCount", "likeCount", "favoriteCount", "commentCount"}, {"items.statistics.viewCount", "items.statistics.likeCount", "items.statistics.favoriteCount", "items.statistics.commentCount"}),
  #"Expanded pageInfo" = Table.ExpandRecordColumn(#"Expanded items.statistics", "pageInfo", {"totalResults", "resultsPerPage"}, {"pageInfo.totalResults", "pageInfo.resultsPerPage"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Expanded pageInfo", {{"items.id", type text}, {"items.snippet.publishedAt", type datetime}, {"items.snippet.channelId", type text}, {"items.snippet.title", type text}, {"items.snippet.description",type text},{"items.snippet.channelTitle", type text}, {"items.snippet.categoryId", Int64.Type}, {"items.snippet.liveBroadcastContent", type text}, {"items.snippet.defaultLanguage", type text}, {"items.snippet.localized.title", type text}, {"items.snippet.localized.description", type text}, {"items.statistics.viewCount", Int64.Type}, {"items.statistics.likeCount", Int64.Type}, {"items.statistics.commentCount", Int64.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type", {{"items.id", "ID"}}),
  #"Removed other columns" = Table.SelectColumns(#"Renamed columns", {"ID", "items.snippet.publishedAt", "items.snippet.title", "items.snippet.description", "items.statistics.commentCount", "items.statistics.likeCount", "items.statistics.viewCount", "items.snippet.channelTitle", "items.snippet.localized.title"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Removed other columns", {{"items.snippet.publishedAt", "publishedAt"}, {"items.snippet.title", "Title"}, {"items.snippet.description", "Description"}, {"items.statistics.commentCount", "commentCount"}, {"items.statistics.likeCount", "likeCount"}, {"items.statistics.viewCount", "viewCount"}, {"items.snippet.channelTitle", "channelTitle"}, {"items.snippet.localized.title", "localized.title"}}),
  #"Removed columns" = Table.RemoveColumns(#"Renamed columns 1", {"localized.title"}),
  #"Added custom" = Table.TransformColumnTypes(Table.AddColumn(#"Removed columns", "Country_code", each "DE(Germany)"), {{"Country_code", type text}}),
  #"Removed columns 1" = Table.RemoveColumns(#"Added custom", {"Description"})
in
  #"Removed columns 1";
shared #"Query (3)_DataDestination" = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "426f0a69-fcff-4962-a896-60f4d743937e"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6159a7f6-6232-4f9b-8e1e-e95fe55773ad"]}[Data],
  TableNavigation = Navigation_2{[Id = "YOUTUBE_UK", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared #"Query (4)_DataDestination" = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "426f0a69-fcff-4962-a896-60f4d743937e"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6159a7f6-6232-4f9b-8e1e-e95fe55773ad"]}[Data],
  TableNavigation = Navigation_2{[Id = "YOUTUBE_GERMANY", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared NavigationQuery = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false])
in
  Source;
shared Query_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "426f0a69-fcff-4962-a896-60f4d743937e"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6159a7f6-6232-4f9b-8e1e-e95fe55773ad"]}[Data],
  TableNavigation = Navigation_2{[Id = "YOUTUBE_INDIA", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared #"Query (2)_DataDestination" = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "426f0a69-fcff-4962-a896-60f4d743937e"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6159a7f6-6232-4f9b-8e1e-e95fe55773ad"]}[Data],
  TableNavigation = Navigation_2{[Id = "YOUTUBE_USA", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Append_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared Append = let
  Source = Table.Combine({Query, #"Query (2)", #"Query (3)", #"Query (4)"})
in
  Source;
shared Append_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "426f0a69-fcff-4962-a896-60f4d743937e"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "6159a7f6-6232-4f9b-8e1e-e95fe55773ad"]}[Data],
  TableNavigation = Navigation_2{[Id = "ALL_YOUTUBE", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
