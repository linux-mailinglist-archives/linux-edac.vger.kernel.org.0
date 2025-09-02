Return-Path: <linux-edac+bounces-4717-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE3FB40B90
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059201B63A44
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707253431F8;
	Tue,  2 Sep 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FNL4ppSl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8CD342C95;
	Tue,  2 Sep 2025 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832703; cv=none; b=ccRsFVAElZ9CU/GSTr9xLd0EX9nWRpi3/88NNYsHN3mNCH/nvpEYbxuefKRE8/AHdmqJbY2vuNe1/ylI/Ri7lRJig6Vrlc8IhE4hJByFWy00HQ1+02tTfzcMacECblL+KYaJEHBB08CqUfBGv0cyppZ/OF+i6I7+uFBnJflOGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832703; c=relaxed/simple;
	bh=rzy8HDu/HKQD79DhM/v4aEPUamzNdqUSWHeSnavWUa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpQ4kviRbSsigMFz+3zShScs7O1Wr861v81n4IabVZmJWqGoRcbC57XgOigxpxwGXnpkYmqw6hJksVgNgLflAdtERW4Z5miMxu5URwCfZIT7YN694MX93k8SxyPyK4xiXAqSsX7Awtt9AxaUH93KDEAApVt40XZKxnwaG+wGXcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FNL4ppSl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DBD0840E01C9;
	Tue,  2 Sep 2025 17:04:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FGcDTYXnO16y; Tue,  2 Sep 2025 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756832695; bh=wRpxNiX9QRv5BU/SdbZjefeDFacLACtGPJAJoBJUUTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNL4ppSl2+FvxoAangt091+Jvn2MguNFerG0T3uRKvcspqX1qr69crl93b5LmlBoK
	 bjreTCvqKWjn7hkaCx2coSv7rPT40M3P4p3cU4VRGbGlTMeJIufEyIuljWLk5l2b/Z
	 rsRyckg9VwAYUHKr7FmLFrv8w6GYtuAiYbHqdeHR2XwCjE1fo1lXcQeKfDhVkmpoBk
	 NbNfxZ255vPFBo7iOCR4eP3XBK4/9pO11AfYUI04L/QNLebx7oCnoiXsQfqjnC0SnG
	 vLjzFQYZ6ZnyeaLiwW1ZVtztIFewTopEBs40l5ETSMu+3L/du+PUkR5W05mgPHpkfY
	 +x3iPmGFkDErc4CxqLt9RIJybe3eZ/ADI1m8WLa3tPNnon6lBvOrQQsMVJt7O1qeSl
	 HNUP1fWpaG2MAHxkSfVCkkdmIEwDXzFGzisFgd6HXEiEfkRM/XpAACOamC3/SyzRjm
	 n8kFXcmR5ce2ElfyDhSGM03TAAho9ae01348goq5ZpimEVYn4ClDRYAMEfv15BIM2V
	 5qUouojRY7b2CiiZG+IiR90SSjLZgLKRVcek6NOui9YMa4eNil9AtxIOU1HtD5y3Ls
	 jos0cGDwkhWhousxNgELtYfr/qxWanWktyCqG+iv5ESAyVXX5Xb/F8ujfs+2z6BSl8
	 VlHjqqi97h+Yl8hcc55eRgCM=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id CA0F940E01B0;
	Tue,  2 Sep 2025 17:04:44 +0000 (UTC)
Date: Tue, 2 Sep 2025 19:04:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 13/20] x86/mce: Unify AMD THR handler with MCA Polling
Message-ID: <20250902170438.GGaLcjpoEhdfAGtBph@fat_crate.local>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-13-865768a2eef8@amd.com>
 <20250902111052.GDaLbQvA2A0b8Ii26k@fat_crate.local>
 <20250902133712.GB18483@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902133712.GB18483@yaz-khff2.amd.com>

On Tue, Sep 02, 2025 at 09:37:13AM -0400, Yazen Ghannam wrote:
> This means we'd need to do another loop through the banks. Their
> MCi_STATUS registers would be cleared. So they could log another error
> before the limit is reset.
> 
> Overall, the goal is to loop through the banks one time and log/reset
> banks as we go through them.

Is there anything special about keeping this looping once? I might've missed
the reason if there were any particular one...

In any case, it sounds to me like you want a wrapper called

	clear_bank(i)

which executes at the end of machine_check_poll() and hides in there all
the possible MCA banks that need to be touched when done with the bank.

It'll still call back'n'forth through the code but at least all will be nicely
abstracted and concentrated.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

