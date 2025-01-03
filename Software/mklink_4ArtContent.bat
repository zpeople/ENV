@echo off

:step1
set SimOne422ContentPath=E:/Workspace_Projects/lishun1_SimOne4.22/Content
set SimOne425ContentPath=Y:\Content
echo Make link from: 
echo 1: Simone422's Content
echo 2: Simone425's Content
set /p Select="Input 1 or 2: "
set PathToSimOneContent=
if "%Select%"=="1" (
	set PathToSimOneContent=%SimOne422ContentPath%
)else if "%Select%"=="2" (
	set PathToSimOneContent=%SimOne425ContentPath%
)
set TargetProjectContentPath=D:\Test\Content
Set ArtContentSubFolders=(ArtMap,Blueprint,Building,Character,Collections,Common,Effect,Foliage,Prop,Road,Shader,Sound,Splash,Terrain,UI,Vehicle,VPMaster,WIP,WorldEditAssets,opendrive,opendrive_plaintext,PhysXScene,SimOneMaps,SimOneUI)
for %%I in %ArtContentSubFolders% do (
	mklink /d "%TargetProjectContentPath%/%%I" "%PathToSimOneContent%/%%I"
)
echo successed
pause