map_data = {
    "normalForm": true,
    "headword": "NECESSITŪDO, -inis ",
    "etymology": [{
        "period": "PIE",
        "form": "*ḱi̯esdh-",
        "def": "'to drive away; (intr.) go away'",
        "certitude": true
    }, {"period": "PIt", "form": "*kesd-e/o-", "def": "'to go away, avoid'", "certitude": true}],
    "dataFormat": "cent",
    "meanings": [{
        "definition": "Necessity",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "pmivl",
            "category": "Not modal",
            "emergence": -2,
            "disparition": "None",
            "attestation": "ASELL. hist. 5 L. Aemilium Paulum... signis conlatis <non> decertare, nisi summa necessitudo aut summa ei occasio data esset.",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [{"rel": "donbpbb", "cert": true}],
                "unspecified": [{"rel": "vobyud", "cert": true}]
            }
        }, {
            "id": "donbpbb",
            "category": "Modal: dynamic",
            "emergence": -1,
            "disparition": "None",
            "attestation": "SALL. Catil. 33, 5 Te atque senatum obtestamur: consulatis miseris civibus, legis praesidium, quod iniquitas praetoris eripuit, restituatis neve nobis eam necessitudinem inponatis, ut quaeramus, quonam modo maxume ulti sanguinem nostrum pereamus.",
            "certainty": true,
            "relationships": {
                "origins": [{"rel": "pmivl", "cert": true}],
                "destinations": [{"rel": "vmupswpd", "cert": true}],
                "unspecified": []
            }
        }, {
            "id": "vmupswpd",
            "category": "Modal: deontic acceptability",
            "emergence": 6,
            "disparition": "None",
            "attestation": "BOETH. cons. 3, 6, 9 quodsi quid est in nobilitate bonum, id esse arbitror solum, ut imposita nobilibus necessitudo videatur, ne a maiorum virtute degeneret. ",
            "certainty": true,
            "relationships": {"origins": [{"rel": "donbpbb", "cert": true}], "destinations": [], "unspecified": []}
        }]
    }, {
        "definition": "Bond between closely connected people (by family, friendship, obligation)",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "vobyud",
            "category": "Not modal",
            "emergence": -2,
            "disparition": "None",
            "attestation": "LEX repetund. (CIL I2 583) 24 <quei ... se earum qua> necessitudine atingat, quae supra scripta sient. ",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [{"rel": "wpquim", "cert": true}, {"rel": "qmx", "cert": true}],
                "unspecified": [{"rel": "pmivl", "cert": true}]
            }
        }]
    }, {
        "definition": "Association of similar things",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "wpquim",
            "category": "Not modal",
            "emergence": -1,
            "disparition": "None",
            "attestation": "CIC. orat. 186 numerus (i.e. metrum) ... nullam habebat ... necessitudinem aut cognationem cum oratione. ",
            "certainty": true,
            "relationships": {"origins": [{"rel": "vobyud", "cert": true}], "destinations": [], "unspecified": []}
        }]
    }, {
        "definition": "Participants in a close relationship (kinship, friendship, obligation)",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "qmx",
            "category": "Not modal",
            "emergence": -1,
            "disparition": "None",
            "attestation": "VAL. MAX. 2, 1, 7 huius modi inter coniuges verecundia: quid? inter ceteras necessitudines nonne apparet consentanea? (after: pater cum filio..., socer cum genero)",
            "certainty": true,
            "relationships": {"origins": [{"rel": "vobyud", "cert": true}], "destinations": [], "unspecified": []}
        }]
    }]
}
