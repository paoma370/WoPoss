map_data = {
  "normalForm": true,
  "headword": "PROBĀBILIS, -e",
  "etymology": [
    {
      "period": "PIE",
      "form": "*pro-*bʰ(h₂)u-o-",
      "def": "",
      "certitude": true
    },
    {"period":"PIt","form":"* pro-f(w)-o-","def":"'favourable'","certitude":true}
    ],
  "dataFormat": "cent",
  "meanings": [
    {
      "definition": "Worth of approval",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "yjqigo",
          "category": "Modal: deontic",
          "emergence": -1,
          "disparition": "None",
          "attestation": "CAECIN. Cic. fam. 6, 7, 3 tot malis… fractum studium scribendi quid dignum auribus aut probabile potest adferre?",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [
              {
                "rel": "pihaqdhiq",
                "cert": true
              },
              {
                "rel": "aefeqsn",
                "cert": true
              }
            ],
            "unspecified": []
          }
        }
      ]
    },
    {
      "definition": "Tolerable, that can be forgiven",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "pihaqdhiq",
          "category": "Modal: dynamic",
          "emergence": 1,
          "disparition": "None",
          "attestation": "NERAT. Dig. 41, 10, 5, 1 ut probabilis error … usucapioni non obstet (postea: in alieni facti ignorantia tolerabilis error est).",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "yjqigo",
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
      "definition": "Proven to be good at military arts",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "aefeqsn",
          "category": "Not modal",
          "emergence": 3,
          "disparition": "None",
          "attestation": "PASS. Maximil. 1, 1 probabilis est (antea: cum bono tirone).",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "yjqigo",
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
      "definition": "Plausible, apparently true, clear to the understanding",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "pkmhju",
          "category": "Modal: epistemic",
          "emergence": -1,
          "disparition": "None",
          "attestation": "CIC. Quinct. 41 Dubitabitur, utrum sit probabilius, Sex. Naevium statim, si quid deberetur, petiturum fuisse, an ne appellaturum quidem biennio?",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [],
            "unspecified": [
              {
                "rel": "bmbzm",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "Demonstrable",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "bmbzm",
          "category": "Modal: dynamic",
          "emergence": -1,
          "disparition": "None",
          "attestation": "CIC. de orat. 1, 240 (adversarii) disputationem… probabilem et prope veram videri.",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [],
            "unspecified": [
              {
                "rel": "pkmhju",
                "cert": true
              }
            ]
          }
        }
      ]
    }
  ]
}
