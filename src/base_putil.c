#include <R.h>
#include <Rinternals.h>
#include "base_global.h"

SEXP R_MKSUBMAT(SEXP GBLX, SEXP LDIM, SEXP DESCX)
{
  SEXP SUBX;
  PROTECT(SUBX = allocMatrix(REALSXP, INTEGER(LDIM)[0], INTEGER(LDIM)[1]));
  
  mksubmat_(REAL(GBLX), REAL(SUBX), INTEGER(DESCX));
  
  UNPROTECT(1);
  return SUBX;
} 


SEXP R_MKGBLMAT(SEXP SUBX, SEXP DESCX, SEXP RDEST, SEXP CDEST)
{
  SEXP GBLX;
  PROTECT(GBLX = allocMatrix(REALSXP, INTEGER(DESCX)[2], INTEGER(DESCX)[3]));
  
  mkgblmat_(REAL(GBLX), REAL(SUBX), INTEGER(DESCX), INTEGER(RDEST), 
    INTEGER(CDEST));
  
  UNPROTECT(1);
  return GBLX;
} 


SEXP R_DALLREDUCE(SEXP X, SEXP LDIM, SEXP DESCX, SEXP OP, SEXP SCOPE)
{
  const int ictxt = INTEGER(DESCX)[1];
  const int m = INTEGER(DESCX)[2], n = INTEGER(DESCX)[3];
  
  SEXP CPX;
  PROTECT(CPX = allocMatrix(REALSXP, INTEGER(LDIM)[0], INTEGER(LDIM)[1]));
  
  memcpy(REAL(CPX), REAL(X), m*n*sizeof(double));
  
  dallreduce_(REAL(CPX), INTEGER(DESCX), CHARPT(OP, 0), CHARPT(SCOPE, 0));
  
  UNPROTECT(1);
  return CPX;
} 


SEXP R_PTRI2ZERO(SEXP UPLO, SEXP DIAG, SEXP X, SEXP LDIM, SEXP DESCX)
{
  const int m = INTEGER(LDIM)[0], n = INTEGER(LDIM)[1];
  
  SEXP CPX;
  PROTECT(CPX = allocMatrix(REALSXP, m, n));
  
  memcpy(REAL(CPX), REAL(X), m*n*sizeof(double));
  
  ptri2zero_(CHARPT(UPLO, 0), CHARPT(DIAG, 0), REAL(CPX), INTEGER(DESCX));
  
  UNPROTECT(1);
  return CPX;
}


SEXP R_PDSWEEP(SEXP X, SEXP LDIM, SEXP DESCX, SEXP VEC, SEXP LVEC, SEXP MARGIN, SEXP FUN)
{
  const int m = INTEGER(LDIM)[0], n = INTEGER(LDIM)[1];
  const int IJ = 1;
  
  SEXP CPX;
  PROTECT(CPX = allocMatrix(REALSXP, m, n));
  
  memcpy(REAL(CPX), REAL(X), m*n*sizeof(double));
  
  pdsweep_(REAL(CPX), &IJ, &IJ, INTEGER(DESCX), REAL(VEC), INTEGER(LVEC), 
    INTEGER(MARGIN), CHARPT(FUN, 0));
  
  UNPROTECT(1);
  return CPX;
}


SEXP R_RL2BLAS(SEXP X, SEXP LDIM, SEXP DESCX, SEXP VEC, SEXP LVEC, SEXP FUN)
{
  const int m = INTEGER(LDIM)[0], n = INTEGER(LDIM)[1];
  const int IJ = 1;
  
  SEXP CPX;
  PROTECT(CPX = allocMatrix(REALSXP, m, n));
  
  memcpy(REAL(CPX), REAL(X), m*n*sizeof(double));
  
  rl2blas_(REAL(CPX), &IJ, &IJ, INTEGER(DESCX), REAL(VEC), INTEGER(LVEC), INTEGER(FUN));
  
  UNPROTECT(1);
  return CPX;
}


SEXP R_RL2INSERT(SEXP X, SEXP LDIM, SEXP DESCX, SEXP VEC, SEXP LVEC, SEXP INDI, SEXP LINDI, SEXP INDJ, SEXP LINDJ)
{
  const int m = INTEGER(LDIM)[0], n = INTEGER(LDIM)[1];
  const int IJ = 1;
  
  SEXP CPX;
  PROTECT(CPX = allocMatrix(REALSXP, m, n));
  
  memcpy(REAL(CPX), REAL(X), m*n*sizeof(double));
  
  rl2insert_(REAL(CPX), &IJ, &IJ, INTEGER(DESCX), REAL(VEC), INTEGER(LVEC), 
    INTEGER(INDI), INTEGER(LINDI), INTEGER(INDJ), INTEGER(LINDJ));
  
  UNPROTECT(1);
  return CPX;
}


SEXP R_PDDIAGTK(SEXP X, SEXP LDIM, SEXP DESCX, SEXP LDIAG)
{
  const int IJ = 1;
  
  SEXP DIAG;
  PROTECT(DIAG = allocVector(REALSXP, INTEGER(LDIAG)[0]));
  
  pddiagtk_(REAL(X), &IJ, &IJ, INTEGER(DESCX), REAL(DIAG));
  
  UNPROTECT(1);
  return DIAG;
}


SEXP R_PDDIAGMK(SEXP LDIM, SEXP DESCX, SEXP DIAG, SEXP LDIAG)
{
  const int m = INTEGER(LDIM)[0], n = INTEGER(LDIM)[1];
  const int IJ = 1;
  
  SEXP X;
  PROTECT(X = allocMatrix(REALSXP, m, n));
  
  pddiagmk_(REAL(X), &IJ, &IJ, INTEGER(DESCX), REAL(DIAG), INTEGER(LDIAG));
  
  UNPROTECT(1);
  return X;
}


SEXP R_RCOLCPY(SEXP X, SEXP LDIM, SEXP DESCX, SEXP XCOL, SEXP Y, SEXP DESCY, SEXP YCOL, SEXP LCOLS)
{
  const int m = INTEGER(LDIM)[0], n = INTEGER(LDIM)[1];
  
  SEXP CPX;
  PROTECT(CPX = allocMatrix(REALSXP, m, n));
  
  memcpy(REAL(CPX), REAL(X), m*n*sizeof(double));
  
  rcolcpy_(REAL(CPX), INTEGER(DESCX), INTEGER(XCOL), REAL(Y), 
    INTEGER(DESCY), INTEGER(YCOL), INTEGER(LCOLS));
  
  UNPROTECT(1);
  return CPX;
}

SEXP R_RROWCPY(SEXP X, SEXP LDIM, SEXP DESCX, SEXP XROW, SEXP Y, SEXP DESCY, SEXP YROW, SEXP LROWS)
{
  const int m = INTEGER(LDIM)[0], n = INTEGER(LDIM)[1];
  
  SEXP CPX;
  PROTECT(CPX = allocMatrix(REALSXP, m, n));
  
  memcpy(REAL(CPX), REAL(X), m*n*sizeof(double));
  
  rcolcpy_(REAL(CPX), INTEGER(DESCX), INTEGER(XROW), REAL(Y), 
    INTEGER(DESCY), INTEGER(YROW), INTEGER(LROWS));
  
  UNPROTECT(1);
  return CPX;
}

