Return-Path: <linux-edac+bounces-4024-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BEFAC709D
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 20:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035FFA25A19
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 18:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDED28E593;
	Wed, 28 May 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B5FOx3Bf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E0280CD6
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455115; cv=none; b=uxeDa3eDLz9E/lSPpIUqnSx8uIcnxlsz/W0zce2Zb0Bjfhn7KiwFTV0iyaqqqtYlOC1GzsgKMc2T64Yfqks42oMXbTMfn1E8i3U03HC3oCvg0r2z8p1Uu3AemUy1RS6TJLeLsSUCPhtr4zFVYjADC9/cKr5W0tceImTsKRh1ylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455115; c=relaxed/simple;
	bh=rXI7MPy60+x6AtuW1k3HJxy96lfIj2fWyjL4b3UwRS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLiWdlMxZXiAv+KP6Y3sJp9wZxToREHxG4DGWdTr7BJLGA9JzjSiV4bCaHggfwr1yH74SoqHvC7nFWwBhLbJ7054jGFnH1nGhzVzWke4voTd/cZ/T7+PyBvc4kCfgPSR89ERTZDu305bLsojV1oWrG/6mOS6zjAXMOX1M7A18T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=B5FOx3Bf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7F8AA40E016E;
	Wed, 28 May 2025 17:58:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mlpqH5-D0i2i; Wed, 28 May 2025 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748455107; bh=hW4yTHQZ3cL4UZGAf13Ms6H5egMMTEKRXZURUWCCYpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5FOx3Bf4p4isUwGbm7BA44LHoBHEpi8hgkPDvols2ROwISNW58J/HS9AUNIzj11n
	 GJxOxQFANiwUMTkbklb0NKxUgVIgHdZ6KjzvsJLwtuyw7SKJUywO3qzgINwxnzHDHX
	 0r9yNgapzlxxv7WeBwQThv6J44B5JTnDqqkBwW4SlCSec0L1EyLcsiZqRs037GgGn7
	 tH+LEbJROeaeDoJRpSLIZAG/A3EkP0sFxiCT9lsIkoi1LTwnurcolqlgasYQ5xtVEL
	 2QIqaZlEVH8CiYzoCS2ao2XDFGg/DztgqiVGM4A7GxZUXHNm0EoZKo+protNwF+/MO
	 hU7VtPyf4vEAE7KGnq8ldypCujnxJbqaYsDhnToYkX8j9RTCg7+xtuveNk8SxVIheB
	 Ird/X2y1Bu5A861eot4jpGZRo48C4/1OuJqngONfZ6TVAzJrIuqfUdzYebFvyaIayc
	 BE125RBl/tNEzlc8Sc0IWXKv15Ssw5VkOB7PkmnMcqKrXEYX5LiUidJlx6vvVfNmvd
	 Rt/dBahZpCHEj5iQQTNlbsT87sJFMeVVO8FBQwRlMY4AWmZOe+ubbOmH4NMuursSlT
	 sLcs8LJ0x7y9D+RYb0LYOq/b9rEL1vOoekrxqCpGJWGNWV7S8AFmcKdjrKqQ17iwYi
	 DHDsGdnPVKb5DdcPhZY/ziNU=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0157A40E01AD;
	Wed, 28 May 2025 17:58:19 +0000 (UTC)
Date: Wed, 28 May 2025 19:58:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: James Blake <jamesedblake@protonmail.ch>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: amd64_edac fails to detect DIMM with only one ECC UDIMM
 installed (works with two)
Message-ID: <20250528175819.GGaDdOuwb-nzE6FfYs@fat_crate.local>
References: <WWtcG6KurPUuwF9vO6BrD2SXUmU20OYqRPPpbGD9Oxp9ZmB8KvHdFELQ9zURHvcXiF5WE2UdhZwbGlvxVQV82Srwl7B9bMKvxFhBQyPTET0=@protonmail.ch>
 <20250528164459.GDaDc9i5ngUZlWECaU@fat_crate.local>
 <c1a5dbb5-3498-4ac3-a278-dfde3f005e6e@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1a5dbb5-3498-4ac3-a278-dfde3f005e6e@amd.com>

On Wed, May 28, 2025 at 12:15:50PM -0500, Naik, Avadhut wrote:
> Just to be sure that you are hitting either of these two issues,
> can you please provide the dmesg output with 1 and 2 DIMMs
> connected?

Yeah, I've pointed Avadhut to the mail with the requested logs.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

