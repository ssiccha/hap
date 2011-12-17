#(C) Graham Ellis, 2005-2006.

## FREE G MODULES ###################################################
DeclareGlobalFunction("Negate");
DeclareGlobalFunction("NegateWord");
DeclareGlobalFunction("AlgebraicReduction");
DeclareGlobalFunction("AddFreeWords");
DeclareGlobalFunction("AddFreeWordsModP");
DeclareGlobalFunction("PrintZGword");
DeclareGlobalFunction("TietzeReduction");
DeclareGlobalFunction("MultiplyWord");
DeclareGlobalFunction("WordModP");

## NONABELIAN TENSOR ################################################
DeclareGlobalFunction("NonabelianTensorSquare");
DeclareGlobalFunction("ThirdHomotopyGroupOfSuspensionB");
DeclareGlobalFunction("NonabelianExteriorProduct");
DeclareGlobalFunction("RelativeSchurMultiplier");
DeclareGlobalFunction("EpiCentre");
DeclareGlobalFunction("UpperEpicentralSeries");
DeclareGlobalFunction("BaerInvariant");
DeclareGlobalFunction("TensorCentre");
DeclareGlobalFunction("ThirdHomotopyGroupOfSuspensionB_alt");
DeclareGlobalFunction("NonabelianTensorSquare_inf");


## RESOLUTIONS ######################################################
DeclareGlobalFunction("ResolutionFiniteGroup");
DeclareGlobalFunction("ResolutionSmallFpGroup");
DeclareGlobalFunction("PresentationOfResolution");
DeclareGlobalFunction("ResolutionFiniteSubgroup");
DeclareGlobalFunction("ResolutionSubgroup");
DeclareGlobalFunction("ResolutionAsphericalPresentation");
DeclareGlobalFunction("ResolutionAbelianGroup");
DeclareGlobalFunction("ResolutionAlmostCrystalGroup");
DeclareGlobalFunction("ResolutionAlmostCrystalQuotient");
DeclareGlobalFunction("CayleyGraphDisplay");

## RESOLUTIONS MOD P ################################################
DeclareGlobalFunction("ResolutionPrimePowerGroup");

## FUNCTORS #########################################################
DeclareGlobalFunction("EvaluateProperty");
DeclareGlobalFunction("EvenSubgroup");
DeclareGlobalFunction("EquivariantChainMap");
DeclareGlobalFunction("TensorWithIntegers");
DeclareGlobalFunction("TensorWithIntegersModP");
DeclareGlobalFunction("PrimePartDerivedFunctor");
DeclareGlobalFunction("ReduceGenerators");
DeclareGlobalFunction("HomToIntegers");
DeclareGlobalFunction("HomToIntegralModule");
DeclareGlobalFunction("PermToMatrixGroup");
DeclareGlobalFunction("AbelianInvariantsToTorsionCoefficients");
DeclareGlobalFunction("TorsionGeneratorsAbelianGroup");
DeclareGlobalFunction("TensorWithRationals");
DeclareGlobalFunction("BigStepLCS");
DeclareGlobalFunction("HomToIntegersModP");
DeclareGlobalFunction("Coclass");
DeclareGlobalFunction("BoundaryMatrix");


## PERTURBATIONS ####################################################
DeclareGlobalFunction("TwistedTensorProduct");
DeclareGlobalFunction("ResolutionFiniteExtension");
DeclareGlobalFunction("ResolutionNormalSeries");
DeclareGlobalFunction("ResolutionDirectProduct");
DeclareGlobalFunction("ResolutionExtension");
DeclareGlobalFunction("ResolutionFiniteDirectProduct");
DeclareGlobalFunction("ResolutionSubnormalSeries");



## ARTIN COXETER ####################################################
DeclareGlobalFunction("CoxeterDiagramMatrix");
DeclareGlobalFunction("CoxeterDiagramVertices");
DeclareGlobalFunction("CoxeterDiagramFpArtinGroup");
DeclareGlobalFunction("CoxeterDiagramFpCoxeterGroup");
DeclareGlobalFunction("CoxeterSubDiagram");
DeclareGlobalFunction("CoxeterDiagramComponents");
DeclareGlobalFunction("CoxeterDiagramDegree");
DeclareGlobalFunction("CoxeterDiagramIsSpherical");
DeclareGlobalFunction("ResolutionArtinGroup");
DeclareGlobalFunction("CoxeterDiagramDisplay");

## HOMOLOGY #########################################################
DeclareOperation("Homology",[IsObject,IsObject]);
#DeclareGlobalFunction("Homology");
DeclareGlobalFunction("IntegralHomology");
DeclareGlobalFunction("ModularHomology");
DeclareGlobalFunction("GroupHomology");
DeclareGlobalFunction("IntegralCohomology");
DeclareOperation("Cohomology",[IsObject,IsObject]);
#DeclareGlobalFunction("Cohomology");
DeclareGlobalFunction("Syzygy");
DeclareGlobalFunction("CR_IntegralCycleToClass");
DeclareGlobalFunction("CocycleCondition");
DeclareGlobalFunction("StandardCocycle");
DeclareGlobalFunction("IsSuperperfect");
DeclareGlobalFunction("ModularCohomology");
DeclareOperation("SolutionsMatDestructive",
			[IsOrdinaryMatrix,IsOrdinaryMatrix]);

## RINGS ############################################################
DeclareGlobalFunction("CR_IntegralCohomology");
DeclareGlobalFunction("CR_ChainMapFromCocycle");
DeclareGlobalFunction("CR_CocyclesAndCoboundaries");
DeclareGlobalFunction("CR_IntegralClassToCocycle");
DeclareGlobalFunction("CR_IntegralCocycleToClass");
DeclareGlobalFunction("IntegralCupProduct");
DeclareGlobalFunction("IntegralRingGenerators");

## ModPRings ########################################################
DeclareGlobalFunction("ModPCohomologyRing");
DeclareGlobalFunction("ModPRingGenerators");

## CURVATURE ########################################################
DeclareGlobalFunction("IsAspherical");
DeclareGlobalFunction("PolytopalGenerators");
DeclareGlobalFunction("VectorStabilizer");
DeclareGlobalFunction("PolytopalComplex");

## POLYCYLIC ########################################################
DeclareGlobalFunction("ResolutionAbelianPcpGroup");
DeclareGlobalFunction("ResolutionNilpotentGroup");

## OBJECTIFICATION ##################################################
DeclareOperation("Target",[IsObject]);
DeclareOperation("Map",[IsObject]);
DeclareOperation("BoundaryMap",[IsObject]);
DeclareOperation("GroupOfResolution",[IsObject]);

## GRAPHS OF GROUPS #################################################
DeclareGlobalFunction("GraphOfGroupsDisplay");
DeclareGlobalFunction("ResolutionGraphOfGroups");
DeclareGlobalFunction("GraphOfGroupsTest");

## LIE ALGEBRAS #####################################################
DeclareGlobalFunction("ChevalleyEilenbergComplex");
DeclareGlobalFunction("IsLieAlgebraHomomorphism");
DeclareGlobalFunction("LieAlgebraHomology");
DeclareGlobalFunction("LowerCentralSeriesLieAlgebra");


