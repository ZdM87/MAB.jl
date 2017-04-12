# Example for using Experiments

using Bandits
import PyPlot

bandit  = [
    # Arms.Bernoulli( 0.20 ),
    # Arms.Bernoulli( 0.90 ),
    # Arms.Bernoulli( 0.10 ),
    # Arms.Bernoulli( 0.15 )
    # Arms.Normal( 0.36, 1.00 ),
    # Arms.Normal( 0.20, 1.00 ),
    # Arms.Normal( 0.81, 1.00 ),
    # Arms.Normal( 0.56, 1.00 ),
    # Arms.Beta( 0.60, 0.40 ),
    # Arms.Sinusoidal( 800, 0 ),
    # Arms.Sinusoidal( 800, π/4 ),
    # Arms.Sinusoidal( 800, π/2 ),
    # Arms.Sinusoidal( 800, 3*π/4 )
    Arms.Pulse( 1000, 820, 100 ),
    Arms.Pulse( 1000, 700, 100 ),
    Arms.Pulse( 1000, 520, 100 )
]

noOfArms = length( bandit )

testAlgs = [
    # Algorithms.UniformStrategy( noOfArms ),
    # Algorithms.epsGreedy( noOfArms, 0.05 ),
    # Algorithms.epsGreedy( noOfArms, 1.00 ),
    # Algorithms.epsNGreedy( noOfArms, 5, 0.05 ),
    # Algorithms.epsNGreedy( noOfArms, 1/noOfArms, 1.0 ),
    # Algorithms.epsNGreedy( noOfArms )
    # Algorithms.EXP3( noOfArms, 0.05 ),
    # Algorithms.EXP3( noOfArms, 0.10 ),
    # Algorithms.UCB1( noOfArms ),
    Algorithms.TS( noOfArms ),
    # Algorithms.OTS( noOfArms )
    Algorithms.DynamicTS( noOfArms, 10 ),
    # Algorithms.UCBNormal( noOfArms )
    # Algorithms.EXP31( noOfArms )
]

exp1 = Experiments.Compare( bandit, testAlgs )
# run
noOfRounds      = 2000
noOfTimeSteps   = 2000
result = Experiments.run( exp1, noOfTimeSteps, noOfRounds )

fig = PyPlot.figure()
## Plot avg rewards
for alg in keys(result)
    PyPlot.plot( 1:noOfTimeSteps, result[alg], label = alg )
end

PyPlot.xlabel( "Timesteps" )
PyPlot.ylabel( "Avg. Reward" )
PyPlot.title( "Average Reward (Normalized for $noOfRounds rounds)")
ax = PyPlot.gca()
ax[:set_ylim]( [0.00,1.00] )
PyPlot.legend()
