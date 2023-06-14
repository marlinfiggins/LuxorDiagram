using Luxor, MathTeXEngine
using DiagramLuxor

function main()
    Drawing(800, 300, "SIR-diagram.png")
    origin()
    background("white")

    # Set font and font size
    fontface("Lato light")
    fontsize(80)

    # Set heights and width
    width = 80
    height = 80

    # Positions
    posS = Point(-300, 0)
    posI = Point(0, 0)
    posR = Point(300, 0)

    # Make compartments
    S = Compartment(posS, width, height, L"S")
    I = Compartment(posI, width, height, L"I")
    R = Compartment(posR, width, height, L"R")

    comps = [S, I, R]
    comp_colors = ["red", "blue", "green"]

    # Transitions
    SI = Transition(S, I, L"\beta S I")
    IR = Transition(I, R, L"\gamma I")

    trans = [SI, IR]
    # Drawing
    fontsize(40)
    for tr in trans
        draw(tr)
    end

    fontsize(80)
    for (comp, col) in zip(comps, comp_colors)
        draw(comp; color=col)
    end

    finish()
    return preview()
end

main()
