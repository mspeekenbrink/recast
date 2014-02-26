/***** Method *****/

/* Retrieve gender and age for the two experimental groups, including tests for differences */

DATASET ACTIVATE DataSet1.
CROSSTABS
  /TABLES=Condition BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT ROW 
  /COUNT ROUND CELL.

DATASET ACTIVATE DataSet1.
MEANS TABLES=Age BY Condition
  /CELLS MEAN COUNT STDDEV MIN MAX.

T-TEST GROUPS=Condition_Num(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=Age
  /CRITERIA=CI(.95).


/***** Results *****/

/*** Group differences ***/

/* Anova to test whether the two groups differ in their interpretation of words */

ONEWAY Proportion_Rowing BY Condition_Num
  /STATISTICS HOMOGENEITY 
  /MISSING ANALYSIS.

/* Distribution of Proportion_Rowing within the two groups */

EXAMINE VARIABLES=Proportion_Rowing BY Condition
  /PLOT BOXPLOT NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

/* Mann-Whitney-U-test */

NPAR TESTS
  /M-W= Proportion_Rowing BY Condition_Num(0 1)
  /MISSING ANALYSIS.


/*** Initial checks ***/

/* Excluding the control group */

USE ALL.
COMPUTE filter_conditions=(Condition="Rower").
VARIABLE LABELS filter_conditions 'Condition="Rower" (FILTER)'.
VALUE LABELS filter_conditions 0 'Not Selected' 1 'Selected'.
FORMATS filter_conditions (f1.0).
FILTER BY filter_conditions.
EXECUTE.

/* Initial correlation check */

CORRELATIONS
  /VARIABLES=Proportion_Rowing Age Rowing_Experience_Years Days_Since_Rowed Times_PerWeek_Rowed
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

/* Looking at dependent and independent variable(s) */

EXAMINE VARIABLES=Proportion_Rowing Age Rowing_Experience_Years Days_Since_Rowed Times_PerWeek_Rowed    
  /PLOT BOXPLOT STEMLEAF HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.


/*** Linear Regression ***/

/* Full Regression */

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Proportion_Rowing
  /METHOD=ENTER Age Rowing_Experience_Years Days_Since_Rowed Times_PerWeek_Rowed
  /SCATTERPLOT=(*ZRESID ,*ZPRED) (*ZPRED ,Proportion_Rowing)
  /RESIDUALS HISTOGRAM(ZRESID)
  /SAVE COOK.

/* Reduced Regression */

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Proportion_Rowing
  /METHOD=BACKWARD Age Rowing_Experience_Years Days_Since_Rowed Times_PerWeek_Rowed
  /SCATTERPLOT=(*ZRESID ,*ZPRED) (*ZPRED ,Proportion_Rowing)
  /RESIDUALS HISTOGRAM(ZRESID)
  /SAVE COOK.


/*** Non-linear Regression ***/

/* Centering Age and Experience */

DESCRIPTIVES VARIABLES=Age Rowing_Experience_Years
  /STATISTICS=MEAN.

COMPUTE Age_Centered=Age-31.92.
EXECUTE.

COMPUTE Rowing_Experience_Centered=Rowing_Experience_Years-7.80.
EXECUTE.

COMPUTE Age_Centered_Squared=Age_Centered**2.
EXECUTE.

COMPUTE Rowing_Experience_Centered_Squared=Rowing_Experience_Centered**2.
EXECUTE.

/* Full Regression */

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Proportion_Rowing
  /METHOD=ENTER Age_Centered Age_Centered_Squared Rowing_Experience_Centered 
    Rowing_Experience_Centered_Squared Days_Since_Rowed Times_PerWeek_Rowed.

/* Reduced Regression */

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Proportion_Rowing
  /METHOD=BACKWARD Age_Centered Age_Centered_Squared Rowing_Experience_Centered 
    Rowing_Experience_Centered_Squared Days_Since_Rowed Times_PerWeek_Rowed.
