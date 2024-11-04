Return-Path: <linux-edac+bounces-2430-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBFF9BBC2E
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 18:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14497282566
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06771C4A3C;
	Mon,  4 Nov 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bdsxy9nV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93F1C82E6;
	Mon,  4 Nov 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742078; cv=none; b=J68o5cHQZpzCyoOmcZwsn4bG87N7ISrIJqycExNm2GeXLSW2dU6aLZ6y2hW1Jw/gj2pJjCi7GHCsstkeQCpNUcQrvVkYYKkYt/Ufx8dzQ+Lkcd1o8IpeqF95hBMjHo+DccgjsvDzJhu+zgBanfQB2CWCn8K1Nen6rLb1AxLHMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742078; c=relaxed/simple;
	bh=xnVTWkalRJCWw5WZlC8+5KqaanyJ1FOj72eGA4hFVdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKDGCZcC9JatjuzsiWJ6gJrl4F/2XtAS5OOq+Y6E8eeexPf753CVyvfTNWI7I3qcmwGxYCcf1cxGCPXH4XxryTVjSW4fSimwjO+duzyNis/lCr4FUgD5Hbt0C19dACHChka1iwugCwu3JzpUpsOrGvA29kfcBb+/0Zx1YTHuB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bdsxy9nV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5C6A840E0163;
	Mon,  4 Nov 2024 17:41:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9BzomZbwGONy; Mon,  4 Nov 2024 17:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730742067; bh=ziPRZMN9GLRMfEhJa/LLVOSx0r9syDdWy5ak1INEYhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdsxy9nVL+I63jgx8zDI0M0t3b72VUIS/gN4FixbaiKDI/SpYtUiWvTfOn3BcRO9E
	 tNRYzht26YTkNlB15up7i8LXhXOk4bvP6onJ4DjVCjZlU5dJvrcLcvsaulWbPObcjv
	 UFs3CJ1ONPJriTkrkEz42LNSqzs2lNQzsHXoySqna4DppsyK9IAE/9VSbwyZcjPneZ
	 t09prQSMFBr6p735Z5kw36AGSZcpfUu8eAmrgGZAZthKYWMugJe+JH59+ZBm999WPu
	 GVuVPteJUIp0I/ncDaewSN04FSboyWk1V9g/5mptbNeiNvEJtsU5Cd4JYByRr1+u9m
	 13uUu5sTyq+keGVvEgaJRzrqs4bGrAlnMghxhy2a03F2nc9uYjzyYUOicmpW3Ct+0q
	 v3oSI4scKgDuoY8w2LYVL+8OIEFNLsYDROOLy/k4kwH6VhwxfHkLPty4IoXm0loCQs
	 8mLZrw3Y9vMz4aiOJ2lx5Koro662hTtqptKUeh6QDEVoOJYD3PhfcOSNkbJCufOO9R
	 27LFRRqJVtuenUGZ9581kk7pzLXXsaXvm2WhhbDX7SrjoM6PtDIl9ZTEOl+N3QTzDe
	 1cIhamJARXtLTofUQCxFW7OyIrnqayIkF9OxsqBHcPHEEGL7PYVB2PeUGQHyCdJ9LM
	 E6wNlVUq1Ec4ri36UttGdZac=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D85440E0028;
	Mon,  4 Nov 2024 17:40:58 +0000 (UTC)
Date: Mon, 4 Nov 2024 18:40:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Orange Kao <orange@aiven.io>
Cc: tony.luck@intel.com, qiuxu.zhuo@intel.com, james.morse@arm.com,
	orange@kaosy.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, mchehab@kernel.org, rric@kernel.org
Subject: Re: [PATCH 3/3] EDAC/igen6: Add polling support
Message-ID: <20241104174052.GHZykHJEiU2KPqIMRr@fat_crate.local>
References: <20241104124237.124109-1-orange@aiven.io>
 <20241104124237.124109-4-orange@aiven.io>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104124237.124109-4-orange@aiven.io>

On Mon, Nov 04, 2024 at 12:40:54PM +0000, Orange Kao wrote:
> +module_param(edac_op_state, int, 0444);
> +MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll, Others or default=Auto detect");

Why is this module parameter here instead of detecting those broken machines
and enabling polling on them by default and automatically?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

