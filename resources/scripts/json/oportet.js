map_data = {
    "normalForm": true,
    "headword": "OPORTET, -uit, -ēre",
    "etymology": [{"period": "PIE", "form": "*u̯e-u̯(o)rt-", "def": "'to turn'", "certitude": true}, {
        "period": "PIt",
        "form": "*op-wort-(ē-)",
        "def": "",
        "certitude": true
    }],
    "dataFormat": "cent",
    "meanings": [{
        "definition": "It is necessary",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "mfxcwu",
            "category": "Modal: deontic authority",
            "emergence": -2,
            "disparition": "None",
            "attestation": "LEX BANT. (CIL I 583) 8 quaeve ex h(ace) l(ege) facere oportuerit.",
            "certainty": true,
            "relationships": {"origins": [{"rel": "pvqz", "cert": true}], "destinations": [], "unspecified": []}
        }]
    }, {
        "definition": "It is necessary",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "pvqz",
            "category": "Modal: deontic acceptability",
            "emergence": -3,
            "disparition": "None",
            "attestation": "PLAUT. Merc. 724 quin dicis? :: quin, si liceat… :: dictum oportuit.",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [{"rel": "mfxcwu", "cert": true}],
                "unspecified": [{"rel": "xvqwvjr", "cert": true}]
            }
        }]
    }, {
        "definition": "It is necessary",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "xvqwvjr",
            "category": "Modal: epistemic",
            "emergence": -3,
            "disparition": "None",
            "attestation": "PLAUT. Asin. 381 ut demonstratae sunt mihi, hasce aedis esse oportet, Demaenetus ubi dicitur habitare.",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [{"rel": "jobvodx", "cert": true}],
                "unspecified": [{"rel": "pvqz", "cert": true}]
            }
        }]
    }, {
        "definition": "It is necessary",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "jobvodx",
            "category": "Modal: dynamic",
            "emergence": -2,
            "disparition": "None",
            "attestation": "PLAUT. Aul. 180 Nam neque quisquam curialium venit neque magister quem dividere argentum oportuit.",
            "certainty": true,
            "relationships": {
                "origins": [{"rel": "xvqwvjr", "cert": true}],
                "destinations": [],
                "unspecified": [{"rel": "rjzizg", "cert": true}]
            }
        }]
    }, {
        "definition": "To have to",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "rjzizg",
            "category": "Modal: dynamic",
            "emergence": -2,
            "disparition": "None",
            "attestation": "TER. Andr. 481 adhuc, Archylis, quae adsolent quaeque oportent signa esse ad salutem, omnia huic esse video.",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [{"rel": "cugunm", "cert": true}],
                "unspecified": [{"rel": "jobvodx", "cert": true}]
            }
        }]
    }, {
        "definition": "To have to",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "cugunm",
            "category": "Modal: deontic acceptability",
            "emergence": -1,
            "disparition": "None",
            "attestation": "VITR. 4, 6, 1 reliqua ... videntur oportere conlocari. ",
            "certainty": true,
            "relationships": {
                "origins": [{"rel": "rjzizg", "cert": true}],
                "destinations": [],
                "unspecified": [{"rel": "bgtph", "cert": true}]
            }
        }]
    }, {
        "definition": "To have to",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "bgtph",
            "category": "Modal: deontic authority",
            "emergence": -1,
            "disparition": "None",
            "attestation": "LEX URSON. (CIL I 594)1 125, 18 quibusque locos in decurionum loco | ex d(ecreto) d(ecurionum) col(oniae) Gen(etivae) d(ari) o(portebit),",
            "certainty": true,
            "relationships": {"origins": [], "destinations": [], "unspecified": [{"rel": "cugunm", "cert": true}]}
        }]
    }]
}
