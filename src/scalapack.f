!     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!     PDGESV:  Solve system AX=B
!     X --> B
!     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
      SUBROUTINE RPDGESV(A, B, ICTXT, MYROW, MYCOL,
     $                   DESCA, DESCB, N, NRHS,
     $                   MXLDIMS, INFO)

      INTEGER            IA, JA, IB, JB, N, NRHS, 
     $                   ICTXT, INFO, MYROW, MYCOL,
     $                   MXRHSC, MXLDIMS(4),
     $                   DESCA( 9 ), DESCB( 9 ),
     $                   IPIV ( MXLDIMS(1) + DESCA(6) )
      PARAMETER        ( IA = 1, JA = 1, IB = 1, JB = 1 )

      DOUBLE PRECISION   A( DESCA(9), * ), 
     $                   B( DESCB(9), MXLDIMS(4) )

      EXTERNAL           PDGESV

!     If I'm not in the process grid, go to the end of the program
      IF( MYROW.EQ.-1 )
     $   GO TO 10

!     Solve the linear system A * X = B
      CALL PDGESV( N, NRHS, 
     $             A, IA, JA, DESCA, IPIV, 
     $             B, IB, JB, DESCB, INFO )

   10 CONTINUE

      RETURN
      END
!
!     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!     PDGESVD:  Singular value decomposition
!     X --> B
!     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
!!!!!      ! First determine the size of LWORK.  Combining with the 
!!!!!      ! subroutine below causes bizarre memory deallocation errors.
!!!!!      SUBROUTINE RPDGESVDSZ(M, N, ASIZE, ICTXT, MYROW, MYCOL,
!!!!!     $                    DESCA, DESCU, DESCVT, TEMP, INFO, 
!!!!!     $                    JOBU, JOBVT)

!!!!!      INTEGER          :: LWORK = -1
!!!!!      INTEGER             M, N, ASIZE,
!!!!!     $                    DESCA( 9 ), DESCU( 9 ), DESCVT( 9 ),
!!!!!     $                    ICTXT, INFO, MYROW, MYCOL,
!!!!!     $                    IA, JA, IU, JU, IVT, JVT
!!!!!      PARAMETER         ( IA = 1, JA = 1, IU = 1, JU = 1,
!!!!!     $                    IVT = 1, JVT = 1 )

!!!!!      DOUBLE PRECISION    A( 1, 1 ), 
!!!!!     $                    D( 1 ),
!!!!!     $                    U( 1,1 ),
!!!!!     $                    VT( 1,1 )
!!!!!      DOUBLE PRECISION    TEMP( 1 )
!!!!!      
!!!!!      CHARACTER*1         JOBU, JOBVT

!!!!!      EXTERNAL            PDGESVD

!!!!!!     If I'm not in the process grid, go to the end of the program
!!!!!      IF( MYROW.EQ.-1 )
!!!!!     $   GO TO 10

!!!!!      CALL PDGESVD(JOBU, JOBVT, M, N, 
!!!!!     $            A, IA, JA, DESCA, 
!!!!!     $            D, 
!!!!!     $            U, IU, JU, DESCU, 
!!!!!     $            VT, IVT, JVT, DESCVT, 
!!!!!     $            TEMP, LWORK, INFO)

!!!!!   10 CONTINUE

!!!!!      RETURN
!!!!!      END
!!!!!      !
!!!!!      ! Calculation of SVD
!!!!!      !
!!!!!      SUBROUTINE RPDGESVD(M, N, ASIZE, ICTXT, MYROW, MYCOL,
!!!!!     $                    A, DESCA, D,
!!!!!     $                    U, DESCU, VT, DESCVT,
!!!!!     $                    INFO, LWORK, JOBU, JOBVT)

!!!!!      INTEGER             M, N, ASIZE,
!!!!!     $                    DESCA( 9 ), DESCU( 9 ), DESCVT( 9 ),
!!!!!     $                    ICTXT, INFO, MYROW, MYCOL,
!!!!!     $                    IA, JA, IU, JU, IVT, JVT
!!!!!      PARAMETER         ( IA = 1, JA = 1, IU = 1, JU = 1,
!!!!!     $                    IVT = 1, JVT = 1 )

!!!!!!      DOUBLE PRECISION    A( DESCA(9), * ), 
!!!!!!     $                    D( ASIZE ),
!!!!!!     $                    U( DESCU(9), * ),
!!!!!!     $                    VT( DESCVT(9), * )
!!!!!      DOUBLE PRECISION    A( * ), 
!!!!!     $                    D( * ),
!!!!!     $                    U( * ),
!!!!!     $                    VT( * )
!!!!!      DOUBLE PRECISION, ALLOCATABLE :: WORK(:)

!!!!!      CHARACTER*1         JOBU, JOBVT

!!!!!      EXTERNAL            PDGESVD

!!!!!!     If I'm not in the process grid, go to the end of the program
!!!!!      IF( MYROW.EQ.-1 )
!!!!!     $   GO TO 10

!!!!!      ALLOCATE (WORK(LWORK))
!!!!!      
!!!!!      CALL PDGESVD(JOBU, JOBVT, M, N, 
!!!!!     $            A, IA, JA, DESCA, 
!!!!!     $            D, 
!!!!!     $            U, IU, JU, DESCU, 
!!!!!     $            VT, IVT, JVT, DESCVT, 
!!!!!     $            WORK, LWORK, INFO)

!!!!!   10 CONTINUE

!!!!!      DEALLOCATE (WORK)

!!!!!      RETURN
!!!!!      END
!
!     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!     PDGETRI:  Invert matrix A
!     inv(A) --> A
!     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
      ! First calculate LWORK and LIWORK
      SUBROUTINE RPDGETRISZ( ICTXT, MYROW, MYCOL, DESCA, N, INFO,
     $                       TEMP, ITEMP )

      INTEGER              :: LWORK = -1
      INTEGER              :: LIWORK = -1
      INTEGER            IA, JA, N
     $                   ICTXT, INFO, MYROW, MYCOL,
     $                   DESCA( 9 ),
     $                   IPIV ( N + DESCA(6) ),
     $                   ITEMP( 1 )
      PARAMETER        ( IA = 1, JA = 1 )

      DOUBLE PRECISION   A( 1,1 ), 
     $                   TEMP( 1 )

      EXTERNAL           PDGETRI

!     If I'm not in the process grid, go to the end of the program
      IF( MYROW.EQ.-1 )
     $   GO TO 10

!     Determine LWORK and LIWORK
      CALL PDGETRI( N, A, IA, JA, DESCA,
     $              IPIV, TEMP, LWORK, ITEMP, LIWORK,
     $              INFO )

   10 CONTINUE

      RETURN
      END
      !
      ! Calculation of Inverse
      !
      SUBROUTINE RPDGETRI(A, ICTXT, MYROW, MYCOL,
     $                   DESCA, N,
     $                   INFO, LWORK, LIWORK)

      INTEGER, ALLOCATABLE :: IWORK(:)
      INTEGER            IA, JA, N, LWORK, LIWORK,
     $                   ICTXT, INFO, MYROW, MYCOL,
     $                   DESCA( 9 ),
     $                   IPIV ( N + DESCA(6) ),
     $                   LTEMP( 1 )
      PARAMETER        ( IA = 1, JA = 1 )

      DOUBLE PRECISION   A( DESCA(9), * ), 
     $                   TEMP( 1 )
      DOUBLE PRECISION, ALLOCATABLE :: WORK(:)

      EXTERNAL           PDGETRI, PDGETRF

!     If I'm not in the process grid, go to the end of the program
      IF( MYROW.EQ.-1 )
     $   GO TO 10

!     Compute LU decomposition
      CALL PDGETRF( N, N, A, IA, JA, DESCA,
     $              IPIV, INFO )

      ALLOCATE (WORK(LWORK))
      ALLOCATE (IWORK(LIWORK))

      CALL PDGETRI( N, A, IA, JA, DESCA,
     $              IPIV, WORK, LWORK, IWORK, LIWORK,
     $              INFO )

      DEALLOCATE(WORK)
      DEALLOCATE(IWORK)

   10 CONTINUE

      RETURN
      END
!
!     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!     PDGETRF:  Compute LU Factorization of matrix A
!     
!     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
      SUBROUTINE RPDGETRF(A, ICTXT, MYROW, MYCOL,
     $                   DESCA, M, N,
     $                   LIPIV, INFO)

      INTEGER            IA, JA, M, N, LIPIV,
     $                   ICTXT, INFO, MYROW, MYCOL,
     $                   DESCA( 9 ), 
     $                   IPIV ( LIPIV )
      PARAMETER        ( IA = 1, JA = 1 )

      DOUBLE PRECISION   A( DESCA(9), * )

      EXTERNAL           PDGETRF

!     If I'm not in the process grid, go to the end of the program
      IF( MYROW.EQ.-1 )
     $   GO TO 10

!     Compute LU decomposition
      CALL PDGETRF( M, N, A, IA, JA, DESCA,
     $              IPIV, INFO )

   10 CONTINUE

      RETURN
      END
!
!     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!     PDPOTRF:  Compute Cholesky factorization of symmetric, 
!             positive definite, distributed matrix A
!     
!     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
      SUBROUTINE RPDPOTRF( A, ICTXT, MYROW, MYCOL,
     $                   DESCA, N,
     $                   UPLO, INFO)

      INTEGER            IA, JA, N, INFO,
     $                   ICTXT, MYROW, MYCOL,
     $                   DESCA( 9 )
      PARAMETER        ( IA = 1, JA = 1 )

      DOUBLE PRECISION   A( DESCA(9), * )

      CHARACTER*1         UPLO

      EXTERNAL           PDPOTRF

!     If I'm not in the process grid, go to the end of the program
      IF( MYROW.EQ.-1 )
     $   GO TO 10

!     Compute LU decomposition
      CALL PDPOTRF( UPLO, N,
     $            A, IA, JA, DESCA,
     $            INFO )

   10 CONTINUE

      RETURN
      END

























!      SUBROUTINE PDGESVD(JOBU,JOBVT,M,N,A,IA,JA,DESCA,S,U,IU,JU,DESCU,
!     +                   VT,IVT,JVT,DESCVT,WORK,LWORK,INFO)
!*
!*  -- ScaLAPACK routine (version 1.7) --
!*     Univ. of Tennessee, Oak Ridge National Laboratory
!*     and Univ. of California Berkeley.
!*     Jan 2006

!*
!*     .. Scalar Arguments ..
!      CHARACTER JOBU,JOBVT
!      INTEGER IA,INFO,IU,IVT,JA,JU,JVT,LWORK,M,N
!*     ..
!*     .. Array Arguments ..
!      INTEGER DESCA(*),DESCU(*),DESCVT(*)
!      DOUBLE PRECISION A(*),U(*),VT(*),WORK(*)
!      DOUBLE PRECISION S(*)
!*
!*     .. Parameters ..
!      INTEGER BLOCK_CYCLIC_2D,DLEN_,DTYPE_,CTXT_,M_,N_,MB_,NB_,RSRC_,
!     +        CSRC_,LLD_,ITHVAL
!      PARAMETER (BLOCK_CYCLIC_2D=1,DLEN_=9,DTYPE_=1,CTXT_=2,M_=3,N_=4,
!     +          MB_=5,NB_=6,RSRC_=7,CSRC_=8,LLD_=9,ITHVAL=10)
!      DOUBLE PRECISION ZERO,ONE
!      PARAMETER (ZERO= (0.0D+0),ONE= (1.0D+0))
!*     ..
!*     .. Local Scalars ..
!      CHARACTER UPLO
!      INTEGER CONTEXTC,CONTEXTR,I,INDD,INDD2,INDE,INDE2,INDTAUP,INDTAUQ,
!     +        INDU,INDV,INDWORK,IOFFD,IOFFE,ISCALE,J,K,LDU,LDVT,LLWORK,
!     +        LWMIN,MAXIM,MB,MP,MYPCOL,MYPCOLC,MYPCOLR,MYPROW,MYPROWC,
!     +        MYPROWR,NB,NCVT,NPCOL,NPCOLC,NPCOLR,NPROCS,NPROW,NPROWC,
!     +        NPROWR,NQ,NRU,SIZE,SIZEB,SIZEP,SIZEPOS,SIZEQ,WANTU,WANTVT,
!     +        WATOBD,WBDTOSVD,WDBDSQR,WPDGEBRD,WPDLANGE,WPDORMBRPRT,
!     +        WPDORMBRQLN
!      DOUBLE PRECISION ANRM,BIGNUM,EPS,RMAX,RMIN,SAFMIN,SIGMA,SMLNUM
!*     ..
!*     .. Local Arrays ..
!      INTEGER DESCTU(DLEN_),DESCTVT(DLEN_),IDUM1(3),IDUM2(3)
!      DOUBLE PRECISION C(1,1)
!*     ..
!*     .. External Functions ..
!      LOGICAL LSAME
!      INTEGER NUMROC
!      DOUBLE PRECISION PDLAMCH,PDLANGE
!      EXTERNAL LSAME,NUMROC,PDLAMCH,PZLANGE
!*     ..
!*     .. External Subroutines ..
!      EXTERNAL BLACS_GET,BLACS_GRIDEXIT,BLACS_GRIDINFO,BLACS_GRIDINIT,
!     +         CHK1MAT,DBDSQR,DESCINIT,DGAMN2D,DGAMX2D,DSCAL,IGAMX2D,
!     +         IGEBR2D,IGEBS2D,PCHK1MAT,PDGEBRD,PDGEMR2D,PDLARED1D,
!     +         PDLARED2D,PDLASCL,PDLASET,PDORMBR,PXERBLA
!*     ..
!*     .. Intrinsic Functions ..
!      INTRINSIC MAX,MIN,SQRT,DBLE
!*     ..
!*     .. Executable Statements ..
!*     This is just to keep ftnchek happy
!      IF (BLOCK_CYCLIC_2D*DTYPE_*LLD_*MB_*M_*NB_*N_.LT.0) RETURN
!*
!      CALL BLACS_GRIDINFO(DESCA(CTXT_),NPROW,NPCOL,MYPROW,MYPCOL)
!      ISCALE = 0
!      INFO = 0
!*
!      IF (NPROW.EQ.-1) THEN
!          INFO = - (800+CTXT_)
!      ELSE
!*
!          SIZE = MIN(M,N)
!          SIZEB = MAX(M,N)
!          NPROCS = NPROW*NPCOL
!          IF (M.GE.N) THEN
!              IOFFD = JA - 1
!              IOFFE = IA - 1
!              SIZEPOS = 1
!          ELSE
!              IOFFD = IA - 1
!              IOFFE = JA - 1
!              SIZEPOS = 3
!          END IF
!*
!          IF (LSAME(JOBU,'V')) THEN
!              WANTU = 1
!          ELSE
!              WANTU = 0
!          END IF
!          IF (LSAME(JOBVT,'V')) THEN
!              WANTVT = 1
!          ELSE
!              WANTVT = 0
!          END IF
!*
!          CALL CHK1MAT(M,3,N,4,IA,JA,DESCA,8,INFO)
!          IF (WANTU.EQ.1) THEN
!              CALL CHK1MAT(M,3,SIZE,SIZEPOS,IU,JU,DESCU,13,INFO)
!          END IF
!          IF (WANTVT.EQ.1) THEN
!              CALL CHK1MAT(SIZE,SIZEPOS,N,4,IVT,JVT,DESCVT,17,INFO)
!          END IF
!          CALL IGAMX2D(DESCA(CTXT_),'A',' ',1,1,INFO,1,1,1,-1,-1,0)
!*
!          IF (INFO.EQ.0) THEN
!*
!*           Set up pointers into the WORK array.
!*
!              INDD = 2
!              INDE = INDD + SIZEB + IOFFD
!              INDD2 = INDE + SIZEB + IOFFE
!              INDE2 = INDD2 + SIZEB + IOFFD
!*
!              INDTAUQ = INDE2 + SIZEB + IOFFE
!              INDTAUP = INDTAUQ + SIZEB + JA - 1
!              INDWORK = INDTAUP + SIZEB + IA - 1
!              LLWORK = LWORK - INDWORK + 1
!*
!*           Initialize contexts for "column" and "row" process matrices.
!*
!              CALL BLACS_GET(DESCA(CTXT_),10,CONTEXTC)
!              CALL BLACS_GRIDINIT(CONTEXTC,'R',NPROCS,1)
!              CALL BLACS_GRIDINFO(CONTEXTC,NPROWC,NPCOLC,MYPROWC,
!     +                            MYPCOLC)
!              CALL BLACS_GET(DESCA(CTXT_),10,CONTEXTR)
!              CALL BLACS_GRIDINIT(CONTEXTR,'R',1,NPROCS)
!              CALL BLACS_GRIDINFO(CONTEXTR,NPROWR,NPCOLR,MYPROWR,
!     +                            MYPCOLR)
!*
!*           Set local dimensions of matrices (this is for MB=NB=1).
!*
!              NRU = NUMROC(M,1,MYPROWC,0,NPROCS)
!              NCVT = NUMROC(N,1,MYPCOLR,0,NPROCS)
!              NB = DESCA(NB_)
!              MB = DESCA(MB_)
!              MP = NUMROC(M,MB,MYPROW,DESCA(RSRC_),NPROW)
!              NQ = NUMROC(N,NB,MYPCOL,DESCA(CSRC_),NPCOL)
!              IF (WANTVT.EQ.1) THEN
!                  SIZEP = NUMROC(SIZE,DESCVT(MB_),MYPROW,DESCVT(RSRC_),
!     +                    NPROW)
!              ELSE
!                  SIZEP = 0
!              END IF
!              IF (WANTU.EQ.1) THEN
!                  SIZEQ = NUMROC(SIZE,DESCU(NB_),MYPCOL,DESCU(CSRC_),
!     +                    NPCOL)
!              ELSE
!                  SIZEQ = 0
!              END IF
!*
!*           Transmit MAX(NQ0, MP0).
!*
!              IF (MYPROW.EQ.0 .AND. MYPCOL.EQ.0) THEN
!                  MAXIM = MAX(NQ,MP)
!                  CALL IGEBS2D(DESCA(CTXT_),'All',' ',1,1,MAXIM,1)
!              ELSE
!                  CALL IGEBR2D(DESCA(CTXT_),'All',' ',1,1,MAXIM,1,0,0)
!              END IF
!*
!              WPDLANGE = MP
!              WPDGEBRD = NB* (MP+NQ+1) + NQ
!              WATOBD = MAX(MAX(WPDLANGE,WPDGEBRD),MAXIM)
!*
!              WDBDSQR = MAX(1,4*SIZE)
!              WPDORMBRQLN = MAX((NB* (NB-1))/2, (SIZEQ+MP)*NB) + NB*NB
!              WPDORMBRPRT = MAX((MB* (MB-1))/2, (SIZEP+NQ)*MB) + MB*MB
!              WBDTOSVD = SIZE* (WANTU*NRU+WANTVT*NCVT) +
!     +                   MAX(WDBDSQR,MAX(WANTU*WPDORMBRQLN,
!     +                   WANTVT*WPDORMBRPRT))
!*
!*           Finally, calculate required workspace.
!*
!              LWMIN = 1 + 6*SIZEB + MAX(WATOBD,WBDTOSVD)
!              WORK(1) = DBLE(LWMIN)
!*
!              IF (WANTU.NE.1 .AND. .NOT. (LSAME(JOBU,'N'))) THEN
!                  INFO = -1
!              ELSE IF (WANTVT.NE.1 .AND. .NOT. (LSAME(JOBVT,'N'))) THEN
!                  INFO = -2
!              ELSE IF (LWORK.LT.LWMIN .AND. LWORK.NE.-1) THEN
!                  INFO = -19
!              END IF
!*
!          END IF
!*
!          IDUM1(1) = WANTU
!          IDUM1(2) = WANTVT
!          IF (LWORK.EQ.-1) THEN
!              IDUM1(3) = -1
!          ELSE
!              IDUM1(3) = 1
!          END IF
!          IDUM2(1) = 1
!          IDUM2(2) = 2
!          IDUM2(3) = 19
!          CALL PCHK1MAT(M,3,N,4,IA,JA,DESCA,8,3,IDUM1,IDUM2,INFO)
!          IF (INFO.EQ.0) THEN
!              IF (WANTU.EQ.1) THEN
!                  CALL PCHK1MAT(M,3,SIZE,4,IU,JU,DESCU,13,0,IDUM1,IDUM2,
!     +                          INFO)
!              END IF
!              IF (WANTVT.EQ.1) THEN
!                  CALL PCHK1MAT(SIZE,3,N,4,IVT,JVT,DESCVT,17,0,IDUM1,
!     +                          IDUM2,INFO)
!              END IF
!          END IF
!*
!      END IF
!*
!      IF (INFO.NE.0) THEN
!          CALL PXERBLA(DESCA(CTXT_),'PDGESVD',-INFO)
!          RETURN
!      ELSE IF (LWORK.EQ.-1) THEN
!          GO TO 40
!      END IF
!*
!*     Quick return if possible.
!*
!      IF (M.LE.0 .OR. N.LE.0) GO TO 40
!*
!*     Get machine constants.
!*
!      SAFMIN = PDLAMCH(DESCA(CTXT_),'Safe minimum')
!      EPS = PDLAMCH(DESCA(CTXT_),'Precision')
!      SMLNUM = SAFMIN/EPS
!      BIGNUM = ONE/SMLNUM
!      RMIN = SQRT(SMLNUM)
!      RMAX = MIN(SQRT(BIGNUM),ONE/SQRT(SQRT(SAFMIN)))
!*
!*     Scale matrix to allowable range, if necessary.
!*
!      ANRM = PDLANGE('1',M,N,A,IA,JA,DESCA,WORK(INDWORK))
!      IF (ANRM.GT.ZERO .AND. ANRM.LT.RMIN) THEN
!          ISCALE = 1
!          SIGMA = RMIN/ANRM
!      ELSE IF (ANRM.GT.RMAX) THEN
!          ISCALE = 1
!          SIGMA = RMAX/ANRM
!      END IF
!*
!      IF (ISCALE.EQ.1) THEN
!          CALL PDLASCL('G',ONE,SIGMA,M,N,A,IA,JA,DESCA,INFO)
!      END IF
!*
!      CALL PDGEBRD(M,N,A,IA,JA,DESCA,WORK(INDD),WORK(INDE),
!     +             WORK(INDTAUQ),WORK(INDTAUP),WORK(INDWORK),LLWORK,
!     +             INFO)
!*
!*     Copy D and E to all processes.
!*     Array D is in local array of dimension:
!*     LOCc(JA+MIN(M,N)-1) if M >= N; LOCr(IA+MIN(M,N)-1) otherwise.
!*     Array E is in local array of dimension
!*     LOCr(IA+MIN(M,N)-1) if M >= N; LOCc(JA+MIN(M,N)-2) otherwise.
!*
!      IF (M.GE.N) THEN
!*        Distribute D
!          CALL PDLARED1D(N+IOFFD,IA,JA,DESCA,WORK(INDD),WORK(INDD2),
!     +                   WORK(INDWORK),LLWORK)
!*        Distribute E
!          CALL PDLARED2D(M+IOFFE,IA,JA,DESCA,WORK(INDE),WORK(INDE2),
!     +                   WORK(INDWORK),LLWORK)
!      ELSE
!*        Distribute D
!          CALL PDLARED2D(M+IOFFD,IA,JA,DESCA,WORK(INDD),WORK(INDD2),
!     +                   WORK(INDWORK),LLWORK)
!*        Distribute E
!          CALL PDLARED1D(N+IOFFE,IA,JA,DESCA,WORK(INDE),WORK(INDE2),
!     +                   WORK(INDWORK),LLWORK)
!      END IF
!*
!*     Prepare for calling PDBDSQR.
!*
!      IF (M.GE.N) THEN
!          UPLO = 'U'
!      ELSE
!          UPLO = 'L'
!      END IF
!*
!      INDU = INDWORK
!      INDV = INDU + SIZE*NRU*WANTU
!      INDWORK = INDV + SIZE*NCVT*WANTVT
!*
!      LDU = MAX(1,NRU)
!      LDVT = MAX(1,SIZE)
!*
!      CALL DESCINIT(DESCTU,M,SIZE,1,1,0,0,CONTEXTC,LDU,INFO)
!      CALL DESCINIT(DESCTVT,SIZE,N,1,1,0,0,CONTEXTR,LDVT,INFO)
!*
!      IF (WANTU.EQ.1) THEN
!          CALL PDLASET('Full',M,SIZE,ZERO,ONE,WORK(INDU),1,1,DESCTU)
!      ELSE
!          NRU = 0
!      END IF
!*
!      IF (WANTVT.EQ.1) THEN
!          CALL PDLASET('Full',SIZE,N,ZERO,ONE,WORK(INDV),1,1,DESCTVT)
!      ELSE
!          NCVT = 0
!      END IF
!*
!      CALL DBDSQR(UPLO,SIZE,NCVT,NRU,0,WORK(INDD2+IOFFD),
!     +            WORK(INDE2+IOFFE),WORK(INDV),SIZE,WORK(INDU),LDU,C,1,
!     +            WORK(INDWORK),INFO)
!*
!*     Redistribute elements of U and VT in the block-cyclic fashion.
!*
!      IF (WANTU.EQ.1) CALL PDGEMR2D(M,SIZE,WORK(INDU),1,1,DESCTU,U,IU,
!     +                              JU,DESCU,DESCU(CTXT_))
!*
!      IF (WANTVT.EQ.1) CALL PDGEMR2D(SIZE,N,WORK(INDV),1,1,DESCTVT,VT,
!     +                               IVT,JVT,DESCVT,DESCVT(CTXT_))
!*
!*     Set to ZERO "non-square" elements of the larger matrices U, VT.
!*
!      IF (M.GT.N .AND. WANTU.EQ.1) THEN
!          CALL PDLASET('Full',M-SIZE,SIZE,ZERO,ZERO,U,IA+SIZE,JU,DESCU)
!      ELSE IF (N.GT.M .AND. WANTVT.EQ.1) THEN
!          CALL PDLASET('Full',SIZE,N-SIZE,ZERO,ZERO,VT,IVT,JVT+SIZE,
!     +                 DESCVT)
!      END IF
!*
!*     Multiply Householder rotations from bidiagonalized matrix.
!*
!      IF (WANTU.EQ.1) CALL PDORMBR('Q','L','N',M,SIZE,N,A,IA,JA,DESCA,
!     +                             WORK(INDTAUQ),U,IU,JU,DESCU,
!     +                             WORK(INDWORK),LLWORK,INFO)
!*
!      IF (WANTVT.EQ.1) CALL PDORMBR('P','R','T',SIZE,N,M,A,IA,JA,DESCA,
!     +                              WORK(INDTAUP),VT,IVT,JVT,DESCVT,
!     +                              WORK(INDWORK),LLWORK,INFO)
!*
!*     Copy singular values into output array S.
!*
!      DO 10 I = 1,SIZE
!          S(I) = WORK(INDD2+IOFFD+I-1)
!   10 CONTINUE
!*
!*     If matrix was scaled, then rescale singular values appropriately.
!*
!      IF (ISCALE.EQ.1) THEN
!          CALL DSCAL(SIZE,ONE/SIGMA,S,1)
!      END IF
!*
!*     Compare every ith eigenvalue, or all if there are only a few,
!*     across the process grid to check for heterogeneity.
!*
!      IF (SIZE.LE.ITHVAL) THEN
!          J = SIZE
!          K = 1
!      ELSE
!          J = SIZE/ITHVAL
!          K = ITHVAL
!      END IF
!*
!      DO 20 I = 1,J
!          WORK(I+INDE) = S((I-1)*K+1)
!          WORK(I+INDD2) = S((I-1)*K+1)
!   20 CONTINUE
!*
!      CALL DGAMN2D(DESCA(CTXT_),'a',' ',J,1,WORK(1+INDE),J,1,1,-1,-1,0)
!      CALL DGAMX2D(DESCA(CTXT_),'a',' ',J,1,WORK(1+INDD2),J,1,1,-1,-1,0)
!*
!      DO 30 I = 1,J
!          IF ((WORK(I+INDE)-WORK(I+INDD2)).NE.ZERO) THEN
!              INFO = SIZE + 1
!          END IF
!   30 CONTINUE
!*
!   40 CONTINUE
!*
!      CALL BLACS_GRIDEXIT(CONTEXTC)
!      CALL BLACS_GRIDEXIT(CONTEXTR)
!*
!*     End of PDGESVD
!*
!      RETURN
!      END
