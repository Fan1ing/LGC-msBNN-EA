# LGC-msBNN-EA
####  A target-driven molecule design framework.
For more design concepts and details of the model, please refer to Article  ***Neural Network Driven, Interactive Molecule Design for Nonlinear Optical Materials Based on Group Contribution Method.***

# Overview

Here are the details about the code file.

## Code running conditions
The code we use is run in matlab **R2021a** on **window 11**. 
The matlab program used needs to download the **Neural Net Fitting** toolbox.

#### Code runtime
	For the output of target molecule, it only takes a few minutes.

## Code content

**Evolutionary algorithm Folder (EA)：**

|name |content |
|----------------|--------------------------------|
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

**Neural network Folder (NN)：**
|name |content |
|----------------|--------------------------------|
| **a.m**|Bayesian neural network code for predicting polarizability.|
|  **beta.m** | Bayesian neural network code for predicting first-order hyperpolarizability. |
|**E.m**|Bayesian neural network code for predicting HOMO-LUMO gap.|
| **U.m** |  Bayesian neural network code for predicting dipole moment. |
| **LGC_msBNN.m** |  A multi-stage Bayesian neural network code for predicting first-order hyperpolarizability. |
| **cLGC_msBNN.m** |  A multi-stage Bayesian neural network code for predicting first-order hyperpolarizability. |
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
We choose to obtain high-performance molecules with a specified number of functional groups by adjusting the fitness function.The fitness function we designed is visible in **calobjvalue.m**.
The vector of a certain group interval can be set as a fixed value and the fitness function can be calculated together with the vectors within other group intervals in the population. This way, different combinations can be obtained according to the needs.
Of course, we can also set all features as variables and participate in the evolution of the population to obtain more molecules.
### Selection Operator
Here, we have chosen the **roulette wheel selection** for individual selection. 
With this method, individuals whose fitness tends to zero only have a very low probability of being selected, which speeds up the search of molecular structure. Moreover, for individuals with relatively low fitness but potential, there is also a chance to be selected, which avoids premature convergence of the model.
## Multi-stage Bayesian Neural Network
### Calculation of second-order features
**First order feature**: vector of the number of groups.
**The second-order features** are all calculated from the **first-order  features**, and their calculation methods can be obtained in our article. 
The weight vectors corresponding to different features can be viewed in **calobjvalue.m** and **main.m**.
### First order optical property
**polarizability(α)**、**dipole moment(μ)**、**HOMO-LUMO gap(ΔE)**
The neural networks used to predict these three features are all composed of **two hidden layers**, with a number of neurons of **22,16**.  
More parameter settings can be obtained in **a.m**, **E.m**, and **U.m**.

### Second-order optical property
 **Logarithm of first-order hyperpolarizability(ln(β))**
The neural networks used to predict ln(β) is composed of **two hidden layers**, with a number of neurons of **60,35**.  
More parameter settings can be obtained in **beta.m**.
# Data set
In the **data.xlsx** file, from left to right are: 
the structural formula of molecules (SMILES), first-order features, second-order features, first-order and second-order optical features.

In the **data-new.csv** file, from left to right are: 
the structural formula of molecules (SMILES), third-order features，first-order features, second-order features, first-order and second-order optical features.（We have removed some duplicate molecules from the data.xlsx）

## third-order features
All features are calculated by RDKit, and the specific information of the features used is as follows：
|name |Type |Description |Extended class |	
|----------------|--------------------------------|----------------|--------------------------------|
| BalabanJ         | Balaban's J index | Balaban's J value for a molecule,Chem.Phys. Lett. 89:399-404 (1982).                                                                                            | Topological descriptors   |
| BertzCT          | BertzCT           | A topological index meant to quantify "complexity" of molecules.J. Am. Chem. Soc. 103:3599-601 (1981).                                                          | Topological descriptors   |
| Chi0             | Chi indices       | From equations (1), (9) and (10) of Rev. Comp. Chem. vol 2, 367-422, (1991)                                                                                     | Connectivity descriptors  |
| Chi1             | Chi indices       | From equations (1), (11) and (12) of Rev. Comp. Chem. vol 2, 367-422, (1991)                                                                                    | Connectivity descriptors  |
| Chi0v            | Chi indices       | From equations (5), (9) and (10) of Rev. Comp. Chem. vol 2, 367-422, (1991)                                                                                     | Connectivity descriptors  |
| Chi1v            | Chi indices       | From equations (5), (11) and (12) of Rev. Comp. Chem. vol 2, 367-422, (1991)                                                                                    | Connectivity descriptors  |
| Chi2v            | Chi indices       | From equations (5), (15) and (16) of Rev. Comp. Chem. vol 2, 367-422, (1991)                                                                                    | Connectivity descriptors  |
| Chi3v            | Chi indices       | From equations (5), (15) and (16) of Rev. Comp. Chem. vol 2, 367-422, (1991)                                                                                    | Connectivity descriptors  |
| Chi4v            | Chi indices       | From equations (5), (15) and (16) of Rev. Comp. Chem. vol 2, 367-422, (1991)                                                                                    | Connectivity descriptors  |
| Chi0n            | Chi indices       | Similar to Hall Kier Chi0v, but uses nVal instead of valence This makes a big difference after we get out of the first row.Rev. Comput. Chem. 2:367-422 (1991). | Connectivity descriptors  |
| Chi1n            | Chi indices       | Similar to Hall Kier Chi1v, but uses nVal instead of valence.Rev. Comput. Chem. 2:367-422 (1991).                                                               | Connectivity descriptors  |
| Chi2n            | Chi indices       | Similar to Hall Kier Chi2v, but uses nVal instead of valence This makes a big difference after we get out of the first row.Rev. Comput. Chem. 2:367-422 (1991). | Connectivity descriptors  |
| Chi3n            | Chi indices       | Similar to Hall Kier Chi3v, but uses nVal instead of valence This makes a big difference after we get out of the first row.Rev. Comput. Chem. 2:367-422 (1991). | Connectivity descriptors  |
| Chi4n            | Chi indices       | Similar to Hall Kier Chi4v, but uses nVal instead of valence.This makes a big difference after we get out of the first row.Rev. Comput. Chem. 2:367-422 (1991). | Connectivity descriptors  |
| EState_VSA1      | EState_VSA        | MOE-type descriptors using EState indices and surface area contributions (developed at RD, not described in the CCG paper).                                     | E-state descriptors       |
| EState_VSA2      | EState_VSA        | MOE-type descriptors using EState indices and surface area contributions (developed at RD, not described in the CCG paper).                                     | E-state descriptors       |
| EState_VSA3      | EState_VSA        | MOE-type descriptors using EState indices and surface area contributions (developed at RD, not described in the CCG paper).                                     | E-state descriptors       |
| EState_VSA4      | EState_VSA        | MOE-type descriptors using EState indices and surface area contributions (developed at RD, not described in the CCG paper).                                     | E-state descriptors       |
| EState_VSA5      | EState_VSA        | MOE-type descriptors using EState indices and surface area contributions (developed at RD, not described in the CCG paper).                                     | E-state descriptors       |
| EState_VSA6         | EState_VSA          | MOE-type descriptors using EState indices and surface area contributions (developed at RD, not described in the CCG paper).                        | E-state descriptors             |
| EState_VSA7         | EState_VSA          | MOE-type descriptors using EState indices and surface area contributions (developed at RD, not described in the CCG paper).                        | E-state descriptors             |
| EState_VSA8         | EState_VSA          | MOE-type descriptors using EState indices and surface area contributions (developed at RD, not described in the CCG paper).                        | E-state descriptors             |
| EState_VSA9         | EState_VSA          | MOE-type descriptors using EState indices and surface area contributions (developed at RD, not described in the CCG paper).                        | E-state descriptors             |
| EState_VSA10        | EState_VSA          | MOE-type descriptors using EState indices and surface area contributions (developed at RD, not described in the CCG paper).                        | E-state descriptors             |
| FractionCSP3        | FractionCSP3        | The fraction of C atoms that are SP3 hybridized.                                                                                                   | Constitutional descriptors      |
| HallKierAlpha       | HallKierAlpha       | The Hall-Kier alpha value for a molecule.Rev. Comput. Chem. 2:367-422 (1991).                                                                      | Topological descriptors         |
| Ipc                 | Ipc                 | the information content of the coefficients of the characteristic polynomial of the adjacency matrix of a hydrogen-suppressed graph of a molecule. | Topological descriptors         |
| Kappa1              | Kappa descriptors   | Hall-Kier Kappa1 value                                                                                                                             | Topological descriptors         |
| Kappa2              | Kappa descriptors   | Hall-Kier Kappa2 value                                                                                                                             | Topological descriptors         |
| Kappa3              | Kappa descriptors   | Hall-Kier Kappa2 value                                                                                                                             | Topological descriptors         |
| LabuteASA           | LabuteASA           | Labute's Approximate Surface Area (ASA from MOE)                                                                                                   | MOE-type descriptors            |
| MolMR               | MolMR               | Wildman-Crippen MR value.Wildman and Crippen JCICS 39:868-73 (1999)                                                                                | Molecular property descriptors  |
| NumValenceElectrons | NumValenceElectrons | The number of valence electrons the molecule has                                                                                                   | Constitutional descriptors      |
| PEOE_VSA1           | PEOE_VSA            | MOE Charge VSA Descriptor 1 (-inf < x < -0.30)                                                                                                     | MOE-type descriptors            |
| PEOE_VSA2        | PEOE_VSA | MOE Charge VSA Descriptor 2 (-0.30 <= x < -0.25) | MOE-type descriptors  |
| PEOE_VSA3        | PEOE_VSA | MOE Charge VSA Descriptor 3 (-0.25 <= x < -0.20) | MOE-type descriptors  |
| PEOE_VSA4        | PEOE_VSA | MOE Charge VSA Descriptor 4 (-0.20 <= x < -0.15) | MOE-type descriptors  |
| PEOE_VSA5        | PEOE_VSA | MOE Charge VSA Descriptor 5 (-0.15 <= x < -0.10) | MOE-type descriptors  |
| PEOE_VSA6        | PEOE_VSA | MOE Charge VSA Descriptor 6 (-0.10 <= x < -0.05) | MOE-type descriptors  |
| PEOE_VSA7        | PEOE_VSA | MOE Charge VSA Descriptor 7 (-0.05 <= x < 0.00)  | MOE-type descriptors  |
| PEOE_VSA8        | PEOE_VSA | MOE Charge VSA Descriptor 8 (0.00 <= x < 0.05)   | MOE-type descriptors  |
| PEOE_VSA9        | PEOE_VSA | MOE Charge VSA Descriptor 9 (0.05 <= x < 0.10)   | MOE-type descriptors  |
| PEOE_VSA10       | PEOE_VSA | MOE Charge VSA Descriptor 10 (0.10 <= x < 0.15)  | MOE-type descriptors  |
| PEOE_VSA11       | PEOE_VSA | MOE Charge VSA Descriptor 11 (0.15 <= x < 0.20)  | MOE-type descriptors  |
| PEOE_VSA12       | PEOE_VSA | MOE Charge VSA Descriptor 12 (0.20 <= x < 0.25)  | MOE-type descriptors  |
| PEOE_VSA13       | PEOE_VSA | MOE Charge VSA Descriptor 13 (0.25 <= x < 0.30)  | MOE-type descriptors  |
| PEOE_VSA14       | PEOE_VSA | MOE Charge VSA Descriptor 14 (0.30 <= x < inf)   | MOE-type descriptors  |
| SMR_VSA1         | SMR_VSA  | MOE MR VSA Descriptor 1 (-inf < x < 1.29)        | MOE-type descriptors  |
| SMR_VSA2         | SMR_VSA  | MOE MR VSA Descriptor 2 (1.29 <= x < 1.82)       | MOE-type descriptors  |
| SMR_VSA3            | SMR_VSA        | MOE MR VSA Descriptor 3 (1.82 <= x < 2.24)                                                                    | MOE-type descriptors     |
| SMR_VSA4            | SMR_VSA        | MOE MR VSA Descriptor 4 (2.24 <= x < 2.45)                                                                    | MOE-type descriptors     |
| SMR_VSA5            | SMR_VSA        | MOE MR VSA Descriptor 5 (2.45 <= x < 2.75)                                                                    | MOE-type descriptors     |
| SMR_VSA6            | SMR_VSA        | MOE MR VSA Descriptor 6 (2.75 <= x < 3.05)                                                                    | MOE-type descriptors     |
| SMR_VSA7            | SMR_VSA        | MOE MR VSA Descriptor 7 (3.05 <= x < 3.63)                                                                    | MOE-type descriptors     |
| SMR_VSA9            | SMR_VSA        | MOE MR VSA Descriptor 9 (3.80 <= x < 4.00)                                                                    | MOE-type descriptors     |
| SMR_VSA10           | SMR_VSA        | MOE MR VSA Descriptor 10 (4.00 <= x < inf)                                                                    | MOE-type descriptors     |
| VSA_EState8         | VSA_Estate     | VSA EState Descriptor 8 (6.45 <= x < 7.00)                                                                    | E-state descriptors      |
| VSA_EState9         | VSA_Estate     | VSA EState Descriptor 9 (7.00 <= x < 11.00)                                                                   | E-state descriptors      |
| VSA_EState10        | VSA_Estate     | VSA EState Descriptor 10 (11.00 <= x < inf)                                                                   | E-state descriptors      |
| MaxAbsEStateIndex   | Estate Index   | Returns a tuple of EState indices for the molecule, Reference: Hall, Mohney and Kier. JCICS _31_ 76-81 (1991) | Topological descriptors  |
| MaxAbsPartialCharge | Partial Charge | Returns molecular charge descriptors                                                                          | Topological descriptors  |
| MaxEStateIndex      | Estate Index   | Returns a tuple of EState indices for the molecule, Reference: Hall, Mohney and Kier. JCICS _31_ 76-81 (1991) | Topological descriptors  |
| MaxPartialCharge    | Partial Charge | Returns molecular charge descriptors                                                                          | Topological descriptors  |
| MinAbsEStateIndex   | Estate Index   | Returns a tuple of EState indices for the molecule, Reference: Hall, Mohney and Kier. JCICS _31_ 76-81 (1991) | Topological descriptors  |
| MinAbsPartialCharge | Partial Charge | Returns molecular charge descriptors                                                                          | Topological descriptors  |
| MinEStateIndex      | Estate Index   | Returns a tuple of EState indices for the molecule, Reference: Hall, Mohney and Kier. JCICS _31_ 76-81 (1991) | Topological descriptors  |
| MinPartialCharge    | Partial Charge | Returns molecular charge descriptors                                                                          | Topological descriptors  |
