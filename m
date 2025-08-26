Return-Path: <linux-edac+bounces-4688-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD2AB35F34
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 14:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CD768327B
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 12:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95F7318146;
	Tue, 26 Aug 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IJbnUDS5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AFA2D060B;
	Tue, 26 Aug 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211735; cv=none; b=o4QTTkOHQD9XVc0dxJ3sQbxODL7U0Q+agKNGVJVL70+Dw+TJrKFV7dy1fpHNx9Gg5Ylpe2uByjFznSG6BV6vceUql8PeTQCR+KAqVktynE0zTor6jiUpS7l5n8/m1ggogaJre5IqR22SaA7eMrtlEfB+6bcxE4HkrGEwEAUiXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211735; c=relaxed/simple;
	bh=tsg8sofVKU1gAA4xm07JjD4e07ulHOEy2RCaq9LMvzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeBPTIO1reBz6NFFgTqyN44FGKY+00ZBTBFwvFihf6mW2LRZAZ8M26N3JDfepxlqV+yI7PjWzp60+jlAhwRUtKObo0gsL6bG/ddN4ETjQw6XCjwpnuorbkDR3f+ApzwUZKlXywiLmIbBONYLrYnhtvA0sBqkJxet9x8xphCyVsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IJbnUDS5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C92840E019C;
	Tue, 26 Aug 2025 12:35:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OxaYDB8Ybs47; Tue, 26 Aug 2025 12:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756211720; bh=lGSH99NR2GNnJhwGm4yaNbNzgYqDVCmJ+LnXEzv8sS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJbnUDS5uwS+oELwj39bMB+KdOyQthhU61envLs3tdr6Shomts7LSH9fQYTHEqm4T
	 EZV4xddbNcdJaNxXfcuzGHIt2rJt/GDMZH0MZidYoA9FpDV4rGovaXpl2iuPSaFcl0
	 leEmfSE3WItq4uG8T8NtSpxPh1KR8KX2K1HemAL9WGXhi+qO8J1zLvBsXBe4TvH7ny
	 KGXu3Im35qsNgRWPdIoALYKMgFLZC9w11CKgWoiAj5sCOoUwy7s7wCKzIXubjxfg1L
	 N+hGwkwtfmctz+LjXtA6N1hAdar7dmydENHZuXVJxDDZPKCtLUC3XeoJQ99wjJhFKz
	 LrE/hfh92gd4J+Ecj/UD8ff2nvzBc8bmIQXVX5qTXXtD/YLp/cHKf/Vfl4yWIiXx9T
	 yqBPhCkGQnrP0ZdN7J2yAkCTSrOMGOamCsEb3F0IXyzOrHQpbEewmVHN2GlIZqrcxQ
	 Zlln4AddQBayoi23Ygt1eUIEPiteHcI6dwbPTjbGPBSj0+Z5vG1fbDf0LzNx1xdfnr
	 7v1Fl1JcRMZUGxoIFHV7I6IbTp6CZ4GxJ86G+hV7ytvTPiayh0Vd/rdoqEq6aKfqkt
	 cCoihtBCQ9wQBYNVYdsyzU3nyghbP0J/G8cTn/dpYPjzNkOqSLwvVNTzKQzrg8q2JI
	 mJ0dXFPY4yZKzTDVNfPOjAo0=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 94E5640E0288;
	Tue, 26 Aug 2025 12:35:10 +0000 (UTC)
Date: Tue, 26 Aug 2025 14:35:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 05/20] x86/mce: Cleanup bank processing on init
Message-ID: <20250826123503.GEaK2p9-e87SaTMKVv@fat_crate.local>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-5-865768a2eef8@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825-wip-mca-updates-v5-5-865768a2eef8@amd.com>

On Mon, Aug 25, 2025 at 05:33:02PM +0000, Yazen Ghannam wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Unify the bank preparation into __mcheck_cpu_init_clear_banks(), rename
> that function to what it does now - prepares banks. Do this so that
> generic and vendor banks init goes first so that settings done during
> that init can take effect before the first bank polling takes place.
> 
> Move __mcheck_cpu_check_banks() into __mcheck_cpu_init_prepare_banks()
> as it already loops over the banks.
> 
> The MCP_DONTLOG flag is no longer needed, since the MCA polling function
> is now called only if boot-time logging should be done.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Yeah, when you send someone else's patch, you need to add your SOB underneath.
I'll add it now.

> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

