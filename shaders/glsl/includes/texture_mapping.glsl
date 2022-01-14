#include "../uniformPerFrameConstants"
#include "../uniformShaderConstants"

    vec3 rotateNormals(vec3 baseNormal, vec3 reliefMap){
        // Fake TBN transformations for normalmapps
        // TODO: Weird thing and takes alot of performance because of branching
        // TODO: Needs refactoring (if true TBN is more performant than this)
        if(length(reliefMap) > 0.9){
            
            float normalMapStrength = NORMAL_MAP_STRENGTH;

            reliefMap = reliefMap * 2.0 - 1.0;

            if(baseNormal.g > 0.9){
                reliefMap.gb = reliefMap.bg;
                reliefMap.rb *= normalMapStrength;
                baseNormal = normalize(reliefMap);
            }else{
                if(baseNormal.g < -0.9){
                    reliefMap.b *= -1.0;
                    reliefMap.gb = reliefMap.bg;
                    reliefMap.rb *= normalMapStrength;
                    baseNormal = normalize(reliefMap);
                }else{
                    if (baseNormal.b > 0.9){
                        reliefMap.g *=  -1.0;
                        reliefMap.rg *= normalMapStrength;
                        baseNormal = normalize(reliefMap);
        
                    }else{
                        if(baseNormal.b < -0.9){
                            reliefMap *= -1.0;
                            reliefMap.rg *= normalMapStrength;
                            baseNormal = normalize(reliefMap);
                        }else{
                            if(baseNormal.r > 0.9){
                                reliefMap.rg *= -1.0;
                                reliefMap.rb = reliefMap.br;
                                reliefMap.gb *= normalMapStrength;
                                baseNormal = normalize(reliefMap);
                            }else{
                                if(baseNormal.r < -0.9){
                                    reliefMap.gb *= -1.0;
                                    reliefMap.rb = reliefMap.br;
                                    reliefMap.gb *= normalMapStrength;
                                    baseNormal = normalize(reliefMap);
                                }
                            }
                        }
                    }
                }
            }
        }
        return baseNormal;
    }

    vec3 rotateNormals(mat3 TBN, vec3 reliefMap){
        reliefMap = reliefMap * 2.0 - 1.0;
        return normalize(TBN * reliefMap);
    }

    vec3 mapWaterNormals(sampler2D texture0){
		highp float t = TIME * 0.1;
		float wnScale = 1.0;

        //read two water noise normals texture moving reading coordinates in different directions
        vec2 invercedPixelSize = vec2(1.0) / TEXTURE_DIMENSIONS.xy;
        
        #ifdef WATER_NORMAL_MAP_RESOLUTION
            vec2 waterNormalMapSize = vec2(WATER_NORMAL_MAP_RESOLUTION) / TEXTURE_DIMENSIONS.xy;
        #else
            vec2 waterNormalMapSize = vec2(16.0) / TEXTURE_DIMENSIONS.xy;
        #endif

        vec3 n1 = texture2D(texture0, invercedPixelSize + fract(position.xz * wnScale - t*wnScale) * waterNormalMapSize).rgb * 2.0 - 1.0;
        vec3 n2 = texture2D(texture0, invercedPixelSize + fract(position.xz * wnScale * vec2(-0.33, 0.33) - t*wnScale) * waterNormalMapSize).rgb * 2.0 - 1.0;

        //mix them together in some special way (google unreal engine mix normalmaps)
        return normalize(vec3(n1.xy + n2.xy, n1.z / WATER_NORMAL_MAP_STRENGTH)) * 0.5 + 0.5;
    }

    float mapPuddles(sampler2D texture0, vec2 position, float isRain){
		float puddlesScale = 16.0;
        float edgePadding = 0.5; //trying to prevent interpolation issues on texture edges

         #ifdef NOISE_MAP_OFFSET
            vec2 noiseTextureOffset = NOISE_MAP_OFFSET / TEXTURE_DIMENSIONS.xy; 
        #else
            vec2 noiseTextureOffset = vec2(16.0, 0.0) / TEXTURE_DIMENSIONS.xy;
        #endif


        #ifdef NOISE_MAP_RESOLUTION
            vec2 noiseMapSize = vec2(NOISE_MAP_RESOLUTION) / TEXTURE_DIMENSIONS.xy;
        #else
            vec2 noiseMapSize = vec2(16.0) / TEXTURE_DIMENSIONS.xy;
        #endif

		float puddles = texture2D(texture0, fract(position  / puddlesScale) * noiseMapSize + noiseTextureOffset).r;
		puddles = puddles * isRain * PUDDLES_AMOUNT;
		puddles = clamp(puddles, RAIN_MIN_WETNESS, 1.0);

		return puddles * pow(uv1.y, 2.0);// No puddles in dark places like caves (uv1.y is an ingame ambient oclusion)
    }

    vec3 mapCaustics(sampler2D texture0, highp vec3 position, float isUnderWater){
        if(isUnderWater > 0.9){
            highp float time = TIME;
            highp float causticsSpeed = 0.05;
            highp float causticsScale = 0.1;
            
            //use two texture coordinates moving in opposite directions
            highp vec2 cauLayerCoord_0 = (position.xz + vec2(position.y / 4.0)) * causticsScale + vec2(time * causticsSpeed);
            highp vec2 cauLayerCoord_1 = (-position.xz - vec2(position.y / 4.0)) * causticsScale*0.876 + vec2(time * causticsSpeed);

            float edgePadding = 0.5; //trying to prevent interpolation issues on texture edges
            
            #ifdef NOISE_MAP_OFFSET
		        vec2 noiseTextureOffset = NOISE_MAP_OFFSET / TEXTURE_DIMENSIONS.xy; 
            #else
                vec2 noiseTextureOffset = vec2(16.0, 0.0) / TEXTURE_DIMENSIONS.xy;
            #endif


            #ifdef NOISE_MAP_RESOLUTION
                vec2 noiseMapSize = vec2(NOISE_MAP_RESOLUTION) / TEXTURE_DIMENSIONS.xy;
            #else
                vec2 noiseMapSize = vec2(16.0) / TEXTURE_DIMENSIONS.xy;
            #endif

            //mix them toogether
            highp float caustics = texture2D(texture0, fract(cauLayerCoord_0) * noiseMapSize + noiseTextureOffset).r;
            caustics += texture(texture0, fract(cauLayerCoord_1) * noiseMapSize + noiseTextureOffset).r;
            //now noise can be a number from 0.0 to 2.0
            
            //make caustics brightness dependin on how close it to 1.0 
            //(bright pixels are in a middle of a transition from <1.0 to >1.0 which results in lines surronunding bright areas of resulted noise texture)
            caustics = -abs(caustics - 1.0)  + 1.0;
            

            highp float causticsSharpness = 8.0;//higher number - sharper caustics lines
            highp float causticsStrength = 1.5;
            caustics = pow(caustics, causticsSharpness);
         

            return vec3(caustics) * causticsStrength;
        }else return vec3(0.0);
    }





    // highp vec2 parallax(highp vec2 uv, highp vec3 viewDir){
        
    //     highp vec3 n = vec3(0.0, 1.0, 0.0);
    //     highp vec3 t = vec3(0.0, 0.0, 1.0);
    //     highp vec3 b = vec3(1.0, 0.0, 0.0);

    //     highp mat3 tbn = transpose(mat3(t, b, n));

    //     viewDir = tbn * viewDir;

    //     highp float height_scale = 0.01;

    //     //highp float height = texture2D(texture0, uv).b;
    //     highp vec2 p = viewDir.xy / viewDir.z * (height * height_scale);

    //     //return uv;
    //     return uv - p;

    //     // return uv;
    // }

    highp vec2 parallax(
        highp vec3 relativePosition, 
        sampler2D texture0, 
        highp vec2 uv0, 
        highp vec2 diffuseMapCoord,
        highp float offset,
        vec3 normal,
        out float depth
        // highp mat3 TBN
    ){
 
        highp vec2 reliefMapCoordLinear = uv0 + vec2(offset / TEXTURE_DIMENSIONS.x, 0.0);


        highp vec4 reliefMapLinear = texture2D(texture0, reliefMapCoordLinear);

        highp float depthMap = 1.0 - reliefMapLinear.a;
       
        //rotate base vector depending on block face dirrection (normal.xyz) 
        highp vec3 kernelVector = vec3(0.0);
        if(normal.b < -0.9){
            kernelVector = relativePosition;
        } else if (normal.b > 0.9) {
            kernelVector = vec3(-relativePosition.x, relativePosition.y, -relativePosition.z);
        } 
        
        else if (normal.g > 0.9) {
            kernelVector = vec3(relativePosition.x, relativePosition.z, relativePosition.y);
        } else if (normal.g < -0.9) {
            kernelVector = vec3(-relativePosition.x, relativePosition.z, relativePosition.y);
        } 
        
        else if (normal.r > 0.9) {
            kernelVector = vec3(-relativePosition.z, -relativePosition.y, relativePosition.x);
        } else if (normal.r < -0.9) {
            kernelVector = vec3(-relativePosition.z, relativePosition.y, relativePosition.x);
        } else {
            return diffuseMapCoord;
        }

        //true TBN transformation is disabled for now because of performance reasons
        // highp vec3 kernelVector = TBN * normalize(relativePosition);

        highp vec2 displacement = (kernelVector.xy / kernelVector.z) * PARALLAX_DEPTH * depthMap;   

        depth = depthMap;

        // displacement *= (sin(TIME * 4.0) + 1.0) * 0.5;

        displacement.xy = clamp(displacement.xy, vec2(-TEXTURE_PADDING), vec2(TEXTURE_PADDING));
        
        vec2 diffuseMapCoordDisplaced = diffuseMapCoord - displacement;      

        return diffuseMapCoordDisplaced;

    }

    void readTextures(
        out vec4 diffuseMap, 
        out vec3 reliefMap, 
        out vec4 rmeMap, 
        sampler2D texture0, 
        highp vec2 uv0, 
        highp vec3 viewDir, 
        vec3 initialNormalVector
        // highp mat3 TBN
    ){        

        bool curTexIsPBR = false;
        highp float textureSize = 0.0;
        float depthmap = 1.0;
        #ifdef PBR_FEATURE_ENABLED   

            highp vec2 diffuseMapCoord = uv0 * TEXTURE_DIMENSIONS.xy;

            diffuseMap = texelFetch(texture0, ivec2(diffuseMapCoord), 0);
            
            curTexIsPBR = diffuseMap.a > 0.0 && diffuseMap.a < 12.0 / 256.0; //256 is fully opaque, 0 - no PBR, 1 - 4x4, 2 - 8x8, 3 16x16, 4 - 32x32, 5 - 64x64 etc.
            if(curTexIsPBR){
                textureSize = float(diffuseMap.a) * 256.0;
                textureSize = pow(2.0, textureSize + 1.0);
                textureSize = floor(textureSize + TEXTURE_PADDING*2.0); // fix precision issues 
            }
           
            #ifndef BLEND
                #ifdef PARALLAX_MAPPING_ENABLED
                    // if parallax is enabled apply some texture coordinates offsetting to make illusion of depth
                    if(curTexIsPBR){
                        diffuseMapCoord = parallax(viewDir, texture0, uv0, diffuseMapCoord, textureSize, initialNormalVector, depthmap);
                        diffuseMap = texelFetch(texture0, ivec2(diffuseMapCoord), 0);
                        diffuseMap.rgb *= 1.0 - depthmap;
                    }
                #endif
            #endif
           
        #else
            //if no PBR feature enabled than read default texture dirrectly without offsetting UV coordinates
            diffuseMap = texelFetch(texture0, ivec2(uv0 * TEXTURE_DIMENSIONS.xy), 0);
        #endif

        #if defined(NORMAL_MAPPING_ENABLED) & defined(PBR_FEATURE_ENABLED)
            // BLEND is a semitransperent objects like glass or water
            #if defined(BLEND)
                if(isWater >  0.9){
                    #ifdef WATER_DETAILS_ENABLED
                        reliefMap = mapWaterNormals(texture0);
                    #endif
                }else{
                    vec2 reliefMapCoord = diffuseMapCoord + vec2(textureSize, 0.0);
                    reliefMap = texelFetch(texture0, ivec2(reliefMapCoord), 0).rgb;
                }
            #else
            if(curTexIsPBR){
                vec2 reliefMapCoord = diffuseMapCoord + vec2(textureSize, 0.0);
                reliefMap = texelFetch(texture0, ivec2(reliefMapCoord), 0).rgb;
            }
            #endif
        #else
            #ifdef WATER_DETAILS_ENABLED
                if(isWater >  0.9){
                    reliefMap = mapWaterNormals(texture0);
                }else{
                    reliefMap = vec3(0.0);
                }
            #endif
        #endif
        
        #if defined(SPECULAR_MAPPING_ENABLED) & defined(PBR_FEATURE_ENABLED)
            // Top right texture - specular map
            if(curTexIsPBR){
                vec2 rmeMapCoord =  diffuseMapCoord + vec2(textureSize*2.0, 0.0);
                rmeMap = texelFetch(texture0, ivec2(rmeMapCoord), 0);
                rmeMap = max(rmeMap, 0.01);
            }
        #else
            rmeMap = vec4(0.0);
        #endif 
    }
		

    void calculateMaterialProperties(out float metalness, out highp float roughness, out float shininess, highp vec4 rmeMap, float wetness){
        #if !defined(BLEND)
            #ifdef SPECULAR_MAPPING_ENABLED
                metalness = mix(pow(rmeMap.g, 2.0), 0.0, wetness);
                roughness = mix(pow(rmeMap.r, 3.46), 1.0, wetness);
                shininess = 512.0 * roughness;
            #else
                metalness = 0.0;
                roughness = 0.0;
                shininess = 0.0;
            #endif
        #else
            if(isWater >  0.9){
                metalness = 0.0;
                roughness = 1.0;
                shininess = 512.0;
            }else{
                #ifdef SPECULAR_MAPPING_ENABLED
                    metalness = mix(pow(rmeMap.g, 2.0), 0.0, wetness);
                    roughness = mix(pow(rmeMap.r, 2.0), 1.0, wetness);
                    shininess = 512.0 * roughness;
                #else
                    metalness = 0.0;
                    roughness = 0.0;
                    shininess = 0.0;
                #endif
            }
        #endif
    }

    void readLightMaps(out float srcPointLights, out float ambientOclusion, out float fakeShadow, vec2 uv1){
        //I decided to use raw uv coordinates without less performant texture reads
        srcPointLights = uv1.x;
        ambientOclusion = uv1.y;
        
        #ifdef  SHADOWS_ENABLED
            //this shadow basicly just a very sharpened ambient oclusion
            fakeShadow = min(pow(ambientOclusion * 1.15, SHADOW_SHARPNESS), 1.0);
        #else
            fakeShadow = 1.0;
        #endif
    }




	
	/////////////////////////////////////////////some experiments with TBN calculation ///////////////////////////////////////////////
	//highp vec2 duv1 = dFdx(uv0);
	//highp vec2 duv2 = dFdy(uv0);

	//highp vec3 dp2perp = cross(dp2, initNormalColor);
	//highp vec3 dp1perp = cross(initNormalColor, dp1);

	//highp vec3 T = normalize(dp2perp * duv1.x + dp1perp * duv2.x);
	//highp vec3 B = normalize(dp2perp * duv1.y + dp1perp * duv2.y);

	//highp float invmax = inversesqrt(max(dot(T,T), dot(B,B)));
	
	//highp mat3 tbn = mat3(T, B, initNormalColor);

	//reliefMap.rgb = reliefMap.rgb * 2.0 - 1.0;
	
	//normalColor.rgb = tbn * reliefMap.rgb;





	//highp vec3 q1 = dFdx(-position.xyz);
	//highp vec3 q2 = dFdy(-position.xyz);

	//highp vec2 st1 = dFdx(uv0);
	//highp vec2 st2 = dFdy(uv0);

	//highp vec3 T = normalize(q1*st2.t - q2*st1.t);
	//highp vec3 B = normalize(-q1*st2.s + q2*st1.s);

	//highp mat3 tbn = mat3(T, B, initNormalColor);

	//normalColor.rgb = normalColor.rgb * 2.0 - 1.0;

	//normalColor.rgb = reliefMap.rgb * tbn;



	//highp vec3 t = normalize(dFdx(position.xyz));
	//highp vec3 b = normalize(dFdy(position.xyz));
	//highp vec3 n = normalize(cross(t, b));

	//highp mat3 tbn = mat3(t, b, n);

	//normalColor.rgb = normalize(reliefMap.rgb * tbn);
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



