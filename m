Return-Path: <linux-edac+bounces-4149-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A95BADC9A8
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 13:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCB73B658C
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D223C2DBF7D;
	Tue, 17 Jun 2025 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eIam4LQi"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834F202C5D;
	Tue, 17 Jun 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750160538; cv=none; b=LPJJDpa8WprX0tylK2i5T48SkmpJZiGLqs7HGuHDwXbk4EoarZXwdS15dal1p4J8b4ddTA9OtD/qFJIm6XZUdbQAOcQBQN4YXP8fgKtSDcEBaAmrJWpK872cDV1YfjkyS3lU1tA+YOobsiv5DbywkNeWVLBTHm7FsgvsAQPjRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750160538; c=relaxed/simple;
	bh=AWO0cfDxyxQeEmfhVRR0/sqIwN1RCxLHQCyTYId52lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urkqZHTAk01S7IdPqhR8ti+nQQn3oIXanlzABKjmHy+Gx6UnSAlOSjrV1q1Z2VnDMqxTjNzT9VwMJ83vduSWjEx1bYKn4F74VujR9nxyMuWVnVXGvnQ3eggS5F1D7c5HirtccE5YsAVdpbPPh9q6V50I5yiNGcClVzgxLMc/aIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eIam4LQi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5619840E01C9;
	Tue, 17 Jun 2025 11:42:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m9d8qPZqJ9qM; Tue, 17 Jun 2025 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750160526; bh=F63t60WKXtW1zy7ca5a4g7IffJqR3dwiyR4zZcJO3oY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIam4LQi3OXUtzSgl5Boe5qko7FTIUS1Km1uevfO7QsO//r5qJz3+ky8ZD+VqmIg1
	 XSyhxxuN5kWJY3js/vEItp7R5toV/nlW7ecxmEJ5fvkg88Z0a4HX3mrai/JC0KwmbS
	 iouD61sQCbK0aVkLAMTEEWQTrDqB7la02KIjpaTNGbagLtT29p0sI8dg6eLj+fbf7F
	 0rks5VEzjN5dCzwY6Sz1JRh9Bri4YQmWoJlJ1WJ/unq/pn1cpuzWDJOWFlDNdu0IMG
	 UeNbuFmmtrjQwuwT0ftjkn0MUawMF5pL/yKtUsA40mpHU2NnRK3AzEHaUkVd19xqaP
	 9nAe2j4YHBLIm/EWjcnhUMCkeM+CAmZ5opWfx/gdllNXjOl1WK1krcCD8JGSVr3yzN
	 QnKfuRryEJOdyLfBDZeBz0FPK5Li2kI7yLusH0SYCfuxn5HGBeHUF9UBHVy2Two7xt
	 jRsm4zOK/h2xkP8yFQKYUS5BBOzXs+yg5Rfw9pKxF19CNSp5Y4hTdHj9OJlRJClNcW
	 nPimIpnqsMxI9K9oDdVtn065oNjGWM+RXBEwqfeukexzn8ymbBUpMRCZj6D+gOGqC3
	 KJxQD11zrf16XQpWo9ofmZTj8CR++GWu41SZ3kxDY6ga0ZDKXfBxGGtXKfAm3tZ8NP
	 vEwhcuLqumnE24NKtiUE5jRk=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 99BC340E01B3;
	Tue, 17 Jun 2025 11:42:00 +0000 (UTC)
Date: Tue, 17 Jun 2025 13:41:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	yazen.ghannam@amd.com, mario.limonciello@amd.com,
	reox <mailinglist@reox.at>
Subject: Re: [PATCH] EDAC/amd64: Correct number of UMCs for Family 19h Models
 70h-7fh
Message-ID: <20250617114154.GAaFFUgo6SVroOaP02@fat_crate.local>
References: <20250613005233.2330627-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250613005233.2330627-1-avadhut.naik@amd.com>

On Fri, Jun 13, 2025 at 12:51:35AM +0000, Avadhut Naik wrote:
> AMD's Family 19h-based Models 70h-7fh support 4 UMCs per processor die.
> 
> The amd64_edac module, however, assumes only 2 UMCs are supported since
> max_mcs variable for the models has not been explicitly set to 4. The
> same results in incomplete or incorrect memory information being logged
> to dmesg by the module during initialization in some instances.
> 
> Fixes: 6c79e42169fe ("EDAC/amd64: Add support for ECC on family 19h model 60h-7Fh")
> Reported-by: reox <mailinglist@reox.at>
> Closes: https://lore.kernel.org/all/27dc093f-ce27-4c71-9e81-786150a040b6@reox.at/
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Cc: stable@kernel.org
> ---
>  drivers/edac/amd64_edac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 90f0eb7cc5b9..390f5756b66e 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3879,6 +3879,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  			break;
>  		case 0x70 ... 0x7f:
>  			pvt->ctl_name			= "F19h_M70h";
> +			pvt->max_mcs			= 4;
>  			pvt->flags.zn_regs_v2		= 1;
>  			break;
>  		case 0x90 ... 0x9f:
> 
> base-commit: 855b5de2e562c07d6cda4deb08d09dc2e0e2b18d
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

