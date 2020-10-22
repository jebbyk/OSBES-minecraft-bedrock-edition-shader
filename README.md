# OSBES v0.7.5
Open Source Bedrock Edition Shader  

**------------Everyone who will contribute will listed as a developer!-----------**

**HOW TO CONTRIBUTE**
I recomend you to use rooted device with installed Termux <span style="color:green">terminal</span> emulator
#### 0. go to the directory where you wnat to save shader pack
    - run in your terminal: cd /path/where/you/want/to/save/this/shaderpack
#### 1. clone this repository 
    - run in your terminal: git clone git@github.com:jebbyk/OSBES-minecraft-bedrock-edition-shader.git
#### 2. create your own branch named as your feature / work meaning
    - run in your terminal: git checkout -b YOUR_FEATURE_NAME
#### 3. make your lacal changes in shader / .json / .material files
    - better not to change more than 5 files in one branch
#### 4. make your changes to be committed 
    - better not to change more than 2 files in one commit 
    
    - run in your terminal: git status
    - you should see a list of modified files
    - for each file you really want to add run: git add path/to/your/file
#### 5. create a commit 
    - run in your termianl: git commit - "write  here a short message describing your work"
#### 6. checkout to develop branch 
    - run in your terminal: git checkout develop
#### 7. download latest changes from develop branch
    - run in your terminal: git pull
#### 8. make shure you have the latest changes in develop branch
    - run in your terminal: git status
    - Your should see that it is "Already up to date"

#### 9. return to your branch and merge develop branch into your feature branch
    - run in your terminal: git checkout YOUR_BRANCH_NAME
    - run in your terminal: git merge develop
    - make shure that you have no conflicts
#### 10. upload your changes to repository
    - run in your terminal: git push origin YOUR_BRANCH_NAME
#### 11. make a pull request 
    - go to the branches tab on this page
    - make "New pull request" for your branch
#### 12. make fixes in your branch if it's needed and commit them as describet here
 
**ROADMAP**

| feature                  | verison     | subfeature                 | status |
|:-------------------------|:-----------:|:--------------------------:|-------:| 
|basic lighting            |0.0.0        | entyties lighting          |<span style="color:green">ready</span>  |
|                          |0.0.1        | terrain lighting           |<span style="color:green">ready</span>  |
|                          |0.0.2        | improvemnets               |<span style="color:green">ready</span>|
|                          |0.0.3        | fixes                      |<span style="color:gray">no need</span>|
|advanced texture mapping  |0.1.0        | specular mapping           |<span style="color:green">ready</span>  |
|                          |0.1.1        | normal mapping             |<span style="color:green">ready</span> |
|                          |0.1.2        | improvemnets               |<span style="color:green">ready</span>|
|                          |0.1.3        | fixes                      |<span style="color:gray">no need</span>|
|sky fresnel lighting      |0.2.0        | for terrain                |<span style="color:green">ready</span>  |
|                          |0.2.1        | for entyties               |<span style="color:red">**NO**</span>     |
|                          |0.2.2        | improvemnets               |<span style="color:green">ready</span>|
|                          |0.2.3        | fixes                      |<span style="color:green">ready</span>|
|color correction          |0.3.0        | for terrain                |<span style="color:green">ready</span>  |
|                          |0.3.1        | for sky                    |<span style="color:green">ready</span>  |
|                          |0.3.2        | for entyties               |<span style="color:green">ready</span>  |
|                          |0.3.3        | improvemnets               |<span style="color:green">ready</span>|
|                          |0.3.4        | fixes                      |<span style="color:green">ready</span>|
|wind waving               |0.4.0        | leaves and grass           |<span style="color:green">ready</span>  |
|                          |0.4.1        | water                      |<span style="color:green">ready</span>  |
|                          |0.4.2        | improvemnets               |<span style="color:green">ready</span>|
|                          |0.4.3        | fixes                      |<span style="color:green">ready</span>|
|water                     |0.5.0        | specular and fresnel       |<span style="color:green">ready</span>|
|                          |0.5.1        | texuture mapping           |<span style="color:green">ready</span>|
|                          |0.5.2        | point ligts specular       |<span style="color:green">ready</span>|
|                          |0.5.3        | improvemnets               |<span style="color:green">ready</span>|
|                          |0.5.4        | optimizations              |<span style="color:green">ready</span>|
|                          |0.5.5        | fixes                      |<span style="color:green">ready</span>|
|weather and daytime tune  |0.6.0        | raining                    |<span style="color:green">ready</span>|
|                          |0.6.1        |day / night / sunrize       |<span style="color:green">ready</span>|
|                          |0.6.2        | hell detection             |<span style="color:green">ready</span>|
|                          |0.6.3        | improvements               |<span style="color:red">**NO**</span>|
|                          |0.6.4        | fixes                      |<span style="color:green">ready</span>|
|clouds                    |0.7.0        | clouds generating          |<span style="color:green">ready</span>|
|                          |0.7.1        |optimizations               |<span style="color:gray">no need</span>|
|                          |0.7.2        | clouds reflections         |<span style="color:green">ready</span>|
|                          |0.7.3        | improvements               |<span style="color:red">**NO**</span>|
|                          |0.7.4        | fixes                      |<span style="color:green">ready</span>|
|improve textures          |0.7.5        |fix animated texures        |<span style="color:green">ready</span>|
|                          |0.7.6        |add more texture maps       |<span style="color:green">ready</span>|
|                          |0.7.7        |fix block in hand mapping   |<span style="color:orange">**pendding**</span>|
|                          |0.7.8        |fix inventory block mapping |<span style="color:orange">**pending**</span>|
|advanced sun and mooon    |0.8.0        |hallo effect                |<span style="color:orange">**pending**</span>|
|                          |0.8.1        |improve coloring            |<span style="color:orange">**pending**</span>|
|                          |0.8.2        |bugfixes                    |<span style="color:orange">**pending**</span>|
|make entyties and items   |0.9.0        |item in hand                |<span style="color:orange">**pending**</span>|
|lighting and shading      |0.9.1        |entyties lighting           |<span style="color:orange">**pending**</span>|
|the same as on terrain    |0.9.2        |improvements                |<span style="color:orange">**pending**</span>|
|                          |0.9.3        |fixes                       |<span style="color:orange">**pending**</span>|
|make hell great again     |0.10.0       |improve hell detection      |<span style="color:orange">**pending**</span>|
|                          |0.10.1       |improve fogs in hell        |<span style="color:orange">**pending**</span>|
|                          |0.10.2       |improve lighting in hell    |<span style="color:orange">**pending**</span>|
|                          |0.10.3       |improvemnets and fixes      |<span style="color:orange">**pending**</span>|
|Underwater                |0.11.0       |underwater detection        |<span style="color:orange">**pending**</span>|
|                          |0.11.1       |underwater waving           |<span style="color:orange">**pending**</span>|
|                          |0.11.2       |underwater caustics         |<span style="color:orange">**pending**</span>|
|                          |0.11.3       |improvements                |<span style="color:orange">**pending**</span>|
|                          |0.11.4       |fixes                       |<span style="color:orange">**pending**</span>|
|<span style="color:green">**ALPHA RELEASE**</span>| 0.12.0 |-        |<span style="color:orange">**pending**</span>| 
|bug fixes and improvements|0.12.1-0.12.x| bugfixes                   |<span style="color:orange">**pending**</span>|
|                          |0.13.0-0.13.x| improvements               |<span style="color:orange">**pending**</span>|
|refactoring               |0.14.0       | separate include files     |<span style="color:orange">**pending**</span>|
|                          |0.14.1       | cleenup code               |<span style="color:orange">**pending**</span>|
|                          |0.14.2       | bug fixes                  |<span style="color:orange">**pending**</span>|
|settings                  |0.15.0       | quality presets packages   |<span style="color:orange">**pending**</span>|
|                          |0.15.1       | Brightness setting         |<span style="color:orange">**pending**</span>|
|win10 support             |0.16.0       | terrain shaders            |<span style="color:orange">**pending**</span>|
|                          |0.16.1       | sky shaders                |<span style="color:orange">**pending**</span>|
|                          |0.16.2       | entyties shaders           |<span style="color:orange">**pending**</span>|
|                          |0.16.3       | item in hand shaders       |<span style="color:orange">**pending**</span>|
|                          |0.16.4       | inventory items shaders    |<span style="color:orange">**pending**</span>|
|                          |0.16.5       | improvements               |<span style="color:orange">**pending**</span>|
|                          |0.16.6       | bugfixes                   |<span style="color:orange">**pending**</span>|
|<span style="color:green">**BETTA RELEASE**</span>| 0.17.0 |-        |<span style="color:orange">**pending**</span>| 
|bug fixes                 |0.17.1-0.17.x| -                          |<span style="color:orange">**pending**</span>|
|<span style="color:green">**RELEASE**</span>| 1.0.0 |-               |<span style="color:orange">**pending**</span>| 
|bug fixes                 |1.0.1-1.0.x  | -                          |<span style="color:orange">**pending**</span>|
|paralax mapping           |1.1.0        | simple paralax mapping     |<span style="color:orange">**pending**</span>|  
|                          |1.1.1        | paralax oclusion mapping   |<span style="color:orange">**pending**</span>|
|                          |1.1.2        | optimizations              |<span style="color:orange">**pending**</span>|
|                          |1.1.3        | bugfixes                   |<span style="color:orange">**pending**</span>|