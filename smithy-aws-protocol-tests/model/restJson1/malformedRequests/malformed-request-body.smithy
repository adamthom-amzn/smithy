$version: "1.0"

namespace aws.protocoltests.restjson

use aws.protocols#restJson1
use smithy.test#httpMalformedRequestTests

@http(uri: "/MalformedRequestBody", method: "POST")
operation MalformedRequestBody {
    input: MalformedRequestBodyInput
}

apply MalformedRequestBody @httpMalformedRequestTests([
    {
        id: "RestJsonMalformedJsonBody",
        documentation: """
        When the request body is not valid JSON, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: "{["
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RestJsonMalformedJsonBodyWithTrailingContent",
        documentation: """
        When the request body has trailing content, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            { "int": 10 }abc
            """
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RestJsonMalformedJsonBodyWithLeadingContent",
        documentation: """
        When the request body has leading content, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            abc{ "int": 10 }
            """
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RestJsonMalformedJsonBodyWithTrailingComments",
        documentation: """
        When the request body has comments, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            {
                "int": 10 // the integer should be 10
            }"""
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RestJsonMalformedJsonBodyWithInlineComments",
        documentation: """
        When the request body has comments, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            {
                "int": 10 /* the integer should be 10 */
            }"""
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RestJsonMalformedJsonBodyWithDisallowedWhitespace",
        documentation: """
        When the request body has disallowed whitespace, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            {"int" :\u000c10}"""
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RestJsonMalformedJsonBodyWithSingleQuotes",
        documentation: """
        When the request body uses single quotes, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            {
                'int': 10
            }"""
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RestJsonMalformedJsonBodyWithTrailingCommas",
        documentation: """
        When the request body has trailing commas, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            {
                "int": 10,
            }"""
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RestJsonListJsonBody",
        documentation: """
        When the request body is a list, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            [{ "int": 10}]"""
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["technically_valid_json_body"]
    },
    {
        id: "RestJsonNumericJsonBody",
        documentation: """
        When the request body is just a number, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: "10"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["technically_valid_json_body"]
    },
    {
        id: "RestJsonNullJsonBody",
        documentation: """
        When the request body is an explicit null, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: "null"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["technically_valid_json_body"]
    },
    {
        id: "RestJsonNaNInJsonBody",
        documentation: """
        When the request body has a NaN, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            { "float" : NaN }"""
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RestJsonInfinityInJsonBody",
        documentation: """
        When the request body has an Infinity, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            { "float" : Infinity }"""
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RestJsonNegativeInfinityInJsonBody",
        documentation: """
        When the request body has a -Infinity, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            { "float" : -Infinity }"""
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
    {
        id: "RestJsonHexDigitsInJsonBody",
        documentation: """
        When the request body has a -Infinity, the response should be a 400
        SerializationException.""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedRequestBody",
            body: """
            { "int" : 0x42 }"""
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        }
    },
])

structure MalformedRequestBodyInput {
    int: Integer,
    float: Float
}

