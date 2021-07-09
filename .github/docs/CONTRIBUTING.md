**------------Every contributor will be listed as a developer!-----------**

**HOW TO CONTRIBUTE**

#### 0. Fork this repository
    - Click "Fork" button in the top right corner of this page
#### 1. Go to the directory where you want to save shader pack
    - Run in your terminal: cd /path/where/you/want/to/save/this/shaderpack
#### 2. Clone your repository 
    - When your are in your forked repository page click the green "Code" button and the clipboard button to copy the git link
    - Run in your terminal: git clone [your copied link goes here]
#### 3. Convert to a .mcpack file and import
    I recommend the use of mixplorer file manager

    - Archive downloaded folder to .zip archive
    - Change filetype to be .mcpack instead of .zip
    - Open this .mcpack file via Minecraft 
    - After importing, this shader pack should appear in the /sdcard/games/com.mojang/resource_packs/
    - If it does not appear, import some other packs and when they begin to appear in /sdcard/games/ try to import OSBES again. It is your WORKING FOLDER
#### 4. Add link to my original repository to have the actual development version
    - When you are on this page (not your forked repository!!!) click "Code" button, select "HTTPS" and copy this link
    - Run in your terminal: git remote add upstream [your copied link goes here]
#### 5. Switch to develop branch
    The next steps should be done when you are in your WORKING FOLDER 
    - Run in your terminal: git checkout develop
#### 6. Create your own branch named as your feature / work meaning
    - Run in your terminal: git checkout -b your_feature_name
#### 7. Make your local changes in shader / .json / .material files
    - Fewer files changed = faster feature review
#### 8. Make your changes to be committed 
    - Run in your terminal: git status
    - You should see a list of modified files
    - When you've finished making your changes, run: git add .
#### 9. Create a commit 
    - Run in your terminal: git commit -m "[Message goes here]"
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
    - Make sure that you have no conflicts. If you do, fix them (Google "How to fix git conflicts")
#### 14. Upload your changes to the repository
    - Run in your terminal: git push origin your_branch_name
#### 15. Make a pull request into the develop branch 
    - Go to the branches tab in your forked repository
    - Make a new pull request from your branch to my original repository
#### 16. Make fixes in your branch if it's needed and commit them as described here
#### 17. Your pull request will be merged into develop branch

#### If you have problems with these instructions, feel free to create an issue ####