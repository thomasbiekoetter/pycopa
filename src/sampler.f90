module pycopa__sampler

  use copa__sampler, only : run_sampler
  use evortran__util_kinds, only : wp
  use evortran__prng_rand, only : initialize_rands
  use iso_c_binding

  implicit none

  private

  logical(c_bool), private, parameter :: c_true = .true._c_bool
  logical, private :: rand_initialized = .false.

  public :: run_sampler_c

  interface

    function log_prior_py(theta) bind(C)
      import c_double
      real(c_double), intent(in) :: theta(*)
      real(c_double) :: log_prior_py
    end function log_prior_py

    function log_like_py(theta) bind(C)
      import c_double
      real(c_double), intent(in) :: theta(*)
      real(c_double) :: log_like_py
    end function log_like_py

  end interface

contains

  subroutine run_sampler_c(  &
    ndim, log_prior_ptr, log_like_ptr,  &
    lower_lims, upper_lims,  &
    nwalkers, nsteps,  &
    walkers, chains, log_probs)  &
    bind(C, name="pycopa__sampler_run_sampler_c")

    integer(c_int), value, intent(in) :: ndim
    type(c_funptr), value, intent(in) :: log_prior_ptr
    type(c_funptr), value, intent(in) :: log_like_ptr
    real(c_double), intent(in) :: lower_lims(ndim)
    real(c_double), intent(in) :: upper_lims(ndim)
    integer(c_int), value, intent(in) :: nwalkers
    integer(c_int), value, intent(in) :: nsteps
    real(c_double), intent(out) :: walkers(ndim, nwalkers)
    real(c_double), intent(out) :: chains(ndim, nwalkers, nsteps)
    real(c_double), intent(out) :: log_probs(nwalkers, nsteps)

    procedure(log_prior_py), pointer :: log_prior
    procedure(log_like_py), pointer :: log_like
    real(wp), allocatable :: ranges_wp(:, :)
    real(wp), allocatable :: walkers_wp(:, :)
    real(wp), allocatable :: chains_wp(:, :, :)
    real(wp), allocatable :: log_probs_wp(:, :)
    integer :: i
    integer :: j
    integer :: k

    call c_f_procpointer(log_prior_ptr, log_prior)
    call c_f_procpointer(log_like_ptr, log_like)

    if (.not. rand_initialized) then
      call initialize_rands(mode="twister")
      rand_initialized = .true.
    end if

    allocate(ranges_wp(2, ndim))

    do i = 1, ndim
      ranges_wp(1, i) = lower_lims(i)
      ranges_wp(2, i) = upper_lims(i)
    end do

    call run_sampler(  &
      ndim, log_prior_f, log_like_f,  &
      nwalkers, nsteps,  &
      ranges_wp,  &
      walkers_wp, chains_wp, log_probs_wp)

    do j = 1, nwalkers
      do i = 1, ndim
        walkers(i, j) = walkers_wp(i, j)
      end do
    end do

    do k = 1, nsteps
      do j = 1, nwalkers
        do i = 1, ndim
          chains(i, j, k) = chains_wp(i, j, k)
        end do
      end do
    end do

    do j = 1, nsteps
      do i = 1, nwalkers
        log_probs(i, j) = log_probs_wp(i, j)
      end do
    end do

  contains

    subroutine log_prior_f(theta, logp)

      real(wp), intent(in) :: theta(:)
      real(wp), intent(out) :: logp

      real(c_double) :: theta_c(ndim)
      real(c_double) :: logp_c
      integer :: i

      do i = 1, ndim
        theta_c(i) = real(theta(i), c_double)
      end do
      logp_c = log_prior(theta_c)
      logp = real(logp_c, wp)

    end subroutine log_prior_f

    subroutine log_like_f(theta, logl)

      real(wp), intent(in) :: theta(:)
      real(wp), intent(out) :: logl

      real(c_double) :: theta_c(ndim)
      real(c_double) :: logl_c
      integer :: i

      do i = 1, ndim
        theta_c(i) = real(theta(i), c_double)
      end do
      logl_c = log_like(theta_c)
      logl = real(logl_c, wp)

    end subroutine log_like_f

  end subroutine run_sampler_c

end module pycopa__sampler
