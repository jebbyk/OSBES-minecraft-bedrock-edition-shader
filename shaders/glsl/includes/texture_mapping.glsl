#include "../uniformPerFrameConstants"
#include "../uniformShaderConstants"

    vec3 rotateNormals(vec3 baseNormal, vec3 reliefMap){
        // Fake TBN transformations for normalmapps
        // TODO: Weird thing and takes alot of performance because of branching
        // TODO: Needs refactoring
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

    vec3 mapWaterNormals(sampler2D texture0){
		highp float t = TIME * 0.1;
		float wnScale = 1.0;
		vec2 waterNormalOffset = vec2(3.0/TEXTURE_ATLAS_DIMENSION.x, 0.0);

		// TODO resolve interpolation issues on edges using a more correct way (currently it is wierd)
		vec3 n1 = texture2D(texture0, fract(position.xz*wnScale - t*wnScale * 4.0)/(TEXTURE_ATLAS_DIMENSION + vec2(1.0, 1.0)) + waterNormalOffset).rgb * 2.0 - 1.0;
		vec3 n2 = texture2D(texture0, fract(position.xz*0.3*wnScale * vec2(-1.0, 1.0) - t*wnScale)/(TEXTURE_ATLAS_DIMENSION + vec2(1.0, 1.0)) + waterNormalOffset).rgb * 2.0 - 1.0;
        return normalize(vec3(n1.xy + n2.xy, n1.z / WATER_NORMAL_MAP_STRENGTH)) * 0.5 + 0.5;
    }

    float mapPuddles(sampler2D texture0, vec2 position, float isRain){
		float puddlesScale = 16.0;
        float edgePadding = 0.5; //prevent interpolation issues on texture edges

		vec2 noiseTextureOffset = vec2(1.0/(TEXTURE_ATLAS_DIMENSION.x - edgePadding), 0.0); 
		float puddles = texture2D(texture0, fract(position  / puddlesScale)/(TEXTURE_ATLAS_DIMENSION + edgePadding) + noiseTextureOffset).r;
		puddles = puddles * isRain * PUDDLES_AMOUNT;
		puddles = clamp(puddles, RAIN_MIN_WETNESS, 1.0);

		return puddles * pow(uv1.y, 2.0);// No puddles in dark places like caves
    }

    vec3 mapCaustics(sampler2D texture0, highp vec3 position, float isUnderWater){
        if(isUnderWater > 0.9){
            highp float time = TIME;
            highp float causticsSpeed = 0.05;
            highp float causticsScale = 0.1;
            
            highp vec2 cauLayerCoord_0 = (position.xz + vec2(position.y / 4.0)) * causticsScale + vec2(time * causticsSpeed);
            highp vec2 cauLayerCoord_1 = (-position.xz - vec2(position.y / 4.0)) * causticsScale*0.876 + vec2(time * causticsSpeed);

            highp vec2 noiseTexOffset = vec2(1.0/(TEXTURE_ATLAS_DIMENSION.x * 2.0), 0.0); 
            highp float caustics = texture2D(texture0, fract(cauLayerCoord_0)/(TEXTURE_ATLAS_DIMENSION * 2.0) + noiseTexOffset).r;
            caustics += texture(texture0, fract(cauLayerCoord_1)/TEXTURE_ATLAS_DIMENSION + noiseTexOffset).r;
            
           /* highp float redCaustics = texture2D(texture0, fract(cauLayerCoord_0 + 0.001)/32.0+ noiseTexOffset).r;
            redCaustics += texture(texture0, fract(cauLayerCoord_1 + 0.001)/32.0 + noiseTexOffset).r;
            
            highp float blueCaustics = texture2D(texture0, fract(cauLayerCoord_0 - 0.001)/32.0+ noiseTexOffset).r;
            blueCaustics += texture(texture0, fract(cauLayerCoord_1 - 0.001)/32.0 + noiseTexOffset).r;
            
            */
            
            
            
         //   caustics = clamp(caustics, 0.0, 2.0);
            caustics = -abs(caustics - 1.0)  + 1.0;
            
          /*  if(redCaustics > 1.0){
                redCaustics = 2.0 - redCaustics;
            }
            
            if(blueCaustics > 1.0){
                blueCaustics = 2.0 - blueCaustics;
            }*/
            
            
            highp float cauHardness = 8.0;
            highp float cauStrength = 1.5;
            
           // highp float blueCaustics = ;
            caustics = pow(caustics, cauHardness);
          /*  redCaustics = pow(redCaustics, cauHardness);
            blueCaustics = pow(blueCaustics, cauHardness);*/

            return vec3(caustics) * cauStrength;
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
        highp vec2 invercedTextureDimension,
        vec3 normal
    ){
        highp vec2 reliefMapCoordLinear = diffuseMapCoord - vec2(0.0, invercedTextureDimension.y);

        highp float depthMap = 1.0 - texture2D(texture0, uv0 - reliefMapCoordLinear).a;//smooth paralax
        // highp float depthMap = 1.0 - texelFetch(texture0, ivec2((uv0 - reliefMapCoordLinear) * TEXTURE_DIMENSIONS.xy), 0).a;//sharp paralax

        highp vec3 kernelVector = relativePosition;
        if (normal.b > 0.9) {
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
        }

        highp vec2 p = (kernelVector.xy / kernelVector.z) * 0.001 * depthMap;   

        // p *= (sin(TIME * 4.0) + 1.0) * 0.5;
        
        highp vec2 diffuseMapCoordDisplaced = diffuseMapCoord + p;      

        if( fract((uv0.x - diffuseMapCoordDisplaced.x) * TEXTURE_ATLAS_DIMENSION.x) > 0.5){
            if(diffuseMapCoordDisplaced.x > diffuseMapCoord.x){
                diffuseMapCoordDisplaced.x -= invercedTextureDimension.x;
            } else {
                diffuseMapCoordDisplaced.x += invercedTextureDimension.x;
            }
            
        }
        if( fract((uv0.y - diffuseMapCoordDisplaced.y) * TEXTURE_ATLAS_DIMENSION.y) > 0.5){
            if(diffuseMapCoordDisplaced.y > diffuseMapCoord.y){
                diffuseMapCoordDisplaced.y -= invercedTextureDimension.y;
            } else {
                diffuseMapCoordDisplaced.y += invercedTextureDimension.y;
            }
            
        }  

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
    ){
        ////////////////////////////Mapping section///////////////////////////////////
        
        #ifdef PBR_FEATURE_ENABLED
            // Top left texture - default diffuse
            highp vec2 invercedTextureDimension = (1.0 / TEXTURE_ATLAS_DIMENSION) * 0.5; //cache common calculations

            highp vec2 diffuseMapCoord = fract(uv0 * TEXTURE_ATLAS_DIMENSION) * invercedTextureDimension;// 1.0 / 128.0 = 0.0078125; 1.0 / 64.0 = 0.015625
           
            #ifdef PARALLAX_MAPPING_ENABLED
                diffuseMapCoord = parallax(viewDir, texture0, uv0, diffuseMapCoord, invercedTextureDimension, initialNormalVector);  
            #endif  

            diffuseMap = texelFetch(texture0, ivec2((uv0 - diffuseMapCoord) * TEXTURE_DIMENSIONS.xy), 0);

        #else
            float h = texture2D(texture0, uv0).r;
            uv0 = parallax(viewDir, uv0, h);
            diffuseMap = texelFetch(texture0, ivec2(uv0 * TEXTURE_DIMENSIONS.xy), 0);
        #endif

        #if defined(NORMAL_MAPPING_ENABLED) & defined(PBR_FEATURE_ENABLED)
            #if defined(BLEND)
                if(isWater >  0.9){
                    #ifdef WATER_DETAILS_ENABLED
                        reliefMap = mapWaterNormals(texture0);
                    #endif
                }else{
                    highp vec2 reliefMapCoord = diffuseMapCoord - vec2(0.0, invercedTextureDimension.y);
                    reliefMap = texelFetch(texture0, ivec2((uv0 - reliefMapCoord) * TEXTURE_DIMENSIONS.xy), 0).rgb;
                }
            #else
                highp vec2 reliefMapCoord = diffuseMapCoord - vec2(0.0, invercedTextureDimension.y);
                reliefMap = texelFetch(texture0, ivec2((uv0 - reliefMapCoord) * TEXTURE_DIMENSIONS.xy), 0).rgb;
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
            highp vec2 rmeMapCoord = diffuseMapCoord - vec2(invercedTextureDimension.x, 0.0);// 1.0/128.0
            rmeMap = clamp(texelFetch(texture0, ivec2((uv0 - rmeMapCoord) * TEXTURE_DIMENSIONS.xy), 0),0.01, 1.0);
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
        srcPointLights = uv1.x;
        ambientOclusion = uv1.y;
        
        #ifdef  SHADOWS_ENABLED
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



