# 3. Packages
### Packages for R code for R tools
##### AlteryxPredictive
[Github](https://github.com/alteryx/AlteryxPredictive)

Some source code: `<Alteryx_install_directory>/R-x.y.z/library/AlteryxPredictive`

This is the back end R code for the tools Linear Regression, Logistic Regression, Decision Tree.
##### AlteryxSim
[Github](https://github.com/alteryx/AlteryxSim)

Some source code: `<Alteryx_install_directory>/R-x.y.z/library/AlteryxSim`

This is the back end R code for the Simulation tools.

##### AlteryxPrescriptive
[Github](https://github.com/alteryx/AlteryxPrescriptive)

Some source code: `<Alteryx_install_directory>/R-x.y.z/library/AlteryxPrescriptive`

This is the back end R code for the Optimization tool.

##### flightdeck
[Github](https://github.com/alteryx/flightdeck)

Some source code: `<Alteryx_install_directory>/R-x.y.z/library/flightdeck`

This is used in visualization for Linear Regression, Logistic Regression, and Decision Tree.

##### AlteryxRViz
Some source code: `<Alteryx_install_directory>/R-x.y.z/library/AlteryxRViz`

A package to handle most of the interactive visualization for R tools in Alteryx. 

This does not handle visualization for Linear Regression, Logistic Regression, or Decision Tree.

### Packages for R Alteryx developers
##### generateAlteryxRTests
A package to take a test for a macro and generate many more tests by changing parameters.

##### jeeves and AlteryxRhelper
[Github](https://github.com/alteryx/jeeves)

[Github](https://github.com/AlteryxLabs/AlteryxRhelper)

I include these together because the motivation behind them is similar. These packages help make moving between a developer environment (e.g. RStudio) and Alteryx much easier.

The functionality includes:
- Moving code between R files and Alteryx R tools in a workflow / macro
- Run workflows from R
- Providing question constant default values

AlteryxRhelper is probably more of a help to customers whereas jeeves is more useful internally (a lot more depends on how the build works, etc.

### Packages for data flow between R and Alteryx
##### AlteryxRDataX
Some source code: `<Alteryx_install_directory>/R-x.y.z/library/AlteryxRDataX`

A package for moving data from Alteryx and R. 
This is only included for completeness. All relevant documentation is in the R tool's help page.
