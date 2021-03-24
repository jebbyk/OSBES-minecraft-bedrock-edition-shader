#include "../uniformPerFrameConstants"
#include "../uniformShaderConstants"

    vec3 rotateNormals(vec3 baseNormal, vec3 reliefMap){
        // Fake TBN transformations for normalmapps
        // TODO: Weird thing and takes alot of performance because of branching
        // TODO: Needs refactoring
        if(length(reliefMap) > 0.9){
            
            float normalMapStrength = 1.0;

            if(baseNormal.g > 0.9){
                reliefMap.gb = reliefMap.bg;
                reliefMap = reliefMap * 2.0 - 1.0;
                reliefMap.rb *= normalMapStrength;
                baseNormal = normalize(reliefMap);
            }else{
                if(baseNormal.g < -0.9){
                    reliefMap.b = -reliefMap.b;
                    reliefMap.gb = reliefMap.bg;
                    reliefMap = reliefMap * 2.0 - 1.0;
                    reliefMap.rb *= normalMapStrength;
                    baseNormal = normalize(reliefMap);
                }else{
                    if (baseNormal.b > 0.9){
                        reliefMap.g = 1.0 - reliefMap.g;// OpenGl needs G to be flipped
                        reliefMap = reliefMap * 2.0 - 1.0;
                        reliefMap.rg *= normalMapStrength;
                        baseNormal = normalize(reliefMap);
        
                    }else{
                        if(baseNormal.b < -0.9){
                            reliefMap.b = -reliefMap.b;
                            reliefMap.g = 1.0 - reliefMap.g;// OpenGl G flip
                            reliefMap.r = 1.0 - reliefMap.r;
                            reliefMap.rg = reliefMap.rg * 2.0 - 1.0;
                            reliefMap.b = reliefMap.b * 2.0 + 1.0;
                            reliefMap.rg *= normalMapStrength;
                            baseNormal = normalize(reliefMap);
                        }else{
                            if(baseNormal.r > 0.9){
                                reliefMap.g = 1.0 - reliefMap.g;// OpenGl G flip
                                reliefMap.r = 1.0 - reliefMap.r;
                                reliefMap.rb = reliefMap.br;
                                reliefMap = reliefMap * 2.0 - 1.0;
                                reliefMap.gb *= normalMapStrength;
                                baseNormal = normalize(reliefMap);
                            }else{
                                if(baseNormal.r < -0.9){
                                    reliefMap.b = -reliefMap.b;
                                    reliefMap.g = 1.0 - reliefMap.g;//OpenGl G flip
                                    reliefMap.rb = reliefMap.br;
                                    reliefMap.gb = reliefMap.gb * 2.0 - 1.0;
                                    reliefMap.r = reliefMap.r * 2.0 + 1.0;
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
		vec2 waterNormalOffset = vec2(4.0/32.0, 0.0);

		// TODO resolve interpolation issues on edges using a more correct way (currently it is wierd)
		vec3 n1 = texture2D(texture0, fract(position.xz*wnScale - t*wnScale * 4.0)/33.0 + waterNormalOffset).rgb * 2.0 - 1.0;
		vec3 n2 = texture2D(texture0, fract(position.xz*0.3*wnScale * vec2(-1.0, 1.0) - t*wnScale)/33.0 + waterNormalOffset).rgb * 2.0 - 1.0;
        return normalize(vec3(n1.xy + n2.xy, n1.z)) * 0.5 + 0.5;
    }

    float mapPuddles(sampler2D texture0, vec2 position, float isRain){
		float puddlesCovering = 1.5;
		float puddlesScale = 32.0;
		float minRainWettneess = 0.5;

		vec2 noiseTextureOffset = vec2(1.0/32.0, 0.0); 
		float puddles = texture2D(texture0, fract(position  / puddlesScale)/32.0 + noiseTextureOffset).r;
		puddles = puddles * isRain * puddlesCovering;
		puddles = clamp(puddles, minRainWettneess, 1.0);

		return puddles * pow(uv1.y, 2.0);// No puddles in dark places like caves
    }

    vec3 mapCaustics(sampler2D texture0, highp vec3 position, float isUnderWater){
        if(isUnderWater > 0.9){
            highp float time = TIME;
            highp float causticsSpeed = 0.05;
            highp float causticsScale = 0.1;
            
            highp vec2 cauLayerCoord_0 = (position.xz + vec2(position.y / 4.0)) * causticsScale + vec2(time * causticsSpeed);
            highp vec2 cauLayerCoord_1 = (-position.xz - vec2(position.y / 4.0)) * causticsScale*0.876 + vec2(time * causticsSpeed);

            highp vec2 noiseTexOffset = vec2(1.0/32.0, 0.0); 
            highp float caustics = texture2D(texture0, fract(cauLayerCoord_0)/32.0+ noiseTexOffset).r;
            caustics += texture(texture0, fract(cauLayerCoord_1)/32.0 + noiseTexOffset).r;
            
           /* highp float redCaustics = texture2D(texture0, fract(cauLayerCoord_0 + 0.001)/32.0+ noiseTexOffset).r;
            redCaustics += texture(texture0, fract(cauLayerCoord_1 + 0.001)/32.0 + noiseTexOffset).r;
            
            highp float blueCaustics = texture2D(texture0, fract(cauLayerCoord_0 - 0.001)/32.0+ noiseTexOffset).r;
            blueCaustics += texture(texture0, fract(cauLayerCoord_1 - 0.001)/32.0 + noiseTexOffset).r;
            
            */
            
            
            
         //   caustics = clamp(caustics, 0.0, 2.0);
            if(caustics > 1.0){
                caustics = 2.0 - caustics;
            }
            
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


    void readTextures(out vec4 diffuseMap, out vec3 reliefMap, out vec4 rmeMap, sampler2D texture0, highp vec2 uv0){
        ////////////////////////////Mapping section///////////////////////////////////

        // By default (with default texture pack) result "megatexture" demensions is 1.0 x 0.5
        // but wtih my texture pack I have 1.0 x ture2D1.0. with your custom texuture pack you should check result texture  dimensions
        
        // Top left texture - default diffuse
        highp vec2 diffuseMapCoord = fract(uv0 * vec2(32.0)) * vec2(0.015625);// 1.0 / 64.0 = 0.015625
        diffuseMap = texelFetch(texture0, ivec2((uv0 - diffuseMapCoord) * TEXTURE_DIMENSIONS.xy), 0);
    
        #if defined(BLEND)
            if(isWater >  0.9){
		        reliefMap = mapWaterNormals(texture0);
            }else{
                highp vec2 reliefMapCoord = diffuseMapCoord - vec2(0.0, 0.015625);
                reliefMap = texelFetch(texture0, ivec2((uv0 - reliefMapCoord) * TEXTURE_DIMENSIONS.xy), 0).rgb;
            }
        #else
            highp vec2 reliefMapCoord = diffuseMapCoord - vec2(0.0, 0.015625);
            reliefMap = texelFetch(texture0, ivec2((uv0 - reliefMapCoord) * TEXTURE_DIMENSIONS.xy), 0).rgb;
        #endif
        
        // Top right texture - specular map
        highp vec2 rmeMapCoord = diffuseMapCoord - vec2(0.015625, 0.0);// 1.0/64.0 = 0.015625
        rmeMap = clamp(texelFetch(texture0, ivec2((uv0 - rmeMapCoord) * TEXTURE_DIMENSIONS.xy), 0),0.01, 1.0);
    }
		

    void calculateMaterialProperties(out float metalness, out highp float roughness, out float shininess, highp vec4 rmeMap, float wetness){
        #if !defined(BLEND)
            metalness = mix(pow(rmeMap.g, 2.0), 0.0, wetness);
            roughness = mix(pow(rmeMap.r, 3.46), 1.0, wetness);
            shininess = 512.0 * roughness;
        #else
            if(isWater >  0.9){
                metalness = 0.0;
                roughness = 1.0;
                shininess = 512.0;
            }else{
                metalness = mix(pow(rmeMap.g, 2.0), 0.0, wetness);
                roughness = mix(pow(rmeMap.r, 2.0), 1.0, wetness);
                shininess = 512.0 * roughness;
            }
        #endif
    }

    void readLightMaps(out float srcPointLights, out float ambientOclusion, out float fakeShadow, vec2 uv1){
        srcPointLights = uv1.x;
        ambientOclusion = uv1.y;
        fakeShadow = min(pow(ambientOclusion * 1.15, 128.0), 1.0);
    }



/*
    highp vec2 parallax(highp vec2 uv, highp vec3 viewDir){
        
        highp vec3 n = vec3(0.0, 1.0, 0.0);
        highp vec3 t = vec3(0.0, 0.0, 1.0);
        highp vec3 b = vec3(1.0, 0.0, 0.0);

        highp mat3 tbn = transpose(mat3(t, b, n));

        viewDir = tbn * viewDir;

        highp float height_scale = 0.01;

        //highp float height = texture2D(texture0, uv).b;
        highp float height = 0.5;
        highp vec2 p = viewDir.xy / viewDir.z * (height * height_scale);

        //return uv;
        return uv - p;
    }
*/

	
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



