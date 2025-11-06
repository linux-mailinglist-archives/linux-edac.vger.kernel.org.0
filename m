Return-Path: <linux-edac+bounces-5355-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC8C391C6
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 05:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB9E1A24940
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 04:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438AB2D12E7;
	Thu,  6 Nov 2025 04:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YStyB7qj"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A801E1A33;
	Thu,  6 Nov 2025 04:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762404582; cv=none; b=i81JI79vnNLGd0/xY3/xSG70KfHVSBOn18WweiJh1WatUUYTHNqRHDWQwQRWdjUNo28gxNSLqnp/qJUJnlpkFH5UUfB/PDeQMdmmkk8/MQREfWFwssLldC6cyhfk8aQ6WIO71r7GJv9J0Frmu8WQKZMNmekKRAX/VH5a47HfYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762404582; c=relaxed/simple;
	bh=K5q6mFCqEJoiN/KJurCtB8NCrdq395/U9mnU7TWiwP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvKqwfxCMa47qFflXWg85mVbQF34wK+EG2z14gAwTEUfg8uNgCNjpB7dQWJ1wgTs6bWWwPmLOPTUVU+9kc/hMOOAauavr3nd/UDAHSTI+yo3OK1CxvYpyhhRLX5zdeuHZ8mhUTXC9wNl0ZtzqEY3kMGFUYMmi+rSVi7AmXOPuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YStyB7qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5307CC4CEF7;
	Thu,  6 Nov 2025 04:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762404581;
	bh=K5q6mFCqEJoiN/KJurCtB8NCrdq395/U9mnU7TWiwP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YStyB7qjfvn/iLsLoKrii/KL0mjZOMw4rQHVT6Ykoa2Z8Kypqb23rewhbYHNbQrBr
	 U9jQMiR99T6fKVoXmB2PWmdpiVRixaoC1NwiKVuoAPSBGu5AEvlxZXGldUDIiMJn0Q
	 r0ybFQNhmiHFqHmdsnEd5DIfDFcyF7jUrRdcMwUuNk6Bj72IML9RI5Q/hKp9cGRWq/
	 m47Lgpw3j38ZEwDPXWOulGcRRvU/x+yxYroOCbhzltBI25OKAooG6crr9naVtsisuN
	 /z8lQ5r5lYLLGPNYJFc2ePaWbmrra8tYAhByIdI2UIHPGrIe8LmhH8ljhbhSPtHDIs
	 g8JPhX+Tygglg==
Message-ID: <3f138af5-8473-4366-9562-3cdea3862f1a@kernel.org>
Date: Wed, 5 Nov 2025 22:49:40 -0600
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/altera: Handle OCRAM ECC enable after warm reset
To: niravkumarlaxmidas.rabara@altera.com, bp@alien8.de, tony.luck@intel.com
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251103140920.1060643-1-niravkumarlaxmidas.rabara@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251103140920.1060643-1-niravkumarlaxmidas.rabara@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/25 08:09, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> The OCRAM ECC is always enabled either by the BootROM or by the Secure
> Device Manager (SDM) during a power-on reset on SoCFPGA.
> 
> However, during a warm reset, the OCRAM content is retained to preserve
> data, while the control and status registers are reset to their default
> values. As a result, ECC must be explicitly re-enabled after a warm reset.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> ---
>   drivers/edac/altera_edac.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 103b2c2eba2a..a776d61027f2 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -1184,10 +1184,22 @@ altr_check_ocram_deps_init(struct altr_edac_device_dev *device)
>   	if (ret)
>   		return ret;
>   
> -	/* Verify OCRAM has been initialized */
> +	/*
> +	 * Verify that OCRAM has been initialized.
> +	 * During a warm reset, OCRAM contents are retained, but the control
> +	 * and status registers are reset to their default values. Therefore,
> +	 * ECC must be explicitly re-enabled in the control register.
> +	 * Error condition: if INITCOMPLETEA is clear and ECC_EN is already set.
> +	 */
>   	if (!ecc_test_bits(ALTR_A10_ECC_INITCOMPLETEA,
> -			   (base + ALTR_A10_ECC_INITSTAT_OFST)))
> -		return -ENODEV;
> +			   (base + ALTR_A10_ECC_INITSTAT_OFST))) {
> +		if (!ecc_test_bits(ALTR_A10_ECC_EN,
> +				   (base + ALTR_A10_ECC_CTRL_OFST)))
> +			ecc_set_bits(ALTR_A10_ECC_EN,
> +				     (base + ALTR_A10_ECC_CTRL_OFST));
> +		else
> +			return -ENODEV;
> +	}
>   
>   	/* Enable IRQ on Single Bit Error */
>   	writel(ALTR_A10_ECC_SERRINTEN, (base + ALTR_A10_ECC_ERRINTENS_OFST));


Acked-by: Dinh Nguyen <dinguyen@kernel.org>

