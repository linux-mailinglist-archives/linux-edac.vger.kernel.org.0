Return-Path: <linux-edac+bounces-2126-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1266A9A2230
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 14:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4F0281BE8
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 12:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A981DA619;
	Thu, 17 Oct 2024 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A+zuW+ZE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF011C695;
	Thu, 17 Oct 2024 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168124; cv=none; b=PrSKgm6btI/FRGa5PmFswWc+A5SK2HR5VgHLDc4qUAuet43fh7+TaFJTra/kANAw8x8JWvDIGIHkVLPprjTSgE93wDFC2UYCllEqENIamg0f7wW8sDx9DmckVlGibgCCEZF3p12QHonySG1rpLvRP7cZ8I0HBBz0Fk0uzsz18QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168124; c=relaxed/simple;
	bh=TxyNE4LWsh+SUUVvoPKyMDxhFEUHS7A9qg+WMKuZbDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoapEFzzorC/CzZ3Ww1K267VOLJ7Yk/0NOhlWCvI/pJuuoyHDh1fbR+JIqpv83SUIgxXlUxby82cANZ57i44CUOyWm6/tGh0CyKGUX9nR2G2oBIDaPK50u0o4Hrh99hDziA/q1PML85pB3ecOL2/FzubwxSrae/9/1Ojy/bQU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A+zuW+ZE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E618F40E015F;
	Thu, 17 Oct 2024 12:28:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VGCST1WCAEer; Thu, 17 Oct 2024 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729168109; bh=PeHLwZcct5EGxPOPDOFjUJFhNZU2/K11QpjGqe0GtcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+zuW+ZE3ZotcyAt8QQ2mH6hzLcWFrnX72/8IHeGl+xMCopbDnzFSm8/0dSPhsLkY
	 rn19Oc8SI6DzN7qneGW72fv8yHIrxmVIGxJvvQiDZ4S3/p6pWTWdMA8E/WpQGCSIM8
	 XYPTrFhS1cCipBTJyoWi4twV3CxAr21yKkFa21OJMTPO13ZPKfiW3JxqGnX8tDGLdb
	 OTmo96cs4WOCrCS4tgfV94TDdSb7/YBytf7B6fBW6ylA5Aca9QsXow4AZQxiQrWV8l
	 HQ3HD1S0bCTKLW5J1trNiuh0cz9r9EjGi6gM/s3zRTu8Z00i1uVf1+GXFhZmI3qKNE
	 LbWTZqH5bcOwNvgKZ9hRxG5d6yYx6EL8bB2dOklxdnpid/WGefQJWT7N7LTd1LtUV5
	 8mmFIYN2h1oB/wOhQ67JesHrcDBuFpyHxv0sdHVK+hEYtlEEOHWW1PzNuV8yOdBKtZ
	 9lE5y+J3dhSQISXSmkiIttPQrrfy6CVDjsVpOioh4Zt3BZvJjIM0pnwryUMINWPZbM
	 Zojo7vlt0CEZ1hRtTmGTrSapmywfQ8FATTAmfhwvHOFeLXzRZFmPZT1crB7vDHhG3s
	 W849uft/kYhJrAmny+sRM7juc4V58noKIOeDaeDS7/Z76ayR1m/nc95RYV2xk46PLr
	 xZvMMdzSg2O1swMC2nfC8lGE=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7FD640E0169;
	Thu, 17 Oct 2024 12:28:21 +0000 (UTC)
Date: Thu, 17 Oct 2024 14:28:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, linux-edac@vger.kernel.org, shravankr@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] EDAC/bluefield: Use Arm SMC for EMI access on
 BlueField-2
Message-ID: <20241017122816.GUZxEC4B04zA6YsCuS@fat_crate.local>
References: <20240930152030.11773-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930152030.11773-1-davthompson@nvidia.com>

On Mon, Sep 30, 2024 at 11:20:30AM -0400, David Thompson wrote:
> The BlueField EDAC driver supports the first generation BlueField-1 SoC,
> but not the second generation BlueField-2 SoC.  The BlueField-2 SoC is
> different in that only secure accesses are allowed to the External Memory
> Interface (EMI) register block. On BlueField-2, all read/write accesses
> from Linux to EMI registers are routed via Arm Secure Monitor Call (SMC)
> through Arm Trusted Firmware (ATF), which runs at EL3 privileged state.
> 
> On BlueField-1, EMI registers are mapped and accessed directly. In order
> to support BlueField-2, the driver's read and write access methods must
> be extended with additional logic to include secure access to the EMI
> registers via SMCs.
> 
> The driver's probe routine must check the ACPI table for presence of
> the "sec_reg_block" property and ensure the minimum required SMC service
> version is present before enabling the BlueField-2 secure access methods.
> The "sec_reg_block" property is only present in BlueField-2 ACPI table,
> not the BlueField-1 ACPI table.
> 
> Also, the bluefield_edac driver needs two coding style fixes: one fix
> addresses an issue raised by checkpatch, and the other fix provides
> consistency in declaration of #defines.

Do not talk about *what* the patch is doing in the commit message - that
should be obvious from the diff itself. Rather, concentrate on the *why*
it needs to be done.

Imagine one fine day you're doing git archeology, you find the place in
the code about which you want to find out why it was changed the way it 
is now.

You do git annotate <filename> ... find the line, see the commit id and
you do:

git show <commit id>

You read the commit message and there's just gibberish and nothing's
explaining *why* that change was done. And you start scratching your head,
trying to figure out why. Because the damn commit message is not really
helping.

>  struct bluefield_edac_priv {
> +	struct device *dev;
>  	int dimm_ranks[MLXBF_EDAC_MAX_DIMM_PER_MC];
>  	void __iomem *emi_base;
>  	int dimm_per_mc;
> +	bool svc_sreg_support;
> +	u32 sreg_tbl_edac;

Some comments above these members as to what they are, would be good.

>  static u64 smc_call1(u64 smc_op, u64 smc_arg)
> @@ -86,6 +98,71 @@ static u64 smc_call1(u64 smc_op, u64 smc_arg)
>  	return res.a0;
>  }
>  
> +static int bluefield_edac_secure_readl(void __iomem *addr, u32 *result, u32 sreg_tbl)

For all static functions' names:

s/bluefield_edac_//

> +{
> +	struct arm_smccc_res res;
> +	int status;
> +
> +	arm_smccc_smc(MLXBF_READ_REG_32, sreg_tbl, (uintptr_t)addr,
> +		      0, 0, 0, 0, 0, &res);
> +
> +	status = res.a0;
> +
> +	switch (status) {
> +	case SMCCC_RET_NOT_SUPPORTED:
> +	case MLXBF_SMCCC_ACCESS_VIOLATION:
> +		return -1;
> +	default:
> +		*result = (u32)res.a1;
> +		return 0;
> +	}

This is a silly switch-case - just use a normal if-else.

> +}
> +
> +static int bluefield_edac_secure_writel(void __iomem *addr, u32 data, u32 sreg_tbl)
> +{
> +	struct arm_smccc_res res;
> +	int status;
> +
> +	arm_smccc_smc(MLXBF_WRITE_REG_32, sreg_tbl, data, (uintptr_t)addr,
> +		      0, 0, 0, 0, &res);
> +
> +	status = res.a0;
> +
> +	switch (status) {
> +	case SMCCC_RET_NOT_SUPPORTED:
> +	case MLXBF_SMCCC_ACCESS_VIOLATION:
> +		return -1;
> +	default:
> +		return 0;
> +	}

Ditto.

> @@ -109,14 +186,22 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
>  	 * registers with information about the last ECC error occurrence.
>  	 */
>  	ecc_latch_select = MLXBF_ECC_LATCH_SEL__START;
> -	writel(ecc_latch_select, priv->emi_base + MLXBF_ECC_LATCH_SEL);
> +	err = bluefield_edac_writel(priv->emi_base + MLXBF_ECC_LATCH_SEL,
> +				    ecc_latch_select, priv->svc_sreg_support,
> +				    priv->sreg_tbl_edac);
> +	if (err)
> +		dev_err(priv->dev, "ECC latch select write failed.\n");
>  
>  	/*
>  	 * Verify that the ECC reported info in the registers is of the
>  	 * same type as the one asked to report. If not, just report the
>  	 * error without the detailed information.
>  	 */
> -	dram_syndrom = readl(priv->emi_base + MLXBF_SYNDROM);
> +	err = bluefield_edac_readl(priv->emi_base + MLXBF_SYNDROM, &dram_syndrom,
> +				   priv->svc_sreg_support, priv->sreg_tbl_edac);

You're passing three priv members down here. Why don't you simply pass down
@priv itself?

Ditto for the write routine.

> +	if (err)
> +		dev_err(priv->dev, "DRAM syndrom read failed.\n");
> +
>  	serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
>  	derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
>  	syndrom = FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrom);

...

> @@ -279,13 +385,44 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	priv = mci->pvt_info;
> +	priv->dev = dev;
> +
> +	/*
> +	 * The "sec_reg_block" property in the ACPI table determines the method
> +	 * the driver uses to access the EMI registers:
> +	 * a) property is not present - directly access registers via readl/writel
> +	 * b) property is present - indirectly access registers via SMC calls
> +	 *    (assuming required Silicon Provider service version found)
> +	 */
> +	if (device_property_read_u32(dev,
> +				     "sec_reg_block", &priv->sreg_tbl_edac)) {

Please do not do such ugly linebreaks.

> +		priv->svc_sreg_support = false;
> +	} else {
> +		/*
> +		 * Check for minimum required Arm Silicon Provider (SiP) service
> +		 * version, ensuring support of required SMC function IDs.
> +		 */
> +		arm_smccc_smc(MLXBF_SIP_SVC_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
> +		if (res.a0 == MLXBF_SVC_REQ_MAJOR &&
> +		    res.a1 >= MLXBF_SVC_REQ_MINOR) {
> +			priv->svc_sreg_support = true;
> +		} else {
> +			dev_err(dev, "Required SMCs are not supported.\n");
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

