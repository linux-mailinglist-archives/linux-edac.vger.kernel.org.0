Return-Path: <linux-edac+bounces-5509-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FE7C7E2B7
	for <lists+linux-edac@lfdr.de>; Sun, 23 Nov 2025 16:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D9BF345752
	for <lists+linux-edac@lfdr.de>; Sun, 23 Nov 2025 15:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361ED29AB1A;
	Sun, 23 Nov 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="imYZsXmt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3222D23AD;
	Sun, 23 Nov 2025 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763912035; cv=none; b=tbgCU3GztFLst2blZx4iLOXpuOwVrI5VxjFjfqB8S5bM/wIKHL2IhdJLx+rfRN89Of/rXEgvlpCMFm0khaskB0Vd0s1E3C/R8h0atQ4eLPQ+gsAKsjXW7zdGedkQf3kcdG2Adz6J3ozjOwp8ECpvQVh6G/IUNxrfHN+8bRwOO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763912035; c=relaxed/simple;
	bh=JWQRd7G6acbIi85rJP4W2oooivosQAzt9TkXKO10chU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgA1Dxjq5QnRpaCsCCOYO248xazIkyN7JFFEBCqxHFn/Dvp9MimMn4K+LJ1AKtUgt0O+dkzOfYZo94Z1/t/aej5IIDI9QHjyCJHYuCL55jkdUbalReDQyqqp3LP2CAfXWETj3e9s0sLiFyhF/jxx/RAKkI0mp4Bxmtg8/zWQEq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=imYZsXmt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 71CA340E01CD;
	Sun, 23 Nov 2025 15:33:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ACE4ofPTRjCS; Sun, 23 Nov 2025 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763912015; bh=DC7fjxqOorhi0vq2Cld/ZdHAtlAIE/Z71qPK0uep39g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imYZsXmt+WdgTUzMCqR+u7isTvtNMju59Fg0UAREwbsu9pkP4q3u3Bc5Ay7A2/py4
	 A13Wf5nDTBxVldlZOwtpW2Zf/YFR50cOe0yzz8N83CEk7AcbsJG1br9jWvVueVCYLp
	 qPwgEDcRm1qh66g89I449pVDeyBEj8N385R0H/9d7sRxEshs8sdDLHEZOyQgjxCeAx
	 w/1gmz0ErFwRGOwlb2Ouost0DcA1uufqJr9ef+886jWJwrqmIsCt3VQRb+qaY6buui
	 RIN5LgQUczKjvcqZhvY3wnByYWJQdpQIV0efDamh6JMc/QsJjHGK+PrdS8nrkqQYUH
	 mSzfYNky1I7rJfNQ4q7Jh6gGfaaGgkaWo9lO/6RibGvSocdBb0D+YPzurH7Sd2sxIO
	 3oAVSMzuGqQY7Q6uVxSRVVZ6RyoPX+4T3EBEOE0L36T+U8a8ng4M5EWYOb4UN7qWea
	 0twvvxI1WAFmk4nsQXws3kzzvAtWiQYQiuSgzOQwvnxi9W+yFU6iF0PtGzSYzLWZso
	 U1BE7tlKga8kNKbz53GJqamGk2587UBL16Wk5KblSJ5V/xx3AeBJS7YRdawADt6YLO
	 fe+vVuJlt+7YCK5oVa/WHnu7PY/ylB0qsvnsZmQB5rwf6QZN20nLWlnSROM51uUaft
	 lD60WbUdlNUdUtBdjpOlGElQ=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5AF2940E0191;
	Sun, 23 Nov 2025 15:33:25 +0000 (UTC)
Date: Sun, 23 Nov 2025 16:33:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Devang Vyas <devangnayanbhai.vyas@amd.com>
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ramesh Garidapuri <ramesh.garidapuri@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] EDAC/amd64: Add support for family 19h, models 40h-4fh
Message-ID: <20251123153318.GAaSMpPrSZLkzx8D5c@fat_crate.local>
References: <20251123142746.1879744-1-devangnayanbhai.vyas@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251123142746.1879744-1-devangnayanbhai.vyas@amd.com>

On Sun, Nov 23, 2025 at 07:57:45PM +0530, Devang Vyas wrote:

-ENOCOMMITMESSAGE

Use the commit message to explain why those need to load the EDAC driver at
all.

> Co-developed-by: Ramesh Garidapuri <ramesh.garidapuri@amd.com>
> Signed-off-by: Ramesh Garidapuri <ramesh.garidapuri@amd.com>
> Signed-off-by: Devang Vyas <devangnayanbhai.vyas@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index a17f3c0cdfa6..2f6c3c4ed557 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3878,6 +3878,10 @@ static int per_family_init(struct amd64_pvt *pvt)
>  				pvt->max_mcs		= 8;
>  			}
>  			break;
> +		case 0x40 ... 0x4f:
> +			pvt->ctl_name                   = "F19h_M40h";
> +			pvt->max_mcs                    = 4;
> +			break;
>  		case 0x50 ... 0x5f:
>  			pvt->ctl_name			= "F19h_M50h";
>  			break;
> -- 

EDAC patches need to be done against:

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git

the edac-for-next branch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

