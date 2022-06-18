struct Agent{T <: Real}
    pos::Point
    radius::T
    text::Union{S, Nothing} where {S <: AbstractString} 
end


#TODO: Add option for text in agent
function draw(a::Agent, color="white")
    """
    Draw agent with fill color `color`.
    """
    
    # Add inner filled circle
    sethue(color)
    circle(a.pos, a.radius, :fill)

    # Add outer radius
    sethue("black")
    circle(a.pos, a.radius, :stroke)

    # Add text
    if !isnothing(a.text)
        text(a.text, a.pos, halign=:center, valign=:middle)
    end
end

struct Transmission
    parent::Agent
    child::Agent
    text::Union{S, Nothing} where {S <: AbstractString}
end

function circleedges(t::Transmission; scale_radius=1.25)
    # Unpack positions
    p_pos = t.parent.pos
    p_radius = t.parent.radius * scale_radius

    c_pos = t.child.pos
    c_radius = t.child.radius * scale_radius

    # Angle between two points
    θ = atan(p_pos.y-c_pos.y, p_pos.x-c_pos.x)

    # Origin and Destination of arrow
    orig = Point(p_pos.x - p_radius * cos(θ), p_pos.y - p_radius * sin(θ))
    dest = Point(c_pos.x + c_radius * cos(θ), c_pos.y + c_radius * sin(θ))
    return orig, dest
end

function draw!(t::Transmission, scale_radius=1.25)
    orig, dest = circleedges(t, scale_radius=scale_radius)

    text = isnothing(t.text) ? " " : t.text
    arrow(orig, dest, 
        linewidth=1.5,  
        decorate = () -> arrowtext(text))
end
