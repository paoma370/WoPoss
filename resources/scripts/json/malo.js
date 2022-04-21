map_data = {
  "normalForm": true,
  "headword": "MALO, -uī, -le",
  "etymology": [
    {
      "period": "PIE",
      "form": "*mǵ-i(V)s- + *u̯elh₁- [aor.], *u̯ei̯h₁-",
      "def": "'greater' + 'to strive after, pursue'",
      "certitude": true
    },
    {
      "period": "PIt",
      "form": "*magjōs-, -jo/es-, -is + *wel-mi, -si, -ti [pr.], *wel-e/o- [subj.], *wel-ī- [opt.]",
      "def": "",
      "certitude": true
    }
  ],
  "dataFormat": "cent",
  "meanings": [
    {
      "definition": "To prefer",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "lse",
          "category": "Modal: deontic",
          "emergence": -3,
          "disparition": "None",
          "attestation": "PLAUT. Mil. 171 hau multos homines... nunc videre... quam te mavellem. ",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [
              {
                "rel": "xdxonqr",
                "cert": true
              },
              {
                "rel": "agwg",
                "cert": true
              }
            ],
            "unspecified": []
          }
        }
      ]
    },
    {
      "definition": "To rather consider, think",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "xdxonqr",
          "category": "Not modal",
          "emergence": -1,
          "disparition": "None",
          "attestation": "CIC. Cael. 50 ea si tu non es – sicut ego malo – ...; sin eam te volunt esse eqs.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "lse",
                "cert": true
              }
            ],
            "destinations": [
              {
                "rel": "pfm",
                "cert": true
              }
            ],
            "unspecified": []
          }
        }
      ]
    },
    {
      "definition": "To want",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "agwg",
          "category": "Modal: deontic",
          "emergence": -1,
          "disparition": "None",
          "attestation": "GRAN. LIC. p. 26, 6 F. condiciones impositae, si rex pacem mallet.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "lse",
                "cert": true
              }
            ],
            "destinations": [
              {
                "rel": "pfm",
                "cert": true
              }
            ],
            "unspecified": []
          }
        }
      ]
    },
    {
      "definition": "To decide to do something ",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "pfm",
          "category": "Not modal",
          "emergence": 2,
          "disparition": "None",
          "attestation": "PAUL. coll. Mos. 4, 2, 1 interpretationem... facturus per ipsa capitula ire malui.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "xdxonqr",
                "cert": true
              },
              {
                "rel": "agwg",
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
