# Changelog

### v0.xx.xx
  - Fixed barrier visibility

### v0.13.2
- Updated loading messages to include the vanilla pool
- Reverted change to water visuals from v0.13.1
- Bugfixes
  - Fixed inventory icons
  - Fixed texture map read issues causing black blocks and glitches on iOS and some other devices
  - Fixed size of the sun and moon if no PBR texture packs is loaded
  - Fixed underwater detection
  - Fixed rain occlusion
-------------
### v0.13.1
- Moved all PBR textures into a seperate downloadable pack
  - Because of this, regular texture packs will now work with OSBES
- Added preset support! Create and share your own custom OSBES adjustments.
- Added an in-game shader quality slider
- Improved clouds
- Improved reflections
-------------
### v0.13.0 (unreleased)
- Fixed support for 1.17.10 (1.17.0 and earlier versions no longer work)
- Code refactor
- Adjusted clouds
- Adjusted the sun and moon
  - They now use more realistic textures and effects
- New water map 
  - This fixes visible texture borders previously visible on the water's surface
- Shader now uses a skybox instead of a skyplane
  - There are now clouds below the ground as well as in the sky to give the illusion of further detail than the render distance allows
  - Slight adjustments to the sky colour (most notably, the sunset)
- Improved reflections
- Reduced filesize via texture optimizations
-------------
### v0.12.3
- Rain fog fix
- Updated 1.17 beta textures
-------------
### v0.12.2
- Fixed caustics
- Fixed normal mapping glitches on some iOS devices
- Fixed gray crymson forest particles
- Fixed black metal blocks in some situations
- Fixed wierd swamp water
- Fixed pink leaves in some situations
- Fixed not animated plants and foliage in some situations
- Improved water
- Improved texture mapping to reduce the need for shader code editing
- Improved grass side texture
- Improved horizontal fog when we go up high
- Added experimental textures
------------
### v0.12.1
- `renderchunk.fragment` refactored
- Metallness pipeline
- Improved reflections
- Updated textures from Vanilla Normals Renewed
-----------
<sub>Changelogs not recorded prior to v0.12.1</sub>
