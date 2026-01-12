Return-Path: <linux-edac+bounces-5615-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC124D11A33
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 10:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5598330C75BD
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA097274FC2;
	Mon, 12 Jan 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C9tAlO9h"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845F2765FF;
	Mon, 12 Jan 2026 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211508; cv=none; b=X5dbY3lMk8wj3/yvIzLjtc8q0G8vOGIRxwgCxjR20+RTq0B7JOvDmpuRoiv+2uzXZjQpS8GSr/T6gZWasn3g+xiKhnll06ZDa4ho4/S9Rm40ix478k1sL0vTN5l02AttHK629QoUcnISYENuWDmNLqrNzbI3ZeqDtLFb4n+cLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211508; c=relaxed/simple;
	bh=AQ9Ok/tHyHybrADXxbv5C+B3ER4QbX8LG0MmZ9vRExE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApJsfFj2kwPrkViz0VMsfV/UYwv5Lhc6XWMd8VG40f664O6dd5uL77E0FJSfl+b0DefKUsoBE65q66cwN5PvtvxDbCN0Mx/e4SFt6hyK1fsiRQVErgDrbPLwpsVYVQmB0n40eYpk+gYyWNF7UlwX3BJmMtF+aXX95XE7dOhLh/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C9tAlO9h; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E994640E0200;
	Mon, 12 Jan 2026 09:51:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id puexZwRd2bn3; Mon, 12 Jan 2026 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768211498; bh=BdfztDcsHgj+zuAmiXA+KMtv1atAhmfZE2MKcpRRypk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9tAlO9hjIEdzlRgG0GRkG7gSlZkYXLy/A0tbd3JFPPJZTnpSoCnPNkW67YfU6Kaj
	 ZNmttkiUQdt6+SbOtmxUPf6yma/iOCqlbIMxml3243VHlkYnxnCrFv8AxwhmZHLncB
	 +M17xs6mCxfHnwK9FRxf2RmGWQls8h4+3oKrbfk4a102HNOpKaNwf5PLtvLdDDQ70N
	 y1rafitXbJh96XqwU+aKePFs8V4bIXmgzLsGMNA/pTRHDfWtQG7WxvYc/56IXfW1Q4
	 HFit56aZ58Vr/aciJh2NBJLbb9d6B4GDj5y38ZvQqL7o2fLLvCIdc1atKAGrJPASQP
	 q3q5kdb6X1oYM6zA4Wcgyf7osm3KSBvI2X1jATxffATcR7w11I+jGuse/7p5GvJMU5
	 MmibJsFjx0bnN1s69Rhysnj+lGxU1tqDbo4jnmCAeDZIDWyC85AOU1ZOl4wkBjvYwB
	 BzaJF9+72BgzTqpbgvlzL2oHhtePwvHrS4xmU03WfYf5gSfca0ZJ3tU/A3JHlJkv4W
	 IhvpAVmKS7Tj38jxIlOGSeTBiS94j+vxEjBzzufgXGMc0LxoDXqGVPcXBL9IX4MLHh
	 AaVynuMMOQqb++Bb+5H5vjORK+9DmgET4WA+ckTJiQSZs4ylBX8n4y+ne4/RSNchWZ
	 zru2t2AEIkwP1DW0BjIULAWk=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A1C3D40E0281;
	Mon, 12 Jan 2026 09:51:25 +0000 (UTC)
Date: Mon, 12 Jan 2026 10:51:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2?=
 =?utf-8?B?XSBSZTogW1BBVENIXSB4ODYvbWNl?= =?utf-8?Q?=3A?= Fix timer interval
 adjustment after logging a MCE event
Message-ID: <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
References: <20260112082747.2842-1-lirongqing@baidu.com>
 <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
 <56d12335986e41da81581ef724742319@baidu.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56d12335986e41da81581ef724742319@baidu.com>

On Mon, Jan 12, 2026 at 09:36:21AM +0000, Li,Rongqing wrote:
> Ok, I will add more explanation, and rename mce_notify_irq() as
> mce_notify_user();

No, first you should explain what you're fixing here and why.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

