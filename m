Return-Path: <linux-edac+bounces-5350-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E1C37F07
	for <lists+linux-edac@lfdr.de>; Wed, 05 Nov 2025 22:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC8084F717C
	for <lists+linux-edac@lfdr.de>; Wed,  5 Nov 2025 21:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D1434F278;
	Wed,  5 Nov 2025 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bABr39JQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861ED34CFBB;
	Wed,  5 Nov 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376907; cv=none; b=fEInkbIfgN3BVgszMQGf7UhUslA4/zmcsnLsDbvsV95zRwY0I3p9UxvUT2MetCT/sdSWbaaY4RqN9pQWJmMQbj3Y+APcvRuP7S3IHMmqCUV94AevnLHm3VkEB/+/t3/UwE/EnQRoRcCtmkTe0hBeEBxADsdrkxa6lUpPStvQsoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376907; c=relaxed/simple;
	bh=qF/7G6b6bMCeTqEJRO6OoZSjfhD4qO2mFlX3yc8lFzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j28VuJ2NlGDT8AgHHFwr2tgK/iJZ98q27QE6HhLpIcJLlAijtRE9HIx/Y0+ytgt57FiQ3QcKvwTx6nSsK58eLxr8tsuoNqPyc0YwsBBid3MlG3770n24qJKC1Tvh82jTq6qpNDEYxf6k+lT0xxUD0AyMFG6vH/+YPoNLfSuS/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bABr39JQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 02F9740E01CD;
	Wed,  5 Nov 2025 21:08:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lTPOn_9RffCd; Wed,  5 Nov 2025 21:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762376896; bh=weoaShVliDwQXR0eNym2lveoCR1vjFXdljRSAg+XZN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bABr39JQTGlF2BQeSm62CCk2a6e5C3euwl87IbZvtSJ0uqDOEM09TGw5WNPC/BoYP
	 C0CGZUbu50DquA0RuLy+B2n9rRihgwpaQIbPhlPl1FazsvMDGQ8no5mUzzgC9QJDhC
	 DLiIXnZxuVqQ2laKse7mFSC3grY7CDiXp/7v3MuyDP70dO3CqKOxM6LcYtGJLANeTE
	 kkzax9itQjggBIgA/MoMpqimKjwvHp1z14se5HK9LCz1CUWvuvwbt2/+YKwvXTqquA
	 o2qe/D7v2xm35G8U25anW65SBTjaKPGXTPqLEzrJcXT0asGHtboZ5du1SLQ0phqBMv
	 PNNgIhSQHAfmunnBfuchFBt6L9z4OQmrFCb+giTB55J1paUWdLHMLZvj/hfF6a0txp
	 ErR0UNOcabaEH04mhzyvkDe6n0xQZILFh3e8aU2qccsWQ8EqIhYD4SYeP03uTW6LUl
	 h/K+Mr0efE8yaAuT4xyAVATu7w9hCJQbdQAllqjXNNfth8PWjahpVZYXqos+2/3741
	 wKotYfhxNr0qD36zyAyr+tt2GJX69rsiwGKxoybszPCM9srqi4gzlJsvwjENtx255k
	 a+wYG6sl7x6jHvvXbXQOMafSAMOb0VUKp/dUh/QdBrmWMQSn1mWjNTyJgVvwXVvD4+
	 url5eKjcWNsF7TgfqR15nrmM=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3611640E00DE;
	Wed,  5 Nov 2025 21:08:07 +0000 (UTC)
Date: Wed, 5 Nov 2025 22:08:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
Message-ID: <20251105210800.GCaQu8sKCjZ9Xcq8-n@fat_crate.local>
References: <20251105160819.302988-1-marco.crivellari@suse.com>
 <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local>
 <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>

On Wed, Nov 05, 2025 at 05:55:49PM +0100, Marco Crivellari wrote:
> The code is using system_wq, this is the per-cpu workqueue. This change will
> only replace system_wq with system_percpu_wq. So the behavior is the same as
> before.

What does that mean?

We're going away from system_wq in favor or system_percpu_wq? Or?

It is not clear to me what the issue is what the new correct way should be...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

