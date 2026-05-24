# Adaptive Cart Controller

A fuzzy logic–based control system designed to balance an inverted pendulum (cart-pole system) by dynamically adjusting cart movement using intelligent rule-based decision making.

---

## Overview

This project implements a Fuzzy Logic Controller (FLC) for the classic Cart-Pole System, a fundamental control problem widely used in robotics, automation, and artificial intelligence.

The objective is to keep the pole balanced in an upright position by controlling the horizontal motion of the cart. Unlike traditional PID controllers, fuzzy logic allows the system to make human-like decisions under uncertain and dynamic conditions.

---

## Features

- Fuzzy logic–based balancing mechanism
- Real-time cart-pole stabilization
- Rule-based intelligent control system
- Adjustable membership functions
- Simulation and visualization support
- Lightweight and modular implementation

---

## How It Works

The controller continuously monitors:

- Pole angle
- Angular velocity
- Cart position
- Cart velocity

Based on these inputs, the fuzzy inference system determines the appropriate force to apply to the cart in order to maintain stability.

The system uses:

### 1. Fuzzification
Converts numerical inputs into fuzzy linguistic variables.

### 2. Rule Evaluation
Applies IF-THEN fuzzy rules to determine control actions.

### 3. Defuzzification
Converts fuzzy outputs back into crisp control signals.

---

## Technologies Used

- Python / MATLAB
- Fuzzy Logic Control
- Control Systems Engineering
- Simulation Tools
- Numerical Modeling

---

## Project Structure

```bash
├── src/
│   ├── controller/
│   ├── simulation/
│   ├── membership_functions/
│   └── utils/
├── results/
├── docs/
├── README.md
└── requirements.txt
```

---

## Applications

- Robotics
- Autonomous systems
- Industrial automation
- Intelligent control systems
- AI-based decision systems
- Reinforcement learning environments

---

## Learning Outcomes

This project demonstrates:

- Practical implementation of fuzzy logic
- Intelligent control system design
- Dynamic system stabilization
- Real-world engineering problem solving
- Simulation-based testing and analysis

---

## Future Improvements

- Integrate reinforcement learning with fuzzy control
- Improve response optimization
- Add real-time graphical dashboard
- Hardware implementation using microcontrollers
- Compare performance against PID controllers

---

## Author

Developed by Yasaswi Jaiswal  
Electrical Engineering @ NUS  
Specialization in Industry 4.0 | Minor in Computing
