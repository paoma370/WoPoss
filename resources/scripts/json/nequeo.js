map_data = {
    "normalForm": true,
    "headword": "NEQUEO, -īvī/-iī, -itum, -īre",
    "etymology": [{
        "period": "PIE",
        "form": "*ne- + *h₁ei- / *h₁i-",
        "def": "'not, un-' + 'to go'",
        "certitude": true
    }, {
        "period": "PIt",
        "form": "*ne-kʷe- + *ei- / *i-, *ito-, *eitu- / *itu-",
        "def": "'not, un-' + ‘to go’, 'gone', 'the going'",
        "certitude": true
    }],
    "dataFormat": "cent",
    "meanings": [{
        "definition": "To be unable (to)",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "buviujw",
            "category": "Modal: dynamic",
            "emergence": -3,
            "disparition": "None",
            "attestation": "PLAUT. Merc. 636 ubi habitaret invenires saltem, si nomen nequis.",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [{"rel": "qwud", "cert": true}],
                "unspecified": [{"rel": "hcxiiq", "cert": true}]
            }
        }]
    }, {
        "definition": "Not to be possible",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "hcxiiq",
            "category": "Modal: dynamic",
            "emergence": -3,
            "disparition": "None",
            "attestation": "PLAUT. Rud. 1064 alienon prius quam tuo dabis orationem? ut nequitur comprimi!",
            "certainty": true,
            "relationships": {
                "origins": [],
                "destinations": [],
                "unspecified": [{"rel": "buviujw", "cert": true}, {"rel": "qwud", "cert": true}]
            }
        }]
    }, {
        "definition": "To be unable to prevent oneself (from doing something)",
        "construct": "_",
        "group": "_",
        "analysis": [{
            "id": "qwud",
            "category": "Modal: dynamic",
            "emergence": -3,
            "disparition": "None",
            "attestation": "PLAUT. Mil. 1343 nequeo, quin fleam. ",
            "certainty": true,
            "relationships": {
                "origins": [{"rel": "buviujw", "cert": true}],
                "destinations": [],
                "unspecified": [{"rel": "hcxiiq", "cert": true}]
            }
        }]
    }]
}
