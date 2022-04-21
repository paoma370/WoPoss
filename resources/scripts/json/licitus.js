map_data = {
    "normalForm": true,
    "headword": "LICITUS, -a, -um",
    "etymology": [{"period": "PIt", "form": "*lik-ē-", "def": "'to be available, have the value of'", "certitude": true}],
    "dataFormat": "cent",
    "meanings": [{
        "definition": "Allowed, lawful",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "nukbce",
            "category": "Not modal",
            "emergence": -1,
            "disparition": "None",
            "attestation": "VERG. Aen. 8, 468 licito tandem sermone fruuntur.",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [{"rel": "bidsbwr", "cert": true}],
                "unspecified": [{"rel": "bkuiw", "cert": true}]
            }
        }]
    }, {
        "definition": "It is allowed",
        "construct": "Licitum est",
        "group": "_",
        "analysis": [{
            "id": "bidsbwr",
            "category": "Modal: deontic",
            "emergence": 5,
            "disparition": "None",
            "attestation": "COD. IUST. 1, 57, 1 Iubemus apud Alexandrinae dumtaxat clarissimae civitatis iuridicum licitum et concessum esse singulis quibusque volentibus donationis conscriptae sollemniter instrumenta reserare.",
            "certainty": true,
            "relationships": {"origins": [{"rel": "nukbce", "cert": true}], "destinations": [], "unspecified": []}
        }]
    }, {
        "definition": "What is allowed",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "bkuiw",
            "category": "Not modal",
            "emergence": -1,
            "disparition": "None",
            "attestation": "MANIL. 4, 211 licitum sciet et vetitum quae poena sequatur.",
            "certainty": true,
            "relationships": {"origins": [], "destinations": [], "unspecified": [{"rel": "nukbce", "cert": true}]}
        }]
    }]
}
