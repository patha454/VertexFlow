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


/**
 * `Vector3` provides a custom precision structure for a vector in cartesian
 * 3-space.
 */
struct Vector3(T)
{
    /** The *x* position of the vector. */
    private const T _x;

    /** The *y* position of the vector. */
    private const T _y;

    /** The *z* position of the vector. */
    private const T _z;

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
        this._x = x;
        this._y = y;
        this._z = z;
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
        assert (a == a);
        assert (a == b);
        assert (a != c);
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
        return this.x + this.y + this.z;
    }

    unittest
    {
        const auto a = Vector3!int(5, 4, -2);
        const auto b = Vector3!int(5, 4, -2);
        assert (a.toHash == b.toHash);
        assert (a == b);
    }

    /**
     * Overloads addition and subtraction for 3-vectors.
     *
     * The binary operators return new 3-vectors with the calculated value,
     * because the 3-vector's *x*, *y*, and *z* positions should be considered
     * constant to ensure consistency if multiple objects refer to the same
     * `Vector3`.
     *
     * Params:
     *  op  =   The operator.
     *  rhs =   The other operand.
     * 
     */
    Vector3!T opBinary(string op)(Vector3!T rhs) const
    {
        static if (op == "+")
        {
            return Vector3!T(this.x + rhs.x, this.y + rhs.y, this.z + rhs.z);
        }
        else static if (op == "-")
        {
            return Vector3!T(this.x - rhs.x, this.y - rhs.y, this.z - rhs.z);
        }
        else static assert(0, "Operator " ~ op ~ " not defined.");
    }

    unittest
    {
        const Vector3!int a = Vector3!int(1, 3, -3);
        const Vector3!int b = Vector3!int(0, -4, 2);
        const Vector3!int c = a + b;
        assert(c == Vector3!int(1, -1, -1));
    }

    /** `x` provides property access to the *x* position. */
    @property public T x() const { return this._x; }

    /** `y` provides property access to the *y* position. */
    @property public T y() const { return this._y; }

    /** `z` provides property access to the *z* position. */
    @property public T z() const { return this._z; }
}
