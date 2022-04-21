map_data = {
    "normalForm": true,
    "headword": "INĪQUĒ",
    "etymology": [{"period": "PIE", "form": "*n- + *aikʷos", "def": "", "certitude": false}, {
        "period": "Lat",
        "form": "in + aequus",
        "def": "'not equal'",
        "certitude": true
    }],
    "dataFormat": "cent",
    "meanings": [{
        "definition": "Without equanimity",
        "construct": "_",
        "group": "In an equal way",
        "analysis": [{
            "id": "pvmbaaq",
            "category": "Not modal",
            "emergence": 1,
            "disparition": "None",
            "attestation": "SVET. Iul. 45, 2 ut calvitii… deformitatem iniquissime ferret (Caesar).",
            "certainty": true,
            "relationships": {"origins": [{"rel": "rojkn", "cert": true}], "destinations": [], "unspecified": []}
        }]
    }, {
        "definition": "Unfairly, wrongfully",
        "construct": "_",
        "group": "IN AN UNEQUAL WAY",
        "analysis": [{
            "id": "rojkn",
            "category": "Not modal",
            "emergence": -2,
            "disparition": "None",
            "attestation": "PLAUT. Cas. 617 quid ego umquam erga Venerem inique fecerim...? ",
            "certainty": true,
            "relationships": {
                "origins": [{"rel": "unpuil", "cert": true}],
                "destinations": [{"rel": "pvmbaaq", "cert": true}, {"rel": "braewu", "cert": true}],
                "unspecified": []
            }
        }]
    }, {
        "definition": "Unlawfully, not legitimately",
        "construct": "_",
        "group": "In an equal way",
        "analysis": [{
            "id": "braewu",
            "category": "Not modal",
            "emergence": 5,
            "disparition": "None",
            "attestation": "AUG. bon. coniug. 14, 16 agris inique ac perperam invasis. (right context: iniusta potestate, opposed to iuste quaesito agro, possessor legitimus).",
            "certainty": true,
            "relationships": {"origins": [{"rel": "rojkn", "cert": true}], "destinations": [], "unspecified": []}
        }]
    }, {
        "definition": "In the wrong way",
        "construct": "_",
        "group": "In an equal way",
        "analysis": [{
            "id": "unpuil",
            "category": "Not modal",
            "emergence": -3,
            "disparition": "None",
            "attestation": "PLAUT. Rud. 1097 haud iniquom dicit (i. imperat )..., ut ostendatur vidulus. ∷ immo hercle insignite inique.",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [{"rel": "rojkn", "cert": true}, {"rel": "adyawj", "cert": true}, {
                    "rel": "jdpsmu",
                    "cert": true
                }],
                "unspecified": []
            }
        }]
    }, {
        "definition": "Recklessly, imprudently",
        "construct": "_",
        "group": "In an equal way",
        "analysis": [{
            "id": "adyawj",
            "category": "Not modal",
            "emergence": 1,
            "disparition": "None",
            "attestation": "HOMER. 329 (Helena ad Paridem) moneo, ne rursus inique illius (i. e. Atridae) tua fata velis committere dextrae.",
            "certainty": true,
            "relationships": {"origins": [{"rel": "unpuil", "cert": true}], "destinations": [], "unspecified": []}
        }]
    }, {
        "definition": "Ill, badly",
        "construct": "_",
        "group": "In an equal way",
        "analysis": [{
            "id": "jdpsmu",
            "category": "Not modal",
            "emergence": 2,
            "disparition": "None",
            "attestation": "PORPH. Hor. Carm. 3, 5, 41/43 bene... additum ‘pudicae coniugis’, ne putares illum ideo osculum coniugis aversatum, quod de pudicitia eius iniquius sensisset.",
            "certainty": true,
            "relationships": {"origins": [{"rel": "unpuil", "cert": true}], "destinations": [], "unspecified": []}
        }]
    }]
}
