// services/LoadDataForRegisterNewUser.js
//
// ═══════════════════════════════════════════════════════════════════
//  HOW THE CLIENT LOADS EACH ASSET TYPE (from SWF bytecode analysis)
// ═══════════════════════════════════════════════════════════════════
//
//  EYES / EYESHADOWS  (DragonBone = true)
//    Full URL = baseHost + "swf/dragonbone_faceparts/" + type + "/" + SWF + "/texture.swf"
//    type for eyes      = "eyes"
//    type for eyeshadow = "eyeshadow"
//    So Eye.SWF   = "eyes_girlnextdoor_2013"
//       → loads: swf/dragonbone_faceparts/eyes/eyes_girlnextdoor_2013/texture.swf
//    EyeShadow.SWF = "eyeshadow_sweetstuff_2013"
//       → loads: swf/dragonbone_faceparts/eyeshadow/eyeshadow_sweetstuff_2013/texture.swf
//
//  NOSES / MOUTHS  (DragonBone = false)
//    Full URL = baseHost + "swf/faceparts/" + SWFLocation
//    So Nose.SWFLocation  = "nose_8_freckles.swf"
//       → loads: swf/faceparts/nose_8_freckles.swf
//
//  CLOTHES  (CLOTHES_SUBPATH = "swf/")
//    Full URL = baseHost + "swf/" + path
//    Since your files are in subdirs:
//      hair      → path = "hair/filename.swf"
//      tops      → path = "tops/filename.swf"
//      bottoms   → path = "bottoms/filename.swf"
//      footwear  → path = "footwear/filename.swf"
//      headwear  → path = "accessories/filename.swf"  (your accessories folder)
//
//  SKINS  (loaded by LoadSkins, NOT from this AMF response)
//    Hardcoded in client: swf/skins/femaleskin.swf, femaleskin1.swf ... femaleskin3dc.swf
//                         swf/skins/maleskin.swf,   maleskin1.swf  ... maleskin3dc.swf
//    YOU MUST SERVE THESE FILES or the loading screen never clears.
//    See the Express static-file note at the bottom of this file.
//
//  ACTOR BODY  (loaded by LoadActor, NOT from this AMF response)
//    DragonStar body renders from: swf/dragonstar/girl/texture.png
//                                  swf/dragonstar/boy/texture.png  (+ more)
//    YOU MUST SERVE THESE FILES TOO.
//
// ═══════════════════════════════════════════════════════════════════
//  CATEGORY IDs  (verified from SWF bytecode)
// ═══════════════════════════════════════════════════════════════════
//   1 = Hair
//   2 = Tops / Shirts
//   3 = Bottoms / Pants
//   5 = Footwear / Shoes
//   6 = Headwear / Hats  (maps to your accessories/ folder)
//
// ═══════════════════════════════════════════════════════════════════
//  REGNEWUSER skin values
// ═══════════════════════════════════════════════════════════════════
//   1 = female only,  2 = male only,  0 (or absent) = unisex
//   SkinId must match RegNewUser on every object.

const nodeamf = require('@jadbalout/nodeamf');

class RegisterNewUserData { constructor() { this._explicitType = "com.moviestarplanet.moviestar.valueObjects.RegisterNewUserData"; } }
class Eye        { constructor() { this._explicitType = "com.moviestarplanet.moviestar.valueObjects.Eye"; } }
class EyeShadow  { constructor() { this._explicitType = "com.moviestarplanet.moviestar.valueObjects.EyeShadow"; } }
class Nose       { constructor() { this._explicitType = "com.moviestarplanet.moviestar.valueObjects.Nose"; } }
class Mouth      { constructor() { this._explicitType = "com.moviestarplanet.moviestar.valueObjects.Mouth"; } }
class Cloth      { constructor() { this._explicitType = "com.moviestarplanet.moviestar.valueObjects.Cloth"; } }

if (nodeamf.registerClassAlias) {
    nodeamf.registerClassAlias("com.moviestarplanet.moviestar.valueObjects.RegisterNewUserData", RegisterNewUserData);
    nodeamf.registerClassAlias("com.moviestarplanet.moviestar.valueObjects.Eye",       Eye);
    nodeamf.registerClassAlias("com.moviestarplanet.moviestar.valueObjects.EyeShadow", EyeShadow);
    nodeamf.registerClassAlias("com.moviestarplanet.moviestar.valueObjects.Nose",      Nose);
    nodeamf.registerClassAlias("com.moviestarplanet.moviestar.valueObjects.Mouth",     Mouth);
    nodeamf.registerClassAlias("com.moviestarplanet.moviestar.valueObjects.Cloth",     Cloth);
}

// Eyes use DragonBone=true. SWF = subfolder name inside swf/dragonbone_faceparts/eyes/
// The full asset path the client requests: swf/dragonbone_faceparts/eyes/{SWF}/texture.swf
function makeEye(id, swfSubfolder, skinId) {
    const o = new Eye();
    Object.assign(o, {
        EyeId:         id,
        Name:          swfSubfolder,
        SWF:           swfSubfolder,       // e.g. "eyes_girlnextdoor_2013"
        SWFLocation:   swfSubfolder,
        DragonBone:    true,
        SkinId:        skinId,
        RegNewUser:    skinId,
        type:          "eyes",
        DefaultColors: "0",
        sortorder:     id,
        hidden:        false,
    });
    return o;
}

// EyeShadows use DragonBone=true. SWF = subfolder inside swf/dragonbone_faceparts/eyeshadow/
// Full path: swf/dragonbone_faceparts/eyeshadow/{SWF}/texture.swf
function makeEyeShadow(id, swfSubfolder, skinId) {
    const o = new EyeShadow();
    Object.assign(o, {
        EyeShadowId:   id,
        Name:          swfSubfolder,
        SWF:           swfSubfolder,       // e.g. "eyeshadow_sweetstuff_2013"
        SWFLocation:   swfSubfolder,
        DragonBone:    true,
        SkinId:        skinId,
        RegNewUser:    skinId,
        type:          "eyeShadow",
        DefaultColors: "0",
        sortorder:     id,
        hidden:        false,
    });
    return o;
}

// Noses use DragonBone=false. SWFLocation = filename inside swf/faceparts/
// Full path: swf/faceparts/{SWFLocation}
function makeNose(id, swfFilename, skinId) {
    const o = new Nose();
    Object.assign(o, {
        NoseId:        id,
        Name:          swfFilename,
        SWF:           swfFilename,
        SWFLocation:   `noses/${swfFilename}`,        // e.g. "nose_8_freckles.swf"
        DragonBone:    false,
        SkinId:        skinId,
        RegNewUser:    skinId,
        type:          "nose",
        DefaultColors: "0",
        sortorder:     id,
        hidden:        false,
    });
    return o;
}

// Mouths use DragonBone=false. SWFLocation = filename inside swf/faceparts/
function makeMouth(id, swfFilename, skinId) {
    const o = new Mouth();
    Object.assign(o, {
        MouthId:       id,
        Name:          swfFilename,
        SWF:           swfFilename,
        SWFLocation:   `mouths/${swfFilename}`,        // e.g. "male_mouth_2.swf"
        DragonBone:    false,
        SkinId:        skinId,
        RegNewUser:    skinId,
        type:          "mouth",
        DefaultColors: "0",
        sortorder:     id,
        hidden:        false,
    });
    return o;
}

// Clothes path = "subdir/filename.swf"  (CLOTHES_SUBPATH = "swf/" so full = swf/subdir/filename.swf)
function makeCloth(id, subdir, filename, categoryId, skinId) {
    const clothPath = `${subdir}/${filename}`;
    const o = new Cloth();
    Object.assign(o, {
        ClothesId:          id,
        Name:               filename,
        path:               clothPath,     // e.g. "hair/miami_2011_female_hair_3.swf"
        SWF:                clothPath,
        ClothesCategoryId:  categoryId,
        SkinId:             skinId,
        RegNewUser:         skinId,
        ColorScheme:        "0",
        hidden:             false,
    });
    return o;
}

// ─────────────────────────────────────────────────────────────────────────────
// INSTRUCTIONS: Replace the placeholder filenames below with real filenames
// from YOUR asset folders. The structure is:
//   eyes/eyeshadows → use the subfolder name from swf/dragonbone_faceparts/eyes/
//   noses/mouths    → use the .swf filename from swf/faceparts/
//   clothes         → use the .swf filename from swf/hair/, swf/tops/, etc.
// ─────────────────────────────────────────────────────────────────────────────

module.exports = {
    execute: function(req) {
        console.log("      => [LoadDataForRegisterNewUser] Building character creator data...");

        const responseData = new RegisterNewUserData();

        // ── EYES ─────────────────────────────────────────────────────────────
        // SWF value = subfolder name inside swf/dragonbone_faceparts/eyes/
        // These are ALL the eye subfolders found in the SWF asset manifest:
        //   eyes_alien_2013, eyes_asian_2013, eyes_asiancutie_2013,
        //   eyes_bling_2013_new, eyes_boynextdoor_2013, eyes_cateyes_2013,
        //   eyes_girlnextdoor_2013, eyes_glittergalore_2013, eyes_honesthero_2013,
        //   eyes_moviestar_2013, eyes_partyperfect_2013, eyes_prettyperfect_2013,
        //   eyes_shadysunday_2013, eyes_theman_2013, eyes_themanblue_2013
        //
        // Female = SkinId 1, Male = SkinId 2
        // Pick ones that actually exist in your swf/dragonbone_faceparts/eyes/ folder:
        responseData.eyes = [
            // female
            makeEye(1,  "eyes_girlnextdoor_2013",  1),
            makeEye(2,  "eyes_prettyperfect_2013",  1),
            makeEye(3,  "eyes_glittergalore_2013",  1),
            makeEye(4,  "eyes_cateyes_2013",        1),
            makeEye(5,  "eyes_partyperfect_2013",   1),
            // male
            makeEye(11, "eyes_boynextdoor_2013",    2),
            makeEye(12, "eyes_theman_2013",         2),
            makeEye(13, "eyes_themanblue_2013",     2),
            makeEye(14, "eyes_honesthero_2013",     2),
            makeEye(15, "eyes_shadysunday_2013",    2),
        ];

        // ── EYE SHADOWS ───────────────────────────────────────────────────────
        // SWF = subfolder inside swf/dragonbone_faceparts/eyeshadow/
        // All found in manifest:
        //   eyeshadow_amusementpark_2013, eyeshadow_bling_2013, eyeshadow_bling2_2013,
        //   eyeshadow_cateyes_2013, eyeshadow_femalestar_2013, eyeshadow_freakshow_2013,
        //   eyeshadow_galaxylove_2013, eyeshadow_party_2013, eyeshadow_partyperfect_2013,
        //   eyeshadow_rococo_2013, eyeshadow_seventies_2013, eyeshadow_sweetstuff_2013
        responseData.eyeShadows = [
            // female
            makeEyeShadow(1, "eyeshadow_sweetstuff_2013",   1),
            makeEyeShadow(2, "eyeshadow_femalestar_2013",   1),
            makeEyeShadow(3, "eyeshadow_partyperfect_2013", 1),
            makeEyeShadow(4, "eyeshadow_cateyes_2013",      1),
            // male
            makeEyeShadow(11, "eyeshadow_party_2013",       2),
            makeEyeShadow(12, "eyeshadow_bling_2013",       2),
        ];

        // ── NOSES ─────────────────────────────────────────────────────────────
        // SWFLocation = filename inside swf/faceparts/
        // Replace with real filenames from your swf/faceparts/ folder.
        responseData.noses = [
            makeNose(1,  "nose_8_freckles.swf", 1),
            makeNose(11, "nose_3.swf",           2),
        ];

        // ── MOUTHS ────────────────────────────────────────────────────────────
        // SWFLocation = filename inside swf/faceparts/
        responseData.mouths = [
            makeMouth(1,  "eternallove_2011_femalelips_nd.swf", 1),
            makeMouth(2,  "female_mouth_3.swf",                 1),
            makeMouth(11, "male_mouth_2.swf",                   2),
        ];

        // ── CLOTHES ───────────────────────────────────────────────────────────
        // path = "subdir/filename.swf"
        // The client prepends "swf/" so the full URL = baseHost + "swf/" + path
        // Your folders:  hair→swf/hair/  tops→swf/tops/  bottoms→swf/bottoms/
        //                footwear→swf/footwear/  accessories→swf/accessories/ (headwear)
        //
        // Replace all filenames with REAL filenames from your folders.
        responseData.clothes = [

            // HAIR — category 1 — your files are in swf/hair/
            makeCloth(101, "hair", "miami_2011_female_hair_3.swf",  1, 1),
            makeCloth(102, "hair", "HouseParty_2011_female_hair_1_nd.swf",             1, 1),
            makeCloth(103, "hair", "valentines_2011_female_hair_2.swf",             1, 1),
            ///
            makeCloth(111, "hair", "Hair_clovn_Taunus.swf",      1, 2),
            makeCloth(112, "hair", "emo_2011_male_hair_3.swf",               1, 2),
            makeCloth(113, "hair", "2009_hair_boys_Honey_5.swf",               1, 2),

            // TOPS — category 2 — your files are in swf/tops/
            makeCloth(201, "tops", "arabianProm_2015_diamond_dg.swf",         2, 1),
            makeCloth(202, "tops", "Aloha_2014_PineappleTee_FJ.swf",                         2, 1),
            makeCloth(203, "tops", "amusementpark_2011_female_top_7.swf",                         2, 1),
            ///
            makeCloth(211, "tops", "rockstarchristmas_2011_female_tops_1.swf",    2, 2),

            // BOTTOMS — category 3 — your files are in swf/bottoms/
            makeCloth(301, "bottoms", "Mexico_2012_FemaleMariachiShorts_ms.swf", 3, 1),
            makeCloth(302, "bottoms", "grinch_2011_female_bottoms_4.swf",                      3, 1),
            makeCloth(303, "bottoms", "june_female_bottoms_3.swf",                      3, 1),
            ///
            makeCloth(311, "bottoms", "Christmas_2011_male_bottoms_nd_1.swf",                        3, 2),
            makeCloth(312, "bottoms", "elvistrousers.swf",                        3, 2),
            makeCloth(313, "bottoms", "Honey_bottoms_10_boys.swf",                        3, 2),

            // FOOTWEAR — category 5 — your files are in swf/footwear/
            makeCloth(501, "footwear", "may_shoes_female_1.swf",  5, 1),
            ///
            makeCloth(511, "footwear", "may_shoes_female_1.swf",        5, 2),

            // HEADWEAR — category 6 — your files are in swf/accessories/
            makeCloth(601, "accessories", "Christmas_2014_hairPin_dg.swf",  6, 1),
            makeCloth(602, "accessories", "easter_2012_ChickCap_nd.swf",  6, 1),
            //
            makeCloth(611, "accessories", "December_hat_6.swf",    6, 2),
            makeCloth(612, "accessories", "Kineserhat.swf",    6, 2),
        ];

        return responseData;
    }
};

// ═══════════════════════════════════════════════════════════════════
//  CRITICAL: You ALSO need these static files on your Express server
//  or the loading screen will NEVER clear regardless of AMF data:
// ═══════════════════════════════════════════════════════════════════
//
//  SKIN SWFs (hardcoded in client, loaded by LoadSkins):
//    swf/skins/femaleskin.swf
//    swf/skins/femaleskin1.swf
//    swf/skins/femaleskin2.swf
//    swf/skins/femaleskin2dc.swf
//    swf/skins/femaleskin2dc2.swf
//    swf/skins/femaleskin2dc3.swf
//    swf/skins/femaleskin3dc.swf
//    swf/skins/femaleskin10dc.swf
//    swf/skins/maleskin.swf
//    swf/skins/maleskin1.swf
//    swf/skins/maleskin2.swf
//    swf/skins/maleskin2dc.swf
//    swf/skins/maleskin2dc2.swf
//    swf/skins/maleskin2dc3.swf
//    swf/skins/maleskin3dc.swf
//    swf/skins/maleskin10dc.swf
//
//  ACTOR BODY PNGs (DragonStar skeleton, loaded by createMovieStar):
//    swf/dragonstar/girl/texture.png
//    swf/dragonstar/boy/texture.png
//    swf/dragonstar/girl_skin/texture.png
//    swf/dragonstar/boy_skin/texture.png
//    swf/dragonstar/girl_skin_v10/texture.png
//    swf/dragonstar/boy_skin_v10/texture.png
//    swf/dragonstar/base/texture.png
//    swf/dragonstar/skeleton/texture.png
//
//  Add this to your Express server to serve all static assets:
//
//    app.use('/swf', express.static(path.join(__dirname, 'public/swf')));
//
//  Then put all the above files under public/swf/skins/, public/swf/dragonstar/ etc.