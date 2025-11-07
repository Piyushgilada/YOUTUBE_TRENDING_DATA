# 📊 YouTube Trending Analytics — Schema Overview

### Dataflow: Dataflow 1
- Extracts raw CSV/JSON from YouTube API
- Transforms columns: ChannelTitle, CommentCount, CountryCode, VideoID, LikeCount, PublishDate, Title, ViewCount
- Loads to: YouTubeTrendingLakehouse

### Semantic Models:
#### 1.SEMANTIC1
- Measures:
  - Total Views = SUM(ViewCount)
  - Total Likes = SUM(LikeCount)
  - Total Comments=SUM(CommentsCount)
- Tables:
  - YouTubeTrending (Lakehouse Table)

### Report:
**Youtube_trending_analysis_4country**
- Page 1: Global
- Page 2: Germany (DE)
- Page 3: India (IN)
- Page 4: UK (GB)
- Page 5: US (US)

Lakehouse: YouTubeTrendingLakehouse
- Tables:
  - All_YOUTUBE
- View:
  - GERMANY_YOUTUBE_VIEW
  - INDIA_YOUTUBE_VIEW
  - UK_YOUTUBE_VIEW
  - US_YOUTUBE_VIEW
- SQL Endpoint:
  - YouTubeTrendingLakehouse
