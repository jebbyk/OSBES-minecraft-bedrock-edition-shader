# OSBES v0.8.1
Open Source Bedrock Edition Shader  

**------------Everyone contributor will listed as a developer!-----------**

**HOW TO CONTRIBUTE**
I recomend you to use rooted device with installed Termux <span style="color:green">**terminal**</span> emulator
#### 0. fork this repository
    - Click "Fork" button in the top right corner of this page
#### 1. go to the directory where you want to save shader pack
    - run in your terminal: cd /path/where/you/want/to/save/this/shaderpack
#### 2. clone your repository 
    - when your are in your forked repository page click green "Code" button, select "SSH" and copy this link
    - run in your terminal: git clone your@copied.link:goes/Here
#### 3. convert it to shaderpack file and import
    I recomend to use mixplorer file manager

    - archive downloaded folder to .zip archive
    - change filetype to be .mcpack instead of .zip
    - open this .mcpack file via minecraft 
    - after importing this shader pack should appear in the /sdcard/games/com.mojang/resource_packs/
    - If it is not appeared import some other shaderpacks and when they begin to appeare in /sdcard/games/ try to import OSBES again. It is your WORKING FOLDER
#### 4. add link to my original repository to have actual development version
    - when you are on this page (not your forked repository!!!) click "Code" button, select "HTTPS" and copy this link
    - run in your terminal: git remote add upstream your@copied.link:goes/Here
#### 5. switch to develop branch
    - next steps should be done when you are in your WORKING FOLDER 
    - run in your terminal: git checkout develop
#### 6. create your own branch named as your feature / work meaning
    - run in your terminal: git checkout -b your_feature_name
#### 7. make your lacal changes in shader / .json / .material files
    - less files changed = faster feature feview
#### 8. make your changes to be committed 
    - run in your terminal: git status
    - you should see a list of modified files
    - for each file you really want to add run: git add path/to/your/file
#### 9. create a commit 
    - run in your termianl: git commit -m "write  here a short message describing your work"
#### 10. checkout to develop branch 
    - run in your terminal: git checkout develop
#### 11. download latest changes from my original repository develop branch
    - run in your terminal: git pull upstream develop
#### 12. make shure you have the latest changes in develop branch
    - run in your terminal again: git pull upstream develop
    - You should see that it is "Already up to date"

#### 13. return to your branch and merge develop branch into your feature branch
    - run in your terminal: git checkout your_branch_name
    - run in your terminal: git merge develop
    - make shure that you have no conflicts. Otherwise fix them (GOOGLE --> "how to fix conflict in git")
#### 14. upload your changes to repository
    - run in your terminal: git push origin your_branch_name
#### 15. make a pull request into develop branch 
    - go to the branches tab in your forked repository
    - make "New pull request" from your branch to my original repository
#### 16. make fixes in your branch if it's needed and commit them as described here
#### 17. Your pull request will be merged into develop branch

#### If you have some problems with this instruction create an Issue on this page ####

**ROADMAP**

| feature                  | verison     | subfeature                 | status |
|:-------------------------|:-----------:|:-----------------------------:|-------:| 
|basic lighting            |0.0.0        | entyties lighting             |<span style="color:green">ready</span>  |
|                          |0.0.1        | terrain lighting              |<span style="color:green">ready</span>  |
|                          |0.0.2        | improvemnets                  |<span style="color:green">ready</span>|
|                          |0.0.3        | fixes                         |<span style="color:gray">no need</span>|
|advanced texture mapping  |0.1.0        | specular mapping              |<span style="color:green">ready</span>  |
|                          |0.1.1        | normal mapping                |<span style="color:green">ready</span> |
|                          |0.1.2        | improvemnets                  |<span style="color:green">ready</span>|
|                          |0.1.3        | fixes                         |<span style="color:gray">no need</span>|
|sky fresnel lighting      |0.2.0        | for terrain                   |<span style="color:green">ready</span>  |
|                          |0.2.1        | for entyties                  |<span style="color:red">**NO**</span>     |
|                          |0.2.2        | improvemnets                  |<span style="color:green">ready</span>|
|                          |0.2.3        | fixes                         |<span style="color:green">ready</span>|
|color correction          |0.3.0        | for terrain                   |<span style="color:green">ready</span>  |
|                          |0.3.1        | for sky                       |<span style="color:green">ready</span>  |
|                          |0.3.2        | for entyties                  |<span style="color:green">ready</span>  |
|                          |0.3.3        | improvemnets                  |<span style="color:green">ready</span>|
|                          |0.3.4        | fixes                         |<span style="color:green">ready</span>|
|wind waving               |0.4.0        | leaves and grass              |<span style="color:green">ready</span>  |
|                          |0.4.1        | water                         |<span style="color:green">ready</span>  |
|                          |0.4.2        | improvemnets                  |<span style="color:green">ready</span>|
|                          |0.4.3        | fixes                         |<span style="color:green">ready</span>|
|water                     |0.5.0        | specular and fresnel          |<span style="color:green">ready</span>|
|                          |0.5.1        | texuture mapping              |<span style="color:green">ready</span>|
|                          |0.5.2        | point ligts specular          |<span style="color:green">ready</span>|
|                          |0.5.3        | improvemnets                  |<span style="color:green">ready</span>|
|                          |0.5.4        | optimizations                 |<span style="color:green">ready</span>|
|                          |0.5.5        | fixes                         |<span style="color:green">ready</span>|
|weather and daytime tune  |0.6.0        | raining                       |<span style="color:green">ready</span>|
|                          |0.6.1        |day / night / sunrize          |<span style="color:green">ready</span>|
|                          |0.6.2        | hell detection                |<span style="color:green">ready</span>|
|                          |0.6.3        | improvements                  |<span style="color:red">**NO**</span>|
|                          |0.6.4        | fixes                         |<span style="color:green">ready</span>|
|clouds                    |0.7.0        | clouds generating             |<span style="color:green">ready</span>|
|                          |0.7.1        |optimizations                  |<span style="color:gray">no need</span>|
|                          |0.7.2        | clouds reflections            |<span style="color:green">ready</span>|
|                          |0.7.3        | improvements                  |<span style="color:red">**NO**</span>|
|                          |0.7.4        | fixes                         |<span style="color:green">ready</span>|
|improve textures          |0.7.5        |fix animated texures           |<span style="color:green">ready</span>|
|                          |0.7.6        |add more texture maps          |<span style="color:green">ready</span>|
|                          |0.7.7        |fix block in hand mapping      |<span style="color:green">ready</span>|
|                          |0.7.8        |fix inventory block mapping    |<span style="color:green">ready</span>|
|                          |0.7.10       |prepare inventroy flat textures|<span style="color:green">ready</span>|
|                          |0.7.9        |fix entyties texture mapping   |<span style="color:green">ready</span>|
|                          |0.7.12       |fix torches mapping            |<span style="color:green">particulary ready</span>|
|                          |0.7.11       |correct tangent calculation    |<span style="color:green">particulary ready</span>|
|advanced sun and mooon    |0.8.0        |hallo effect                   |<span style="color:green">ready</span>|
|                          |0.8.1        |improve halo coloring          |<span style="color:green">ready</span>|
|                          |-            |halo lighting on the surfaces  |<span style="color:purple">**in progress**</span>|
|                          |-            |improve fog color handling     |<span style="color:purple">**in progress**</span>|
|                          |-            |bugfixes                       |<span style="color:orange">**planned**</span>|
|make entyties and items   |0.9.xx       |item in hand                   |<span style="color:orange">**planned**</span>|
|lighting and shading      |-            |entyties lighting              |<span style="color:orange">**planned**</span>|
|the same as on terrain    |-            |improvements                   |<span style="color:orange">**planned**</span>|
|                          |-            |fixes                          |<span style="color:orange">**planned**</span>|
|make hell great again     |0.10.xx      |improve hell detection         |<span style="color:orange">**planned**</span>|
|                          |-            |improve fogs in hell           |<span style="color:orange">**planned**</span>|
|                          |-            |improve lighting in hell       |<span style="color:orange">**planned**</span>|
|                          |-            |improvemnets and fixes         |<span style="color:orange">**planned**</span>|
|Underwater                |0.11.xx      |underwater detection           |<span style="color:orange">**planned**</span>|
|                          |-            |underwater waving              |<span style="color:orange">**planned**</span>|
|                          |-            |underwater caustics            |<span style="color:orange">**planned**</span>|
|                          |-            |improvements                   |<span style="color:orange">**planned**</span>|
|                          |-            |fixes                          |<span style="color:orange">**planned**</span>|
|<span style="color:green">**ALPHA RELEASE**</span>| 0.12.0 |-           |<span style="color:orange">**planned**</span>| 
|bug fixes and improvements|-            | bugfixes                      |<span style="color:orange">**planned**</span>|
|                          |-            | improvements                  |<span style="color:orange">**planned**</span>|
|refactoring               |-            | separate include files        |<span style="color:orange">**planned**</span>|
|                          |-            | cleenup code                  |<span style="color:orange">**planned**</span>|
|                          |-            | bug fixes                     |<span style="color:orange">**planned**</span>|
|settings                  |-            | quality presets packages      |<span style="color:orange">**planned**</span>|
|                          |-            | Brightness setting            |<span style="color:orange">**planned**</span>|
|win10 support             |-            | terrain shaders               |<span style="color:orange">**planned**</span>|
|                          |-            | sky shaders                   |<span style="color:orange">**planned**</span>|
|                          |-            | entyties shaders              |<span style="color:orange">**planned**</span>|
|                          |-            | item in hand shaders          |<span style="color:orange">**planned**</span>|
|                          |-            | inventory items shaders       |<span style="color:orange">**planned**</span>|
|                          |-            | improvements                  |<span style="color:orange">**planned**</span>|
|                          |-            | bugfixes                      |<span style="color:orange">**planned**</span>|
|<span style="color:green">**BETTA RELEASE**</span>|-       |-           |<span style="color:orange">**planned**</span>| 
|bug fixes                 |-            | -                             |<span style="color:orange">**planned**</span>|
|<span style="color:green">**RELEASE**</span>|-      |-                  |<span style="color:orange">**planned**</span>| 
|bug fixes                 |-            | -                             |<span style="color:orange">**planned**</span>|
|paralax mapping           |-            | simple paralax mapping        |<span style="color:orange">**planned**</span>|  
|                          |-            | paralax oclusion mapping      |<span style="color:orange">**planned**</span>|
|                          |-            | optimizations                 |<span style="color:orange">**planned**</span>|
|                          |-            | bugfixes                      |<span style="color:orange">**planned**</span>|

test
