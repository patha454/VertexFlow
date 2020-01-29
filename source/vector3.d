/**
 * `vector3.d` provides a template for 3-Vector.
 *
 * The 3-Vector is intended to be the backbone of the `Node` data structure,
 * but would not often be used directly because the 3-Vector only provides
 * position information and mathematical operations, and not any metadata.
 *
 * Author: H Paterson.
 * Date: 27/01/20.
 * Licence: Boost Software Licence 1.0.
 */


module vector3;


import std.traits;


/**
 * `Vector3` provides a custom precision structure for a vector in cartesian
 * 3-space.
 */
struct Vector3(T)
{
    /** The *x* position of the vector. */
    private T x;

    /** The *y* position of the vector. */
    private T y;

    /** The *z* position of the vector. */
    private T z;

    /**
     * Constructs a new vector from three co-ordinates.
     * 
     * The Vector3 can only be manipulated by Vector3's arithmetic operations
     * after construction. The Vector3`s `x`, `y`, and `z` values are read
     * only outside of the strut. This helps prevent the vector entering an
     * inconsistent state, or being moved accidentally. This arrangement also
     * discourages programmers from (re)-writing their own vector operations
     * which may introduce bugs or redundancy.
     *
     * Params:
     *  x =    *x* position.
     *  y =    *y* position.
     *  z =    *z* position.
     */
    this(T x, T y, T z)
    {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    ///
    unittest
    {
        const Vector3!int a = Vector3!int(8, -3, 12);
        assert(a.x == 8);
        assert(a.y == -3);
        assert(a.z == 12);
    }

    /**
     * Overloads the equality operator for 3-Vectors.
     *
     * 3-Vectors are considered equal if they have the same type and the same
     * position/displacement.
     *
     * Params:
     *  other   =   A `Vector3` to be compared to.
     *
     * Returns:
     *  True if `a` is considered equal to `b`.
     */   
    bool opEquals(Vector3!T other) const
    {
        return this.x == other.x && this.y == other.y && this.z == other.z;
    }

    ///
    unittest
    {
        const Vector3!int a = Vector3!int(3, 4, 2);
        const Vector3!int b = Vector3!int(3, 4, 2);
        const Vector3!int c = Vector3!int(1, -1, 2);
        assert(a == a);
        assert(a == b);
        assert(a != c);
    }

    /**
     * Override the hash function for a `Vector3`.
     *
     * The hash of two objects must be equal when their values are equal, as
     * defined by `opEquals()`.
     *
     * Warning: This is a naive stopgap hash function until more vector
     * arithmetic is available.
     * 
     * Returns:
     *  A hash representative of the 3-vector's content.
     */
    size_t toHash() const
    {
        return this.x.hashOf + this.y.hashOf+ this.z.hashOf;
    }

    unittest
    {
        const auto a = Vector3!int(5, 4, -2);
        const auto b = Vector3!int(5, 4, -2);
        assert(a.toHash == b.toHash);
        assert(a == b);
    }

    /**
     * Overloads binary arithmetic operators for 3-vectors. 
     *
     * The binary operators return new 3-vectors with the calculated value,
     * because the 3-vector's *x*, *y*, and *z* positions should be considered
     * constant to ensure consistency if multiple objects refer to the same
     * `Vector3`.
     *
     * Valid operations are:
     * - Vector3!T + Vector3!T
     * - Vector3!T - Vector3!T
     * - Vector3!T * scalar
     * - Vector3!T / scalar
     *
     * Params:
     *  op  =   The operator.
     *  rhs =   The right hand side operand.
     */
    Vector3!T opBinary(string op, R)(R rhs) const
    {
        static if (op == "+" && is(R: Vector3!T))
        {
            return Vector3!T(this.x + rhs.x, this.y + rhs.y, this.z + rhs.z);
        }
        else static if (op == "-" && is(R: Vector3!T))
        {
            return Vector3!T(this.x - rhs.x, this.y - rhs.y, this.z - rhs.z);
        }
        else static if (op == "*" && isNumeric!R)
        {
            return Vector3!T(this.x * rhs, this.y * rhs, this.z * rhs);
        }
        else static if (op == "/" && isNumeric!R)
        {
            return Vector3!T(this.x / rhs, this.y / rhs, this.z / rhs);
        }
        else static assert(0, "Operator " ~ op ~ " not defined for " ~ typeof(this).stringof ~ " and " ~ R.stringof);
    }

    /// Addition
    unittest
    {
        immutable Vector3!int a = Vector3!int(1, 3, 2);
        immutable Vector3!int b = Vector3!int(-3, 0, 4);
        assert(a + b == Vector3!int(-2, 3, 6));
    }

    /// Subtraction
    unittest
    {
        immutable auto a = Vector3!double(2.2, 1.1, 8.4);
        immutable Vector3!double b = Vector3!double(-2, 0.1, 6.2);
        assert(a - b == Vector3!double(4.2, 1.0, 2.2));
    }

    /// Multiplication
    unittest
    {
        immutable auto a = Vector3!int(2, 4, 8);
        immutable auto b = Vector3!double(-1.2, 3, -0.5);
        assert(a * 2 == Vector3!int(4, 8, 16));
        assert(b * - 0.5 == Vector3!double(0.6, -1.5, 0.25));
    }

    /// Division
    unittest
    {
        immutable auto a = Vector3!int(-2, 8, 7);
        assert(a / -2 == Vector3!int(1, -4, -3));
    }

    /**
     * Overloads binary arithmetic operators for 3-vectors on the right hand
     * side.
     *
     * Note: Most binary operands should be handled though the left hand side
     * version `opBinary`, so they are only documented and implemented there. 
     *
     * Valid operations are:
     * - scalar * Vector3!T
     * - Vector3!t * Vector!T
     * 
     *
     * Params:
     *  op  =   The operator.
     *  lhs =   The left hand side operand.
     */
    Vector3!T opBinaryRight(string op, L)(const L lhs) const
    {
        static if (op == "+" || op == "*")
        {
            // Exploit the commutative property of multiplication and addition.
            return mixin("this" ~ op ~ "lhs");
        }
        else static assert(0, "Operator " ~ op ~ " not defined for " ~ typeof(this).stringof ~ " and " ~ U.stringof);
    }

    /// Addition
    unittest
    {
        immutable auto a = Vector3!int(3, -4, 0);
        immutable auto b = Vector3!int(1, 0, -4);
        assert(a + b == b + a);
    }

    /// Multiplication
    unittest
    {
        immutable auto a = Vector3!int(-3, 2, 5);
        assert(2 * a == a * 2);
    }
}
