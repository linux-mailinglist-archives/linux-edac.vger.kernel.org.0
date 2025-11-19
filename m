Return-Path: <linux-edac+bounces-5477-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F85C6FA96
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 16:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DCB334A260
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3B3546EF;
	Wed, 19 Nov 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WhhDgprB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662925B311;
	Wed, 19 Nov 2025 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565893; cv=none; b=DHuJQnavrgU9kUpFuQZSOQ1K4V9VqUrLyy69yCJ+qD+0iBbjSic1NbCR1ywC+RVf71ERFtHc145mtMR5zCE4ajHeUMmyRHIL9qICHyKk1EyLzvQb+T0WgjZ4/SW8uEIJDJohrPHL7t9hr05yamdrz7omq5vyxstohT6uoD7akkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565893; c=relaxed/simple;
	bh=oPif/SILTKFDiQuUVB+NCmgg/3F0ypCTcIHGbUO3oIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/0ItS9TrGcq/dzWyhlIcoXSiv3cKY6m8sSYdfc7Pk+iqsOarIHVTK3wWUaUE9dfXp/KnLHrnlLfrZmcqWoQoH9Lfolt+WWovxyfLO83RecVZ3K1Bf95mh4WfKpuv+R7d5H1KVPlrebX82DAVO7PoYuK+HEbtmcnHpG8P0Y/ee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WhhDgprB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8A13B40E016D;
	Wed, 19 Nov 2025 15:24:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NuNCz8Hdm_4m; Wed, 19 Nov 2025 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763565882; bh=xUC2OEkVre+uz7HuL92vsda+2zSHtvoqRB39SLwS0tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WhhDgprBxFh89172y3NfR7v/W+M2jkuflpau4VShwBMG4TK7khJWR3pvdb5fI3un5
	 j6m7fbZhxGf7n7N0qV0qP67aZYNF7uPhwo8EItg8BZZeGT0CqT7RHEBaH/VUvhUOeK
	 /IzAaUgjXdUpQ9QDo1G4L8FL+Z/T7elzN7ZLHnUl2yh3/npiGe06BgTy7uHt7+HqR+
	 4V+joQM9CKyki9vxudNN7Bi+zUWlQu5sGO+WwgM2VIX1GBxJJUh9CYRdMYBRuh1gMC
	 PVMMpBfJSFnSRgTZB9fQ+fQINkj66/EEooDO8h5qm26a8hX6ID6Dhe7qE4v14Z61t3
	 bBs1OnOrMwCo9vkXYcaZ/j3PcqMmk2YsJ0FoVQ/Dk9GgfAW/rtAo5jYb4UnPZbT4hs
	 NZv+nLRZ1PtsFEWo0srCBijmCYBs48Qsp+o+DeMLcIpbPIExBdUvhtCF/vddSWQM7E
	 nUPtW++G7tKycV2UZhveFoMI0uGIShP5XAfL1q+30Lk8Mmjms72l1DbV0+LWgo2Dp8
	 ox9RXBqySjtsT2R2ZAlmwiVkHz6p55Sk2OxWE35E8WTATfj6YCAkrPK+e6HaF/hJJC
	 SHcbc6LhKg0tU1eeeNsIeoSWY5WK67+z7aEXu+XREeeixn6u2OZZKhgZDfKsTPePlz
	 S7PULNH/JVGHGTY+PXIgBn9k=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0162D40E0216;
	Wed, 19 Nov 2025 15:24:36 +0000 (UTC)
Date: Wed, 19 Nov 2025 16:24:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] EDAC/{skx_common,imh}: Add EDAC driver for Intel
 Diamond Rapids servers
Message-ID: <20251119152430.GEaR3hLonaUag36pFg@fat_crate.local>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
 <20251119134132.2389472-5-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119134132.2389472-5-qiuxu.zhuo@intel.com>

On Wed, Nov 19, 2025 at 09:41:28PM +0800, Qiuxu Zhuo wrote:
> 2) Validation processes are costly. Modifications to i10nm_edac would
>    require extensive validation checks against multiple platforms,
>    including Ice Lake, Sapphire Rapids, Emerald Rapids, Granite Rapids,
>    Sierra Forest, and Grand Ridge.

Isn't that what we do all the time anyway? Make sure the kernel works on new
hardware and so on.

I'd understand if adding this new support would mean uglifying i10nm_edac but
just because you can't test it on old hw sounds a bit iffy. By that logic we
should simply spit out a new driver for every new hw generation and in the
end, that strategy will come back to bite you because you'll end up
maintaining a pile of duplicated drivers.

So I hope there are more valid reasons justifying a new driver than just
"validation."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

