# LGC-msBNN-EA
####  A target-driven molecule design framework.
For more design concepts and details of the model, please refer to Article  *Neural Network Driven, Interactive Molecule Design for Nonlinear Optical Materials Based on Group Contribution Method.

# Overview

Here are the details about the code file.

## Code running conditions
The code we use is run in matlab **R2021a** on **window 11**. 
The matlab program used needs to download the **Neural Net Fitting** toolbox.

## Code content

Evolutionary algorithm Folder (EA)：

|name |content |
|----------------|--------------------------------| ------------------------------|
|**main.m** | Main program of Evolutionary algorithm. |
|**initpop.m** |Code for initializing the population.|
|**binary2decimal.m**| Code for binary and Decimal conversion.|
|**crossover.m** | Code for individual crossover.|
|**mutation.m** | Code for variation.|
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
|----------------|--------------------------------| ------------------------------|
| **a.m**|Bayesian neural network code for predicting polarizability.|
|  **beta.m** | Bayesian neural network code for predicting first-order hyperpolarizability. |
|**E.m**|Bayesian neural network code for predicting HOMO-LUMO gap.|
| **U.m** |  Bayesian neural network code for predicting dipole moment. |
