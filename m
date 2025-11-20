Return-Path: <linux-edac+bounces-5486-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E5C73F45
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 13:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 306FE4E2735
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B340432D0D9;
	Thu, 20 Nov 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fC6kkzkJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880932E12E;
	Thu, 20 Nov 2025 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763641365; cv=none; b=WQAFuReqRwVfEo0z2UuU+5pkT4Z1ouBH0mtalNMcOazUIoOIszCh+5u+UCdqN7iBKhjSgd4knHTYWhjPUjMCx8DZGxQghTqEygTBTL9yzW9obEWmJkvQBND6YPUwJMdsrKRHMdv028IQhh6Szd5y7IoHaJFex0uIXFPr3KdSwP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763641365; c=relaxed/simple;
	bh=JEDrR5Djar9ZByqC4EgxiIUC5lAXDjC1ulowVMgS/Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYglyVKHLswnjNYCpn+HgtuRGJdX2S+DQ5u+JkmnyGo1CRpaE6RaK9jeB5pTN+Nxsj5F/QozPLrggqDAOcvkmlbIJtxendHFu2qHAyigy0Ej4d3rcvf4TpT46MalKuAiW4cpoMgG37Smep0idiCQzL1yIenuvIMGB1n4+pSV6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fC6kkzkJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1E5AC40E01A5;
	Thu, 20 Nov 2025 12:22:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2_Ag7KRp96E8; Thu, 20 Nov 2025 12:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763641354; bh=3YOPtEkdRgfJxLHrAmXXDsS6n99vLsiqSHv/jglXyK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fC6kkzkJ4X3v801ZrgODiPtrwlAuph9QNpqYgO6KTh+LhiWW/hi9TqBbA9AquISHN
	 jDeP3ZlsYEVippeU1CGkufKCIi62BV5DCAKInmlO253O+5+mtk5RgUy/H/nbh188ko
	 BHDrMXUqqUKb0ZE/5aFznV0BnQsz9rtD1i7uQbQGWfl5pIJUzPPqvMz+tEXn8an97g
	 Kp23cMH8LkKUkJUYlQ9670G5b6a/5cvKEDkPKs5YfB65jCVT8wIkd63/0W4vJ/0OPJ
	 9ehYI9qCzoQJZ4v1baeRDaNXRoFk5QYU0v0xymdmBR2U5T3Rha/PuWL2f/pHUpUSON
	 kbyEndJUq+z7E0Yjl85UAMEAakMyFHkEspdlvoYLbaNYihEzeGOeRhAiHKw3dIYY0T
	 G9jLxq7XAe6eQ9SIRjtEVfHjsU1m6Qa2iMHhlRLAvX+TZCZcSY244tNtH9ufNTQcd/
	 UhVqaXxnopE72xlARDyWRlEvW9O7Ccy8vf08X3YY9ZfEryYIYN4CDNDBT0qDJeYueE
	 ueRA8/hlzpquUCwiaRhmv4F+SxsEGLSB8tIYGOMB5JHb8fYqNasFa+MrrI9FZytcWt
	 krwRxLI2/wCMtkDpxoFJ6ku3f7M5TPGNWJU1S76J/d4j4LWvjaB4+7x7wM9f5Dgi8q
	 SHXpp4+Gk21NBtI25al5abag=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1FFE540E016E;
	Thu, 20 Nov 2025 12:22:29 +0000 (UTC)
Date: Thu, 20 Nov 2025 13:22:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: tony.luck@intel.com, qiuxu.zhuo@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ras: cec: Fix debugfs error checking
Message-ID: <20251120122222.GAaR8H_iCA0YxuyUvN@fat_crate.local>
References: <20251120080708.427-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251120080708.427-1-vulab@iscas.ac.cn>

On Thu, Nov 20, 2025 at 04:07:08PM +0800, Haotian Zhang wrote:
> The debugfs_create_dir() and debugfs_create_file() functions return
> ERR_PTR() on error, not NULL. The current null-checks fail to detect
> errors because ERR_PTR() encodes error codes as non-null pointer values.
> 
> Replace the null-checks with IS_ERR() for all debugfs_create_dir() and
> debugfs_create_file() and ras_get_debugfs_root calls to properly
> handle errors.
> 
> Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")

git show 011d82611172:fs/debugfs/inode.c
...
struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
{
        struct dentry *dentry = start_creating(name, parent);
        struct inode *inode;
 
        if (IS_ERR(dentry))
                return NULL;
		^^^^^^^^^^^

So it used to return NULL at the time.

However,

/**     
 * debugfs_create_file - create a file in the debugfs filesystem

	...

 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dentry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.
 */

and the _dir() one has the same note. I've been hesitant to remove that error
handling in cec.c until now but I think we can safely zap it. It is
unnecessary clutter by now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

