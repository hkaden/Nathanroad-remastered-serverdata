var Profiles = {
    'default': function(){
        return {
            "label": "預設",
            "color": "#FF0000",
            "offset": "2",
            "thickness": 0.2,
            "length": 0.6,
            "dot": 0.3,
            "buttons": {"dot": true,"lines": true}
        }
    },
    'small': function(){
        return {
            "label": "小",
            "length":0.3,
            "offset":"1",
            "thickness":0.2,
            "buttons":{"dot":false,"lines":true},
            "dot":0.4,
            "color":"#06fed5"
        }
    },
}