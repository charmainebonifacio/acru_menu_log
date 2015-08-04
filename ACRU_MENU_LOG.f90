!###################################################################
! TITLE        : ACRU_MENU_LOG
!-------------------------------------------------------------------
! CREATED BY   : Charmaine Bonifacio
! DATE REVISED : July 27, 2015
!-------------------------------------------------------------------
! DESCRIPTION  : This is a test run for implementing the logfile
!                system.
! REQUIREMENT  : MUST run the .EXE file within the input directory.
! INPUT        : 1) MENU FILE = MENU
!                2) VARIABLE FILE = menu_variable.txt
! OUTPUT       : 1) LOG File
!                2) Updated Menu File
!###################################################################
PROGRAM ACRU_MENU_LOG
USE M_SYSTEMCHECKS
USE M_LOGSYSTEM
IMPLICIT NONE
CHARACTER(LEN=10), PARAMETER :: debugSTAT = '[ STATUS ] '
CHARACTER(LEN=10), PARAMETER :: debugRES = '[ RESULT ] '
CHARACTER(LEN=10), PARAMETER :: debugASK = '[  ASK  ] '
INTEGER :: LINE,I,J,K,L,M,N,O,P,OK,IOcheck
INTEGER :: ISUBNO
INTEGER :: COUNT_0, COUNT_1, COUNT_RATE, COUNT_MAX
CHARACTER(LEN=4), PARAMETER :: MENU = 'MENU'
CHARACTER(LEN=50), PARAMETER :: MENUVARS = "menu_variable.txt"
CHARACTER(LEN=200) :: OUTFILE, INFILE, VARFILE, TMPFILE, LOGRUN
CHARACTER(LEN=200) :: MENUCOPY, MENUTMP, DIR, COPYFILE, KILLFILE
CHARACTER(LEN=80) :: DUMMY
CHARACTER(LEN=8) :: DATEINFO
CHARACTER(LEN=4) :: YEAR, MONTH*2, DAY*2
CHARACTER(LEN=2) :: HRS, MIN, SEC*6
CHARACTER(LEN=10) :: DATE, TIMEINFO, TIMENOW*12, DATENOW, TIMEEND*12, DATEEND
LOGICAL :: EX
!***********************************************************************
! Setup Program Time
!***********************************************************************
      CALL SYSTEM_CLOCK(COUNT_0, COUNT_RATE, COUNT_MAX)
      CALL DATETIMELOG(DATE, DATENOW, TIMENOW)
!***********************************************************************
! START PROGRAM
!***********************************************************************
      WRITE(*,*)
      WRITE(*,*) "###################################################################"
      WRITE(*,*) ' '
      WRITE(*,*) ' The ACRU_MENU program will COPY values from a tab-delimited file. '
      WRITE(*,*) ' '
      WRITE(*,*) "###################################################################"
      WRITE(*,*)
!***********************************************************************
! USER INPUT
!***********************************************************************
	  WRITE(*,*) debugSTAT, ' Date of log  -> ', DATENOW
      WRITE(*,*) debugSTAT, ' Time of log  -> ', TIMENOW
      WRITE(*,*)
      LOGRUN = 'LOGRUN_MENU_'//DATE//'.txt'
      INQUIRE(FILE=LOGRUN, EXIST=EX)
      WRITE(*,*) debugSTAT, ' Checking file: ', LOGRUN
      IF (EX) THEN
        OPEN(UNIT=12,FILE=LOGRUN,STATUS='REPLACE',IOSTAT=OK)
      ELSE
        OPEN(UNIT=12,FILE=LOGRUN,STATUS='NEW',IOSTAT=OK)
      ENDIF
!     IF (OK/=0) THEN
!       WRITE(*,*) debugRES, 'COULD NOT OPEN FILE.'
!       STOP
!     ENDIF
	    WRITE(*,*) debugRES, ' File opened: ', LOGRUN
	    WRITE(*,*) debugRES, ' File status ok = ', OK
      WRITE(12,*)
!***********************************************************************
! START LOG
!***********************************************************************
      CALL STARTPROGRAMLOG(12)
	    WRITE(12,*) debugSTAT, ' DATE -> ', DATENOW
      WRITE(12,*) debugSTAT, ' TIME -> ', TIMENOW
      WRITE(12,*)
      WRITE(12,*) debugSTAT, ' LOGFILE -> ', LOGRUN
      WRITE(12,*) debugSTAT, ' STATUS -> ', OK
      VARFILE = MENUVARS
	    OPEN(UNIT=10,FILE=VARFILE,IOSTAT=OK)
	    WRITE(*,*) debugRES, ' File opened: ', VARFILE
	    WRITE(*,*) debugRES, ' File status ok = ', OK
      WRITE(12,*) debugSTAT, ' VARIABLE FILE -> ', VARFILE
      WRITE(12,*) debugSTAT, ' STATUS -> ', OK
      OUTFILE = MENU
	    OPEN(UNIT=20,FILE=OUTFILE,IOSTAT=OK)
      WRITE(*,*) debugRES, ' File opened: ', OUTFILE
	    WRITE(*,*) debugRES, ' File status ok = ', OK
      WRITE(12,*) debugSTAT, ' MENUFILE -> ', OUTFILE
      WRITE(12,*) debugSTAT, ' STATUS -> ', OK
      MENUCOPY = MENU//'_OLD'
      CALL SYSTEM( "copy " // OUTFILE // " " // MENUCOPY)
      OPEN(UNIT=30,FILE=MENUCOPY,IOSTAT=OK)
      WRITE(*,*) debugRES, ' File opened: ', MENUCOPY
	    WRITE(*,*) debugRES, ' File status ok = ', OK
      WRITE(12,*) debugSTAT, ' MENUFILE COPY -> ', MENUCOPY
      WRITE(12,*) debugSTAT, ' STATUS -> ', OK
      CLOSE(10)
  999 CLOSE(30)
      CLOSE(20)
!***********************************************************************
! ELAPSED TIME
!***********************************************************************
      CALL SYSTEM_CLOCK(COUNT_1, COUNT_RATE, COUNT_MAX)
      CALL DATETIMELOG(DATE, DATEEND, TIMEEND)
!***********************************************************************
! END PROGRAM
!***********************************************************************
      CALL ENDPROGRAMLOG(12)
      CLOSE(12)
      WRITE(*,*) "###################################################################"
      WRITE(*,*) ' '
      WRITE(*,*) '   The ACRU_MENU program has finished creating a new menu file. '
      WRITE(*,*) ' '
      WRITE(*,*) "###################################################################"
      WRITE(*,*)
      WRITE(*,*) 'END OF PROGRAM. '
   	  STOP
END PROGRAM ACRU_MENU_LOG
