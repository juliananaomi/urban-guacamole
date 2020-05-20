Program Subprojeto_B

IMPLICIT REAL*8 (a-h,o-z) !dupla precisão
dimension at(1:3), v(1:2), res(1:2)	!vetores das variáveis
character(len=70) fn

at = (/0.01,0.001,0.0001/)	!avanço temporal
v = (/0.d0,10.d0/)			!velocidade inicial
res = (/0.1,0.01/)			!resistência do ar
				
ifilenum = 10

do i=1, 3
	do j=1, 2
		do k = 1, 2
			tv = 0			!tempo inicial
			ty = 0
			ypos = 100.d0	!posição inicial
			acel = -10.d0	!aceleração	inicial
			vel = v(j)		!velocidade inicial
			ifilenum = ifilenum + 1	!numeração dos arquivos
			print*,  'v=', v(j), 'res=', res(k),'at=', at(i), ifilenum
			write(fn,fmt='(i0,a)') ifilenum,'.dat'
			open(unit=ifilenum,file=fn)
			do while (ypos .ge. 0.d0)
				write(ifilenum,*) ty, ypos, tv, vel
				ty = ty + at(i)
				tv = ty - at(i)/2.d0
				ac = acel - res(k)*vel	!aceleração variável devido a resistência do ar
				if (tv .eq. (at(i)/2.d0)) then	!ajuste da primeira iteração
				vel = v(j) + (at(i)/2.d0)*ac
			else 
				vel = vel + at(i)*ac
			end if
				ypos = ypos + at(i)*vel
			end do
			close(ifilenum)
		end do
	end do	
end do
End Program Subprojeto_B
