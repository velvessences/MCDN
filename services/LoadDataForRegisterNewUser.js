// services/LoadDataForRegisterNewUser.js
//
// All ClothesId, Name, Price, Vip, DiamondsPrice, and ColorScheme values are
// sourced from the live database (source.txt).
// SWF paths that were NOT found in source.txt are commented out with // MISSING.

// ── Pure AMF3 encoder ─────────────────────────────────────────────────────────

function encodeU29(n) {
    if (n < 0x80)     return Buffer.from([n]);
    if (n < 0x4000)   return Buffer.from([((n >> 7) & 0x7f) | 0x80, n & 0x7f]);
    if (n < 0x200000) return Buffer.from([((n >> 14) & 0x7f) | 0x80, ((n >> 7) & 0x7f) | 0x80, n & 0x7f]);
    return Buffer.from([((n >> 22) & 0x7f) | 0x80, ((n >> 15) & 0x7f) | 0x80, ((n >> 8) & 0x7f) | 0x80, n & 0xff]);
}

function rawStr(str) {
    const b = Buffer.from(str, 'utf8');
    return Buffer.concat([encodeU29((b.length << 1) | 1), b]);
}

function amf3Null()  { return Buffer.from([0x01]); }
function amf3True()  { return Buffer.from([0x03]); }
function amf3False() { return Buffer.from([0x02]); }

function amf3Int(n) {
    return Buffer.concat([Buffer.from([0x04]), encodeU29(n & 0x1FFFFFFF)]);
}

function amf3String(str) {
    if (str === null || str === undefined) return amf3Null();
    const b = Buffer.from(str, 'utf8');
    return Buffer.concat([Buffer.from([0x06]), encodeU29((b.length << 1) | 1), b]);
}

function amf3Bool(v) { return v ? amf3True() : amf3False(); }

function amf3TypedObject(alias, props) {
    const parts = [
        Buffer.from([0x0A]),
        encodeU29((props.length << 4) | 0x03),
        rawStr(alias),
    ];
    for (const [k] of props) parts.push(rawStr(k));
    for (const [, v] of props) parts.push(v);
    return Buffer.concat(parts);
}

function amf3Array(items) {
    const parts = [Buffer.from([0x09]), encodeU29((items.length << 1) | 1), Buffer.from([0x01])];
    for (const item of items) parts.push(item);
    return Buffer.concat(parts);
}

// ── Category → SlotType mapping (from ClothingCategories.as) ─────────────────
const SLOT_MAP = {
    1:1, 2:2, 3:3, 5:4, 6:2, 7:2,
    8:3, 9:3, 10:5, 11:5, 12:5,
    13:6, 14:6, 15:6, 19:8, 20:8
};

function encodeSlotType(slotTypeId) {
    return amf3TypedObject(
        'MovieStarPlanet.Model.Actor.ValueObjects.UiActorClothesSlotType',
        [
            ['SlotTypeId', amf3Int(slotTypeId)],
            ['Name',       amf3String(String(slotTypeId))],
        ]
    );
}

function encodeClothesCategory(categoryId) {
    const slotTypeId = SLOT_MAP[categoryId] || 1;
    return amf3TypedObject(
        'MovieStarPlanet.Model.Actor.ValueObjects.UiActorClothesCategory',
        [
            ['ClothesCategoryId', amf3Int(categoryId)],
            ['Name',              amf3String(String(categoryId))],
            ['SlotTypeId',        amf3Int(slotTypeId)],
            ['SlotType',          encodeSlotType(slotTypeId)],
        ]
    );
}

// ── Value object builders ─────────────────────────────────────────────────────

function facePartProps(o) {
    return [
        ['SWF',           amf3String(o.SWF)],
        ['Name',          amf3String(o.Name)],
        ['DragonBone',    amf3Bool(o.DragonBone)],
        ['SkinId',        amf3Int(o.SkinId)],
        ['RegNewUser',    amf3Int(o.RegNewUser)],
        ['DefaultColors', amf3String(o.DefaultColors || '0')],
        ['sortorder',     amf3Int(o.sortorder || 0)],
        ['hidden',        amf3Bool(o.hidden || false)],
        ['Price',         amf3Int(o.Price || 0)],
        ['Vip',           amf3Int(o.Vip || 0)],
        ['Discount',      amf3Int(o.Discount || 0)],
        ['isNew',         amf3Int(o.isNew || 0)],
        ['DiamondsPrice', amf3Int(o.DiamondsPrice || 0)],
    ];
}

function encodeEye(o) {
    return amf3TypedObject(
        'MovieStarPlanet.Model.Actor.ValueObjects.Eye',
        [['EyeId', amf3Int(o.EyeId)], ...facePartProps(o)]
    );
}

function encodeEyeShadow(o) {
    return amf3TypedObject(
        'MovieStarPlanet.Model.Actor.ValueObjects.EyeShadow',
        [['EyeShadowId', amf3Int(o.EyeShadowId)], ...facePartProps(o)]
    );
}

function encodeNose(o) {
    return amf3TypedObject(
        'MovieStarPlanet.Model.Actor.ValueObjects.Nose',
        [['NoseId', amf3Int(o.NoseId)], ...facePartProps(o)]
    );
}

function encodeMouth(o) {
    return amf3TypedObject(
        'MovieStarPlanet.Model.Actor.ValueObjects.Mouth',
        [['MouthId', amf3Int(o.MouthId)], ...facePartProps(o)]
    );
}

function encodeCloth(o) {
    return amf3TypedObject(
        'MovieStarPlanet.Model.Actor.ValueObjects.UiActorClothes',
        [
            ['ClothesId',         amf3Int(o.ClothesId)],
            ['Name',              amf3String(o.Name)],
            ['SWF',               amf3String(o.SWF)],
            ['ClothesCategoryId', amf3Int(o.ClothesCategoryId)],
            ['SkinId',            amf3Int(o.SkinId)],
            ['RegNewUser',        amf3Int(o.RegNewUser)],
            ['ColorScheme',       amf3String(o.ColorScheme || '0')],
            ['Price',             amf3Int(o.Price || 0)],
            ['Vip',               amf3Int(o.Vip || 0)],
            ['ShopId',            amf3Int(o.ShopId || 0)],
            ['Discount',          amf3Int(o.Discount || 0)],
            ['DiamondsPrice',     amf3Int(o.DiamondsPrice || 0)],
            ['sortorder',         amf3Int(o.sortorder || 0)],
            ['isNew',             amf3Int(o.isNew || 0)],
            ['ClothesCategory',   encodeClothesCategory(o.ClothesCategoryId)],
        ]
    );
}

function encodeRegisterNewUserData(d) {
    return amf3TypedObject(
        'RegisterNewUserData',
        [
            ['eyes',       amf3Array(d.eyes.map(encodeEye))],
            ['eyeShadows', amf3Array(d.eyeShadows.map(encodeEyeShadow))],
            ['noses',      amf3Array(d.noses.map(encodeNose))],
            ['mouths',     amf3Array(d.mouths.map(encodeMouth))],
            ['clothes',    amf3Array(d.clothes.map(encodeCloth))],
        ]
    );
}

// ── Data ─────────────────────────────────────────────────────────────────────
// Face parts (eyes, eyeShadows, noses, mouths) are not in source.txt — they use
// their own tables. SWF paths below are kept from the original implementation.

module.exports = {
    execute: function(req) {
        console.log("      => [LoadDataForRegisterNewUser] Building character creator data...");

        const data = {
            // ── EYES ──────────────────────────────────────────────────────────
            // Not in clothes source.txt; SWF paths kept from original.
            eyes: [
                { EyeId:1,  SWF:'eyes_girlnextdoor_2013',  Name:'eyes_girlnextdoor_2013',  DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeId:2,  SWF:'eyes_prettyperfect_2013',  Name:'eyes_prettyperfect_2013',  DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeId:3,  SWF:'eyes_glittergalore_2013',  Name:'eyes_glittergalore_2013',  DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeId:4,  SWF:'eyes_cateyes_2013',        Name:'eyes_cateyes_2013',        DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeId:5,  SWF:'eyes_partyperfect_2013',   Name:'eyes_partyperfect_2013',   DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeId:11, SWF:'eyes_boynextdoor_2013',    Name:'eyes_boynextdoor_2013',    DragonBone:true, SkinId:2, RegNewUser:2 },
                { EyeId:12, SWF:'eyes_theman_2013',         Name:'eyes_theman_2013',         DragonBone:true, SkinId:2, RegNewUser:2 },
                { EyeId:13, SWF:'eyes_themanblue_2013',     Name:'eyes_themanblue_2013',     DragonBone:true, SkinId:2, RegNewUser:2 },
                { EyeId:14, SWF:'eyes_honesthero_2013',     Name:'eyes_honesthero_2013',     DragonBone:true, SkinId:2, RegNewUser:2 },
                { EyeId:15, SWF:'eyes_shadysunday_2013',    Name:'eyes_shadysunday_2013',    DragonBone:true, SkinId:2, RegNewUser:2 },
            ],

            // ── EYE SHADOWS ──────────────────────────────────────────────────
            // Not in clothes source.txt; SWF paths kept from original.
            eyeShadows: [
                { EyeShadowId:1,  SWF:'eyeshadow_sweetstuff_2013',   Name:'eyeshadow_sweetstuff_2013',   DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeShadowId:2,  SWF:'eyeshadow_femalestar_2013',   Name:'eyeshadow_femalestar_2013',   DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeShadowId:3,  SWF:'eyeshadow_partyperfect_2013', Name:'eyeshadow_partyperfect_2013', DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeShadowId:4,  SWF:'eyeshadow_cateyes_2013',      Name:'eyeshadow_cateyes_2013',      DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeShadowId:11, SWF:'eyeshadow_party_2013',        Name:'eyeshadow_party_2013',        DragonBone:true, SkinId:2, RegNewUser:2 },
                { EyeShadowId:12, SWF:'eyeshadow_bling_2013',        Name:'eyeshadow_bling_2013',        DragonBone:true, SkinId:2, RegNewUser:2 },
            ],

            // ── NOSES ────────────────────────────────────────────────────────
            // Not in clothes source.txt; SWF paths kept from original.
            noses: [
                { NoseId:1,  SWF:'nose_8_freckles', Name:'nose_8_freckles.swf', DragonBone:false, SkinId:1, RegNewUser:1 },
                { NoseId:11, SWF:'nose_3',           Name:'nose_3.swf',          DragonBone:false, SkinId:2, RegNewUser:2 },
            ],

            // ── MOUTHS ───────────────────────────────────────────────────────
            // Not in clothes source.txt; SWF paths kept from original.
            mouths: [
                { MouthId:1,  SWF:'eternallove_2011_femalelips_nd', Name:'eternallove_2011_femalelips_nd.swf', DragonBone:false, SkinId:1, RegNewUser:1 },
                { MouthId:2,  SWF:'female_mouth_3',                 Name:'female_mouth_3.swf',                 DragonBone:false, SkinId:1, RegNewUser:1 },
                { MouthId:11, SWF:'male_mouth_2',                   Name:'male_mouth_2.swf',                   DragonBone:false, SkinId:2, RegNewUser:2 },
            ],

            // ── CLOTHES ──────────────────────────────────────────────────────
            // All IDs, Names, Price, Vip, DiamondsPrice, ColorScheme from source.txt.
            // Items marked // MISSING had no SWF entry in source.txt.
            clothes: [

                // ── HAIR (CategoryId=1 → SlotTypeId=1) ───────────────────────
                // Female hair (SkinId=1, RegNewUser=1)
                { ClothesId:1695,  SWF:'march_female_hair_1',                    Name:'Smooth Gaga',         ClothesCategoryId:1, SkinId:1, RegNewUser:1, Price:575,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xf5f3eb,Color' },
                { ClothesId:3828,  SWF:'love_2011_female_hair_3',                Name:'Brides Hair',         ClothesCategoryId:1, SkinId:1, RegNewUser:1, Price:450,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x996633,Color;colors=color2,0xCC9966,Highlights' },
                { ClothesId:3937,  SWF:'amusementpark_2011_female_hair_3',       Name:'The Big Bounce',      ClothesCategoryId:1, SkinId:1, RegNewUser:1, Price:400,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xB4875A,Color' },
                { ClothesId:4393,  SWF:'rockstarchristmas_2011_female_hair_1',   Name:'Soft Locks',          ClothesCategoryId:1, SkinId:1, RegNewUser:1, Price:500,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xC49261,Color' },
                { ClothesId:4473,  SWF:'newyears_2011_female_hair_1',            Name:'Party Pigtails',      ClothesCategoryId:1, SkinId:1, RegNewUser:1, Price:500,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xEEE7E0,Color' },
                { ClothesId:4474,  SWF:'newyears_2011_female_hair_2',            Name:'New Year Girl',       ClothesCategoryId:1, SkinId:1, RegNewUser:1, Price:550,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x101119,Color;colors=color2,0xFF0099,Streaks' },
                { ClothesId:4694,  SWF:'shuffleparty_2011_female_hair_1',        Name:'Topsy Tale',          ClothesCategoryId:1, SkinId:1, RegNewUser:1, Price:500,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xECE6DC,Color' },
                { ClothesId:4729,  SWF:'garden_2012_female_hair_1',              Name:'Silky Mane',          ClothesCategoryId:1, SkinId:1, RegNewUser:1, Price:500,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xECE3C6,Color' },
                { ClothesId:10371, SWF:'arabianProm_2015_diamond_dg',            Name:'Sweet Prom Dream',    ClothesCategoryId:1, SkinId:1, RegNewUser:1, Price:0,    Vip:0, DiamondsPrice:8, ColorScheme:'defaultcolor=defaultcolor,0xE9DAA7,Color;colors=color2,0xff9999,Highlights:color3,0xff99cc,Lowlights' },

                // Male hair (SkinId=2, RegNewUser=2)
                { ClothesId:2377,  SWF:'sept_male_hair_1',                       Name:'Punk Rock',           ClothesCategoryId:1, SkinId:2, RegNewUser:2, Price:450,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x333333,Color' },
                { ClothesId:3387,  SWF:'emo_2011_male_hair_1',                   Name:'Emo Boy',             ClothesCategoryId:1, SkinId:2, RegNewUser:2, Price:400,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x271D26,Color' },
                { ClothesId:4148,  SWF:'halloween_2011_vampireHair_mf_2',        Name:'Dracula',             ClothesCategoryId:1, SkinId:2, RegNewUser:2, Price:350,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x311A05,Color' },
                { ClothesId:4653,  SWF:'Valentines_2012_male_hair_nd_1',         Name:'Date Night',          ClothesCategoryId:1, SkinId:2, RegNewUser:2, Price:500,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x330000,Color' },
                { ClothesId:4819,  SWF:'mermaid_2012_maleHair_mf',              Name:'Sea Slick',           ClothesCategoryId:1, SkinId:2, RegNewUser:2, Price:400,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xCB8643,Color' },
                // { ClothesId:3970,  SWF:'HouseParty_2011_female_hair_1_nd',    Name:'Foxy Undercut',       ClothesCategoryId:1, SkinId:0, RegNewUser:2, Price:500,  Vip:2, ... }, // Vip=2, skipped for new user

                // ── TOPS (CategoryId=2 → SlotTypeId=2) ───────────────────────
                // Female tops (SkinId=1, RegNewUser=1)
                { ClothesId:2793,  SWF:'dec_female_top_15',                      Name:'White Kitten Tee',    ClothesCategoryId:2, SkinId:1, RegNewUser:1, Price:400,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x333333,Color;colors=color2,0xffffff,Design' },
                { ClothesId:3137,  SWF:'birthday_2011_female_tops_3',            Name:'Cupcake Shirt',       ClothesCategoryId:2, SkinId:1, RegNewUser:1, Price:400,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xFCFAFA,Color;colors=color2,0xcc0033,Berry:color3,0xff99cc,Icing' },
                { ClothesId:3820,  SWF:'love_2011_female_tops_2A',               Name:'Model Pose',          ClothesCategoryId:2, SkinId:1, RegNewUser:1, Price:300,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xFFFFFF,Color;colors=color2,0xFF0099,Figure' },
                { ClothesId:3876,  SWF:'streetDance_2011_femaleTop_mf_3_a',      Name:'Manga Girl',          ClothesCategoryId:2, SkinId:1, RegNewUser:1, Price:350,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xF8F5F5,Color;colors=color2,0xFF79E0,Face:color3,0xFF79E0,Outfit' },
                { ClothesId:8642,  SWF:'Aloha_2014_PineappleTee_FJ',             Name:'Feeling Juicy',       ClothesCategoryId:2, SkinId:1, RegNewUser:1, Price:300,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xFCEEDB,T-Shirt;colors=color2,0x3F702A,Pattern:color3,0xB89346,Text' },
                { ClothesId:5891,  SWF:'BigCityMagic_2012_GirlsShortFurCoat_ms',Name:'Fresh Fake',          ClothesCategoryId:2, SkinId:1, RegNewUser:1, Price:725,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x93A9BB,Jacket;colors=color2,0x93A9BB,Collar and Cuffs:color3,0xAF8569,Belt:color4,0xCCCCCC,Buckle' },

                // Male tops (SkinId=2, RegNewUser=2)
                { ClothesId:2346,  SWF:'sept_male_tops_1',                       Name:'Casual Gentleman',    ClothesCategoryId:2, SkinId:2, RegNewUser:2, Price:550,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xffffff,Color;colors=color2,0x333333,Jacket' },
                { ClothesId:2380,  SWF:'sept_male_tops_6',                       Name:'Cool Cat',            ClothesCategoryId:2, SkinId:2, RegNewUser:2, Price:500,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xffffff,Color;colors=color2,0x333333,Jacket' },
                { ClothesId:2841,  SWF:'jan_2011_male_tops_2',                   Name:'Winged Skull',        ClothesCategoryId:2, SkinId:2, RegNewUser:2, Price:400,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x333333,Color;colors=color2,0x66ff00,Wings' },
                { ClothesId:2904,  SWF:'jan_2011_male_tops_12',                  Name:'Robotic Love',        ClothesCategoryId:2, SkinId:2, RegNewUser:2, Price:350,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x990000,Color' },

                // ── BOTTOMS (CategoryId=3 → SlotTypeId=3) ────────────────────
                // Female bottoms (SkinId=1, RegNewUser=1)
                { ClothesId:3052,  SWF:'school_2011_female_bottoms_2',           Name:'Houndstooth Skirt',   ClothesCategoryId:3, SkinId:1, RegNewUser:1, Price:450,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xffffff,Color;colors=color2,0xff99cc,Belt and Trim' },
                { ClothesId:3511,  SWF:'street_2011_female_bottoms_1',           Name:'Fierce Cut-Offs',     ClothesCategoryId:3, SkinId:1, RegNewUser:1, Price:450,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x7C91A5,Color;colors=color2,0xCAD5D7,Ripped' },
                { ClothesId:4080,  SWF:'galaxyLove_2011_femaleBottoms_nd_1',     Name:'Lovely Galaxy',       ClothesCategoryId:3, SkinId:1, RegNewUser:1, Price:350,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xCC2C83,Color;colors=color2,0xD77F4B,Detail' },
                { ClothesId:4691,  SWF:'ShuffleParty_2012_female_bottoms_nd_1',  Name:'Party People',        ClothesCategoryId:3, SkinId:1, RegNewUser:1, Price:400,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xFEEE5C,Color;colors=color2,0x000000,Detail' },
                { ClothesId:4989,  SWF:'Mexico_2012_FemaleMariachiShorts_ms',    Name:'Mariachita Shorts',   ClothesCategoryId:3, SkinId:1, RegNewUser:1, Price:400,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x666666,Color;colors=color2,0xffffcc,Decoration' },

                // Male bottoms (SkinId=2, RegNewUser=2)
                { ClothesId:1710,  SWF:'march_male_bottoms_2',                   Name:'Skinny Jeans',        ClothesCategoryId:3, SkinId:2, RegNewUser:2, Price:500,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x195069,Color;colors=color2,0xcccccc,Button' },
                { ClothesId:3207,  SWF:'70s_2011_male_bottoms_3',                Name:'Tie Dye Jeans',       ClothesCategoryId:3, SkinId:2, RegNewUser:2, Price:450,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x6A8CBF,Color' },
                { ClothesId:3371,  SWF:'Emo_2011_male_bottoms1',                 Name:'Holez',               ClothesCategoryId:3, SkinId:2, RegNewUser:2, Price:500,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x3F3F3F,Color;colors=color2,0x1E1E1E,Shorts' },

                // ── FOOTWEAR (CategoryId=10 → SlotTypeId=5) ──────────────────
                // Unisex / female shoes (SkinId=0 or 1)
                { ClothesId:1329,  SWF:'Bjoerneshoes_1',                         Name:'Long Toenails',       ClothesCategoryId:10, SkinId:0, RegNewUser:1, Price:250,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x6D4C29,Color' },
                { ClothesId:1944,  SWF:'may_shoes_female_1',                     Name:'Laced Sneakers',      ClothesCategoryId:10, SkinId:0, RegNewUser:1, Price:450,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x9966cc,Color;colors=color2,0xcccc99,Laces:color3,0xffffff,Front' },
                { ClothesId:2135,  SWF:'july_shoes_female_1',                    Name:'Flip Flops',          ClothesCategoryId:10, SkinId:0, RegNewUser:1, Price:350,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0xff9900,Color;colors=color2,0xff3366,Detail' },
                { ClothesId:5068,  SWF:'jetSet_2012_sandals_female_nd',           Name:'High Fashion',        ClothesCategoryId:10, SkinId:1, RegNewUser:1, Price:350,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x999999,Color' },

                // Male shoes (SkinId=2)
                { ClothesId:1370,  SWF:'Fall_mens_shoes_1',                      Name:'Classic Shoes',       ClothesCategoryId:10, SkinId:2, RegNewUser:2, Price:350,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x333333,Color;colors=color2,0x666666,Detail' },
                { ClothesId:3396,  SWF:'50ties_2011_shoes_male_2',               Name:'Black Shoes',         ClothesCategoryId:10, SkinId:2, RegNewUser:2, Price:450,  Vip:0, DiamondsPrice:0, ColorScheme:'defaultcolor=defaultcolor,0x252525,Color;colors=color2,0x333333,Laces' },
            ],
        };

        const raw = encodeRegisterNewUserData(data);
        console.log(`      => AMF3 bytes (first 20): ${raw.subarray(0,20).toString('hex')}`);
        return { __rawAMF3__: raw };
    }
};