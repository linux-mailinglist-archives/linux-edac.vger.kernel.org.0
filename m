Return-Path: <linux-edac+bounces-1170-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4578D8781
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36431F21EA8
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AED1369A5;
	Mon,  3 Jun 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xx+PoQf6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8E1369A7;
	Mon,  3 Jun 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433752; cv=none; b=qm7Xx743/urlXs0ruvA15u9JKZb7ZTqt2AzqHt1OwHq0ZpiNImYIA4PrsUDDU/6UsU5c0gHG0XC+wXYMD017i+ECBvhznRykUA8HxpD74d9I0pAYSQPI9/cu4XsIpARU/vZIBUqYQ8y1pHsbCFVdZrPL1OBQhCVq6aQd0v6Sht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433752; c=relaxed/simple;
	bh=1JY5giR8tigZEuaRc4F7AHu/Puv1SymNII1xdYKwxxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0kQr99w6/hgPzO4crL/AMQ7uDhc/8nuE16EWmaA5EPfQDJHgfIuXlDUDG1UDEn3UZVnOE5xEqUnxE6/P+AelfBqUUZ+DxgslVORLw8PCJeqxffIPguI81CKFrIGuRLOmp9ZAr9gGz5ya00rn9MnClzyJJQIt7CvDZYWsGzmfPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xx+PoQf6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D9FF040E016A;
	Mon,  3 Jun 2024 16:55:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2_HiGnsD6OZb; Mon,  3 Jun 2024 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717433743; bh=s5eN5yVkeKGkUm5T3DGoBbn7AsYBRjMyVANCmgwxza0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xx+PoQf6gJjR0nDXlsJqatrFFhW4C4+tcLSXzrN9w/9cK1ScnE1BG7fQZ2AbVtbWi
	 M5IeDeN1VfuE3DX2N17/wOGTxJ6XCLpoGS2UCvWeDodTqGQfhXMC4ie7GVEEwtPeyt
	 LB7qDfabmC0OV8ktkjVTZsi4A/M8i7ObGzzod56Ucq+knkKa13Tsbx/5KhYDouOjTZ
	 cqDjeOTeAShgIIXAU1GAqizf8JfDdUA2Ymwt4KYDgkjvQJvZ2h7wf2xaUhig9LvoQz
	 jlcLM7MsnW4/xHGToxUFIcEBxxZUN/4v4v2jwrH4VNKtH6Kmw9XSK/jXgT13LfMC0P
	 2VY523jHDoSeXrcCfhIks2OFcyT9RYum8/nOG9ijlpXeAC5MAr4jG6YMfWCWfOxl7b
	 TSRjmDAuqjc9JIPt4EoPbc09ZDDNqwKd3L7YZwBHPIlIVaezVfdbjz7fSF5mlApSEL
	 f0noRnCO8+5qb5ZZMcQ4N9nOh94XWhTJl/7WIn0QGTE9WxPYKkRQH2Lc1jUwO0HB4O
	 olLyIXADwmD4Kfsx2H9R46FRScGFWKdJb3SIDcqOx/MeaKLVKQok8mEJp69I4LeoeL
	 Ei9f8vQ58Hg+cALcu/F8ZXo5FaHCbaNkRNSbpHaYHmrSyJhbN3k6dzs5xYjuqAXpRf
	 gV2hufwYQvlQaweshQo3KkKo=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F166B40E0081;
	Mon,  3 Jun 2024 16:55:35 +0000 (UTC)
Date: Mon, 3 Jun 2024 18:55:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 3/3] x86/mce: Use mce_prep_record() helpers for
 apei_smca_report_x86_error()
Message-ID: <20240603165530.GFZl31gtuABwpe1svP@fat_crate.local>
References: <20240521125434.1555845-1-yazen.ghannam@amd.com>
 <20240521125434.1555845-4-yazen.ghannam@amd.com>
 <20240529172809.GJZldlqSr5km0frQ_o@fat_crate.local>
 <6d508036-befd-4d5c-b02e-abb228ed9144@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d508036-befd-4d5c-b02e-abb228ed9144@amd.com>

On Mon, Jun 03, 2024 at 10:34:10AM -0400, Yazen Ghannam wrote:
> One day I'll break this habit. Thanks again for the reminder. :)

Sure, np. :-)

> >>  	for_each_possible_cpu(cpu) {
> >> -		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
> >> -			m.extcpu = cpu;
> >> -			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
> >> +		if (cpu_data(cpu).topo.initial_apicid == lapic_id)
> >>  			break;
> >> -		}
> >>  	}
> >>  
> >> -	m.apicid = lapic_id;
> >> +	if (!cpu_possible(cpu))
> >> +		return -EINVAL;
> > 
> > What's that test for? You just iterated over the possible CPUs using
> > "cpu" as the iterator there...
> > 
> 
> This is to catch the case where there was no break from the loop.

If the CPU is possible != whether there was a apicid match.

Here's how you do that and I'd let you figure out why yours doesn't
always work:

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 0cbadfaf2400..3885fe05f01e 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -66,6 +66,7 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	bool apicid_found = false;
 	unsigned int cpu;
 	struct mce m;
 
@@ -98,11 +99,13 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		return -EINVAL;
 
 	for_each_possible_cpu(cpu) {
-		if (cpu_data(cpu).topo.initial_apicid == lapic_id)
+		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
+			apicid_found = true;
 			break;
+		}
 	}
 
-	if (!cpu_possible(cpu))
+	if (!apicid_found)
 		return -EINVAL;
 
 	mce_prep_record_common(&m);


Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

