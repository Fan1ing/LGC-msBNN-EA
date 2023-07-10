# LGC-msBNN-EA
####  A target-driven molecule design framework.
For more design concepts and details of the model, please refer to Article  ***Neural Network Driven, Interactive Molecule Design for Nonlinear Optical Materials Based on Group Contribution Method.***

# Overview

Here are the details about the code file.

## Code running conditions
The code we use is run in matlab **R2021a** on **window 11**. 
The matlab program used needs to download the **Neural Net Fitting** toolbox.
#### Code runtime
For the output of a target molecule, it only takes a few minutes.

## Code content

Evolutionary algorithm Folder (EA)：

|name |content |
|     :---:     |     :---:     |
|**main.m** | Main program of Evolutionary algorithm. |
|**initpop.m** |Code for initializing the population.|
|**binary2decimal.m**| Code for binary and Decimal conversion.|
|**crossover.m** | Code for individual crossover.|
|**mutation.m** | Code for individual variation.|
| **calobjvalue.m**| Code for calculating fitness function.|
| **selection.m**|Code for individual selection. |
| **best.m** | Code for calculating the optimal individual. |
| **A.mat**| A trained model for predicting polarizability.|
| **beta.mat** | A trained model for predicting first-order hyperpolarizability |
|**U.mat**|A trained model for predicting dipole moment.|
| **E.mat**|A trained model for predicting HOMO-LUMO gap.|

**Note**: All codes of Evolutionary algorithm should be placed in the **same folder** when used.

Evolutionary algorithm Folder (EA)：
|name |content |
|     :---:     |     :---:     |
| **a.m**|Bayesian neural network code for predicting polarizability.|
|  **beta.m** | Bayesian neural network code for predicting first-order hyperpolarizability. |
|**E.m**|Bayesian neural network code for predicting HOMO-LUMO gap.|
| **U.m** |  Bayesian neural network code for predicting dipole moment. |
# Model parameter

## Evolutionary algorithm

### Initial population
The initial population consists of a binary population of **550 individuals** with a length of **28**, and the vector length of each feature is **1**.
To adjust the range of each feature, you can change the vector of Characteristic length. The method used in this paper defaults to the range of change of each feature to **0-1**.
### Individual crossover
Crossover probability：**0.3**.
We chose two ways of crossing：(1)  self crossing of the same individual. (2) mutual crossing between different individuals.
Both of these crossover methods are within different functional groups.

### individual variation
Mutation probability:**0.5**.

### Fitness function
We choose to obtain high-performance molecules with a specified number of functional groups by adjusting the fitness function.The fitness function we designed is visible in **calobjvalue.m** and **main.m**.
The vector of a certain group interval can be set as a fixed value and the fitness function can be calculated together with the vectors within other group intervals in the population. This way, different combinations can be obtained according to the needs.
Of course, we can also set all features as variables and participate in the evolution of the population to obtain more molecules.
### Selection Operator
Here, we have chosen the **roulette wheel selection** for individual selection. 
With this method, individuals whose fitness tends to zero only have a very low probability of being selected, which speeds up the search of molecular structure. Moreover, for individuals with relatively low fitness but potential, there is also a chance to be selected, which avoids premature convergence of the model.
