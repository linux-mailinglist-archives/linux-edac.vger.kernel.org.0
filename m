Return-Path: <linux-edac+bounces-1181-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497718FBBB9
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 20:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9525285176
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2024 18:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1113DB9F;
	Tue,  4 Jun 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="k/ryAEwm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C04A5F;
	Tue,  4 Jun 2024 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717526324; cv=none; b=j2qjE+WKCMV9CRyeatDsAfFotTrS3LYM1PCXpZeTt2scpDjUStWMt+4NL72y5wWok2D2gD5D9DEyaTRPtegdnzC0gMakQt0DG4LI2uvwOfIVeO/W0iXyfE7F3bXqsrjGpBpd8QRJNHNiGFpncqnVsmf6YmAsXB8kQbx1PUEBp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717526324; c=relaxed/simple;
	bh=qKilePeUYl4N0owePs1i85TmPQCrdSEykDz+72qVKzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg0r84A4PyrZ/2clZ2hD+pJM3c+OWuTWqnqFIJbAmUskiY+HtUv+Bb6tIYte61tKc/kOsqSoA0sZXAuaDbr4J1Jq4lGjVE6WwyxraO+IPeOwOv3ujJAKXIz9UCK4XuUczuic//6VvYHib2UJvpOz/B0Ff2Ez4nt/2bxedHDWObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=k/ryAEwm reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EEF4040E016A;
	Tue,  4 Jun 2024 18:38:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CWzbnTfk6O2c; Tue,  4 Jun 2024 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717526316; bh=Hkxfp90gizC3m2qlcIHQ6IKrCEoG2r2lC0hRXpfclZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/ryAEwmWyR2iwGsf6tb3FMc46HvAsyOYU1sgQw7pe+jU8tP8sLvef3Ne4QJkZxuY
	 Q8g2NsOoooDMheR7WP3KSfiAIpu2/8A01e3wH47Wch00PCEZhU4BZAO0vOjeknW45A
	 moIMJaDsO4MkGUPVNg/jF3llFWOBaXXB3xYqAY8kgIt/1CV6aYt1mvZrCSt42eo4Gv
	 /XbUO6rzZVeMXwMSMgxD1+xuJ1z4NYTCfJM+u+Qj9jU64vPe8A5/L1mIFkgRpFK5ep
	 PcFVHTm9Vle1BRhPSgR/hzRSbllzRFpTu+qhIgH4DEM0yuG+XaNfPMQDxEUz6aLXj+
	 R8LheoixFY1KI1SjK8MGPNg4aF7FDjR6UZbn4k9tvpymajk7XlC9HJpbnxAo58buKd
	 WXgh+d/uf5FLkQsbrmAAQ7SdSLVtfpAu/NwzxVEEsrKLKwj2paGvNc9P4zRA6rK2+F
	 39qrdaeS7pHBRgd5bSGapp+7Y7DWrIIIFP0eN2HIXtlNSHveO8PSidG/4E7FmrPQSM
	 MowXRkejuNtg1zBEqMbmRoL3LoXjJxd98aIeOVF8daZi5u6mgOxZ4IGr1dMhoN86PR
	 Dp2r/32O28x/0zQWcLIoyM7qG5IaUgzHWRgke1VY+tLu/oT1h2nNtFCE7+ZptG7I5w
	 NadrARPLyRxb/Y0CCto0/FK0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 03BA640E0081;
	Tue,  4 Jun 2024 18:38:20 +0000 (UTC)
Date: Tue, 4 Jun 2024 20:38:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Manish Narani <manish.narani@xilinx.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/20] EDAC/synopsys: Fix generic device type
 detection procedure
Message-ID: <20240604183803.GJZl9fC9R5M2NSQ01O@fat_crate.local>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
 <20240222181324.28242-3-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222181324.28242-3-fancer.lancer@gmail.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 09:12:47PM +0300, Serge Semin wrote:
> First of all the enum dev_type constants describe the memory DRAM chips
> used at the stick, not the entire DQ-bus width (see the enumeration kdo=
c

Which kdoc?

The kernel doc above enum dev_type in include/linux/edac.h?

In any case, you need to be precise pls.

> for details). So what is returned from the zynqmp_get_dtype() function =
and
> then specified to the dimm_info->dtype field is definitely incorrect.

Whoops, you lost me here. Why is it incorrect?

You want

"zynqmp_get_dtype - Return the controller memory width."

to return the memory width supported by the controller?

	dimm->dtype     =3D p_data->get_dtype(priv->baseaddr);

	enum dev_type dtype;    /* memory device type */

Yeah, no, that function returns the DIMM device type.

/me looks at the code.

Aha, so you mean the device width should be determined from that
DDRC_MSTR_CFG* thing.

> Secondly the DRAM chips type has nothing to do with the data bus width
> specified in the MSTR.data_bus_width CSR field. That CSR field just
> determines the part of the whole DQ-bus currently used to access the da=
ta
> from the all DRAM memory chips. So it doesn't indicate the individual
> chips type. Thirdly the DRAM chips type can be determined only in case =
of
> the DDR4 protocol by means of the MSTR.device_config field state (it is

Hold on, this driver runs on all kinds of hardware I presume. Are you
thinking about older ones which don't do DDR4?

Or does that thing do DDR4 only?

> supposed to be set by the system firmware). Finally the DW uMCTL2 DDRC =
ECC
> capability doesn't depend on the memory chips type. Moreover it doesn't
> depend on the utilized data bus width in runtime either. The IP-core
> reference manual says in [1,2] that the ECC support can't be enabled
> during the IP-core synthesizes for the DRAM data bus widths other than =
16,

This sentence is missing something.

> 32 or 64.  At the same time the bus width mode (MSTR.data_bus_width)
> doesn't change the ECC feature availability. Thus it was wrong to
> determine the ECC state with respect to the DQ-bus width mode.

You need to split your paragraphs with newlines to help readability.
Right now it is a blob of hard to parse text. For example, when you have
to write "Secondly, " that's your split right there. "Thirdly," is your
next newline. And so on.

> Fix all of the mistakes described above in the zynqmp_get_dtype() and
> zynqmp_get_ecc_state() methods: specify actual DRAM chips data width on=
ly
> for the DDR4 protocol and return that it's UNKNOWN in the rest of the
> cases;

What are the rest of the cases and why is it ok to return UNKNOWN all of
a sudden? IOW, how was the old code even tested?!

> determine ECC availability by the ECCCFG0.ecc_mode field state
> only (that field can't be modified anyway if the IP-core was synthesize=
d
> with no ECC support).
>=20
> [1] DesignWare=C2=AE Cores Enhanced Universal DDR Memory Controller (uM=
CTL2)
> Databook, Version 3.91a, October 2020, p. 421.
> [2] DesignWare=C2=AE Cores Enhanced Universal DDR Memory Controller (uM=
CTL2)
> Databook, Version 3.91a, October 2020, p. 633.

Can those be freely accessed?

If not, you should say so.

> Fixes: b500b4a029d5 ("EDAC, synopsys: Add ECC support for ZynqMP DDR co=
ntroller")

So this commit is in 4.20.

Does that mean that this fix needs to get backported to all stable
kernels?

Have you tested this on all hw this driver supports and made sure no
regressions are introduced?

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

