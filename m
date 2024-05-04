Return-Path: <linux-edac+bounces-995-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1804A8BBC77
	for <lists+linux-edac@lfdr.de>; Sat,  4 May 2024 16:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6337D2826CA
	for <lists+linux-edac@lfdr.de>; Sat,  4 May 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2B939ADB;
	Sat,  4 May 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QpPsT6HH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C122F00;
	Sat,  4 May 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714833496; cv=none; b=DK/LIzfYvuuR9yDIhtio5BoZ7SUkajvsq8/1kLcgs0ZEByoCARFwu+h68CGye+8UMwEKM9BXHd4H4bR1PnP74rOSsvve5wHsT/OUI97eEUbBfubocCziNIft+aIxQBAzQvvOHpt1ofbsbLhs2cYfHZHs7UQjX8eY4UN1Sbr/8ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714833496; c=relaxed/simple;
	bh=a5Wrjr3S1wBrFXBpNK5JSOZp5PtABF+yVcJPccAxyrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPG74S0CCgCY3mwviTykAxvBKGaI10ofHYZ9G9fkSmUWOXr9apfJHRnOC2CXFstGIYf7iNIYComf1e1RR9Xwt4Z39XaMv6bOf97vsSYSHYbAfuU8x3uAnEWrsGvIbQROre0vJ9MRQZ+cW7cX3MYoeJ+DaI1Cwx79Q4NXg2iS7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QpPsT6HH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 02BD040E01F6;
	Sat,  4 May 2024 14:38:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fOQXwZrDk9Eq; Sat,  4 May 2024 14:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714833488; bh=HVYuqXL56sZYSXgKpg8JcXGW/2VcAJVVwWWQi4f3F7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpPsT6HHaMvbMkdD7VRNsh0iO8Kzy43OWtEVCTRF+mtWC9CPg2J/3zcwkEDGQQb37
	 zzZwi8Ks2xoaj2l7S8lbguT+YtVJydx5Mf/3pYsMn23oDzMGQ2DPog9Moplnch5LBP
	 2VbTzX+MO1AN+ADvl6NqwuqJHPU2mVLevqGKL5qBKsQNGa0pFseu9PLZpOXqalmYU+
	 YePbI8RZkxJMWsCK7SnaejbdTxhPrNJbgBNKFVXR2zoXOf2Y6BNV6PnmNaH1L3nKmQ
	 DCQj2MY60hgYmkG+bEovTmci7usAMmvK9t9XM4aP8aRfqFY1NOdzBdDX95Y2NwJ4GW
	 wFSqVeHvnFtR8ku+IlE339igNsDv5XLWcVaz3PCRyZ5AYhpXBTAehMW+G/40bGZKMn
	 Vwg8HdWwD9ZDJrnjtmfpGv5HacLR2VJk2J2nXlmKiLDCU39Qwpj04PWLHjphKlUDRr
	 34wh54gzWQJ4c3D80fuLh/G5FmLZbJtQYY5AnMge/03mCUo1u6s9fuT/qj5Z1aGgrx
	 N9Di25yCUUv1oIyQcx6DkIxZPg/skT6lPFwMzDzl1xpMNyGtRxTNUr/nBzqGwD36U5
	 Uud/2FPska7dPUZAVVoco1pWTC+9kqrWmLNIhfdWywMZRvsonvRLSAjL2RLQ/7DhzM
	 lN4IOn1JSj7I5PWF01ar9bOw=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9F9D40E01A1;
	Sat,  4 May 2024 14:38:00 +0000 (UTC)
Date: Sat, 4 May 2024 16:37:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Robert Richter <rrichter@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Message-ID: <20240504143755.GDZjZIQ-TNxbQJ6zX2@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
 <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
 <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
 <Zi_oPUzvCDhRVSk4@rric.localdomain>
 <20240430180635.GDZjEzK8H3xQ_uEGYn@fat_crate.local>
 <a5f623ba-6df1-42f1-a709-aafa59b004ba@amd.com>
 <ZjPgAoFZXQDsWMJ_@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjPgAoFZXQDsWMJ_@rric.localdomain>

On Thu, May 02, 2024 at 08:48:34PM +0200, Robert Richter wrote:
> The general approach to use the preprogrammed offsets looks good to
> me. Though, existing code [1] checks the offset and reapplies a
> hardcoded value of 2 if it is zero. I don't know the history of
> this. However, it would be great if that code could be simplified.

Whatever we do, the best approach is to leave old hw as it is - you
don't want to "rework" all this and break some obscure old configuration
which only one user has and debugging on it is hard, to say the least.

So for everyone's sake, do a cutoff at Zen, leave the pre-Zen machines
support as it is and go wild with Zen and SMCA and so on, where we can
still test on all kinds of hw.

And as always, ask yourself whether any "simplification" you're thinking
of, is even worth the effort and is not just code churn without any real
advantages.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

