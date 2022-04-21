map_data = {
    "normalForm": true,
    "headword": "APTUS, -a, -um",
    "etymology": [{
        "period": "PIE",
        "form": "*h₁p-i- [pr.], *h₁e-h₁(o)p- [pf.]",
        "def": "'to get, grab'",
        "certitude": true
    }, {"period": "PIt", "form": "*ap-(e)i-", "def": "'to get, seize'", "certitude": true}],
    "dataFormat": "cent",
    "meanings": [{
        "definition": "Suitably, properly joined",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "liujppi",
            "category": "Not modal",
            "emergence": -2,
            "disparition": "None",
            "attestation": "ENN. Ann. 373 vinclis venatica velox apta.",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [{"rel": "vuwvywq", "cert": true}, {"rel": "inllzs", "cert": true}],
                "unspecified": [{"rel": "lvk", "cert": true}]
            }
        }]
    }, {
        "definition": "Connected",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "vuwvywq",
            "category": "Not modal",
            "emergence": -1,
            "disparition": "None",
            "attestation": "CIC. inv. 2, 110 aptas inter se omnes causas et aliam in alia implicatam videbit. ",
            "certainty": true,
            "relationships": {
                "origins": [{"rel": "liujppi", "cert": true}],
                "destinations": [],
                "unspecified": [{"rel": "cclkf", "cert": true}]
            }
        }]
    }, {
        "definition": "Closely associated, dependent",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "cclkf",
            "category": "Not modal",
            "emergence": -1,
            "disparition": "None",
            "attestation": "CIC. Tusc. 5, 36 cui viro … ex se ipso apta sunt omnia.",
            "certainty": true,
            "relationships": {"origins": [], "destinations": [], "unspecified": [{"rel": "vuwvywq", "cert": true}]}
        }]
    }, {
        "definition": "Fit for, adapted to, equipped",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "lvk",
            "category": "Not modal",
            "emergence": -2,
            "disparition": "None",
            "attestation": "ENN. Trag. 380 o Fides alma apta pinnis …! ",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [{"rel": "pvvfvkjg", "cert": true}],
                "unspecified": [{"rel": "liujppi", "cert": true}]
            }
        }]
    }, {
        "definition": "Joined together, properly arranged",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "inllzs",
            "category": "Not modal",
            "emergence": -1,
            "disparition": "None",
            "attestation": "CIC. nat. deor. 2, 115 quod … mundus … ita cohaeret ad permanendum, ut nihil ne excogitari quidem possit aptius.",
            "certainty": true,
            "relationships": {
                "origins": [{"rel": "liujppi", "cert": true}],
                "destinations": [],
                "unspecified": [{"rel": "pvvfvkjg", "cert": true}]
            }
        }]
    }, {
        "definition": "Suitable, fitted for something",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "pvvfvkjg",
            "category": "Not modal",
            "emergence": -1,
            "disparition": "None",
            "attestation": "VARRO Men. 569 aptam mollis umeris fibulam.",
            "certainty": true,
            "relationships": {
                "origins": [{"rel": "lvk", "cert": true}],
                "destinations": [{"rel": "fftxhr", "cert": true}],
                "unspecified": [{"rel": "inllzs", "cert": true}, {"rel": "hhpng", "cert": true}]
            }
        }]
    }, {
        "definition": "Apt, appropriate, conforming to",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "hhpng",
            "category": "Not modal",
            "emergence": -1,
            "disparition": "None",
            "attestation": "VARRO rust. 1, 6, 2 infimis alia cultura aptior quam summis.",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [],
                "unspecified": [{"rel": "pvvfvkjg", "cert": true}, {"rel": "hxywf", "cert": true}]
            }
        }, {
            "id": "hxywf",
            "category": "Modal: deontic acceptability",
            "emergence": -1,
            "disparition": "None",
            "attestation": "CIC. fin. 3, 57 quam … appellant εὐδοξίαν, aptius est bonam famam … appellare.",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [],
                "unspecified": [{"rel": "hhpng", "cert": true}, {"rel": "fftxhr", "cert": true}]
            }
        }]
    }, {
        "definition": "Able to",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "fftxhr",
            "category": "Modal: dynamic possibility",
            "emergence": -1,
            "disparition": "None",
            "attestation": "CIC. de orat. 1, 99 te … ad dicendum maxume natum aptumque.",
            "certainty": true,
            "relationships": {
                "origins": [{"rel": "pvvfvkjg", "cert": true}],
                "destinations": [],
                "unspecified": [{"rel": "hxywf", "cert": true}]
            }
        }]
    }]
}
