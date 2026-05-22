# Factor Analysis of US Judges' Ratings

## Overview

This project applies **exploratory factor analysis (EFA)** to the classic `USJudgeRatings` dataset from the `psych` package in R. The goal is to uncover the latent factor structure behind 12 different ratings of US superior court judges (e.g., integrity, diligence, legal knowledge) and visualize judges' positions in the reduced factor space.

The analysis compares:
- Maximum Likelihood (ML) factor extraction
- Principal Axis Factoring (PAF)
- One‑factor vs. two‑factor solutions
- Orthogonal rotation (Varimax)

## Tools & Libraries

| Tool | Purpose |
|------|---------|
| R | Core analysis |
| `psych` | Factor analysis, KMO, SMC, factor diagrams |
| `GPArotation` | Rotation methods (Varimax) |

## Dataset

- **Name**: `USJudgeRatings` (built into `psych`)
- **Observations**: 43 US superior court judges
- **Variables**: 12 numeric ratings (e.g., `CONT` – integrity, `INTG` – judicial integrity, `DMNR` – demeanor, `DILG` – diligence, etc.)

## Methodology

1. **Correlation matrix** – inspected pairwise relationships.
2. **Assumption checks**:
   - Squared Multiple Correlations (SMC) – all high, indicating good factorability.
   - Kaiser‑Meyer‑Olkin (KMO) – overall measure of sampling adequacy.
   - Bartlett’s test of sphericity – rejects identity matrix (p < 0.05).
3. **Number of factors** – eigenvalues > 1 rule + scree plot → suggested **2 factors**.
4. **Factor extraction**:
   - Maximum Likelihood (with and without rotation)
   - Principal Axis Factoring (PAF) with Varimax rotation (final model).
5. **Factor scores** – computed for each judge using regression method.
6. **Visualization**:
   - Scree plot
   - Factor diagram (loadings)
   - Biplot of judges in 2‑factor space

## Key Findings

- The 12 ratings are **highly correlated** – a **single strong general factor** (judicial competence) dominates.
- A two‑factor solution with Varimax rotation did **not** produce clean simple structure due to the very high general factor.
- PAF with 2 factors still showed that most loadings are high on the first factor, and the second factor explains little additional variance.
- Judges can be positioned in a 2D factor space, but most variation aligns with one dimension.

## Results Summary (PAF – 2 factors, Varimax)

| Factor | Variance Explained | Interpretation |
|--------|------------------|----------------|
| Factor 1 | ~70% | Overall judicial competence / professionalism |
| Factor 2 | ~10% | Possibly demeanor vs. legal substance (weak) |

> Full loadings table and factor diagram are generated in the script.

## How to Run

### Requirements

Install the required R packages:

```r
install.packages(c("psych", "GPArotation"))
