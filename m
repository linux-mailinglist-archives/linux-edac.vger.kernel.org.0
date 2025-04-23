Return-Path: <linux-edac+bounces-3665-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3C3A98A12
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 14:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F23AB793
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BCC2701B7;
	Wed, 23 Apr 2025 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibOEyq04"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70083182
	for <linux-edac@vger.kernel.org>; Wed, 23 Apr 2025 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745412365; cv=none; b=roueYQdxGADnZTN6fHskJSBwycEIdjpn+/CHILxHC/BPomyQkjYB/l/UHgyfXcywD1AS0/2tn02Rn/A74M9l1SZs5slH+6V6P40I5wk+SNJECHZf6MQ9urVerKcRGMAKO+Nkr5K0paRkmq5ZV8fpN9g9qjjVTNN4VtULxoL/+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745412365; c=relaxed/simple;
	bh=RdVIsQcwaYaNZcrLtpMJb7+sOwFoo6Ay9jN4KPWHpQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0qK6ZHzKCb4VN5c5y7UYxUVPmYN53/qXUrE4RrmMN9y0pseFz4LVb/5ww5PBmp+Bfpxjcr0APuGeiTBrCCEvIR2CXbQ6mxcFY1KUmLn8wXX8xllwfU1VfchW6JV+HIciGqWxiOaH5/c/IiQ2woXGXfn5X1B6LUcEc8SNEZs2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibOEyq04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFA9C4CEE2;
	Wed, 23 Apr 2025 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745412364;
	bh=RdVIsQcwaYaNZcrLtpMJb7+sOwFoo6Ay9jN4KPWHpQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ibOEyq04n0kJZYFjBzIVAfba4faQ+SkwlTGaid34annbsTvWT1mU3ATn0E2ncjTAD
	 JI3/isUlSe0WRjLNQE6r4YLAw77RgmRDlxc4w3xzi0N0WZbJKyG1ZR3/1SLAzMBESa
	 by6yXzVRITKmHqRrXmvbi7yS5+HT+UdvTpMusTHylgcmBA7Apga0hEegaIkDzKEoyl
	 zyw0JY/72sodSKoxVkXwvKtaCZ83flYIhqJXhMV5+N55CymSUF5s4di1sMaE3QEl6Z
	 5nGpMEUdR+AkmMky/rGWC4Z45FLRs20TdtKvgPxuyVv2148ooZhqlNVK92F5i+R3NE
	 kfW2ps28ky59w==
Message-ID: <494fe323-9132-40f8-9b1f-feabcbccd829@kernel.org>
Date: Wed, 23 Apr 2025 14:46:01 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] edac: xilinx: Add EDAC support for Xilinx XilSem
To: Rama devi Veggalam <rama.devi.veggalam@amd.com>,
 linux-edac@vger.kernel.org, git-dev@amd.com, michal.simek@amd.com
Cc: radhey.shyam.pandey@amd.com
References: <20250422162347.3217007-1-rama.devi.veggalam@amd.com>
 <20250422162347.3217007-6-rama.devi.veggalam@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250422162347.3217007-6-rama.devi.veggalam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2025 18:23, Rama devi Veggalam wrote:
> +	if (device_sub_family_code == VERSALNET_SUB_FAMILY_CODE) {
> +		priv->sw_event_node_id = VERSAL_NET_EVENT_ERROR_SW_ERR;
> +		priv->cram_ce_mask = XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_CRAM_CE;
> +		priv->cram_ue_mask = XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_CRAM_UE;
> +		priv->npi_ue_mask = XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_NPI_UE;
> +	} else if (device_sub_family_code == VERSAL_SUB_FAMILY_CODE) {
> +		priv->sw_event_node_id = VERSAL_EVENT_ERROR_SW_ERR;
> +		priv->cram_ce_mask = XPM_VERSAL_EVENT_ERROR_MASK_XSEM_CRAM_CE_5;
> +		priv->cram_ue_mask = XPM_VERSAL_EVENT_ERROR_MASK_XSEM_CRAM_UE_6;
> +		priv->npi_ue_mask = XPM_VERSAL_EVENT_ERROR_MASK_XSEM_NPI_UE_7;
> +	} else {
> +		edac_printk(KERN_ERR, EDAC_DEVICE, "Invalid Device Sub family code %d\n",
> +			    device_sub_family_code);
> +	}
> +	rc = xlnx_register_event(PM_NOTIFY_CB, priv->sw_event_node_id,
> +				 priv->cram_ce_mask | priv->cram_ue_mask | priv->npi_ue_mask,
> +				 false, xsem_err_callback, dci);
> +	if (rc) {
> +		if (rc == -EACCES)
> +			rc = -EPROBE_DEFER;
> +		goto free_edac_dev;
> +	}
> +
> +	edac_printk(KERN_DEBUG, EDAC_DEVICE, "%s success\n", __func__);

Drop, your drivers are supposed to be silent on success.


> +	return rc;
> +
> +free_edac_dev:
> +	edac_device_del_device(&pdev->dev);
> +free_dev_ctl:
> +	edac_device_free_ctl_info(dci);
> +
> +	return rc;
> +}
> +
> +/**
> + * xsem_edac_remove - Unbind driver from controller.
> + * @pdev:	Platform device.
> + *
> + * Return: Unconditionally 0
> + */

Whatever KPIs you have for amount of documented code we do not care, so
please drop all such silly function comments. There is really no benefit
in documenting what remove() does.


> +static void xsem_edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
> +	struct xsem_edac_priv *priv = dci->pvt_info;
> +
> +	xlnx_unregister_event(PM_NOTIFY_CB, priv->sw_event_node_id,
> +			      priv->cram_ce_mask | priv->cram_ue_mask | priv->npi_ue_mask,
> +			      xsem_err_callback, dci);
> +	edac_device_del_device(&pdev->dev);
> +	edac_device_free_ctl_info(dci);
Best regards,
Krzysztof

