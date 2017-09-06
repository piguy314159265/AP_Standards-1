# 8. Macro Modification


## Modifying R code
Depending on the type of macro, R code modification may take place in one of 2 different places


### 'New' Macros
Many more recently developed macros have packages developed to help with the back-end execution. The macros and corresponding packages are:
- Decision Tree: AlteryxPredictive
- Linear Regression: AlteryxPredictive
- Logistic Regression: AlteryxPredictive
- Score: AlteryxPredictive (to a lesser extent)
- Optimization: AlteryxPrescriptive
- Simulation Sampling: AlteryxSim
- Simulation Scoring: AlteryxSim
- Simulation Summary: AlteryxSim

Most of the functionality is provided by those packages. In order to change functionality a user should fork the package; all are open source and on github. [See the packages document](3_Packages.md). They can then make modifications, [build](https://support.rstudio.com/hc/en-us/articles/200486488-Developing-Packages-with-RStudio) the package, and use that on their machine.

The macros corresponding to these tools can be found in `<alteryx_install_path>/bin/HtmlPlugins/`. You can see from the R tool where the code calls functionality from these packages.


### 'Old' Macros
The other macros supply most of the code in their R tools. You can open these by right clicking on them and choosing `Open Macro: ...`.

The user must have admin privileges and have Alteryx open as an admin or save a copy of the macro and use that instead.


## Modifying Alteryx functionality in R tools


### 'New' Macros
See the `jeeves` package for help with Html plugin macro modification via R.


### 'Old' Macros
These are similar to any other macros for editing.
