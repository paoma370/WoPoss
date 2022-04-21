map_data = {
  "normalForm": true,
  "headword": "DĒBEO, -uī, -itum, -ēre",
  "etymology": [
    {
      "period": "PIE",
      "form": "de + *gʰh₁b⁽ʰ⁾-(e)i-, aor. *gʰh₁b⁽ʰ⁾-(e)h₁-",
      "def": "'to take'",
      "certitude": true
    },
    {
      "period": "PIt",
      "form": "de + *χab/f-ē-",
      "def": "'has taken > has, holds'",
      "certitude": true
    }
  ],
  "dataFormat": "cent",
  "meanings": [
    {
      "definition": "To owe something to someone else",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "ikyhwan",
          "category": "Premodal",
          "emergence": -3,
          "disparition": "None",
          "attestation": "PLAUT. Mil. 421 quid tibi istic in istisce aedibus debetur, quid negotist?",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [
              {
                "rel": "jbsmy",
                "cert": true
              },
              {
                "rel": "xpmotr",
                "cert": true
              },
              {
                "rel": "qcgcl",
                "cert": true
              }
            ],
            "unspecified": []
          }
        }
      ]
    },
    {
      "definition": "To be obliged to give or furnish something",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "xpmotr",
          "category": "Not modal",
          "emergence": -1,
          "disparition": "None",
          "attestation": "CIC. inv. 2, 97 hostiae, quas debuisti ad sacrificium, praesto non fuerunt.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "ikyhwan",
                "cert": true
              }
            ],
            "destinations": [],
            "unspecified": []
          }
        }
      ]
    },
    {
      "definition": "To be obliged by necessity",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "jbsmy",
          "category": "Modal: dynamic",
          "emergence": -2,
          "disparition": "None",
          "attestation": "CATO agr. 119 cap. CXIX Ut odorem malum eximas de uino quid facere debeas.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "ikyhwan",
                "cert": true
              }
            ],
            "destinations": [
              {
                "rel": "mkny",
                "cert": true
              },
              {
                "rel": "bpdueo",
                "cert": true
              }
            ],
            "unspecified": [
              {
                "rel": "kd",
                "cert": true
              }
            ]
          }
        },
        {
          "id": "bpdueo",
          "category": "Modal: deontic acceptability",
          "emergence": -1,
          "disparition": "None",
          "attestation": "VARRO ling. 10, 1 non fundamenta, ut debuit, posita ab ullo.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "jbsmy",
                "cert": true
              }
            ],
            "destinations": [],
            "unspecified": [
              {
                "rel": "ipnyzrb",
                "cert": true
              },
              {
                "rel": "lxtmws",
                "cert": true
              }
            ]
          }
        },
        {
          "id": "ipnyzrb",
          "category": "Modal: deontic authority",
          "emergence": -1,
          "disparition": "None",
          "attestation": "LEX Falcid. dig. 35, 2, 1 heres, qui eam pecuniam dare iussus damnatus erit, eam pecuniam debeto dare, quam damnatus est.",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [],
            "unspecified": [
              {
                "rel": "bpdueo",
                "cert": true
              },
              {
                "rel": "lxtmws",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "To be obligated to someone",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "qcgcl",
          "category": "Not modal",
          "emergence": -1,
          "disparition": "None",
          "attestation": "CIC. Att. 1, 1, 1 illi ita negant..., ut mihi se debere dicant.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "ikyhwan",
                "cert": true
              }
            ],
            "destinations": [],
            "unspecified": []
          }
        }
      ]
    },
    {
      "definition": "To be obliged by laws or customs",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "kd",
          "category": "Modal: deontic acceptability",
          "emergence": -2,
          "disparition": "None",
          "attestation": "PLAUT. Amph. 39 debetis velle quae velimus: meruimus et ego et pater de vobis et re publica.",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [],
            "unspecified": [
              {
                "rel": "jbsmy",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "~(not) to be allowed",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "lxtmws",
          "category": "Modal: deontic acceptability",
          "emergence": -1,
          "disparition": "None",
          "attestation": "RHET. HER. 2, 3, 5 vituperatio eorum quae extra id crimen sunt non debeat assignari.",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [],
            "unspecified": [
              {
                "rel": "bpdueo",
                "cert": true
              },
              {
                "rel": "ipnyzrb",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "Ought, should (for logical or similar reasons)",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "mkny",
          "category": "Modal: epistemic",
          "emergence": -1,
          "disparition": "None",
          "attestation": "CIC. Verr. 4, 65 erat candelabrum eo splendore qui ex... pulcherrimis gemmis esse debebat.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "jbsmy",
                "cert": true
              }
            ],
            "destinations": [],
            "unspecified": []
          }
        }
      ]
    }
  ]
}
