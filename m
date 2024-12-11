Return-Path: <linux-edac+bounces-2687-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E31B9ECAD8
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 12:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C151887077
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 11:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020F1EE7A5;
	Wed, 11 Dec 2024 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hqtl/3ey"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6716239BCB;
	Wed, 11 Dec 2024 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733915277; cv=none; b=r8jc7fdqjtMIxopfh3UIfhVH92QmJSdwBUKrFmWPGLbmbq0cMHEK9B7UEfMBRHZHBxqkVmXdqp+6xMPF736p7yJNtqrkZSMv/0JvLE8znWXhGiV/lHGdkRYhBqB/BL2rhrrbcpQiQ+5FfcCBcfMrd+xwJMJSvw2NK88Q2Ssev7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733915277; c=relaxed/simple;
	bh=n198s/UJEM/yqZRmrp9/HGyXPvrMj2GvOxWx1wlC8zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdl5KzYvrgh0c/uAopfS68wX4kffzAIFEBTznCetB6cyo3IUZfmLWW5pgLNYZL1y6rj6xdC7K1lllAg1panVpjnNDUf+zB6XhIox/dZh4CenExaTZDsuqdhDSZq53t6k18kUG5C0Gm1cL8aEOOtJOzqJ36DsUdtd+TxdDMIwg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hqtl/3ey; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3BDC540E02BA;
	Wed, 11 Dec 2024 11:07:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2wimx1OvP8D4; Wed, 11 Dec 2024 11:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733915261; bh=IFkwIihJ/VvJUWe2kYbkC4m9Ruw5N5k+UnlEEIErv/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hqtl/3ey6lJnax02mpg0CmfgnmVr4RvNjze557kJhSmT+qAktB5UTOGpH9ESBG7Hd
	 5N2SJDSNUeJ1KlIjN+54w3TeW7+RkdHBrOYDUTH2AEhlHRcH6AKoKLqMhTi7Q8djRb
	 4eeOvdI6La8RPw/rie2i6BasKU1KCkfQE/RmY3Ltmpe9Q33PLMdz+ttgOvl7xJfZI3
	 nuPYvNlBmds3AcYe6eGYaaOjgd7BFr+uo4BedoyJw41ePFuc+DNvF/HWz4Ny2kRBVk
	 QW5Pvp3mPw/jIQErhmK8w2nceNTuRy+7pNJHj67ri+NDDQQ/yefl9Vu+m/uaRUxMij
	 pXDJmAGfmByEw0vgrMS0DmU6ueSvn8+SmY0ipWrLHswE9Z3N1y2XXEYyuM+AT2vS9y
	 atXRF9ALZS3RJ+AcNWbeXw4jcYQgj2JoWuuKzs/FhGZLZmJlBZQCJ1fGfpfWkRCAGO
	 9zGEqbp6sJVs75HkEqppwP00HMPFJKjt2Pbb/ce+61B0J/lhl9lWLl23oAsMRmAdNh
	 NyGg7lOXhHeijY1EQNBvYje4O6HEZl43jYdljKtaXWH18LjE1mQt1VodOgkAfrK+0O
	 b+lYkMt1RYkVXjPVMEcv4pOPbhnvyhtJwlGvSFKZdymjGZZCK//4TF5nMR28z3MTYe
	 1L6g00LTZHQYVaQvJLMNQ17I=
Received: from zn.tnic (p200300EA971f930C329C23FfFEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:930c:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F95840E0266;
	Wed, 11 Dec 2024 11:07:37 +0000 (UTC)
Date: Wed, 11 Dec 2024 12:07:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>, yazen.ghannam@amd.com
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/amd64: Fix possible module load failure on some
 UMC usage combinations
Message-ID: <20241211110729.GAZ1lycaGYmjgNDGv9@fat_crate.local>
References: <20241210212054.3895697-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210212054.3895697-1-avadhut.naik@amd.com>

On Tue, Dec 10, 2024 at 09:20:00PM +0000, Avadhut Naik wrote:
> Starting Zen4, AMD SOCs have 12 Unified Memory Controllers (UMCs) per
> socket.
> 
> When the amd64_edac module is being loaded, these UMCs are traversed to
> determine if they have SdpInit (SdpCtrl[31]) and EccEnabled (UmcCapHi[30])
> bits set and create masks in umc_en_mask and ecc_en_mask respectively.
> 
> However, the current data type of these variables is u8. As a result, if
> only the last 4 UMCs (UMC8 - UMC11) of the system have been utilized,
> umc_ecc_enabled() will return false. Consequently, the module may fail to
> load on these systems.
> 
> Fixes: e2be5955a886 ("EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh")
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> 1. Change data type of variables from u16 to int. (Boris)
> 2. Modify commit message per feedback. (Boris)
> 3. Add Fixes: and CC:stable tags. (Boris)
> ---
>  drivers/edac/amd64_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index ddfbdb66b794..b1c034214a8d 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3362,7 +3362,7 @@ static bool dct_ecc_enabled(struct amd64_pvt *pvt)
>  
>  static bool umc_ecc_enabled(struct amd64_pvt *pvt)
>  {
> -	u8 umc_en_mask = 0, ecc_en_mask = 0;
> +	int umc_en_mask = 0, ecc_en_mask = 0;
>  	u16 nid = pvt->mc_node_id;
>  	struct amd64_umc *umc;
>  	u8 ecc_en = 0, i;

Hmm, looking at that whole function, it looks kinda clumsy to me. If the point
is to check whether at least one UMC is enabled, why aren't we doing simply
that instead of those silly masks?

Yazen? Did you think about checking anything else here, in addition?

Because if not, this can be written as simple as:

static bool umc_ecc_enabled(struct amd64_pvt *pvt)
{
        u16 nid = pvt->mc_node_id;
        struct amd64_umc *umc;
        bool ecc_en = false; 
        int i;

        /* Check whether at least one UMC is enabled: */
        for_each_umc(i) {
                umc = &pvt->umc[i];
                
                if (umc->sdp_ctrl & UMC_SDP_INIT && 
                    umc->umc_cap_hi & UMC_ECC_ENABLED) {
                        ecc_en = true;
                        break; 
                }       
        }

        edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
        
        return ecc_en;
}

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

