# using ModelingToolkit

# @variables t x(t)   # independent and dependent variables
# @parameters τ       # parameters
# @constants h = 1    # constants have an assigned value
# D = Differential(t) # define an operator for the differentiation w.r.t. time

# # your first ODE, consisting of a single equation, the equality indicated by ~
# @named fol = ODESystem([D(x) ~ (h - x) / τ])

# using DifferentialEquations: solve

# prob = ODEProblem(fol, [x => 0.0], (0.0, 10.0), [τ => 3.0])
# # parameter `τ` can be assigned a value, but constant `h` cannot
# sol = solve(prob)

# using Plots
# plot(sol)
# savefig("myplot.png")

######################################################################

# using Plots
# x = 1:10; y = rand(10); # These are the plotting data
# plot(x, y)
# savefig("myplot.png")

######################################################################


# using ModelingToolkit, Plots, DifferentialEquations

# @variables t
# @connector function Pin(; name)
#     sts = @variables v(t)=1.0 i(t)=1.0 [connect = Flow]
#     ODESystem(Equation[], t, sts, []; name = name)
# end

# @component function Ground(; name)
#     @named g = Pin()
#     eqs = [g.v ~ 0]
#     compose(ODESystem(eqs, t, [], []; name = name), g)
# end

# @component function OnePort(; name)
#     @named p = Pin()
#     @named n = Pin()
#     sts = @variables v(t)=1.0 i(t)=1.0
#     eqs = [v ~ p.v - n.v
#            0 ~ p.i + n.i
#            i ~ p.i]
#     compose(ODESystem(eqs, t, sts, []; name = name), p, n)
# end

# @component function Resistor(; name, R = 1.0)
#     @named oneport = OnePort()
#     @unpack v, i = oneport
#     ps = @parameters R = R
#     eqs = [
#         v ~ i * R,
#     ]
#     extend(ODESystem(eqs, t, [], ps; name = name), oneport)
# end

# @component function Capacitor(; name, C = 1.0)
#     @named oneport = OnePort()
#     @unpack v, i = oneport
#     ps = @parameters C = C
#     D = Differential(t)
#     eqs = [
#         D(v) ~ i / C,
#     ]
#     extend(ODESystem(eqs, t, [], ps; name = name), oneport)
# end

# @component function ConstantVoltage(; name, V = 1.0)
#     @named oneport = OnePort()
#     @unpack v = oneport
#     ps = @parameters V = V
#     eqs = [
#         V ~ v,
#     ]
#     extend(ODESystem(eqs, t, [], ps; name = name), oneport)
# end

# R = 1.0
# C = 1.0
# V = 1.0
# @named resistor = Resistor(R = R)
# @named capacitor = Capacitor(C = C)
# @named source = ConstantVoltage(V = V)
# @named ground = Ground()

# rc_eqs = [connect(source.p, resistor.p)
#           connect(resistor.n, capacitor.p)
#           connect(capacitor.n, source.n)
#           connect(capacitor.n, ground.g)]

# @named _rc_model = ODESystem(rc_eqs, t)
# @named rc_model = compose(_rc_model,
#                           [resistor, capacitor, source, ground])
# sys = structural_simplify(rc_model)
# u0 = [
#     capacitor.v => 0.0,
# ]
# prob = ODAEProblem(sys, u0, (0, 10.0))
# sol = solve(prob, Tsit5())
# plot(sol)
# savefig("myplot.png")

###############################################################



using ModelingToolkit, OrdinaryDiffEq, Plots
using ModelingToolkitStandardLibrary.Electrical
using ModelingToolkitStandardLibrary.Blocks: Constant
using ModelingToolkitStandardLibrary.Blocks: RealInput
using ModelingToolkitStandardLibrary.Blocks: Sine



@component function My_Resistor(; name, R_min = 0.75)
    @named oneport = OnePort()
    @unpack v, i = oneport
    @named R = RealInput()

    sts = @variables begin
        R_actual(t) = R_min
    end
    eqs = [
        R_actual ~ ifelse(R.u < R_min, R_min, R.u)
        v ~ i * R_actual
    ]
    extend(ODESystem(eqs, t, sts, []; name = name, systems = [R]), oneport)
end

R = 1.0
C = 1.0
V = 1.0
@variables t
@named resistor = My_Resistor()
@named capacitor = Capacitor(C = C)
@named source = Voltage()
@named constant = Constant(k = V)
@named ground = Ground()
@named constant2 = Constant(k = R)
@named input_ref = Sine(; frequency = 1, offset = 1, amplitude = 0.5)

rc_eqs = [connect(constant.output, source.V)
          connect(source.p, resistor.p)
          connect(resistor.n, capacitor.p)
          connect(capacitor.n, source.n, ground.g)
          connect(input_ref.output, resistor.R)]

@named rc_model = ODESystem(rc_eqs, t,
                            systems = [resistor, capacitor, constant, source, ground, input_ref])
sys = structural_simplify(rc_model)
prob = ODAEProblem(sys, Pair[], (0, 1.0))
sol = solve(prob, Tsit5())
plot(sol, vars = [capacitor.v, resistor.i, resistor.R_actual],
     title = "RC Circuit Demonstration",
     labels = ["Capacitor Voltage" "Resistor Current" "Resistor Resistance"])
savefig("plot.png");