struct Compartment{T<:Real,S<:AbstractString}
    pos::Point
    width::T
    height::T
    text::Union{S,Nothing}
end

function Compartment(pos, width, height)
    return Compartment(pos, width, height, nothing)
end

function draw(c::Compartment; color="white", rt=0.5)
    sethue(color)
    squircle(c.pos, c.width, c.height; action=:fill, rt=rt)

    sethue("black")
    squircle(c.pos, c.width, c.height; action=:stroke, rt=rt)

    if !isnothing(c.text)
        text(c.text, c.pos; halign=:center, valign=:middle)
    end
end

# There can be multiple types of transitions, some arrows some not
# We'll just use arrows for now
struct Transition
    from::Compartment
    to::Compartment
    text::Union{S,Nothing} where {S<:AbstractString}
end

function Transition(from, to)
    return Transition(from, to, nothing)
end

function squricleedges(t::Transition; scale_radius=0.8)
    # We really want to find the position on the rectangle?
    # Unpack positions
    p_pos = t.from.pos
    p_radius = sqrt(t.from.width^2 + t.from.height^2) * scale_radius

    c_pos = t.to.pos
    c_radius = sqrt(t.to.width^2 + t.to.height^2) * scale_radius

    # Angle between two points
    θ = atan(p_pos.y - c_pos.y, p_pos.x - c_pos.x)

    # Origin and Destination of arrow
    orig = Point(p_pos.x - p_radius * cos(θ), p_pos.y - p_radius * sin(θ))
    dest = Point(c_pos.x + c_radius * cos(θ), c_pos.y + c_radius * sin(θ))
    return orig, dest
end

function arrowtext(t)
    return text(t, Point(0, 0) + Point(0, -5); halign=:center, valign=:bottom)
end

# Add option for text over arrow
function draw(t::Transition; linewidth=2.5, scale_radius=0.8)
    text = isnothing(t.text) ? "" : t.text
    orig, dest = squricleedges(t; scale_radius=scale_radius)
    return arrow(orig, dest; linewidth=linewidth, decorate=() -> arrowtext(text))
end
