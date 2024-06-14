Return-Path: <linux-edac+bounces-1295-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5EE909435
	for <lists+linux-edac@lfdr.de>; Sat, 15 Jun 2024 00:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36111C20E3D
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2024 22:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BFB1862A9;
	Fri, 14 Jun 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HBltePky"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F6F149C44;
	Fri, 14 Jun 2024 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718405084; cv=none; b=PO+cC+woUo2eUDBagH2wZrKzGTBNfPlgwXoeXLdbfQf9IicOYM4ymTC7atr2q/8g84+Ee/7/HUizkn8sXmaoh1cVcWMrREUElfZCEHES18MWkfquzseTHqjaCWn1vtCSnkyIOHsN3fQmT7oqtL4M7JVXP3YNUEScgH1N1knoBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718405084; c=relaxed/simple;
	bh=LwLfd7EKwsJ0G7wHBCXbWwKS/g5mW2CBi1ld96rE67I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=no7nevhJtZGH8YA/KZCctZFGnhyl8TUvuyoROg1d9HGT0Jmj+P72XuRPN779/AVrcKhaRnWXIlAT88jBTD1HhwNkq3puUelmSvTe0+iO1935320Zo2WDZ37xYCcaO22qG8i0TrGLRGrSBDXQ98TEgBzCFEm6Z0CrMfJJx9ei5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HBltePky; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CB01E40E01E1;
	Fri, 14 Jun 2024 22:44:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OHx-QliiWOsE; Fri, 14 Jun 2024 22:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718405074; bh=pZEP9FiO05naVI+EWU0oRywVwkC22GZNUEWLRM/5K2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBltePkyk+H4i3SNgF8v3RHoFy7eQtxanZkGnciYSijEncMRJJ2REhwMptp0E7do8
	 oQ7YiTXs024ZE9blVVJtETyIF0eoSPIRs42Qc8+XpsnwbxbTkG4rpKb0R6zBEpNmj0
	 caroeWpBn6KSFsISQ+QujYa/WlN3iORRzDVTvCB3Vy/KFgmYZLVOK2D8ugCJBNPnFj
	 ENAj8Lfe+R3Zes98E49I2TsaKqQym8OgMTKesMSUDmRfHknXyb3iY3zksmX2eKIQNt
	 mwmcCuMC5nMCgSyDK/DDFoeLwZWlvPUevGfXQi+6iMnU87om3+iJcXCXcZMbDfEXDp
	 jXK7hdCWkvG5HfuJjBVOA5Oym31sHlJQMh5JmPbTTJVHhIvcxbmdxbNnYpUk1SRaos
	 iXpkGZ5tIeGf4GikzSysRsgocLrx+EhsDP3VSK02dS7p4EZBgm1Xie0pJ0zNHnyEpk
	 trGcsEukca7dYB2MNdBzpj2NDhd4ODYZpXy85TRPvUT/S6CSEeoLzkgs8L/4+AOrZP
	 Y+QcQ5S4Nl8MuVy1tsLTwCiWOfvPtLI3Vwyq1WBsNMEu7PFWog0opTUBtOjOcGpMMD
	 bW3ikl1/92v6gxJ0uezH8fNgGb4lc/eRc82yA7NAciLvmh2KxenFvS/LDbDMVx1X70
	 tplMrSnczxFb7eMWKS6YlUsg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93B9540E01D6;
	Fri, 14 Jun 2024 22:44:27 +0000 (UTC)
Date: Sat, 15 Jun 2024 00:44:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 3/3] x86/mce: Use mce_prep_record() helpers for
 apei_smca_report_x86_error()
Message-ID: <20240614224420.GGZmzHxDEH2D2TLpjN@fat_crate.local>
References: <20240521125434.1555845-1-yazen.ghannam@amd.com>
 <20240521125434.1555845-4-yazen.ghannam@amd.com>
 <20240529172809.GJZldlqSr5km0frQ_o@fat_crate.local>
 <6d508036-befd-4d5c-b02e-abb228ed9144@amd.com>
 <20240603165530.GFZl31gtuABwpe1svP@fat_crate.local>
 <20240614214736.GA726880@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614214736.GA726880@yaz-khff2.amd.com>

On Fri, Jun 14, 2024 at 05:47:36PM -0400, Yazen Ghannam wrote:
> I don't see why it won't work. If there is no break, then the iterator
> ends by setting the variable past the last valid value.
> 
> For example, I ran this on a system with 512 CPUs:
> 
>         unsigned int cpu;
> 
> 	/* Loops over CPUs 0-511. */
>         for_each_possible_cpu(cpu)
>                 pr_info("loop: cpu=%d\n", cpu);
> 
> 	/* CPU is now set to 512. */
>         pr_info("final: cpu=%d\n", cpu);
> 
> 	/* CPU 512 is not possible. */
>         pr_info("CPU %d is %s possible\n", cpu, cpu_possible(cpu) ? "" : "not");
> 
> But...I like your suggestion as it is much more explicit. And I might be
> missing something. :/

I can think of at least three:

* CPU topology and the initial_apicid sometimes can get programmed wrong by the
* FW. Nothing new.

* nr_cpus= - you can enable less CPUs than actually physically present so an MCE
on a CPU which is not enabled by Linux will be -EINVAL

* possible_cpus= - pretty much the same thing

But I haven't actually tried them - am just looking at the code.

And yes, with the apicid_found boolean it is perfectly clear what's going on.

And looking at

  convert_apicid_to_cpu()

which already does that loop, we probably should talk to tglx whether we can
simply export that helper.

And better yet if he's done some more helpful caching of the reverse mapping:
apicid to CPU number. As part of the topology rewrite. Because then we don't
need the loop at all.

Thx. 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

