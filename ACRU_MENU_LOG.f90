!###################################################################
! TITLE        : ACRU_MENU_LOG
!-------------------------------------------------------------------
! CREATED BY   : CHARMAINE BONIFACIO
! DATE CREATED : NOVEMBER 25, 2014
! DATE REVISED : JULY 31, 2015
!-------------------------------------------------------------------
! DESCRIPTION  : THIS IS A TEST RUN FOR IMPLEMENTING THE LOGFILE
!                SYSTEM.
! REQUIREMENT  : MUST RUN THE .EXE FILE WITHIN THE INPUT DIRECTORY.
! MODULES      : MUST INCLUDE M_SYSTEMCHECK AND M_SYSTEMLOG
! INPUT        : 1) MENU FILE = MENU
!                2) VARIABLE FILE = MENU_VARIABLE.TXT
! OUTPUT       : 1) LOG FILE
!                2) UPDATED MENU FILE
!###################################################################
program acru_menu_log
use m_systemcheck
use m_systemlog
implicit none

character(len=4), parameter :: menu = 'MENU'
character(len=*), parameter :: menuvars = 'menu_variable.txt'
character(len=*), parameter:: format_etime = '(1X, A11, A20, F10.5)'
character(len=*), parameter:: format_logfile = '(1X, A11, A20, A30)'
character(len=*), parameter:: format_logstat = '(1X, A11, A20, A20)'
character(len=*), parameter:: format_daytime = '(1X, A11, A20, A15)'
character(len=*), parameter:: format_filestat = '(1X, A11, A20, I4)'
character(len=*), parameter:: format_endmsg = '( A75,A10,A3,A5 )'
character(len=30) :: outfile, infile, logrun, varfile
character(len=80) :: dum, dum2, msg
character(len=10) :: date, date_now, date_end
character(len=12) :: time_now, time_end
integer :: count_0, count_1, count_rate, count_max
integer :: i, p, ok
logical :: ex
real :: elapsed_time

!***********************************************************************
! START PROGRAM - DAY & TIME SETUP AND LOGFILE SETUP
    call system_clock(count_0, count_rate, count_max)
    call datetimelog(date, date_now, time_now)
    logrun = 'LOGRUN_MENU_'//date//'.txt'
    inquire(file=logrun, exist=ex)
    write(*,*) debugStat, ' checking file: ', logrun
    if (ex) then
        open(unit=12,file=logrun,status='replace',iostat=ok)
    else
        open(unit=12,file=logrun,status='new',iostat=ok)
    endif
    call startprogramlog(12)
    write(12,format_daytime) debugLog, dayStat, date_now
    write(12,format_daytime) debugLog, timeStat, time_now
    write(12,*)
    write(12,format_logfile) debugLog, logfileStat, logrun
    write(12,format_filestat) debugLog, fileStat, ok
    write(12,*)
    write(12,*) '[ C R E A T I N G   M E N U   F I L E ] '
    write(12,*)
    infile = menu
    outfile = menu//'_OLD'
    call system( "copy " // infile // " " // outfile)
    call system( "copy " // infile // " " // 'ORIGINAL_'//menu)
    write(12,*) debugStat, ' COPIED MENU FILE AND RENAMED TO MENU_OLD. '
    varfile = menuvars
    open(unit=11,file=varfile,iostat=ok)
    write(12,*) '>> PROCESSING VARIABLE FILE...'
    call filestatcheck(ok,12)
    write(12,format_logstat) debugStat, fileNameOpened, varfile
    write(12,format_filestat) debugStat, fileStat, ok
    write(12,*)
    open(unit=20,file=outfile,iostat=ok)
    write(12,*) '>> PROCESSING MENU_OLD COPY OF MENU FILE.'
    call filestatcheck(ok,12)
    write(12,format_logstat) debugStat, fileNameOpened, outfile
    write(12,format_filestat) debugStat, fileStat, ok
    write(12,*)
    open(unit=30,file=infile,iostat=ok)
    write(12,*) '>> PROCESSING WORKING COPY OF MENU FILE.'
    call filestatcheck(ok,12)
    write(12,format_logstat) debugStat, fileNameOpened, infile
    write(12,format_filestat) debugStat, fileStat, ok
    write(12,*)
    msg = ' MENU CALIBRATED & CREATED BY CHARMAINE BONIFACIO. MENU SCRIPT VERSION --- '
    write(30,format_endmsg) msg, date, ' | ', time_now
    endfile(30)
    close(30)
!***********************************************************************
! END PROGRAM - ELAPSED TIME
    call system_clock(count_1, count_rate, count_max)
    call datetimelog(date, date_end, time_end)
    write(12,format_daytime) debugStat, dayStat, date_end
    write(12,format_daytime) debugStat, timeStat, time_end
    call elapsedtime(elapsed_time, count_0, count_1, count_rate)
    write(12,format_etime) debugStat, etimeStat, elapsed_time
    call endprogramlog(12)
    close(12)

end program acru_menu_log
