# 📊 Future Jobs & Skills Demand Analysis (2025)

### *EDA + Hiring Churn Analysis*

## 📌 Project Overview

This project analyzes **future job market trends for 2025**, focusing on **job demand, salary distribution, skills requirements, remote work trends, and hiring churn** across emerging industries.

The analysis is performed using **SQL (MySQL)** for data exploration and metric computation, and is designed to simulate **real-world hiring and talent demand behavior**.

> ⚠️ **Note:** The dataset used in this project is **synthetic**, sourced from Kaggle, and created to simulate realistic job market patterns.
> No real company or job posting data is used.
> Dataset : https://www.kaggle.com/datasets/ahsanneural/future-jobs-and-skills-demand-2025
---

## 🗂 Dataset Description

* **Total records:** 10,000 job postings
* **Industries covered:**

  * Artificial Intelligence
  * Blockchain
  * Green Technology
  * Quantum Computing
* **Time period:** January–December 2025

### Key Columns

* `job_title`
* `industry`
* `location`
* `salary_usd`
* `skills_required`
* `remote_option`
* `company_size`
* `posting_date`
* `hiring_entity_id` *(synthetically derived)*

---

## 🎯 Key Business Metrics & Insights

### 1️⃣ Job Market Overview

#### 🔹 Percentage of Remote Jobs

* **50.89%** of all job postings offer remote work
  📌 *Insight:* Remote work is nearly evenly split with on-site roles, indicating hybrid hiring dominance in 2025.

---

#### 🔹 Top Job Locations

Top hiring cities by number of postings:

* New York (1,689)
* Singapore (1,682)
* Tokyo (1,673)
* Dubai (1,660)
* London (1,656)

📌 *Insight:* Hiring demand is globally distributed, with strong representation from North America, Asia, and the Middle East.

---

### 2️⃣ Salary & Compensation Analysis

#### 🔹 Salary Distribution by Industry

| Industry          | Avg Salary (USD) |
| ----------------- | ---------------- |
| AI                | 150,672          |
| Quantum Computing | 151,131          |
| Blockchain        | 149,384          |
| Green Tech        | 149,330          |

📌 *Insight:* All four emerging industries offer **high and competitive compensation**, with Quantum Computing and AI slightly leading.

---

#### 🔹 Top 10 Highest Paying Job Roles

Some of the highest-paying roles include:

* Quantum Software Developer
* ML Researcher
* Sustainability Analyst
* Data Scientist
* Smart Contract Engineer

📌 *Insight:* Advanced research-oriented and deep-tech roles command the highest salaries.

---

### 3️⃣ Skills Demand Analysis

#### 🔹 Top 15 Most In-Demand Skills

Most frequently required skills:

* Energy Modeling
* Climate Data Analysis
* Quantum Algorithms
* TensorFlow
* Ethereum
* Qiskit
* Solidity
* Python

📌 *Insight:*

* Sustainability skills dominate Green Tech
* AI roles emphasize ML frameworks
* Blockchain roles heavily depend on Ethereum & Solidity
* Quantum roles demand specialized toolkits

---

#### 🔹 Skills Demand by Industry

* **AI:** TensorFlow, Python, PyTorch
* **Blockchain:** Ethereum, Solidity, Rust
* **Green Tech:** Energy Modeling, Climate Data Analysis
* **Quantum Computing:** Quantum Algorithms, Qiskit, Linear Algebra

📌 *Insight:* Skill specialization is highly industry-specific with minimal overlap, indicating targeted learning paths.

---

### 4️⃣ Hiring Churn Analysis *(Proxy Churn Model)*

> Since direct customer activity data is unavailable, **churn is modeled using hiring inactivity**, a common approach in B2B marketplaces and talent platforms.

#### 🔹 Hiring Churn Rate

* **15.30%** of hiring entities stopped posting jobs in the last 60 days of 2025.

📌 *Insight:* While most employers remain active, a noticeable portion exits the hiring market toward year-end.

---

#### 🔹 Churned Hiring Entities by Company Size

| Company Size | Churned Entities |
| ------------ | ---------------- |
| Small        | 151              |
| Medium       | 153              |
| Large        | 151              |

📌 *Insight:* Churn is evenly distributed across company sizes, suggesting **market-wide hiring slowdown rather than size-specific risk**.

---

### 5️⃣ Skill Demand Retention (Q1 vs Q4)

#### 🔹 Skill Retention Percentage Highlights

* Most skills retain **94%–110%** of demand from Q1 to Q4
* Skills like **Qiskit, PyTorch, Quantum Algorithms** show growth above 100%

📌 *Insight:* Advanced and future-focused skills show **increasing demand**, indicating low skill churn.

---

### 6️⃣ Remote Job Trend Analysis (H1 vs H2)

| Industry          | H1 Remote | H2 Remote |
| ----------------- | --------- | --------- |
| AI                | 623       | 628       |
| Blockchain        | 645       | 638       |
| Green Tech        | 621       | 652       |
| Quantum Computing | 636       | 646       |

📌 *Insight:*

* Remote hiring remains stable overall
* Green Tech and Quantum Computing show **remote job growth**, while Blockchain shows slight decline.

---

## 🛠 Tools & Technologies Used

* **SQL (MySQL)** – Data cleaning, EDA, KPI computation
* **Power BI** – Dashboarding & visualization *(optional extension)*
* **GitHub** – Version control & project documentation

---

## 📌 Key Takeaways

* Emerging tech industries offer **high salaries and global opportunities**
* Skills demand is **highly specialized by industry**
* Hiring churn exists but remains **moderate (15.3%)**
* Remote work continues to be a **core hiring strategy**
* Advanced skills show **strong long-term retention**

---

## ⚠️ Disclaimer

This project uses a **synthetic dataset** sourced from Kaggle, created for educational and analytical purposes only.
All insights are **simulated** and do not represent real companies or hiring behavior.

---


