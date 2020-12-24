# OSBES v0.11.1
Open Source Bedrock Edition Shader  

**------------Every contributor will be listed as a developer!-----------**

**HOW TO CONTRIBUTE**
I recomend you to use rooted device with installed Termux <span style="color:green">**terminal**</span> emulator
#### 0. Fork this repository
    - Click "Fork" button in the top right corner of this page
#### 1. Go to the directory where you want to save shader pack
    - Run in your terminal: cd /path/where/you/want/to/save/this/shaderpack
#### 2. Clone your repository 
    - When your are in your forked repository page click the green "Code" button, the clipboard button to copy the git link
    - Run in your terminal: git clone [your copied link goes here]
#### 3. convert it to a .mcpack file and import
    I recomend to use mixplorer file manager

    - Archive downloaded folder to .zip archive
    - Change filetype to be .mcpack instead of .zip
    - Open this .mcpack file via Minecraft 
    - After importing, this shader pack should appear in the /sdcard/games/com.mojang/resource_packs/
    - If it does not appear, import some other packs and when they begin to appear in /sdcard/games/ try to import OSBES again. It is your WORKING FOLDER
#### 4. Add link to my original repository to have the actual development version
    - when you are on this page (not your forked repository!!!) click "Code" button, select "HTTPS" and copy this link
    - run in your terminal: git remote add upstream [your copied link goes here]
#### 5. Switch to develop branch
    The next steps should be done when you are in your WORKING FOLDER 
    - Run in your terminal: git checkout develop
#### 6. Create your own branch named as your feature / work meaning
    - Run in your terminal: git checkout -b your_feature_name
#### 7. Make your lacal changes in shader / .json / .material files
    - Fewer files changed = faster feature review
#### 8. Make your changes to be committed 
    - Run in your terminal: git status
    - You should see a list of modified files
    - For each file you want to add run: git add path/to/your/file
#### 9. Create a commit 
    - Run in your terminal: git commit -m "write  here a short message describing your work"
#### 10. Checkout to develop branch 
    - Run in your terminal: git checkout develop
#### 11. Download latest changes from my original repository develop branch
    - Run in your terminal: git pull upstream develop
#### 12. Make sure you have the latest changes in develop branch
    - Run in your terminal again: git pull upstream develop
    - You should see that it is "Already up to date"

#### 13. Return to your branch and merge the develop branch into your feature branch
    - Run in your terminal: git checkout your_branch_name
    - Run in your terminal: git merge develop
    - Make sure that you have no conflicts. Otherwise, fix them (GOOGLE --> "how to fix conflict in git")
#### 14. Upload your changes to the repository
    - Run in your terminal: git push origin your_branch_name
#### 15. Make a pull request into the develop branch 
    - Go to the branches tab in your forked repository
    - Make a new pull request from your branch to my original repository
#### 16. Make fixes in your branch if it's needed and commit them as described here
#### 17. Your pull request will be merged into develop branch

#### If you have some problems with this instruction create an issue ####

**ROADMAP**

| Feature                  | Version     | Subfeature                 | Status |
|:-------------------------|:-----------:|:-----------------------------:|-------:| 
|Basic lighting            |0.0.0        | Entity lighting             |<span style="color:green">ready</span>  |
|                          |0.0.1        | Terrain lighting              |<span style="color:green">ready</span>  |
|                          |0.0.2        | Improvements                  |<span style="color:green">ready</span>|
|                          |0.0.3        | Fixes                         |<span style="color:gray">no need</span>|
|Advanced texture mapping  |0.1.0        | Specular mapping              |<span style="color:green">ready</span>  |
|                          |0.1.1        | Normal mapping                |<span style="color:green">ready</span> |
|                          |0.1.2        | Improvements                  |<span style="color:green">ready</span>|
|                          |0.1.3        | Fixes                         |<span style="color:gray">no need</span>|
|Sky fresnel lighting      |0.2.0        | For terrain                   |<span style="color:green">ready</span>  |
|                          |0.2.1        | For entities                  |<span style="color:red">**NO**</span>     |
|                          |0.2.2        | Improvements                  |<span style="color:green">ready</span>|
|                          |0.2.3        | Fixes                         |<span style="color:green">ready</span>|
|Color correction          |0.3.0        | For terrain                   |<span style="color:green">ready</span>  |
|                          |0.3.1        | For sky                       |<span style="color:green">ready</span>  |
|                          |0.3.2        | For entities                  |<span style="color:green">ready</span>  |
|                          |0.3.3        | Improvements                  |<span style="color:green">ready</span>|
|                          |0.3.4        | Fixes                         |<span style="color:green">ready</span>|
|Wind waving               |0.4.0        | Leaves and grass              |<span style="color:green">ready</span>  |
|                          |0.4.1        | Water                         |<span style="color:green">ready</span>  |
|                          |0.4.2        | Improvements                  |<span style="color:green">ready</span>|
|                          |0.4.3        | Fixes                         |<span style="color:green">ready</span>|
|Water                     |0.5.0        | Specular and fresnel          |<span style="color:green">ready</span>|
|                          |0.5.1        | Texuture mapping              |<span style="color:green">ready</span>|
|                          |0.5.2        | Point lights specular          |<span style="color:green">ready</span>|
|                          |0.5.3        | Improvements                  |<span style="color:green">ready</span>|
|                          |0.5.4        | Optimizations                 |<span style="color:green">ready</span>|
|                          |0.5.5        | Fixes                         |<span style="color:green">ready</span>|
|Weather and daytime tune  |0.6.0        | Raining                       |<span style="color:green">ready</span>|
|                          |0.6.1        |Day / Night / Sunrise          |<span style="color:green">ready</span>|
|                          |0.6.2        | Hell detection                |<span style="color:green">ready</span>|
|                          |0.6.3        | Improvements                  |<span style="color:red">**NO**</span>|
|                          |0.6.4        | Fixes                         |<span style="color:green">ready</span>|
|Clouds                    |0.7.0        | Cloud generation             |<span style="color:green">ready</span>|
|                          |0.7.1        |Optimizations                  |<span style="color:gray">no need</span>|
|                          |0.7.2        | Clouds reflections            |<span style="color:green">ready</span>|
|                          |0.7.3        | improvements                  |<span style="color:red">**NO**</span>|
|                          |0.7.4        | Fixes                         |<span style="color:green">ready</span>|
|Improve textures          |0.7.5        |Fix animated texures           |<span style="color:green">ready</span>|
|                          |0.7.6        |Add more texture maps          |<span style="color:green">ready</span>|
|                          |0.7.7        |Fix block in hand mapping      |<span style="color:green">ready</span>|
|                          |0.7.8        |Fix inventory block mapping    |<span style="color:green">ready</span>|
|                          |0.7.10       |Prepare inventory flat textures|<span style="color:green">ready</span>|
|                          |0.7.9        |Fix entity texture mapping   |<span style="color:green">ready</span>|
|                          |0.7.12       |Fix torches mapping            |<span style="color:green">particulary ready</span>|
|                          |0.7.11       |Correct tangent calculation    |<span style="color:green">particulary ready</span>|
|Advanced Sun and Moon    |0.8.0        |Halo effect                   |<span style="color:green">ready</span>|
|                          |0.8.1        |Improve Halo coloring          |<span style="color:green">ready</span>|
|                          |0.8.2        |Halo lighting on the surfaces  |<span style="color:green">ready</span>|
|                          |0.8.3        |Improve fog color handling     |<span style="color:green">ready</span>|
|                          |-            |bugfixes                       |<span style="color:gray">no need</span>|
|Underwater                |0.9.0        |Underwater detection and waving|<span style="color:green">ready</span>|
|                          |0.9.1        |Underwater caustics            |<span style="color:green">ready</span>|
|                          |0.9.2        |Improvements                   |<span style="color:green">ready</span>|
|                          |0.9.3        |Fixes                          |<span style="color:green">ready</span>|
|Make hell great again     |0.10.0       |Improve hell detection         |<span style="color:green">ready</span>|
|                          |0.10.1       |Fix rainy weather              |<span style="color:green">ready</span>|
|                          |0.10.2       |Fix some texutres              |<span style="color:green">ready</span>|
|<span style="color:green">**ALPHA RELEASE**</span>| 0.11.0 |hotfixes|<span style="color:green">ready</span>|
|Bug fixes and improvements|0.11.1       | Bugfixes                      |<span style="color:green">ready</span>
|                          |-            | Improvements                  |<span style="color:purple">**In progress**</span>| 
|Refactoring               |0.12.0       | Separate include files        |<span style="color:orange">**Planned**</span>|
|                          |-            | Clean up code                  |<span style="color:orange">**Planned**</span>|
|                          |-            | Bug fixes                     |<span style="color:orange">**Planned**</span>|
|Make entity and item   |0.13.0       |Held items                   |<span style="color:orange">**Planned**</span>|
|lighting and shading      |-            |Entity lighting              |<span style="color:orange">**Planned**</span>|
|the same as on terrain    |-            |Improvements                   |<span style="color:orange">**Planned**</span>|
|                          |-            |fixes                          |<span style="color:orange">**Planned**</span>|
|settings                  |0.14.0       | Quality presets packages      |<span style="color:orange">**Planned**</span>|
|                          |-            | Brightness setting            |<span style="color:orange">**Planned**</span>|
|Win10 support             |0.15.0       | Terrain shaders               |<span style="color:orange">**Planned**</span>|
|                          |-            | Sky shaders                   |<span style="color:orange">**Planned**</span>|
|                          |-            | Entity shaders              |<span style="color:orange">**Planned**</span>|
|                          |-            | Held item shaders          |<span style="color:orange">**Planned**</span>|
|                          |-            | Inventory item shaders       |<span style="color:orange">**Planned**</span>|
|                          |-            | Improvements                  |<span style="color:orange">**Planned**</span>|
|                          |-            | Bugfixes                      |<span style="color:orange">**Planned**</span>|
|<span style="color:green">**BETA RELEASE**</span>|0.16.0|-             |<span style="color:orange">**Planned**</span>| 
|Bug fixes                 |-            | -                             |<span style="color:orange">**Planned**</span>|
|<span style="color:green">**RELEASE**</span>|1.0.0|-                    |<span style="color:orange">**Planned**</span>| 
|Bug fixes                 |-            | -                             |<span style="color:orange">**Planned**</span>|
|Parallax mapping           |1.1.0        | simple paralax mapping        |<span style="color:orange">**Planned**</span>|  
|                          |-            | Parallax occlusion mapping      |<span style="color:orange">**Planned**</span>|
|                          |-            | Optimizations                 |<span style="color:orange">**Planned**</span>|
|                          |-            | Bugfixes                      |<span style="color:orange">**Planned**</span>|
