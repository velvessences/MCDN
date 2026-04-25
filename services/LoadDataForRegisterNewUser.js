// services/LoadDataForRegisterNewUser.js

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
        ['Price',         amf3Int(0)],
        ['Vip',           amf3Int(0)],
        ['Discount',      amf3Int(0)],
        ['isNew',         amf3Int(0)],
        ['DiamondsPrice', amf3Int(0)],
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
            ['Price',             amf3Int(0)],
            ['Vip',               amf3Int(0)],
            ['ShopId',            amf3Int(0)],
            ['Discount',          amf3Int(0)],
            ['DiamondsPrice',     amf3Int(0)],
            ['sortorder',         amf3Int(o.sortorder || 0)],
            ['isNew',             amf3Int(0)],
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

module.exports = {
    execute: function(req) {
        console.log("      => [LoadDataForRegisterNewUser] Building character creator data (manual AMF3)...");

        const data = {
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
            eyeShadows: [
                { EyeShadowId:1,  SWF:'eyeshadow_sweetstuff_2013',   Name:'eyeshadow_sweetstuff_2013',   DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeShadowId:2,  SWF:'eyeshadow_femalestar_2013',   Name:'eyeshadow_femalestar_2013',   DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeShadowId:3,  SWF:'eyeshadow_partyperfect_2013', Name:'eyeshadow_partyperfect_2013', DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeShadowId:4,  SWF:'eyeshadow_cateyes_2013',      Name:'eyeshadow_cateyes_2013',      DragonBone:true, SkinId:1, RegNewUser:1 },
                { EyeShadowId:11, SWF:'eyeshadow_party_2013',        Name:'eyeshadow_party_2013',        DragonBone:true, SkinId:2, RegNewUser:2 },
                { EyeShadowId:12, SWF:'eyeshadow_bling_2013',        Name:'eyeshadow_bling_2013',        DragonBone:true, SkinId:2, RegNewUser:2 },
            ],
            noses: [
                { NoseId:1,  SWF:'nose_8_freckles', Name:'nose_8_freckles.swf', DragonBone:false, SkinId:1, RegNewUser:1 },
                { NoseId:11, SWF:'nose_3',           Name:'nose_3.swf',          DragonBone:false, SkinId:2, RegNewUser:2 },
            ],
            mouths: [
                { MouthId:1,  SWF:'eternallove_2011_femalelips_nd', Name:'eternallove_2011_femalelips_nd.swf', DragonBone:false, SkinId:1, RegNewUser:1 },
                { MouthId:2,  SWF:'female_mouth_3',                 Name:'female_mouth_3.swf',                 DragonBone:false, SkinId:1, RegNewUser:1 },
                { MouthId:11, SWF:'male_mouth_2',                   Name:'male_mouth_2.swf',                   DragonBone:false, SkinId:2, RegNewUser:2 },
            ],
            clothes: [
                // HAIR — category 1 → slot 1
                { ClothesId:101, SWF:'miami_2011_female_hair_3',          Name:'miami_2011_female_hair_3.swf',          ClothesCategoryId:1, SkinId:1, RegNewUser:1 },
                { ClothesId:102, SWF:'HouseParty_2011_female_hair_1_nd',  Name:'HouseParty_2011_female_hair_1_nd.swf',  ClothesCategoryId:1, SkinId:1, RegNewUser:1 },
                { ClothesId:103, SWF:'valentines_2011_female_hair_2',     Name:'valentines_2011_female_hair_2.swf',     ClothesCategoryId:1, SkinId:1, RegNewUser:1 },
                { ClothesId:104, SWF:'streetdance_2011_female_hair_2',     Name:'streetdance_2011_female_hair_2.swf',     ClothesCategoryId:1, SkinId:1, RegNewUser:1 },
                { ClothesId:105, SWF:'july_female_hair_9',                  Name:'july_female_hair_9.swf',     ClothesCategoryId:1, SkinId:1, RegNewUser:1 },
                { ClothesId:106, SWF:'december_female_hair_1',             Name:'december_female_hair_1.swf',     ClothesCategoryId:1, SkinId:1, RegNewUser:1 },
                { ClothesId:107, SWF:'june_female_hair_19',                 Name:'june_female_hair_19.swf',     ClothesCategoryId:1, SkinId:1, RegNewUser:1 },
                { ClothesId:108, SWF:'VIP_female_hair_5',                Name:'VIP_female_hair_5.swf',     ClothesCategoryId:1, SkinId:1, RegNewUser:1 },
                { ClothesId:109, SWF:'bling_2011_female_hair_2',       Name:'bling_2011_female_hair_2.swf',     ClothesCategoryId:1, SkinId:1, RegNewUser:1 },
            //
                { ClothesId:111, SWF:'Hair_clovn_Taunus',                 Name:'Hair_clovn_Taunus.swf',                 ClothesCategoryId:1, SkinId:2, RegNewUser:2 },
                { ClothesId:112, SWF:'emo_2011_male_hair_3',              Name:'emo_2011_male_hair_3.swf',              ClothesCategoryId:1, SkinId:2, RegNewUser:2 },
                { ClothesId:113, SWF:'2009_hair_boys_Honey_5',            Name:'2009_hair_boys_Honey_5.swf',            ClothesCategoryId:1, SkinId:2, RegNewUser:2 },
               
               
                // TOPS — category 2 → slot 2
                { ClothesId:201, SWF:'arabianProm_2015_diamond_dg',          Name:'arabianProm_2015_diamond_dg.swf',          ClothesCategoryId:2, SkinId:1, RegNewUser:1 },
                { ClothesId:202, SWF:'Aloha_2014_PineappleTee_FJ',          Name:'Aloha_2014_PineappleTee_FJ.swf',          ClothesCategoryId:2, SkinId:1, RegNewUser:1 },
                { ClothesId:203, SWF:'amusementpark_2011_female_top_7',      Name:'amusementpark_2011_female_top_7.swf',      ClothesCategoryId:2, SkinId:1, RegNewUser:1 },
                { ClothesId:204, SWF:'amusementpark_2011_female_top_9',      Name:'amusementpark_2011_female_top_9.swf',      ClothesCategoryId:2, SkinId:1, RegNewUser:1 },
                { ClothesId:205, SWF:'BigCityMagic_2012_GirlsShortFurCoat_ms',      Name:'BigCityMagic_2012_GirlsShortFurCoat_ms.swf',      ClothesCategoryId:2, SkinId:1, RegNewUser:1 },
                { ClothesId:206, SWF:'emo_2011_female_tops_2',      Name:'emo_2011_female_tops_2.swf',      ClothesCategoryId:2, SkinId:1, RegNewUser:1 },
             //
                { ClothesId:211, SWF:'rockstarchristmas_2011_female_tops_1', Name:'rockstarchristmas_2011_female_tops_1.swf', ClothesCategoryId:2, SkinId:2, RegNewUser:2 },
                
                
                // BOTTOMS — category 3 → slot 3
                { ClothesId:301, SWF:'Mexico_2012_FemaleMariachiShorts_ms', Name:'Mexico_2012_FemaleMariachiShorts_ms.swf', ClothesCategoryId:3, SkinId:1, RegNewUser:1 },
                { ClothesId:302, SWF:'grinch_2011_female_bottoms_4',        Name:'grinch_2011_female_bottoms_4.swf',        ClothesCategoryId:3, SkinId:1, RegNewUser:1 },
                { ClothesId:303, SWF:'june_female_bottoms_3',               Name:'june_female_bottoms_3.swf',               ClothesCategoryId:3, SkinId:1, RegNewUser:1 },
             //
                { ClothesId:311, SWF:'Christmas_2011_male_bottoms_nd_1',    Name:'Christmas_2011_male_bottoms_nd_1.swf',    ClothesCategoryId:3, SkinId:2, RegNewUser:2 },
                { ClothesId:312, SWF:'elvistrousers',                       Name:'elvistrousers.swf',                       ClothesCategoryId:3, SkinId:2, RegNewUser:2 },
                { ClothesId:313, SWF:'Honey_bottoms_10_boys',               Name:'Honey_bottoms_10_boys.swf',               ClothesCategoryId:3, SkinId:2, RegNewUser:2 },
               
               
                // FOOTWEAR — category 10 → slot 5
                { ClothesId:501, SWF:'may_shoes_female_1', Name:'may_shoes_female_1.swf', ClothesCategoryId:10, SkinId:1, RegNewUser:1 },
            //
                { ClothesId:511, SWF:'may_shoes_female_1', Name:'may_shoes_female_1.swf', ClothesCategoryId:10, SkinId:2, RegNewUser:2 },
            ],
        };

        const raw = encodeRegisterNewUserData(data);
        console.log(`      => AMF3 bytes (first 20): ${raw.subarray(0,20).toString('hex')}`);
        return { __rawAMF3__: raw };
    }
};