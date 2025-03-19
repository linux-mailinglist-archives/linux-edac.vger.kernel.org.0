Return-Path: <linux-edac+bounces-3371-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFC2A689D6
	for <lists+linux-edac@lfdr.de>; Wed, 19 Mar 2025 11:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278D4171BB3
	for <lists+linux-edac@lfdr.de>; Wed, 19 Mar 2025 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2063253B6F;
	Wed, 19 Mar 2025 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X4EAX8i2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3A1E1E0C;
	Wed, 19 Mar 2025 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380921; cv=none; b=ZaN6MeMqoBD22cXbQp+/oQEMvsDY4jeChxFaEmpqlfZmzP6r05CSqopRtuBSc9a+rqNjJrTavVFmx+igPMG8V+IykJs9+9GrN9kSZ9Urv9n8QZ3q2eQLfqvoBa7e9uSSm//W/qmjUbpTaHkOji6WAQYT7+blBfEnA2HhQJvmATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380921; c=relaxed/simple;
	bh=Yr8Y2Du55o9P3Pl0RIuFcErJNK2KF8M6MrjAvGzvtk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkVsJe+li1xWHrNXi+wU+uLVSyZzKK+kzRthC4zwYPQju8c2zWE/5Xai30RlqeU4UYX1gg2A2sVqVpMdVHUe0/mr90DRftS77AFeMhQ7C88WJPRO1cDOKpupmYmdbFHD/vIAVJxqs22ULoreOLSGZ/T1CETLoebjmDUK/jEC/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X4EAX8i2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DE88740E0196;
	Wed, 19 Mar 2025 10:41:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TVXHJIq9QTTQ; Wed, 19 Mar 2025 10:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742380913; bh=t3X6/NLTS8ezkuarlOZMucgxr0JOZCZcdd9Cy1iwOmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4EAX8i2oTK/tC7WkQgtg/v+IQFu+Hc52lJlXUKmyzo+GtNQxopWI5y4oYp62oid/
	 SeqKimNh4WDiKkFcrL55jSAXWiYFmi3VxE1rKS/dKkj9p0dd2kw8nj8d5fYxTf4L37
	 Uz7tBApG0QL7bMk3CwdNLpErtrNtJX1tLOD22z9IuQ8OFTqepU4eDV9tBkJ7+G1459
	 w1LGjfmPjrKo+qhFm8P3D/m5zJX2DRi3Xx6pknOgvztKtfWxs7ZySx1nCrEy/+FY8h
	 GN3cotp6WwTNI63l1MsOqJO5niwjABdCR0gnAHiF7ZFz84IdZf0+pnLzNjSBbaeqxi
	 pFR6NCCySM6tQI/EpelVY7r0Gwoy2ZK9iBedAGRZHVoWN90XBcAkpgu/rwZPeWQxhB
	 wQEaM6gA1FERj2Z4z9gNHc10zPlCCdvxsd0uHxGvDXWHttJH4LZxVqRw+UEPILgJVv
	 MG1HT49/gBBM2M+nVO0Tgy0myjE+tKD04l+oBKRAWTRpZGrsFbKiaGz8sc04OawGJW
	 iwQcdw/NZbIk4r18F/u/S9bHKVSTRl1tgUYhiIkPObq8sX1XXe6UNIhp4z6SlYx8qW
	 imZxV0n1kk5jRFix1o7FmNbh6EYxkliQpCbZjTlHy9QvnWYZo4apDJstKI8v3qq+Yx
	 p1ySQqqjTc3R3hk9MSHYaLXk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B0AE40E016E;
	Wed, 19 Mar 2025 10:41:40 +0000 (UTC)
Date: Wed, 19 Mar 2025 11:41:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v5 5/5] EDAC: Versal NET: Add support for error
 notification
Message-ID: <20250319104134.GKZ9qfXkfKDSqJRzG2@fat_crate.local>
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
 <20250106053358.21664-6-shubhrajyoti.datta@amd.com>
 <20250211094002.GAZ6sa8l_2BdJQfk0I@fat_crate.local>
 <SA1PR12MB89472E1EF3BDE072EEEF17B181CD2@SA1PR12MB8947.namprd12.prod.outlook.com>
 <20250303175527.GDZ8XtD5pOTtLUe16B@fat_crate.local>
 <SA1PR12MB8947D2A37B834687E6EE000A81CB2@SA1PR12MB8947.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8947D2A37B834687E6EE000A81CB2@SA1PR12MB8947.namprd12.prod.outlook.com>

On Wed, Mar 05, 2025 at 05:18:19AM +0000, Datta, Shubhrajyoti wrote:
> The loop iterates through all 8 controllers, checking their configuration
> registers.  It looks for the first enabled controller by verifying if its
> device width (dt) is not DEV_UNKNOWN.  Once it finds the first valid
> controller, it breaks out of the loop and registers that one

So the first enabled controller doesn't have an unknown device width. Ok, put
a comment above that loop pls.

Also, if no controller is enabled, that driver will continue probing with
num_chans of the last controller. Which is wrong. You need to handle that too.

I'd suggest you put that loop first (or as early as possible) in the probe
function to avoid all kinds of unnecessary unwinding when it doesn't detect
an enabled controller.

And so on...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

