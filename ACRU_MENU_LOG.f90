!###################################################################
! TITLE        : ACRU_MENU_LOG
!-------------------------------------------------------------------
! CREATED BY   : CHARMAINE BONIFACIO
! DATE REVISED : JULY 30, 2015
!-------------------------------------------------------------------
! DESCRIPTION  : THIS IS A TEST RUN FOR IMPLEMENTING THE LOGFILE
!                SYSTEM.
! REQUIREMENT  : MUST RUN THE .EXE FILE WITHIN THE INPUT DIRECTORY.
! INPUT        : 1) MENU FILE = MENU
!                2) VARIABLE FILE = MENU_VARIABLE.TXT
! OUTPUT       : 1) LOG FILE
!                2) UPDATED MENU FILE
!###################################################################
program acru_menu_log
use m_systemcheck
use m_systemlog
implicit none

character(len=10), parameter :: debugstat = '[ status ] '
character(len=10), parameter :: debugres = '[ result ] '
character(len=10), parameter :: debugask = '[  ask  ] '
integer :: line,i,j,k,l,m,n,o,p,ok,iocheck
integer :: isubno
integer :: count_0, count_1, count_rate, count_max
character(len=4), parameter :: menu = 'menu'
character(len=50), parameter :: menuvars = "menu_variable.txt"
character(len=200) :: outfile, infile, varfile, tmpfile, logrun
character(len=200) :: menucopy, menutmp, dir, copyfile, killfile
character(len=80) :: dummy
character(len=8) :: dateinfo
character(len=4) :: year, month*2, day*2
character(len=2) :: hrs, min, sec*6
character(len=10) :: date, timeinfo, timenow*12, datenow, timeend*12, dateend
logical :: ex

!***********************************************************************
! SETUP PROGRAM TIME
!***********************************************************************
      call system_clock(count_0, count_rate, count_max)
      call datetimelog(date, datenow, timenow)
!***********************************************************************
! START PROGRAM
!***********************************************************************
      call startprogramlog(12)
      write(*,*) debugstat, ' date of log  -> ', datenow
      write(*,*) debugstat, ' time of log  -> ', timenow
      write(*,*)
      logrun = 'logrun_menu_'//date//'.txt'
      inquire(file=logrun, exist=ex)
      write(*,*) debugstat, ' checking file: ', logrun
      if (ex) then
        open(unit=12,file=logrun,status='replace',iostat=ok)
      else
        open(unit=12,file=logrun,status='new',iostat=ok)
      endif
!     if (ok/=0) then
!       write(*,*) debugres, 'could not open file.'
!       stop
!     endif
      write(*,*) debugres, ' file opened: ', logrun
      write(*,*) debugres, ' file status ok = ', ok
      write(12,*)
!***********************************************************************
! START LOG
!***********************************************************************
      write(12,*) debugstat, ' date -> ', datenow
      write(12,*) debugstat, ' time -> ', timenow
      write(12,*)
      write(12,*) debugstat, ' logfile -> ', logrun
      write(12,*) debugstat, ' status -> ', ok
      varfile = menuvars
      open(unit=10,file=varfile,iostat=ok)
      write(12,*) debugstat, ' variable file -> ', varfile
      write(12,*) debugstat, ' status -> ', ok
      outfile = menu
      open(unit=20,file=outfile,iostat=ok)
      write(12,*) debugstat, ' menufile -> ', outfile
      write(12,*) debugstat, ' status -> ', ok
      menucopy = menu//'_old'
      call system( "copy " // outfile // " " // menucopy)
      open(unit=30,file=menucopy,iostat=ok)
      write(12,*) debugstat, ' menufile copy -> ', menucopy
      write(12,*) debugstat, ' status -> ', ok
      close(10)
  999 close(30)
      close(20)
!***********************************************************************
! ELAPSED TIME
!***********************************************************************
      call system_clock(count_1, count_rate, count_max)
      call datetimelog(date, dateend, timeend)
!***********************************************************************
! END PROGRAM
!***********************************************************************
      call endprogramlog(12)
      close(12)
   	  stop
end program acru_menu_log
