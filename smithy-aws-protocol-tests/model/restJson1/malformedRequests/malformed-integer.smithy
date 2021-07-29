$version: "1.0"

namespace aws.protocoltests.restjson

use aws.protocols#restJson1
use smithy.test#httpMalformedRequestTests

@http(uri: "/MalformedInteger/{integerInPath}", method: "POST")
operation MalformedInteger {
    input: MalformedIntegerInput
}

apply MalformedInteger @httpMalformedRequestTests([
    {
        id: "RestJsonBodyIntegerUnderflow",
        documentation: """
        Underflow should result in SerializationException""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            body: """
            { "integerInBody" : -9223372000000000000 }
            """
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonBodyIntegerOverflow",
        documentation: """
        Overflow should result in SerializationException""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            body: """
            { "integerInBody" : 9223372000000000000 }
            """
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonBodyMassiveIntegerOverflow",
        documentation: """
        Overflow should result in SerializationException, even if it overflows parseInt""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            body: """
            { "integerInBody" : 123000000000000000000000 }
            """
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonPathIntegerUnderflow",
        documentation: """
        Underflow should result in SerializationException""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/-9223372000000000000"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonPathIntegerOverflow",
        documentation: """
        Overflow should result in SerializationException""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/9223372000000000000"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonPathMassiveIntegerOverflow",
        documentation: """
        Overflow should result in SerializationException, even if it overflows parseInt""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/123000000000000000000000"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonQueryIntegerUnderflow",
        documentation: """
        Underflow should result in SerializationException""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            queryParams: [
                "integerInQuery=-9223372000000000000"
            ]
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonQueryIntegerOverflow",
        documentation: """
        Overflow should result in SerializationException""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            queryParams: [
                "integerInQuery=9223372000000000000"
            ]
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonQueryMassiveIntegerOverflow",
        documentation: """
        Overflow should result in SerializationException, even if it overflows parseInt""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            queryParams: [
                "integerInQuery=123000000000000000000000"
            ]
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonHeaderIntegerUnderflow",
        documentation: """
        Underflow should result in SerializationException""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            headers: {
               "integerInHeader" : "-9223372000000000000"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonHeaderIntegerOverflow",
        documentation: """
        Overflow should result in SerializationException""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            headers: {
               "integerInHeader" : "9223372000000000000"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonHeaderMassiveIntegerOverflow",
        documentation: """
        Overflow should result in SerializationException, even if it overflows parseInt""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            headers: {
               "integerInHeader" : "123000000000000000000000"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["underflow/overflow"]
    },
    {
        id: "RestJsonBodyIntegerStringCoercionRejected",
        documentation: """
        Strings should not be coerced into integers""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            body: """
            { "integerInBody" : "123" }
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
        id: "RestJsonBodyIntegerBooleanCoercionRejected",
        documentation: """
        Booleans should not be coerced into integers""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            body: """
            { "integerInBody" : true }
            """
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["boolean_coercion"]
    },
    {
        id: "RestJsonBodyIntegerFloatTruncationRejected",
        documentation: """
        Floats should not be coerced into integers""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            body: """
            { "integerInBody" : 1.0001 }
            """
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["float_truncation"]
    },
    {
        id: "RestJsonBodyIntegerTrailingCharactersRejected",
        documentation: """
        Trailing characters should be rejected""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            body: """
            { "integerInBody" : 2ABC }
            """
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["trailing_chars"]
    },
    {
        id: "RestJsonPathIntegerBooleanCoercionRejected",
        documentation: """
        Booleans should not be coerced into integers""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/true"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["boolean_coercion"]
    },
    {
        id: "RestJsonPathIntegerFloatTruncationRejected",
        documentation: """
        Floats should not be coerced into integers""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1.0001"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["float_truncation"]
    },
    {
        id: "RestJsonPathIntegerTrailingCharactersRejected",
        documentation: """
        Trailing characters should be rejected""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/2ABC"
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["trailing_chars"]
    },
    {
        id: "RestJsonQueryIntegerBooleanCoercionRejected",
        documentation: """
        Booleans should not be coerced into integers""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            queryParams: [
                "integerInQuery=true"
            ]
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["boolean_coercion"]
    },
    {
        id: "RestJsonQueryIntegerFloatTruncationRejected",
        documentation: """
        Floats should not be coerced into integers""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            queryParams: [
                "integerInQuery=1.0001"
            ]
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["float_truncation"]
    },
    {
        id: "RestJsonQueryIntegerTrailingCharactersRejected",
        documentation: """
        Trailing characters should be rejected""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            queryParams: [
                "integerInQuery=2ABC"
            ]
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["trailing_chars"]
    },
    {
        id: "RestJsonHeaderIntegerBooleanCoercionRejected",
        documentation: """
        Booleans should not be coerced into integers""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            headers: {
               "integerInHeader" : "true"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["boolean_coercion"]
    },
    {
        id: "RestJsonHeaderIntegerFloatTruncationRejected",
        documentation: """
        Floats should not be coerced into integers""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            headers: {
               "integerInHeader" : "1.0001"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["float_truncation"]
    },
    {
        id: "RestJsonHeaderIntegerTrailingCharactersRejected",
        documentation: """
        Trailing characters should be rejected""",
        protocol: restJson1,
        request: {
            method: "POST",
            uri: "/MalformedInteger/1",
            headers: {
               "integerInHeader" : "2ABC"
            }
        },
        response: {
            code: 400,
            headers: {
                "x-amzn-errortype": "SerializationException"
            }
        },
        tags: ["trailing_chars"]
    },
])

structure MalformedIntegerInput {
    integerInBody: Integer,

    @httpLabel
    @required
    integerInPath: Integer,

    @httpQuery("integerInQuery")
    integerInQuery: Integer,

    @httpHeader("integerInHeader")
    integerInHeader: Integer
}

