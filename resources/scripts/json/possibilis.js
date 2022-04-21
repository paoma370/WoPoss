map_data = {
  "normalForm": true,
  "headword": "POSSIBILIS, -e",
  "etymology": [
    {
      "period": "PIE",
      "form": "*pót-i-",
      "def": "",
      "certitude": true
    },
    {
      "period": "PIt",
      "form": "*poti-, *pot-ē-",
      "def": "'master, in control of', 'to be master'",
      "certitude": true
    }
  ],
  "dataFormat": "cent",
  "meanings": [
    {
      "definition": "(Technical term in rhetoric and philosophy) possible",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "tfbwld",
          "category": "Not modal",
          "emergence": 1,
          "disparition": "None",
          "attestation": "QUINT. Inst. 3, 8, 25 melius… qui tertiam partem duxerunt δυνατόν, quod nostri possibile nominant; quae ut dura videatur appellatio, tamen sola est.",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [],
            "unspecified": [
              {
                "rel": "dhdp",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "That can be or happen",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "vwudovz",
          "category": "Modal: deontic authority permission",
          "emergence": 2,
          "disparition": "None",
          "attestation": "VENUL. Dig. 45, 1, 137, 6 nec ad rem pertinet, quod ius mutari potest et id, quod nunc impossibile est, postea (i.e. iure mutato) possibile fieri.",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [],
            "unspecified": [
              {
                "rel": "dhdp",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "That can be or happen",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "dhdp",
          "category": "Modal: dynamic",
          "emergence": 2,
          "disparition": "None",
          "attestation": "VENUL. dig. 45, 1, 137, 5 si ab eo stipulatus sim, qui efficere non possit, cum alio possibile sit, iure factam obligationem Sabinus scribit.",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [
              {
                "rel": "mipaio",
                "cert": true
              }
            ],
            "unspecified": [
              {
                "rel": "tfbwld",
                "cert": true
              },
              {
                "rel": "vwudovz",
                "cert": true
              },
              {
                "rel": "gaqml",
                "cert": true
              },
              {
                "rel": "nyas",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "That can be satisfied, achieved",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "gaqml",
          "category": "Modal: dynamic",
          "emergence": 2,
          "disparition": "None",
          "attestation": "POMPON. dig. 28, 3, 16 in futurum… collatae condiciones si possibiles sunt [existere potuerunt, licet non exstiterint], efficiunt, ut superius testamentum rumpatur, etiamsi non exstiterint; si vero impossibiles sunt eqs. ",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [
              {
                "rel": "mipaio",
                "cert": true
              },
              {
                "rel": "awgtyj",
                "cert": true
              }
            ],
            "unspecified": [
              {
                "rel": "dhdp",
                "cert": true
              },
              {
                "rel": "nyas",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "That can be proven right",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "awgtyj",
          "category": "Modal: dynamic",
          "emergence": 4,
          "disparition": "None",
          "attestation": "SYMM. Epist. 7, 8 quod possibilis coniectura promittit.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "gaqml",
                "cert": true
              }
            ],
            "destinations": [],
            "unspecified": [
              {
                "rel": "ne",
                "cert": true
              },
              {
                "rel": "abcde",
                "cert": true
              }
            ]
          }
        },
        {
          "id": "abcde",
          "category": "Modal: epistemic",
          "emergence": 4,
          "disparition": "None",
          "attestation": "SYMM. Epist. 7, 8 quod possibilis coniectura promittit.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "gaqml",
                "cert": true
              }
            ],
            "destinations": [
              {
                "rel": "mipaio",
                "cert": true
              }
              ],
            "unspecified": [
              {
                "rel": "ne",
                "cert": true
              },
              {
                "rel": "awgtyj",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "Right, apt, worthy",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "ne",
          "category": "Not modal",
          "emergence": 4,
          "disparition": "None",
          "attestation": "IUVENC. 3, 522 deus electis facilem praepandit in aethra possibilemque viam.",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [],
            "unspecified": [
              {
                "rel": "awgtyj",
                "cert": true
              },
              {
                "rel": "grzzu",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "Someone qualified, worthy",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "grzzu",
          "category": "Not modal",
          "emergence": 4,
          "disparition": "None",
          "attestation": "PS. PHILO antiq. 53, 7 (Samuel ad deum) si possibilis sum, loquere.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "nyas",
                "cert": true
              }
            ],
            "destinations": [],
            "unspecified": [
              {
                "rel": "ne",
                "cert": true
              },
              {
                "rel": "nhkwke",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "Someone who is strong, powerful",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "nyas",
          "category": "Not modal",
          "emergence": 2,
          "disparition": "None",
          "attestation": "ITALA gen. 26, 16 perge a nobis, quia possibilior nobis factus es.",
          "certainty": true,
          "relationships": {
            "origins": [],
            "destinations": [
              {
                "rel": "grzzu",
                "cert": true
              },
              {
                "rel": "nhkwke",
                "cert": true
              }
            ],
            "unspecified": [
              {
                "rel": "dhdp",
                "cert": true
              },
              {
                "rel": "gaqml",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "Someone who is able to / can do something",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "nhkwke",
          "category": "Modal: dynamic",
          "emergence": 4,
          "disparition": "None",
          "attestation": "PHILO quaest. in gen. 4, 208 possibilis factus sum ad inveniendum.",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "nyas",
                "cert": true
              }
            ],
            "destinations": [],
            "unspecified": [
              {
                "rel": "grzzu",
                "cert": true
              }
            ]
          }
        }
      ]
    },
    {
      "definition": "That is possible",
      "construct": "_",
      "group": "_",
      "analysis": [
        {
          "id": "mipaio",
          "category": "Modal: epistemic",
          "emergence": 5,
          "disparition": "None",
          "attestation": "ORIG. in Matth. 15, 16 p. 395, 30 Possibile est ex hoc ipso quod tradidit omnia sua, ut patiens aliquid humanum ex paupertate poeniteat eum facti, desideret autem similia possidere. ",
          "certainty": true,
          "relationships": {
            "origins": [
              {
                "rel": "dhdp",
                "cert": true
              },
              {
                "rel": "gaqml",
                "cert": true
              },
              {
                "rel": "abcde",
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
