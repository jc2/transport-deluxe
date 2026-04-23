# Stochastic Margin Configuration

Defines a pure volatility factor applied to the margin. The primary purpose of this configuration is to conduct price sensitivity testing (to see if customers accept a higher or lower price).

## Status
This is a **Stochastic Rule**, meaning its final value depends on probability distributions defined here, acting purely as controlled randomness.

## Attributes
- **Probability Distribution**: The range of factors and their likelihood (e.g., normal distribution around a +0.02 factor).

> **Decimal Notation**: All factors are expressed as decimals (e.g., 1.0 = 100%, 0.1 = 10%).

## Logic
1. A random value is pulled from the distribution of this configuration.
2. The factor is applied to the **Initial Base Margin**.
3. The result is the [Stochastic Adjustment](../interactions/stochastic_adjustment.md).
