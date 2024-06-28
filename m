Return-Path: <linux-edac+bounces-1428-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158EF91BA31
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 10:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78775B24D8F
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76A214B970;
	Fri, 28 Jun 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZcgXS8Mu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C3322B;
	Fri, 28 Jun 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563842; cv=none; b=AOyy/lnCX79S7VhtS3zgBbr4fv0M9wMZ1h997on/k7/cuU3tps1lESDd+mKBvwZAqAQ5vIx398oHfiq5Fz6k0AjZU76ywVlA311YAtiX8Vh0BtrxeYnXftgIBVxViApZv9V+A59CXEXTI9TqgwfkBLryTuR7N8Rha66OxehY8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563842; c=relaxed/simple;
	bh=zhe3Sc2PIA9XXTss0ADzrumOx6GmkzRzgoF/o+YyLS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucM2p1wjI5ObcV5XdWcWZmPnLx5OroYnhO+pNIF6pIpwR4MamoIarnKLfK4iC4x4kXPGTHPbSYtyafCYjjIjZfDrjrlCO85/95BKxCM2vqMG8igt1CEswKoPzAXkGbWdYzU1Q7xYUXw+Z5/rpwCRrdrp7ZDSSxGEc0cFUbvEuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZcgXS8Mu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9410040E0187;
	Fri, 28 Jun 2024 08:37:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Umf8aggjutjS; Fri, 28 Jun 2024 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719563835; bh=/+w7TRHAZv7oRKb5UTeNv+0L0Y/wjxySxgMuo0tOCBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZcgXS8Munaok/C1MFnXC43lODWM1STHyQmedxqCS2OYS3vPc7dkXCEROiOtFFfJ8Z
	 dCXwyvj2RYAB8nhXdtCyv1j1fHGFcMeayYkSfa49KmCqaZ0R7bQRBZcv/a0mHt44qs
	 H/JVijhgG1Mkc2Znvi52it/15Vx4RzPO367lo2cWWOW2StSShuvpo2UL3umGXdZMmZ
	 NqGP87CQTm+L5sALzTCkqMIkxjAhOYTjB5vOkS4VaQ+WfBMku2LGT6LWFotIvOOvdv
	 0aowbNc1SV7NPO5FHOhBPO7rZhWGy1lQ7SoFcMqQDpNdmu7cL2OTrqzeWTUNmUthA+
	 VG3UQz0BE3J2QeoIg6ciWXaX8BJkTL8q2CMe7dDL9KruCHC5rx2DsNo/a3t3qUvFGM
	 +ny4hvae8vLRRFV8NkUxR5FUU/Z5YS2zri3rLjYS7zJsI5u1aMWkEdQsW8AW7VPpnb
	 6df85PTMaDYCzkjFcZ+3Gmi6D3cmhhbP85kbSJU//UXpOEQP/AIgG/q2VCWjDonF4x
	 d7QIXkntI84A1zmn2iyijrzit4AXf2HxszhDN47ZkgQ8WoikMvkpEAd/lcRtBMgs4u
	 pbUCCNRXbmtm8n9VxZML5jhzWLv9K0j7CzWL0mxzIlr0umQuIjaa5JmqP0cCMJF7DM
	 naXW0vxpOm5sD4/yUX3kQ6mw=
Received: from nazgul.tnic (business-24-134-159-81.pool2.vodafone-ip.de [24.134.159.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AAD640E0219;
	Fri, 28 Jun 2024 08:37:07 +0000 (UTC)
Date: Fri, 28 Jun 2024 10:37:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH v2 1/5] x86/topology: Export helper to get CPU number
 from APIC ID
Message-ID: <20240628083722.GFZn52QnltR_2gjuO5@fat_crate.local>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-2-yazen.ghannam@amd.com>
 <87ed8l7byy.ffs@tglx>
 <20240626014212.GA1086@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626014212.GA1086@yaz-khff2.amd.com>

On Tue, Jun 25, 2024 at 09:42:12PM -0400, Yazen Ghannam wrote:
> But would/could we have SMP support without X86_LOCAL_APIC?

Look at how X86_LOCAL_APIC is defined in Kconfig.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

