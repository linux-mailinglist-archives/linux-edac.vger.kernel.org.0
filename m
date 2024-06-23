Return-Path: <linux-edac+bounces-1345-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DDE913923
	for <lists+linux-edac@lfdr.de>; Sun, 23 Jun 2024 11:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342842812BF
	for <lists+linux-edac@lfdr.de>; Sun, 23 Jun 2024 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B297841C77;
	Sun, 23 Jun 2024 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DHKm+s+y"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA542D052;
	Sun, 23 Jun 2024 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719133333; cv=none; b=MqExtovWRtsV+Q5V9lvuTR0DZQvk/AVEAPgoDKvIHgu6X5zgw094VYs5B/dLDDAEb9DS8c0K6pCaCkM8I+9aiYyPnP4s95nnbkekBeOkWz2tWKk5P/GZETXfurASQzMz4St/tFKuiyuvLVJLhqky5Lo6JAicECknTxyXoUxYjpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719133333; c=relaxed/simple;
	bh=jKJAFcJW1Q6w2ov570G6M9SEGTz+5w/xAOnFiPkm6iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiEqLuHo49987aR7Om3JTFVHPrDCparvsh/Ceud37nqWulq77mUWLZ94pRTDzFOi/HrHqa7z1zBvJB8XKdqlFVrU3va5+U7gBMJ/S04dXxaE3iWF7SALsvHOn5sT3BWlrnemk7yaHZVGQQADshQpF+RBNqKQdumbcoxN4VDXBio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DHKm+s+y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0301540E021A;
	Sun, 23 Jun 2024 09:02:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Rh3-T0MBlHgW; Sun, 23 Jun 2024 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719133325; bh=hzJd8/e356IKfaA5iu57gDT9Jm14uRC62AGmMDtiOxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHKm+s+ymLoUzgvQLitFtYguXtyqaZu/lBrp4M6eelsn60/O/1NlBC4VUqyCEfn0t
	 uNjdXL9+yP9PIMJsdhym0lmgXHfyivVlMTZEyIzbvlyAz5CksA3aP2gLnUn1XA/IbJ
	 GyD1ORnj2NRM19yBR4zNcSJDZ6qnlG/p2TUkrIp9rB0avrtHxYOJXNxd7Rwr7l/t/V
	 rjtFh+FO9+qB2B2+KVSMX5L8Zsc9eSeQLlMqMUtOLvTswNtVMnK8ePyMkQBDw3GbNW
	 A7fUvDNQlNTyLJ3JUh7Rx6O5ujA1Y4ElwhvusSMSz316OK5VDscK04GNHWGqtoRuxq
	 lCFTMbH37WgCS4JNVvSQQyc5VCJp7NbuLycowELsFgCZ7ONkvRjN3aq3VEf2ykAtsD
	 sU/GeSpvYN3Is7IXTd3kRsT2RvsJydh3IYCQuqKK3Zg5+erc6BYjzjYqKKm4vxb8mP
	 eW9VHLHy6C4vtxfF0+z+885MixedfBFCSj0lBf9YqH1loZgU18XHwl/hcHE5iBAkwi
	 okyHgAvnl1iQ5VWnb1gF3sItDls0vKQxelaGWNmEc+ZwP+QNfQU0te4WUqHa8c9HTR
	 OdUZALB6QEbGxE4gRtZvhWNNtRwxs8VIpMkkpYo77h7fmiDZ3Zp2OngSbrQ+rkS3FM
	 OvKPCHZambN2SGUwZmYgd38k=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C688140E0219;
	Sun, 23 Jun 2024 09:01:54 +0000 (UTC)
Date: Sun, 23 Jun 2024 11:01:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jai Arora <jai.arora@samsung.com>
Cc: tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	aswani.reddy@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [Patch v1] EDAC/dmc520: Use devm_platform_ioremap_resource()
Message-ID: <20240623090148.GAZnfkfCvwvLQCUeGN@fat_crate.local>
References: <CGME20240618110747epcas5p2cda870f60796f0357df40ea85df8e0b7@epcas5p2.samsung.com>
 <20240618110226.97395-1-jai.arora@samsung.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618110226.97395-1-jai.arora@samsung.com>

On Tue, Jun 18, 2024 at 04:32:26PM +0530, Jai Arora wrote:
> platform_get_resource() and devm_ioremap_resource() are wrapped up in the
> devm_platform_ioremap_resource() helper. Use the helper and get rid of the
> local variable for struct resource *. We now have a function call less.
> 
> Signed-off-by: Jai Arora <jai.arora@samsung.com>
> ---
>  drivers/edac/dmc520_edac.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
> index 4e30b989a1a4..5e52d31db3b8 100644
> --- a/drivers/edac/dmc520_edac.c
> +++ b/drivers/edac/dmc520_edac.c
> @@ -480,7 +480,6 @@ static int dmc520_edac_probe(struct platform_device *pdev)
>  	struct mem_ctl_info *mci;
>  	void __iomem *reg_base;
>  	u32 irq_mask_all = 0;
> -	struct resource *res;
>  	struct device *dev;
>  	int ret, idx, irq;
>  	u32 reg_val;
> @@ -505,8 +504,7 @@ static int dmc520_edac_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Initialize dmc520 edac */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	reg_base = devm_ioremap_resource(dev, res);
> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(reg_base))
>  		return PTR_ERR(reg_base);
>  
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

