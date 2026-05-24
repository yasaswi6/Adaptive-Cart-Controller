# Adaptive Cart Controller

An adaptive fuzzy logic–based control system designed to stabilize an inverted cart-pole system using both Mamdani and Sugeno Fuzzy Inference Systems (FIS).

---

## Overview

This project implements and compares two widely used fuzzy logic controllers:

- Mamdani Fuzzy Inference System
- Sugeno Fuzzy Inference System

The objective is to balance the cart-pole system by intelligently controlling cart movement based on system behavior and dynamic pole response.

The project demonstrates how fuzzy logic can be used for intelligent decision-making in nonlinear control systems without relying on precise mathematical models.

---

## Features

- Mamdani Fuzzy Logic Controller
- Sugeno Fuzzy Logic Controller
- Membership Function Visualization
- Simulation Result Analysis
- Intelligent Rule-Based Control
- MATLAB Implementation
- Comparative FIS Performance Study

---

## Project Files

```bash
Mamdani_FIS.m          -> Mamdani fuzzy controller implementation
Mamdani_MFs.png        -> Membership functions for Mamdani FIS
Mamdani_results.png    -> Output/simulation results for Mamdani FIS

Sugeno_FIS.m           -> Sugeno fuzzy controller implementation
Sugeno_MFs.png         -> Membership functions for Sugeno FIS
Sugeno_results.png     -> Output/simulation results for Sugeno FIS

README.md              -> Project documentation
```

---

## Requirements

Before running the project, ensure the following are installed:

- MATLAB
- Fuzzy Logic Toolbox

You can verify toolbox installation using:

```matlab
ver
```

Check whether **Fuzzy Logic Toolbox** appears in the installed toolbox list.

---

## Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/yasaswi6/Adaptive-Cart-Controller.git
cd Adaptive-Cart-Controller
```

---

### 2. Open MATLAB

Launch MATLAB on your system.

---

### 3. Open the Project Folder

Navigate to the downloaded repository folder inside MATLAB:

```matlab
cd('path_to_your_repository')
```

Example:

```matlab
cd('C:\Users\John\Downloads\Adaptive-Cart-Controller')
```

The folder path will depend on where the repository is stored on the user's system.

---

## Running the Project

### Run the Mamdani Fuzzy Controller

```matlab
Mamdani_FIS
```

This will:
- Create the Mamdani FIS
- Generate membership functions
- Simulate the control system
- Produce output result plots

---

### Run the Sugeno Fuzzy Controller

```matlab
Sugeno_FIS
```

This will:
- Create the Sugeno FIS
- Generate membership functions
- Simulate the control system
- Produce output result plots

---

## Output Results

### Membership Function Plots

- `Mamdani_MFs.png`
- `Sugeno_MFs.png`

These images visualize the fuzzy membership functions used by each controller.

---

### Simulation Results

- `Mamdani_results.png`
- `Sugeno_results.png`

These plots show the response and performance of the fuzzy controllers during simulation.

---

## Concepts Used

- Fuzzy Logic Control
- Mamdani Inference System
- Sugeno Inference System
- Intelligent Systems
- Nonlinear Control Systems
- Adaptive Control
- MATLAB Simulation

---

## Applications

- Robotics
- Autonomous Systems
- Industrial Automation
- Smart Control Systems
- AI-Based Decision Systems
- Dynamic Stabilization Problems

---

## Future Improvements

- Real-time hardware implementation
- Integration with reinforcement learning
- Optimization of fuzzy rule sets
- GUI-based simulation interface
- Performance comparison with PID controllers

---

## Author

Developed by Yasaswi Jaiswal  
Electrical Engineering @ NUS  
Specialization in Industry 4.0 | Minor in Computing
