Return-Path: <linux-edac+bounces-4014-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74380AC65C4
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 11:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A5E17648E
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1B278E7C;
	Wed, 28 May 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MwCo+B4S"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5570D27585C;
	Wed, 28 May 2025 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424194; cv=none; b=nNvmb1MvKBXXBGMCBTQxxUL9oYAZJ/FzcRpakmIk5i+NwUClbni697rX52fZx2y6Xxw8zg5JEK+zmgE7Ve6C5Tiy2O8/YLqwYbwS+rr+MmaXiWRtpTCg1nO/7NcAqqzR4xJidQmce4PcJ1QkxLa23wNtSxJidepBowmOlracw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424194; c=relaxed/simple;
	bh=XwVcsM0Ke27QaXVu4HALsNtN2BuTrzEyaowisRAZRTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaERraTyQfFkQLsm9vJjuPQs7NUq5/NVNArclvP3KhoeZhiPNnuPmSflUCTU4SZieWn1JeW8hkwHBLLmJ3I3iVyLYmOdSW2rEH1AfB+YGdRaLPhI5wLcYPgu9WDoqRu031S01HK1/brrEXg+Cep0HaOS79wM+vUuR2+W46COLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MwCo+B4S reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9D2DA40E01AD;
	Wed, 28 May 2025 09:23:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6k1iIRKJfFlA; Wed, 28 May 2025 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748424182; bh=si5vjMB3rqYmyMn24gD/zflzQ5T1gxEmIVKPQTemnUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwCo+B4SRUadtIe1XUxkBce8rFMI6dulfrRCIQeV3A/qP5P4UrULAs//ut1GGt8+J
	 9cddGaZsgFOhZ/f7kdnmMZlk8VIDBzPOuasIQm8Qum51RnHfLzrPaGcQMYORD23uhs
	 yDXcDlf7ilZ+EjBjxFxdDeCXbOjQyT4YAflvjvn0anDy6S305curU6phw351VdLwFo
	 1tzAj8ndKknisMKZ4HE0bxEnzWlDSyH65EUH4UuFWAOG40AL8G9Aa0He++7W04oP/u
	 q+rIDZ3iylb9GLu4mlDOxqv4td3pOfZ/3NUvtP7FVrvsqjzBvGgkW0muYsEj/Vk9DK
	 V3uMCtuXN1CTURb9BADn9kTtTU+Jnf3qBNxhp2+ZiV7vY5dqyU0W09bVkEOyRbeyWO
	 5acH68wcAQ/Pv8c4IdbW9yZND1szWbqX/o/wyxzDepbSZsdEI4jdUMPGPP9lYeDp5E
	 sOnn3m7TLbXQan6OtBfgNSxomfAbw7SKLFjkJGbOOB69ME28Fw7sCDaZza7S3lW4YE
	 YpyiTTDOcSviSuAJCdGI/v6Ig8FUkI5hwGEsblInpI7axuw38BeiQZQ4A48LdpKGFH
	 dbV06SpVtBjqJAvgf4TMYdMne7uEHnzZuMET81tnV7XWX8G21DLMYjEMGb6uG4Iga9
	 G1QxEwJ2RSUvJZyJ5OM7ZCXo=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6159540E01B5;
	Wed, 28 May 2025 09:22:56 +0000 (UTC)
Date: Wed, 28 May 2025 11:22:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	avadnaik@amd.com,
	=?utf-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zilvinas@natrix.lt>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
Message-ID: <20250528092250.GAaDbV6oEqvE3279dJ@fat_crate.local>
References: <20250513192221.784445-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250513192221.784445-1-avadhut.naik@amd.com>
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 07:20:11PM +0000, Avadhut Naik wrote:
> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD's
> modern Zen-based SOCs has an Address Mask and a Secondary Address Mask
> register associated with it. The amd64_edac module logs DIMM sizes on a
> per-UMC per-CS granularity during init using these two registers.
>=20
> Currently, the module primarily considers only the Address Mask registe=
r
> for computing DIMM sizes. The Secondary Address Mask register is only
> considered for odd CS. Additionally, if it has been considered, the
> Address Mask register is ignored altogether for that CS. For
> power-of-two DIMMs, this is not an issue since only the Address Mask

What are power-of-two DIMMs?

The number of DIMMs on the system is a 2^x?

Their ranks are a power of two?

Their combined size is not power of two?

One can only guess...

> register is used.
>=20
> For non-power-of-two DIMMs, however, the Secondary Address Mask registe=
r
> is used in conjunction with the Address Mask register. However, since t=
he
> module only considers either of the two registers for a CS, the size
> computed by the module is incorrect.

Yah, it must be something about the size...

> The Secondary Address Mask register
> is not considered for even CS, and the Address Mask register is not
> considered for odd CS.
>=20
> Introduce a new helper function so that both Address Mask and Secondary
> Address Mask registers are considered, when valid, for computing DIMM
> sizes. Furthermore, also rename some variables for greater clarity.

So it is non-power-of-two sized DIMMs?

IOW, DIMMs whose size is not a power of two?

> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
> Reported-by: =C5=BDilvinas =C5=BDaltiena <zilvinas@natrix.lt>
> Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@na=
trix.lt
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Tested-by: =C5=BDilvinas =C5=BDaltiena <zilvinas@natrix.lt>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: stable@vger.kernel.org

All that changelog stuff...

> ```
> Changes in v2:
> 1. Avoid unnecessary variable initialization.
> 2. Modify commit message to accurately reflect the changes.
> 3. Move check for non-zero Address Mask register into the new helper.
>=20
> Changes in v3:
> 1. Add the missing Closes tag and rearrange tags per tip tree handbook.
> 3. Slightly modify commit message to properly reflect the SOCs that may
> encounter this issue.
> 4. Rebase on top of edac-for-next.
>=20
> Changes in v4:
> 1. Rebase on top of edac-for-next.
>=20
> Links:
> v1: https://lore.kernel.org/all/20250327210718.1640762-1-avadhut.naik@a=
md.com/
> v2: https://lore.kernel.org/all/20250415213150.755255-1-avadhut.naik@am=
d.com/
> v3: https://lore.kernel.org/all/20250416222552.1686475-1-avadhut.naik@a=
md.com/
> ---

<--- ... goes here, under the --- line so that patch handling tools can i=
gnore
it.

>  drivers/edac/amd64_edac.c | 57 ++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 21 deletions(-)

...

> +static int __addr_mask_to_cs_size(u32 addr_mask, u32 addr_mask_sec,
> +				  unsigned int cs_mode, int csrow_nr, int dimm)
> +{
> +	int size;
> =20
>  	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
> -	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
> -	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleav=
ed);
> +	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
> =20
>  	/* Register [31:1] =3D Address [39:9]. Size is in kBs here. */
> -	size =3D (addr_mask_deinterleaved >> 2) + 1;
> +	size =3D calculate_cs_size(addr_mask, cs_mode);
> +
> +	edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask_sec);
> +	size +=3D calculate_cs_size(addr_mask_sec, cs_mode);
> =20
>  	/* Return size in MBs. */
>  	return size >> 10;
> @@ -1270,7 +1284,7 @@ static int umc_addr_mask_to_cs_size(struct amd64_=
pvt *pvt, u8 umc,
>  				    unsigned int cs_mode, int csrow_nr)
>  {
>  	int cs_mask_nr =3D csrow_nr;
> -	u32 addr_mask_orig;
> +	u32 addr_mask =3D 0, addr_mask_sec =3D 0;
>  	int dimm, size =3D 0;

The EDAC tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

