## 2. R Installation

> Where does the version of R that we install get installed?
The R installation is in the root of the Alteryx install.

Example:
Alteryx gets installed in `C:/Program Files/Alteryx`. 
Then R gets installed in `C:/Program Files/Alteryx/R-x.y.z` (depends on R version number)

> How does it interact with an existing version?   
> What are things to watch out for

Simply, it doesn't. But that is the underlying problem; users have an install that they use in RStudio. 
Then they install packages in one installation that may be a different version than the ones in another installation.
The issues come from a few different sources:
1. Packages and library path search order
    1. User has packages in pre-existing R directory that aren't in Alteryx directory installed. So they have trouble using them in Alteryx
    2. Alteryx installs packages. User can't use them in their R Studio because the packages aren't in their prexisting R install library.
    3. Alteryx installs different versions of some packages than the user may have on their machine. These may have different requirements / requirement versions, so code will just fail when loading some packages (in either library).
2. Installation version
    1. If using different R versions, same issues as in 1.3.
3. BLAS version
    1. This is more rare and usually only with Microsoft R Client/Server. Different BLAS can result in varying results / possibilities in the library

> How does the Alteryx installation interact with an R installation

The file `<path_to_alteryx_install>/Settings/RPluginSettings.ini` specifies the path that Alteryx should launch an `R.exe` instance from. We recommend not changing it, but in theory, it can be changed to point to another installation.

> How do I make RStudio work with my Alteryx R install?

1. From RStudio, `Tools > Global Options > R version > Change`. Point to `<alteryx_install_path>/R-x.y.z`.
2. Set your library trees to match the ones that Alteryx gives.

> How do I check/set my library trees?

Check your library trees by running the function `.libPaths()`. You can do this in RStudio or you can do this in Alteryx via an R tool.

Change your library tree with the function`.libPaths`. 
The difference is, to change it, supply it arguments; if I have two paths, `path1` and `path2` and I want it to look in `path1` before `path2`, do `.libPaths(c(path1, path2))`.

So if I want to change my RStudio library tree to match my Alteryx one, I do the following:
1. Get `.libPaths()` in Alteryx
    1. Get an empty Alteryx workflow
    2. Add an R tool
    3. In the R tool, type `.libPaths()`
    4. Run
    5. Copy the results from the results window messages. E.g. 
```
"C:/Program Files/Alteryx/R-3.3.2/library"
"C:/Users/dblanchard/Documents/R/win-library/3.3"
```
2. In RStudio, set the library tree to match the one from Alteryx. E.g. 
```
.libPaths(
  c(
    "C:/Program Files/Alteryx/R-3.3.2/library",
    "C:/Users/dblanchard/Documents/R/win-library/3.3"
  )
)
```

If you don't want to run this each time you start RStudio, you can add it to the bottom of your Rprofile.site file:
1. Get the path to your R install used by R studio. From RStudio: `Tools > Global Options > R version`. Call that path `<path>`. Open the file `<path>/etc/Rprofile.site`.
2. At the bottom, insert the code in step 2 above.


> What are best practices for managing multiple R installations and development in RStudio and Alteryx?

1. Don't 
2. Don't
3. If you have to have 2 but only want to use one regularly, follow above instructions to set your RStudio R.exe and library trees to be the same as in Alteryx
4. If you want to regularly use multiple installations, write a shell script to make sure every package in one is installed in the other (copy if same version of R). Only open RStudio or Alteryx after the script executes.
