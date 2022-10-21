$version: "2.0"

namespace software.amazon.smithy.test

structure TestShape {
    /// foo
    @required
    foo: Boolean = false
    /// bar
    @required
    bar: TestString
}

string TestString