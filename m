Return-Path: <linux-edac+bounces-5590-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F80DCEA2FA
	for <lists+linux-edac@lfdr.de>; Tue, 30 Dec 2025 17:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287F830222D3
	for <lists+linux-edac@lfdr.de>; Tue, 30 Dec 2025 16:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE631A807;
	Tue, 30 Dec 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B9eS9G8c"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88152288F7;
	Tue, 30 Dec 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112678; cv=none; b=TKrpOHR9AGEQ1rIWvPR+tvvuCHZgyfHyvZe97VJSCqtsyJPiy8s6utURFPhPmf9Ym+iRt/Jfw0px5oNmeo/jjdzZIrlt3FJGj8z4otPCLHULOcWW/LQxvOyON52cuUJ8XXfukbym/KoW5VYWBzfOGWmgvLfGYM1yLJX+ZZ6ATlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112678; c=relaxed/simple;
	bh=witkOEmaJJa6AMar4fmkKBviZTDgklWbl48MEC0jFZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFCBzF/vjKp5xE1yEBuWC07uixqDhLEmjYN+5Ylvzn9QHWDCn+qqPz3MToyujKBIkJ+Czf+bFEsF3IxeuWSE8xOhAYkXVeCC3y9gHLspaHs3tn9PWUSfOsuAXJElecUSRMvbyH7M66gQ7x+sYZIcxZZf/QU25mzJ3MMtTvElwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=B9eS9G8c; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7193640E01A9;
	Tue, 30 Dec 2025 16:37:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3f0S4RaI0LrB; Tue, 30 Dec 2025 16:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1767112658; bh=NZ+rojh969nkpdOgRSHifcYt18me/f0kucNgJpB7KNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9eS9G8cdm+fRHqN0BZYnq13q1KcNBWgYhB282bpvos8ydwlVCswiHIb51FHhh4qj
	 m1dVBkvBVhIGSm+6lMPUP45Bwn2L4+BBumfglI352v64M05uUh2uDtsm1YGnHoJMUT
	 wMghrqrEGD4Uz6na4VRhtyb1T8fr6pgTcPYxaYqYs1xro5ReIGTO1sv7fR6FAzaQ6K
	 /+L5JPMakxvCRSu9in5Ez2V3A2lhgArstQzAdj+Z9x+OclsoQTjqrCTbIKLgU4ucOI
	 vuwxUdhpdG5DZ4pFOpc+iauakuOVdGsFt84PvEf+kSKj8OcGYekJtohB7Zyay3HtlX
	 +brCos0TiDqXbQIQXmoddviabdt2m/Wr2q1XiR/2yFwDwOhO/YZKQuCh8+lwm5IxcJ
	 tUGh3kTF6hhraZCUuKdtLPt655FnWqJIOE9rU48Z4Ta98KAGyEet8Hv47KfJDQxDl4
	 +GTJgn0plx34DEys2vxcqRh/SY1O80tZB6bhL4Dt+6VltkjD5mrMGNsCk5l55DpN2G
	 etTNB+JXSGMhBHhpoCQN2RKEw6birA9+/7xSOppB4ArNSVc47VhzvHVJ0gutJ8CL3K
	 PqrwsRN8U34JBum5lqU4VeYLlzujOI/vbavEirrAL8k3hlkDFERfTK+N+YTf9116/Z
	 wASSTJtRqF+Kf2Yjo66YT60s=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7267040E0200;
	Tue, 30 Dec 2025 16:37:27 +0000 (UTC)
Date: Tue, 30 Dec 2025 17:37:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: avoid -Wformat-security warning
Message-ID: <20251230163719.GAaVP_v7oYD3lEEcyu@fat_crate.local>
References: <20251204100231.1034557-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251204100231.1034557-1-arnd@kernel.org>

On Thu, Dec 04, 2025 at 11:02:25AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using a variable as a format string causes a (default-disabled) warning:
> 
> drivers/edac/amd64_edac.c: In function 'per_family_init':
> drivers/edac/amd64_edac.c:3914:17: error: format not a string literal and no format arguments [-Werror=format-security]
>  3914 |                 scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), tmp_name);
>       |                 ^~~~~~~~~
> 
> The code here is safe, but in order to enable the warning by default in
> the future, change this instance to pass the name indirectly.
> 
> Fixes: e9abd990aefd ("EDAC/amd64: Generate ctl_name string at runtime")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/edac/amd64_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 2391f3469961..63fca0ee2c23 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3911,7 +3911,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  	}
>  
>  	if (tmp_name)
> -		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), tmp_name);
> +		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "%s", tmp_name);
>  	else
>  		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "F%02Xh_M%02Xh",
>  			  pvt->fam, pvt->model);
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

