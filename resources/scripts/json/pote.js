map_data = {
    "normalForm": true,
    "headword": "POTĒ",
    "etymology": [{"period": "PIE", "form": "*pót-i-", "def": "", "certitude": true}, {
        "period": "PIt",
        "form": "*poti-, *pot-ē-",
        "def": "'master, in control of', 'to be master'",
        "certitude": true
    }],
    "dataFormat": "cent",
    "meanings": [{
        "definition": "To be able, to manage",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "xgbvbio",
            "category": "Modal: dynamic",
            "emergence": -2,
            "disparition": "None",
            "attestation": "ENN. ann. 402 nec pote quisquam... corpus discerpere ferro.",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [{"rel": "yjpyry", "cert": true}, {"rel": "wcazcm", "cert": true}],
                "unspecified": []
            }
        }]
    }, {
        "definition": "It is possible",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "wcazcm",
            "category": "Modal: dynamic",
            "emergence": -1,
            "disparition": "None",
            "attestation": "VARRO rust. 1, 15 (serunt… alii ulmos) ubi id pote, ut ibi, quod est campus, nulla potior serenda est (arbor). ",
            "certainty": true,
            "relationships": {
                "origins": [{"rel": "xgbvbio", "cert": true}],
                "destinations": [],
                "unspecified": [{"rel": "yjpyry", "cert": true}]
            }
        }]
    }, {
        "definition": "To be powerful, have strength, be strong",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "yjpyry",
            "category": "Not modal",
            "emergence": -1,
            "disparition": "None",
            "attestation": "VARRO Men. 289 qui pote plus, urget, piscis ut saepe minutos magnus comest.",
            "certainty": true,
            "relationships": {
                "origins": [{"rel": "xgbvbio", "cert": true}],
                "destinations": [],
                "unspecified": [{"rel": "wcazcm", "cert": true}]
            }
        }]
    }]
}
