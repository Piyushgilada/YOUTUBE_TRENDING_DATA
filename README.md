
# 🎥 YouTube Trending Analytics (Microsoft Fabric + Power BI)

A complete end-to-end analytics project built in **Microsoft Fabric** to explore and visualize **YouTube trending data** across multiple countries (Germany, India, UK, US, and Global).  
This project demonstrates **data ingestion**, **transformation**, **semantic modeling**, and **Power BI reporting** — all managed and version-controlled through **GitHub integration**.

---

## 📘 Project Overview

| Component | Description |
|------------|-------------|
| **Data Source** | YouTube Trending dataset (channel title, comments, country, likes, publish date, title, views) |
| **Goal** | Analyze engagement metrics by country and visualize top trends |
| **Tools Used** | Microsoft Fabric, Power BI, Dataflow Gen2, Lakehouse, Semantic Models |
| **Data Refresh** | Automated through Fabric Dataflow |
| **Version Control** | GitHub Integration (Fabric Workspace → GitHub Repository) |

---

## 🏗️ Architecture

```text
YouTube Data (CSV/API)
      │
      ▼
[ Dataflow Gen2 (ETL) ]
      │
      ▼
[ Lakehouse Storage ]
      │
      ▼
[ Semantic Models ]
      │
      ▼
[ Power BI Report Pages ]
(Global, DE, IN, GB, US)
