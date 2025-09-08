Return-Path: <linux-edac+bounces-4737-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C25BB48829
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 11:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23D23BCDD9
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8572EFD86;
	Mon,  8 Sep 2025 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CxV1RaBq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8701C4A13;
	Mon,  8 Sep 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323299; cv=none; b=PewnO7zJ8eB2tyxy0ChZgV8JDasR5CyIItLqwSCCOj79Npj6bfaPUre7AB574GWuILMD2SYKmBDevSRsXADBz3/KmdcqSTV38oWsImhkyNJT+eGufY97Hu5IhWl8cT58C4b8SkNgyOrxG2g3aiwZ8lOmiqs5NtYQCXGK45+BCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323299; c=relaxed/simple;
	bh=gyfMDd8oh3FEA64suvRNgoBWEPUITsjpSLBmVfUwXr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFJypukYwx/BzypD2xAssRNdvz9nkBb1dkiT34X8Qnu6g9RugoChjExSG7mz5mAeRie5IkVuJL4zX81NSAWfRgV9EWlc+PtFiaD87wIK/iRDiOMiRbOMyEfEfFui4+ujkZmtqVkhBB1v+6cTqTkezrIg8HwlRI9K3DA+ocmAKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CxV1RaBq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F138C40E01A5;
	Mon,  8 Sep 2025 09:21:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yX1mUcSvrTu8; Mon,  8 Sep 2025 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757323291; bh=ogM4I/L9vPwohaHLvQP0E84dhlgodKDu+ayR0GmM+nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CxV1RaBqzhq9mHg8SaZ2/UytWvM1Dow2e82PEI+WrSGEKFWpD2H+cNm5F9JZxfG5M
	 D+FO+28bTXGK2EcLX3rXtEenez9g/WuKOA+6SRdNZ0EMBiJXoDQoT5q4CJPDHTYyu7
	 SOHDzOs4LD6zTaQGIg35QmxGhv+NuGAxL7iLyVYSs3DiII50xpH098yMXH3qgkR9B2
	 MLSimfd/bLZOIWnykx42jST3hD69nrVmnQAUV6AvjQaqT/jj9BqDei2BSC5HuiF2qH
	 tTmRp2WO4I8f7IDHv1KvP3yh0Nr3AMlJVD/7YBCKFfkq0eGOGF6n0C34tlOe+gh0yE
	 8cvfD4EK6KtOv7iEbJcQDj+Gwi39pq/JczAjs0bAkwcnCXYYZ3Vuyjg6LB6yXIkFSG
	 TEVQngi9X7dFtl9I0HNUnoxc1U4JGs+WAyGfkap7D6qkP3WqnClUcZ6Tm7+BLmUt5y
	 lGU2oWt4eoGTdDTPLFkHHTSlU9czyibB922hY30MlHAZ0xR6faXoOPE9VkIwncAtfK
	 5wLDnW5pgglhZs0WTVXgzBzpYYNNrfMxXXMtbbKWckRWGrZfNscGtl5oZlWf0I6qjj
	 scnMbKP1pDATNkbX1qepO72S9s1bKbY4StQi2fnPmHs1GxtD6I7E6WE7UCNOyifWQW
	 YgqnmS7RY591fvHjvOayOrh0=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6AA6640E015D;
	Mon,  8 Sep 2025 09:21:19 +0000 (UTC)
Date: Mon, 8 Sep 2025 11:21:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-edac@vger.kernel.org, git@amd.com, shubhrajyoti.datta@gmail.com,
	Rafael Wysocki <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] APEI: GHES: Replace log_non_standard_event with direct
 tracepoint call
Message-ID: <20250908092116.GDaL6gDC0X4wK5AvgK@fat_crate.local>
References: <20250906150307.13921-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906150307.13921-1-shubhrajyoti.datta@amd.com>

On Sat, Sep 06, 2025 at 08:33:07PM +0530, Shubhrajyoti Datta wrote:
> Simplify non-standard RAS event logging by replacing
> log_non_standard_event() with a direct call to trace_non_standard_event()
> in the GHES error handler. Remove the redundant wrapper from the RAS
> subsystem to reduce indirection.

But if you remove the ifdeffery in ras.h you have to do if
(IS_ENABLED(CONFIG_RAS)) now. Instead of simply calling the function
unconditionally without silly conditionals.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

