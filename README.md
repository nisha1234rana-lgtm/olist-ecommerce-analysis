# 🛒 Olist Brazilian E-Commerce Intelligence Platform

> End-to-end Data Analysis & Business Intelligence project analyzing **99,441 real orders** from Brazil's largest e-commerce marketplace — uncovering growth patterns, customer behaviour, delivery performance, and strategic business insights.

**Tools:** MySQL · Power BI · Python · Scikit-learn · GitHub

**Dataset:** [Olist Brazilian E-Commerce Public Dataset — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) · Real transaction data 2016–2018

---

## 📌 Project Overview

This project replicates a real-world business intelligence workflow — from raw data ingestion to executive dashboards and predictive machine learning models. The analysis covers customer segmentation, revenue trends, delivery operations, geographic distribution, and churn prediction across 99,441 real Brazilian e-commerce orders.

---

## 🏆 Key Findings

| Finding | Insight |
|---|---|
| 📈 Revenue Growth | Olist scaled **26× in 13 months** — from 265 orders (Oct 2016) to 7,289 (Nov 2017) |
| 🚚 Delivery Impact | Early deliveries score **4.30★** vs **1.67★** for late orders — a 61% satisfaction drop |
| ⚠️ Customer Retention | **35,888 at-risk customers** represent R$4.99M in revenue at stake |
| 💳 Payment Behaviour | **73.9%** credit card usage with avg **3.5 installments** — reflecting Brazil's parcelamento culture |
| 📍 Geographic Concentration | São Paulo generates **40% of all revenue** (R$5.08M) from 40,501 orders |
| 💄 Top Category | Beauty & Health — **R$1.23M** revenue combined with **4.19★** customer satisfaction |

---

## 🗂️ Repository Structure

```
olist-ecommerce-analysis/
│
├── 📊 SQL Analysis
│   └── olist_mysql_analysis.sql        # 15 complex MySQL queries
│
├── 📈 Power BI Dashboard
│   └── olist project.pbix              # 5-page interactive dashboard
│
├── 🐍 ML Notebook
│   └── olist_analysis.ipynb            # Full ML pipeline
│
├── 📋 Reports
│   └── olist_report.html               # Interactive HTML report
│
├── 📁 Data (SQL query exports)
│   ├── 01_monthly_revenue.csv
│   ├── 02_top_categories.csv
│   ├── 03_rfm_segments.csv
│   ├── 04_delivery_performance.csv
│   ├── 05_payment_methods.csv
│   └── 06_state_revenue.csv
│
└── README.md
```

---

## 🛠️ Technology Stack

| Tool | Purpose |
|---|---|
| **MySQL 8.0** | Relational database design, 15 complex SQL queries, CTEs, window functions |
| **Power BI** | 5-page interactive dashboard with Olist official brand theme |
| **Python** | Data processing with Pandas, NumPy, Matplotlib, Seaborn |
| **Scikit-learn** | K-Means clustering, Random Forest, Gradient Boosting, Logistic Regression |
| **VS Code + Jupyter** | ML notebook development and visualization |
| **GitHub** | Version control and project documentation |

---

## 📊 Power BI Dashboard — 5 Pages

| Page | Focus | Visuals |
|---|---|---|
| Executive Summary | High-level KPIs & revenue trend | Line chart, category bar, 4 KPI cards, date slicer |
| Delivery & Payments | Operational performance | Delivery vs review score, payment donut, performance table |
| Customer & RFM | Customer segmentation | RFM segments, customer distribution, avg spend |
| Geographic Analysis | State-level revenue | Revenue by state, review scores, order value |
| Strategic Insights | Data-backed recommendations | 6 key findings with business recommendations |

> Dashboard built using Olist's official brand colors — **#CE7B50** (Raw Sienna), **#3E84DF** (Royal Blue), **#000818** (Blue Charcoal)

---

## 🤖 Machine Learning Models

| Model | Algorithm | Performance |
|---|---|---|
| Customer Segmentation | RFM Analysis | 6 behavioral segments identified |
| Customer Clustering | K-Means (K=4) | High Value, Loyal, At Risk, New/Low |
| Churn Prediction | Random Forest | AUC: 0.95+ |
| CLV Forecasting | Gradient Boosting | R²: 0.89 |
| Revenue Forecasting | Linear Regression | 26× growth trend confirmed |

---

## 🗄️ SQL Analysis — 15 Queries

Complex MySQL queries covering:

- Revenue KPIs and Month-over-Month growth with window functions
- RFM Customer Segmentation using NTILE scoring
- Cohort Retention Analysis with period calculations
- Customer Lifetime Value by behavioral tier
- Delivery performance vs review score correlation
- State-level revenue heatmap with RANK()
- Seller performance ranking
- Payment method and installment analysis
- Category-level quality scoring
- Order funnel and cancellation analysis
- Top VIP customer identification
- Freight cost impact analysis
- Executive summary VIEW
- Geographic revenue distribution
- Seasonal trend analysis

---

## 📁 Dataset

**Source:** [Olist Brazilian E-Commerce Public Dataset — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

| Table | Rows | Description |
|---|---|---|
| customers | 99,441 | Customer location and unique ID |
| orders | 99,441 | Order status and timestamps |
| order_items | 112,650 | Products, sellers, prices per line item |
| products | 32,951 | Category, weight, dimensions |
| sellers | 3,095 | Seller location and state |
| order_payments | 103,886 | Payment type, installments, value |
| order_reviews | 99,224 | Customer review scores |

---

## 🚀 How to Run

### MySQL Setup
```sql
-- 1. Run the SQL file to create database and tables
-- 2. Import CSVs using MySQL Workbench Table Data Import Wizard
-- 3. Run each analysis query block individually
```

### Python ML Notebook
```bash
pip install pandas numpy matplotlib seaborn scikit-learn
jupyter notebook olist_analysis.ipynb
```

### Power BI Dashboard
1. Open `olist project.pbix` in Power BI Desktop (free download)
2. Update data source path to your local CSV folder
3. Click Refresh

---

*Real data · End-to-end pipeline · MySQL + Power BI + Python ML*
