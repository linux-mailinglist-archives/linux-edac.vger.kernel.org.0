Return-Path: <linux-edac+bounces-2330-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B59B51BE
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 19:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C1A1F2411C
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9511EF92F;
	Tue, 29 Oct 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NRdVOEee"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623C4AEE0;
	Tue, 29 Oct 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226453; cv=none; b=c4WFV2woBppWrsW6KHLN1Kfv5HZJkTXIszA7KUgVUL9hCgB+kZRUm3T0Nc5pkEROrariJ3B3v/7+Apbahi5lbs05Q5ah/kHXYsvwek2DWGgyxPP3zMxuwwDpJsEuxPGvzA+2JsyvMg2MN1IsnxG+LGbTZ2sArNosmSmB71UMluc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226453; c=relaxed/simple;
	bh=+SYgD8vmIHWiHT6Ff8bGR73OaAHjMoWhTzcOSGvpvGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ec+Gw550MV8e++gALkK+L3fCwFRW+gBtNkcVsfzEs5KGN4pRPzatDInWPTQnVlNGU+mm4BYh5FX4KARDdkZUO+sSk7hP5Vkvx5CzQGb33R6twyvSXRGfrj7dv97MiA8tDmkh86y5bMSVuL0hcXNiNC0wrBvaaEXjoJhj+cF4Cr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NRdVOEee; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B8DE840E0191;
	Tue, 29 Oct 2024 18:27:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iTY6gpNzZzCY; Tue, 29 Oct 2024 18:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730226444; bh=ClvKqaK5sXpYch1y3GXnuSurnZmqrMv5MdJmz3HckIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRdVOEeeiC5qCmKrllCNE9cRwDMn5WjrL+e3gjnUrRJ6etQx+cOlO+vSUCfOlc4PB
	 usAr8rXFgUFzf9uNxGekewHp+dVFcX9zbylp8nW6MIkeTl3lvCoLofcMksyO+zCwu4
	 8QRjICSjKXui+kLtlST2AuBynzKHgOAYgMzsokAN1scFINx/xYraIztWrt5He/cq20
	 N2iz/gZ5cAT5+9VAYFrBliGvUeYEIrjXu8j3oRkTCnAV3ei+B3q4oeZQpoWD1Z/udl
	 X6VZ7mh6L/4M6DPdXc7ARsifIzGtnZSS/9uahq8mRiPPo51l4dTGXoK5Sc3SwXmqq/
	 FkXMAzftPI5R4tDcod2i6N4JSE2lBI34cQrwUC/zVnCnTnSXTKJhXo+5z9K7cVb/wG
	 fIv3/GCBtk43fIdpn15Aazd7DfyHQbrt+faEoi7ioQUZpje3jI3VmSNjEEBSPDZ3uR
	 HKXPjyKXhtKMGL02DgddhRAuzfchKhXfG1hGYguP4ZB/V9a9aKkenWFGlnvJBLmeUe
	 2qhHpYluT2wLoBYvgFqan3Jgu5cyMzTxrU7KB7maHTYD41C8ADTqM+VUagxNr4/64Y
	 ZYsrPtsgZsLSAGh2YBHnDJUL4NxRZPdSoxEDwUo7fCPi9bszbOp+S56xQvxFbfzNJU
	 4JF1T8OBIq488b1DNyg31bvU=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AF0040E0033;
	Tue, 29 Oct 2024 18:27:10 +0000 (UTC)
Date: Tue, 29 Oct 2024 19:27:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, qiuxu.zhuo@intel.com,
	tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org,
	mchehab@kernel.org, yazen.ghannam@amd.com, john.allen@amd.com,
	linux-trace-kernel@vger.kernel.org,
	Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v7 0/5] MCE wrapper and support for new SMCA syndrome MSRs
Message-ID: <20241029182704.GRZyEo-MgqCwpoFJhR@fat_crate.local>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <eb851a8c-73ee-4828-a0e3-2a021d56ad2b@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb851a8c-73ee-4828-a0e3-2a021d56ad2b@amd.com>

On Tue, Oct 29, 2024 at 01:14:16PM -0500, Naik, Avadhut wrote:
> Any further feedback on this set?
> If not, can this please be considered for merging in?

You're on the to-review list which is ever-growing. :-(

While waiting, how about you review some other people's code? Whatever you
find interesting on lkml or somewhere else...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

