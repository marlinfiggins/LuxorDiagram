using Luxor, MathTeXEngine
using DiagramLuxor


function main()
    Drawing(600, 800, "immune-diagram.png")
    origin()
    background("white")

    # Set font and font size
    fontface("Lato")
    fontsize(35)

    # Set heights and width
    width = 120
    height = 80

    # Positions
    posImmunity = Point(-150, -300)
    posInfection = Point(150, -300)
    posRelFitness = Point(0, 0)
    posFreq = Point(0, 300)

    # Make compartments
    immunity = Compartment(posImmunity, width, height, "Immunity")
    infection = Compartment(posInfection, width, height, "Infection")
    relfitness = Compartment(posRelFitness, width, height, "Relative fitness")
    frequency = Compartment(posFreq, width, height, "Frequency")

    comps = [immunity, infection, relfitness, frequency]
    color = "#D5D5FF"

    # Transitions
    im_rf = Transition(immunity, relfitness)
    in_rf = Transition(infection, relfitness)
    rf_fq = Transition(relfitness, frequency)


    trans = [im_rf, in_rf, rf_fq]
    # Drawing
    for tr in trans
        draw(tr, scale_radius=0.7)
    end

    for comp in comps
        draw(comp, color=color)
    end

    finish()
    preview()
end

main()
