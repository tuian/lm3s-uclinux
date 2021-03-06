/* mpn_mod_1s_3p (ap, n, b, cps)
   Divide (ap,,n) by b.  Return the single-limb remainder.
   Requires that d < B / 4.

   Contributed to the GNU project by Torbjorn Granlund.

   THE FUNCTIONS IN THIS FILE ARE INTERNAL WITH MUTABLE INTERFACES.  IT IS ONLY
   SAFE TO REACH THEM THROUGH DOCUMENTED INTERFACES.  IN FACT, IT IS ALMOST
   GUARANTEED THAT THEY WILL CHANGE OR DISAPPEAR IN A FUTURE GNU MP RELEASE.

Copyright 2008, 2009 Free Software Foundation, Inc.

This file is part of the GNU MP Library.

The GNU MP Library is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 3 of the License, or (at your
option) any later version.

The GNU MP Library is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
License for more details.

You should have received a copy of the GNU Lesser General Public License
along with the GNU MP Library.  If not, see http://www.gnu.org/licenses/.  */

#include "gmp.h"
#include "gmp-impl.h"
#include "longlong.h"

void
mpn_mod_1s_4p_cps (mp_limb_t cps[7], mp_limb_t b)
{
  mp_limb_t bi;
  mp_limb_t B1modb, B2modb, B3modb, B4modb, B5modb;
  int cnt;

  ASSERT (b <= GMP_NUMB_MAX / 4);

  count_leading_zeros (cnt, b);

  b <<= cnt;
  invert_limb (bi, b);

  B1modb = -b * ((bi >> (GMP_LIMB_BITS-cnt)) | (CNST_LIMB(1) << cnt));
  ASSERT (B1modb <= b);		/* NB: not fully reduced mod b */
  udiv_rnd_preinv (B2modb, B1modb, b, bi);
  udiv_rnd_preinv (B3modb, B2modb, b, bi);
  udiv_rnd_preinv (B4modb, B3modb, b, bi);
  udiv_rnd_preinv (B5modb, B4modb, b, bi);

  cps[0] = bi;
  cps[1] = cnt;
  cps[2] = B1modb >> cnt;
  cps[3] = B2modb >> cnt;
  cps[4] = B3modb >> cnt;
  cps[5] = B4modb >> cnt;
  cps[6] = B5modb >> cnt;
}

mp_limb_t
mpn_mod_1s_4p (mp_srcptr ap, mp_size_t n, mp_limb_t b, mp_limb_t cps[7])
{
  mp_limb_t rh, rl, bi, q, ph, pl, ch, cl, r;
  mp_limb_t B1modb, B2modb, B3modb, B4modb, B5modb;
  mp_size_t i;
  int cnt;

  B1modb = cps[2];
  B2modb = cps[3];
  B3modb = cps[4];
  B4modb = cps[5];
  B5modb = cps[6];

  umul_ppmm (ph, pl, ap[n - 3], B1modb);
  add_ssaaaa (ph, pl, ph, pl, 0, ap[n - 4]);

  umul_ppmm (ch, cl, ap[n - 2], B2modb);
  add_ssaaaa (ph, pl, ph, pl, ch, cl);

  umul_ppmm (ch, cl, ap[n - 1], B3modb);
  add_ssaaaa (rh, rl, ph, pl, ch, cl);

  for (i = n - 8; i >= 0; i -= 4)
    {
      /* rr = ap[i]				< B
	    + ap[i+1] * (B mod b)		<= (B-1)(b-1)
	    + ap[i+2] * (B^2 mod b)		<= (B-1)(b-1)
	    + ap[i+3] * (B^3 mod b)		<= (B-1)(b-1)
	    + LO(rr)  * (B^4 mod b)		<= (B-1)(b-1)
	    + HI(rr)  * (B^5 mod b)		<= (B-1)(b-1)
      */
      umul_ppmm (ph, pl, ap[i + 1], B1modb);
      add_ssaaaa (ph, pl, ph, pl, 0, ap[i + 0]);

      umul_ppmm (ch, cl, ap[i + 2], B2modb);
      add_ssaaaa (ph, pl, ph, pl, ch, cl);

      umul_ppmm (ch, cl, ap[i + 3], B3modb);
      add_ssaaaa (ph, pl, ph, pl, ch, cl);

      umul_ppmm (ch, cl, rl, B4modb);
      add_ssaaaa (ph, pl, ph, pl, ch, cl);

      umul_ppmm (rh, rl, rh, B5modb);
      add_ssaaaa (rh, rl, rh, rl, ph, pl);
    }

  if (i >= -3)
    {
      umul_ppmm (ph, pl, rl, B1modb);
      add_ssaaaa (ph, pl, ph, pl, 0, ap[i + 3]);
      umul_ppmm (rh, rl, rh, B2modb);
      add_ssaaaa (rh, rl, rh, rl, ph, pl);
      if (i >= -2)
	{
	  umul_ppmm (ph, pl, rl, B1modb);
	  add_ssaaaa (ph, pl, ph, pl, 0, ap[i + 2]);
	  umul_ppmm (rh, rl, rh, B2modb);
	  add_ssaaaa (rh, rl, rh, rl, ph, pl);
	  if (i >= -1)
	    {
	      umul_ppmm (ph, pl, rl, B1modb);
	      add_ssaaaa (ph, pl, ph, pl, 0, ap[0]);
	      umul_ppmm (rh, rl, rh, B2modb);
	      add_ssaaaa (rh, rl, rh, rl, ph, pl);
	    }
	}
    }

  bi = cps[0];
  cnt = cps[1];

#if 1
  umul_ppmm (rh, cl, rh, B1modb);
  add_ssaaaa (rh, rl, rh, rl, 0, cl);
  r = (rh << cnt) | (rl >> (GMP_LIMB_BITS - cnt));
#else
  udiv_qrnnd_preinv (q, r, rh >> (GMP_LIMB_BITS - cnt),
		     (rh << cnt) | (rl >> (GMP_LIMB_BITS - cnt)), b, bi);
  ASSERT (q <= 4);	/* optimize for small quotient? */
#endif

  udiv_qrnnd_preinv (q, r, r, rl << cnt, b, bi);

  return r >> cnt;
}
