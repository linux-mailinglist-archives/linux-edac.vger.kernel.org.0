Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6A25D1B1
	for <lists+linux-edac@lfdr.de>; Fri,  4 Sep 2020 08:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgIDGw2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Sep 2020 02:52:28 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:16713 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgIDGw1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 4 Sep 2020 02:52:27 -0400
IronPort-SDR: q0fwNExURpU7WgXSUb8mGzbfUsyAI8vrGF8Ty/hkzYOd1Akq0sVoCB29d1q+QHZqI0v8XJW/QJ
 oEUjI+kSjml88N/zGwKQCtCwI59/esp1Dy+8Y0yeB4PESQxQ5eSHBOw1kgDqrkYq0x5dxMYWxV
 AVflo8igSsFvD7PtJtUB3LDi7rBhUuo8UnqfjnpxoYh4weWxPrchByImfxBfhrD9jnaDud5jLB
 8SQITKyhkdPopFZLBeAcX+13j/WzqRZOLVQY5M5+p3so8986Uw+RDyoPohV8NE4ixohu6BveM2
 fug=
X-IronPort-AV: E=Sophos;i="5.76,388,1592863200"; 
   d="scan'208";a="13728599"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Sep 2020 08:52:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Sep 2020 08:52:24 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Sep 2020 08:52:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599202344; x=1630738344;
  h=subject:from:to:cc:date:mime-version:
   content-transfer-encoding:message-id;
  bh=laQmDkZSgq5I0w0AUUyCJAr4yaR5ymslVR9BnsiF9xk=;
  b=GUUleuGHTp3UjJYCDzA1Jbw3vSuT0aloP33Myv1LBtfiCVM8MMEtcvCq
   ckWIR7RzxYd8ZbrxOh+S8yq8VhuAHzJXk39MWLlvbQT9wFUrdF1noOv3r
   QauKras4tADBW5Ro9MhoARsII79HFlThwpxKPg8QuKm0MwXWhIHYKpEzX
   AlR9HoQxuSWwW1SqValCUBwadkepQMDY5bqFOI99nslV5gwqtwrrumZ1G
   rhRjgtAG2FRW1y9XC4KeC+fZB1xYPIp5Ir1bpwaOdVSVYmvOMVoNiOaoI
   IPBxTpA2PpqUKbSVybrcI1cfvJEL3warlukEsiYxEmWW8sgNFXnndORIE
   w==;
IronPort-SDR: XN3U8wsgE5+K9uAqECPIOYrl7ed1hzChvN87pSn4qMaSIZcocTt7/qolaUVqQArarzs7eHhKDr
 HMx4ujmHwhP8JfZsi9ZotFVcSTSi0F/ZSs9+P+GWCHQA14jRCTJ8AoT0tBeeW+30zHCEiyOUY0
 /zIpBsWudYZ4x3gmyu1h97RwuNGDrsdWnEUbJ+12NoaNI9Feom2knW0KPQwn5xLQZJVWcR5Htg
 0EShvPRjwvbgRXGTQ4Sfl1d6KswLafIQqGqhquCo/9FJCCMTfIsr/14N9Re2z2XAhQRMOeV89h
 rB4=
X-IronPort-AV: E=Sophos;i="5.76,388,1592863200"; 
   d="scan'208";a="13728598"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Sep 2020 08:52:24 +0200
Received: from vtuxmail01.tq-net.de (localhost [127.0.0.1])
        by vtuxmail01.tq-net.de (Postfix) with ESMTP id 6FC2C280065;
        Fri,  4 Sep 2020 08:52:24 +0200 (CEST)
Received: by vtuxmail01 (kopano-spooler) with MAPI; Fri, 4 Sep 2020 08:52:24
 +0200
Subject: RE: (EXT) Re: [PATCH v2 1/1] edac: fsl_ddr_edac: fix expected data
 message
From:   "Gregor Herburger" <Gregor.Herburger@ew.tq-group.com>
To:     "Borislav Petkov" <bp@alien8.de>
Cc:     =?us-ascii?Q?york=2Esun=40nxp=2Ecom?= <york.sun@nxp.com>,
        =?us-ascii?Q?mchehab=40kernel=2Eorg?= <mchehab@kernel.org>,
        =?us-ascii?Q?tony=2Eluck=40intel=2Ecom?= <tony.luck@intel.com>,
        =?us-ascii?Q?james=2Emorse=40arm=2Ecom?= <james.morse@arm.com>,
        =?us-ascii?Q?rrichter=40marvell=2Ecom?= <rrichter@marvell.com>,
        =?us-ascii?Q?linux-edac=40vger=2Ekernel=2Eorg?= 
        <linux-edac@vger.kernel.org>,
        =?us-ascii?Q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>
Date:   Fri, 4 Sep 2020 06:52:24 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.82
Message-Id: <kcEE.e0qfoTd8SOOr3lTVWaXz/A.AASg8YeC1gE@vtuxmail01.tq-net.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> >=C2=A0 drivers/edac/fsl_ddr_edac.c | 6 +++---
> >=C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> > index 6d8ea226010d..4b6989cf1947 100644
> > --- a/drivers/edac/fsl_ddr_edac.c
> > +++ b/drivers/edac/fsl_ddr_edac.c
> > @@ -343,9 +343,9 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
> >=C2=A0
> >=C2=A0 fsl_mc_printk(mci, KERN_ERR,
> >=C2=A0 "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> > - cap_high ^ (1 << (bad_data_bit - 32)),
> > - cap_low ^ (1 << bad_data_bit),
> > - syndrome ^ (1 << bad_ecc_bit));
> > + (bad_data_bit > 31) =3F cap_high ^ (1 << (bad_data_bit - 32)) : cap_high,
> > + (bad_data_bit <=3D 31) =3F cap_low ^ (1 << (bad_data_bit)) : cap_low,
>
> But if bad_data_bit is -1, this check above will hit and you'd still
> shift by -1, IINM.
You are right. It worked on my machine, but i guess that is again machine-dependent.

> How about you fix it properly, clean it up and make it more readable in
> the process (pasting the code directly instead of a diff because a diff
> is less readable):
>
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((err_detect & DDR_EDE_SBE) && (bus_width =3D=3D 64)) {
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sbe_ecc_decode(cap_high, cap_low, syndrome,
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &bad_data_bit, &bad_ecc_bit);
>
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bad_data_bit !=3D -1) {
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bad_data_bit > 31)
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_high ^=3D 1 << (bad_data_bit - 32);
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_low=C2=A0 ^=3D 1 << bad_data_bit;
>
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsl_mc_printk(mci, KERN_ERR, "Faulty Data bit: %d\n",
> bad_data_bit);
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsl_mc_printk(mci, KERN_ERR, "Expected Data: %#8.8x_%08x\n",
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_high, cap_low);
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bad_ecc_bit !=3D -1) {
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsl_mc_printk(mci, KERN_ERR, "Faulty ECC bit: %d\n",
> bad_ecc_bit);
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsl_mc_printk(mci, KERN_ERR, "Expected ECC: %#2.2x\n",
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syndrome ^ (1 << bad_ecc_bit));
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> This way you print only when the respective faulty bits have been
> properly found and not print anything otherwise.

The cap_low, cap_high and syndrome are used in the printk following the if-Block.
This will make expected data / captured data look the same.

>
> Hmm=3F

I would prefer printing exptected data and captured data in the same format, making it
easier to compare them directly.

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 6d8ea226010d..880cf3f4712b 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -288,6 +288,9 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 cap_low;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int bad_data_bit;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int bad_ecc_bit;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 exp_high;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 exp_low;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 exp_syndrome;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err_detect =3D ddr_in32(pdata->mc_vbase + FSL_MC_ERR_DETECT);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!err_detect)
@@ -334,18 +337,32 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sbe_ecc_decode(cap_high, cap_low, syndrome,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &bad_data_bit, &bad_ecc_bit);

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp_high =3D cap_high;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp_low =3D cap_low;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp_syndrome =3D syndrome;
+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bad_data_bit !=3D -1)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsl_mc_printk(mci, KERN_ERR,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Faulty Data bit: %d\n", bad_data_bit);
+
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bad_data_bit < 32)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp_low =3D cap_low ^ (1 << bad_data_bit);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp_high =3D cap_high ^ (1 << (bad_data_bit - 32));
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bad_ecc_bit !=3D -1)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsl_mc_printk(mci, KERN_ERR,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Faulty ECC bit: %d\n", bad_ecc_bit);

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp_syndrome =3D syndrome ^ (1 << bad_ecc_bit);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsl_mc_printk(mci, KERN_ERR,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_high ^ (1 << (bad_data_bit - 32)),
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_low ^ (1 << bad_data_bit),
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syndrome ^ (1 << bad_ecc_bit));
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp_high, exp_low, exp_syndrome);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsl_mc_printk(mci, KERN_ERR,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Captured Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_high, cap_low, syndrome);

How about something like this=3F

