Return-Path: <linux-edac+bounces-4261-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA9CAE9FF7
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 16:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C4D5676B4
	for <lists+linux-edac@lfdr.de>; Thu, 26 Jun 2025 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B52E175E;
	Thu, 26 Jun 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d3APXVmd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15C249F9;
	Thu, 26 Jun 2025 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947047; cv=none; b=gqhCIjTNKH4hq0KLYiCcNtLtXKhYolzkzd4XgNPON0KDe6qYTM8CsK2y0a+ruLxDParLUDmu/JF/jFKA43heyQZZX8yUTz5slDDrHJ2idQILjhSCGYC+LpNJ90PRTRdTzJeriu4Tz2wGQRmGEQy7UyxPnm+phRhj58m2AHVPwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947047; c=relaxed/simple;
	bh=lRGt/g0g8Dt9x8qN3dripz/CNyLvV5boW50dIA5joSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBY618C9FVIGgjxERgBosOhVaInE9mPghSBBXNorQJHKoeRZdxwYwB0ZMlYocNKYDo5YVGXOmNB1GihsYFRGqvkbGE/y/BRWAlqxi84eI86CmNGX3NF7kS2/PHuGdwqWjxaR4rLlWuy+DTXUHDCqrkINltTPdDgPj75XvA7U05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d3APXVmd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9B38F40E015E;
	Thu, 26 Jun 2025 14:10:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TbYHqpyYlbtU; Thu, 26 Jun 2025 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750947039; bh=x0ZNVMkUtmtDeX1WqjBnG1Spg/z8nwse68E2o5e9q/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3APXVmdrPkfYakMMvxi889t5BDcMTLZP6N9jd58++heM0JmucpBXmB9jaY/SjWj8
	 oODAPZUoKcTNrT3FF8yYK6PTBGZnXewasgSkxUlvgYZa38ps3vehWg/Q3WNKcJ4B0b
	 frz1CAgXPV1G24iRqjjf5TvK7sCC20pAteNx5ptg14W5Ev3ElIJt+bhXzQY2aNJ94S
	 5yJwUYnwUfrwTzcMFY+4/F7G2PWzDCbTcngooJAzZK5hCwF+Fx8PxWUd59nhbodHcf
	 Q6MuXwQDdtAB1uvY2oDBm9XKp0n568Yvib64DiuAjB507tmIxlQ/AjK1ol8+/zrSqf
	 WzFA/mnSgOVrU6IspdlTWYsI+EEkWsSQ0y4mjg6pez21gr5EuGSXMGYWsSvfKvvw/8
	 gEydbC1zWKxcTiuP+azOvJzHksoAKTWE6M4mhSjf529txokI5+s1YcaIcfa1Wd/CEw
	 iNU6VGJKodd7u824zhDQwBT51d36X2W0hTl5xMTQy9FHt04lq0YPNkXdE/z62vdwNB
	 /0t0S1vlw8pyFp3AOuXoR0hL0I+jCpJiBJkB9bXm5yKzVMQNLQ7RdBIX/81SGTCl3V
	 ToGtzTK34exEfP3pe+WLrsV+sRpIi84rIe+KR8klgjdeN0OgEsvpMcx2cH6jAXd3lm
	 YJKCsPBRZ5bqSCikUcmjw3f8=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10F1240E00DE;
	Thu, 26 Jun 2025 14:10:29 +0000 (UTC)
Date: Thu, 26 Jun 2025 16:10:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/synopsys: Clear the ecc counters at init
Message-ID: <20250626141023.GBaF1UzwF9ITE8-LBQ@fat_crate.local>
References: <20250528065650.27646-1-shubhrajyoti.datta@amd.com>
 <20250603090536.GCaD664IbJB5IoR06g@fat_crate.local>
 <SA1PR12MB894764756C6538EE985BDE24816CA@SA1PR12MB8947.namprd12.prod.outlook.com>
 <20250604093735.GAaEAT39KGW1KJDrjD@fat_crate.local>
 <SA1PR12MB89471067967E0A5F46CEE1DF8175A@SA1PR12MB8947.namprd12.prod.outlook.com>
 <20250611164018.GAaEmxctC+ESUCvBNT@fat_crate.local>
 <SA1PR12MB894766DFAD90E9DB15A3268F8174A@SA1PR12MB8947.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR12MB894766DFAD90E9DB15A3268F8174A@SA1PR12MB8947.namprd12.prod.outlook.com>

On Thu, Jun 12, 2025 at 11:42:13AM +0000, Datta, Shubhrajyoti wrote:
> Please find the diff below

Good first try, however...

> -/**
> - * zynqmp_get_ecc_state - Return the controller ECC enable/disable status.
> - * @base:      DDR memory controller base address.
> - *
> - * Get the ECC enable/disable status for the controller.
> - *
> - * Return: a ECC status boolean i.e true/false - enabled/disabled.
> - */
> -static bool zynqmp_get_ecc_state(void __iomem *base)
> +static bool get_ecc_state(struct synps_edac_priv *priv)

This function's signature should be:

static bool get_ecc_state(void __iomem *base, bool is_zynq)

or so.

Or you'd have to invent a proper way to figure out what hardware the driver is
running on. Definitely not:

	if (!priv->p_data->quirks)

I have no clue how the device tree stuff makes the strings you pass in
synps_edac_match available again but there should be a proper way to check the
hw you're running on - not some arbitrary random case where zynq hw doesn't
have quirks because once someone adds quirks, your scheme is down the drain.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

