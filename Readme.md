# E-Commerce Customer Lifetime Value & Cohort Retention Analysis

## Business Question
Olist (a Brazilian e-commerce marketplace) has ~96,000 customers, but only a small
fraction ever make a second purchase. Which customer segments — by geography,
product category, and spend behavior — show the highest actual and predicted
lifetime value, and where should retention effort be concentrated given how thin
the repeat-purchase base is?

## Deliverable
A segment-level CLV ranking, backed by two independent CLV calculations
(historical RFM + probabilistic BG/NBD and Gamma-Gamma modeling), delivered as a
Power BI dashboard with cohort retention visuals and a written recommendation.

## Dataset
[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
(Kaggle) — 9 relational CSVs covering orders, customers, payments, reviews,
products, and sellers.

> Raw CSVs are not included in this repo — download directly from the Kaggle
> link above and place them in a local `data/` folder to reproduce.

## Tech Stack
| Layer | Tools |
|---|---|
| Data cleaning & joins | PostgreSQL — CTEs, window functions, foreign key constraints |
| CLV modeling | Python — pandas, `lifetimes` (BG/NBD + Gamma-Gamma) |
| Supporting calc | Excel — RFM summary/sanity-check |
| Dashboard | Power BI — DAX time-intelligence, cohort heatmaps |

## Repo Structure
```
├── sql/          -- schema creation + verification queries
├── python/        -- data loading and CLV modeling scripts/notebooks
├── dashboard/      -- Power BI file / dashboard screenshots
├── README.md
└── .gitignore
```

## Project Status
- [x] **Phase 1** — PostgreSQL setup, schema design, data ingestion & verification
- [x] **Phase 2** — SQL cleaning, RFM base table, cohort table
- [x] **Phase 3** — CLV modeling in Python (BG/NBD + Gamma-Gamma)
- [ ] **Phase 4** — Power BI dashboard
- [ ] **Phase 5** — Business recommendation & final write-up

## Known Data Considerations
Documenting these upfront rather than glossing over them:
- **`customer_id` vs `customer_unique_id`**: each order generates a new
  `customer_id`; `customer_unique_id` identifies the actual person. All
  repeat-purchase logic in this project uses `customer_unique_id`.
- **Low repeat-purchase rate (~3%)**: the vast majority of customers buy once.
  This directly shapes the project's framing — the goal is identifying *which*
  small segment is worth retention investment, not assuming broad loyalty.
- **`order_reviews` file**: a small number of rows contain embedded line breaks
  inside review text, which breaks naive CSV import; loaded via `psql \copy`
  instead to preserve row alignment.
- **`products.product_category_name`** and **`category_translation`**: a small
  number of nulls/unmapped categories exist in the raw data — noted, not
  silently dropped.

## Author
Saurav Attri — [LinkedIn](https://linkedin.com/in/sauravattri23) · [GitHub](https://github.com/sauravattri23)