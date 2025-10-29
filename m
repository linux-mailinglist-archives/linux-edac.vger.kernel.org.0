Return-Path: <linux-edac+bounces-5259-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736AAC1C699
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 18:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CAB6239C2
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B033C520;
	Wed, 29 Oct 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TPh9yUpp"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAEA3358BF;
	Wed, 29 Oct 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757879; cv=none; b=hWIIyAUpbOOV8U5O18YNqOHaLBqo24toqoLlys1cdpRIFh02EDojg4YiP4xPDMhI1TPWuS0MEUXOOLF9pkepvvnmbJmZfyUgVeiS17015fLiHRdNhxZADBV/95nDDqP5QdiolLfLt9S8kEo7EGaTszptj5xWkfrySkwiJQkrFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757879; c=relaxed/simple;
	bh=b/3xAp3gtlPCyOU2i6iKiC+6rwrJRI2LJEUZeFm3BI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KID6xZce7kB4BNd7jOYUyQSPvVAXiOSKTfkIOOhhclakuMYAvcCKMFZTMsuTg0CsyNx5lqa7Eok6HQ718d7kaBVtsP+beeimoTmZKHmXXIHgpYnpgqZXnSNjyTRZVWTcqMApnsklxb1tE9Nxo5INAmzqW17Y2mmMSO/N1AyTWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TPh9yUpp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 84E0D40E021A;
	Wed, 29 Oct 2025 17:11:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XvSr6Ssn179V; Wed, 29 Oct 2025 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761757867; bh=6mCBYYZdn0PhLS3ufcM12xD6DGHvVl4j7clRBlgywMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPh9yUppyPGugYHAAwonSPZ09LUmJjUB3aKL9T5JCd5TSys9IAefzgfUU4orL5ErF
	 spbm4r6q6ZJJJcJP8l7pwjyMuCGbWHupvEgXR9DG4mf1ZWqh+ytGg5frb+YwrYrGQS
	 oVg9C5OEFA/s7/7H4hd+7hxiI87K9lV2WEcXhhg+c2nLeSb0YA/uDaf6DR86f0JOOy
	 m8UJEpdbuN1rlxTYIox+WdPTALvBQki/RQHWxvuscLDSE2XnCnyUOOxZ1c4XophgY1
	 Q+ZARQ9RmygsMQXC1FWDaxa0KMrrfOdWQK5Q6LYs3f30Tyotb/FlqyI2hyK974IoWJ
	 hELyoBMbsinsN/UdAEDW3YD2S29QokQyQw7PR5DN+i2oWSk7qBViBXyl4UclRhbc0I
	 J8KR+xpfCB+EjuZeFUudysNz0FqeoDlU3blxKb9/O7LXk/AoTu1mBrFbCWDC6Q4dLV
	 beSWqxELs3IpUifLIN2mbWk0qU1hUsQgtE3utdG1KbBm+fj+ItSB5DzqlXm9MfNkkp
	 om+9TMZ8Q5rDHt8HBb5AC0IPfa9ACGsvv6fs2jvhDH/LWS5kCtHjq0/uIJXVs7b2sw
	 7P824UfpGfZuW/KeJzoTDS3Q9M/Fnm05YLpapPNidKAtYnRq0F2oKX7bPO5kR2QQHX
	 Ui3GOuA7fOrrmWd1EDnUvMxg=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8D0C340E00DA;
	Wed, 29 Oct 2025 17:11:03 +0000 (UTC)
Date: Wed, 29 Oct 2025 18:10:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] EDAC/amd64: Set zn_regs_v2 flag for all AMD Family
 1Ah-based SOCs
Message-ID: <20251029171057.GFaQJKoUUKI_VM2GXn@fat_crate.local>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-4-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013173632.1449366-4-avadhut.naik@amd.com>

On Mon, Oct 13, 2025 at 05:30:42PM +0000, Avadhut Naik wrote:
> The zn_regs_v2 flag should be set for all AMD Family 1Ah-based SOCs.
> 
> Set the flag once for all 1Ah-based SOCs and avoid repetetive assignment.

Unknown word [repetetive] in commit message.
Suggestions: ['repetitive', 'repetitively', 'recitative', 'putative']

Please introduce a spellchecker into your patch creation workflow.

> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 2391f3469961..832f9675e7b0 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3779,6 +3779,8 @@ static int per_family_init(struct amd64_pvt *pvt)
>  	else
>  		pvt->ops = &dct_ops;
>  
> +	pvt->flags.zn_regs_v2 = (pvt->fam >= 0x1A) ? 1 : 0;
> +
>  	switch (pvt->fam) {
>  	case 0xf:
>  		tmp_name				= (pvt->ext_model >= K8_REV_F) ?
> @@ -3887,20 +3889,14 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		switch (pvt->model) {
>  		case 0x00 ... 0x1f:
>  			pvt->max_mcs            = 12;
> -			pvt->flags.zn_regs_v2   = 1;
> -			break;
> -		case 0x40 ... 0x4f:
> -			pvt->flags.zn_regs_v2   = 1;
>  			break;
>  		case 0x50 ... 0x57:
>  		case 0xc0 ... 0xc7:
>  			pvt->max_mcs            = 16;
> -			pvt->flags.zn_regs_v2   = 1;
>  			break;
>  		case 0x90 ... 0x9f:
>  		case 0xa0 ... 0xaf:
>  			pvt->max_mcs            = 8;
> -			pvt->flags.zn_regs_v2   = 1;
>  			break;
>  		}

I'm not sure about this: if we hoist this particular assignment up, then
what's the point of the tabellary switch-case where you can see at a quick
glance, all the settings that we do per model...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

