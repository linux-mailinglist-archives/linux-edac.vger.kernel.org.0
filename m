Return-Path: <linux-edac+bounces-1785-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D32969A1A
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 12:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7661A284A67
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 10:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D941B9855;
	Tue,  3 Sep 2024 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0jO1JGv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6B1B9859
	for <linux-edac@vger.kernel.org>; Tue,  3 Sep 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359133; cv=none; b=Zr1LcBAc3SqoCMd0umOINM5wqxVZ0GoQGYtaZKY5yNEzqASRhD+JuvGcz2arPBKpIau8Qe7aosqvnCJSb9OwYDlQocJMN46+pAlIi5AOQouLpsVesJgR/iCKVkttdNkFXwKSVuJ72cJNl8sNXn7eSIb+fDvKOYJv/V2pND80kf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359133; c=relaxed/simple;
	bh=oN5rF1Mtwe+X1+e6eXEyAVAwAsw9T08tJv9O9Z3jkmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUFcqzVOA7Q+uwcDE7gzzqDnQbL8DZVzTnPwfhSLJvlJypbduZ6F77fWB8hXvpayayqLv6ynSMiAEabgniPgw4I+khkvOuhGKsqtT8G3HBG04Fv3h3muRuTVikxKY2HQ1DQj4tiVAwrhEBiPT/nWSzGp9po/qOqiiYqKQizMVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F0jO1JGv; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8682bb5e79so627506366b.2
        for <linux-edac@vger.kernel.org>; Tue, 03 Sep 2024 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725359130; x=1725963930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FhjOSSPYKdQokRD0f5VUMVTrt7/yXDhsNLWMWB2HXlc=;
        b=F0jO1JGvoPJfFNIhll/q3SGxwZqFptaRlWqemly6wjMoCM03zNwoRLMdnpBfX2eoQe
         zIvXpSdtKXwIUTitf+9j3CASljivJN9GU5jUDI5GrJ+pPF5U++YOzpH5Smbrk1WBRaIB
         tB0epHVBEkG2GMWHq5qc0AhSYRkBnRC6YsClp6aSql4aO698EmyBYDy8ZvukSNJhE9+l
         YKa8eHQnLpXlrEnmE2PE0Lf/8940U51x1hFWbIUM4S+gZ7TWZH6XnU3X5i3YIMh9g3hj
         T7eaZEF83JFBp9uEBTMa04jJg61jLEPrrf3Xb83IstXHHXSbXhcQ8y2RsF2HTeZCmNh6
         YkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359130; x=1725963930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhjOSSPYKdQokRD0f5VUMVTrt7/yXDhsNLWMWB2HXlc=;
        b=o8Zi+VtjrsiEHWL5RDgP0JSyq66uQ+aZCqpo9kzxde5xpMEuIAR10EsNe/wQOsT/d3
         HIkcH8TaW6dj+149sWMrs4Z4uNRaJCtdrTdkx9W4ia1tETk9Bh9Dgv6PoG2NrbdvbJ+r
         POFiqGTjNcJkX4+IGkFgpn0yjNbwvhcigt0y0l1SYBZiAE6i0DKYjtdjW+PHcyx25Lcw
         X3IuQt57v8IWutTU8lhTak4QcN8CH04e64+d9z9epckDIEKizBuapHW9Mt1l83RDai+m
         BaNoZOCvTfAG5h1PDuimATLEHosOACDNlAY6hHN32h1fMMMCq8JKTx2RfkZoL8GsY/Uz
         LZGg==
X-Forwarded-Encrypted: i=1; AJvYcCVxDz/pOaS3WFeJTVJKLWYireNTO4VoclEcj86T/9YxB0FISMYlrwZdYk3X5Ojt30LW77MG2QJOV/8r@vger.kernel.org
X-Gm-Message-State: AOJu0YxXa7LClx2UrQzvq0B9w8dxUjDydQMdliJvVKxOpBpKVIk0YrGs
	zYe70J2ZWoYi6KvAYqvbWKXRQFP0d6p1mPm2SHPU79GcNzDzeXfxYGYIq9CTMYY=
X-Google-Smtp-Source: AGHT+IGZbMC+8AxfRktMaXs8vwVDTnVZtWSHrNzE6z21jvPmy2E9Xiz7kgV5kmhvl7T/ABHn/N3PsQ==
X-Received: by 2002:a17:907:3e83:b0:a86:6fb3:fda5 with SMTP id a640c23a62f3a-a89fae1b889mr519848566b.32.1725359129869;
        Tue, 03 Sep 2024 03:25:29 -0700 (PDT)
Received: from linaro.org ([84.232.173.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6fa9sm663853166b.162.2024.09.03.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 03:25:29 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:25:27 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, bp@alien8.de, tony.luck@intel.com,
	mchehab@kernel.org, rric@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, quic_sibis@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/qcom: Make irq configuration optional
Message-ID: <ZtbkF4lkLqSq65Ws@linaro.org>
References: <20240903101510.3452734-1-quic_rjendra@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903101510.3452734-1-quic_rjendra@quicinc.com>

On 24-09-03 15:45:10, Rajendra Nayak wrote:
> On most modern qualcomm SoCs, the configuration necessary to enable the
> Tag/Data RAM related irqs being propagated to the SoC irq controller is
> already done in firmware (in DSF or 'DDR System Firmware')
> 
> On some like the x1e80100, these registers aren't even accesible to the
> kernel causing a crash when edac device is probed.
> 
> Hence, make the irq configuration optional in the driver and mark x1e80100
> as the SoC on which this should be avoided.
> 
> Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> v2: 
> Minor typo fixed in changelog
> 
>  drivers/edac/qcom_edac.c           | 8 +++++---
>  drivers/soc/qcom/llcc-qcom.c       | 3 +++
>  include/linux/soc/qcom/llcc-qcom.h | 2 ++
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index d3cd4cc54ace..96611ca09ac5 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -342,9 +342,11 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
>  	int ecc_irq;
>  	int rc;
>  
> -	rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
> -	if (rc)
> -		return rc;
> +	if (!llcc_driv_data->ecc_irq_configured) {
> +		rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	/* Allocate edac control info */
>  	edev_ctl = edac_device_alloc_ctl_info(0, "qcom-llcc", 1, "bank",
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 8fa4ffd3a9b5..b1c0ae9991d6 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -139,6 +139,7 @@ struct qcom_llcc_config {
>  	int size;
>  	bool need_llcc_cfg;
>  	bool no_edac;
> +	bool irq_configured;
>  };
>  
>  struct qcom_sct_config {
> @@ -718,6 +719,7 @@ static const struct qcom_llcc_config x1e80100_cfg[] = {
>  		.need_llcc_cfg	= true,
>  		.reg_offset	= llcc_v2_1_reg_offset,
>  		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +		.irq_configured = true,
>  	},
>  };
>  
> @@ -1345,6 +1347,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  	drv_data->cfg = llcc_cfg;
>  	drv_data->cfg_size = sz;
>  	drv_data->edac_reg_offset = cfg->edac_reg_offset;
> +	drv_data->ecc_irq_configured = cfg->irq_configured;
>  	mutex_init(&drv_data->lock);
>  	platform_set_drvdata(pdev, drv_data);
>  
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index 9e9f528b1370..acad1f4cf854 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -125,6 +125,7 @@ struct llcc_edac_reg_offset {
>   * @num_banks: Number of llcc banks
>   * @bitmap: Bit map to track the active slice ids
>   * @ecc_irq: interrupt for llcc cache error detection and reporting
> + * @ecc_irq_configured: 'True' if firmware has already configured the irq propagation
>   * @version: Indicates the LLCC version
>   */
>  struct llcc_drv_data {
> @@ -139,6 +140,7 @@ struct llcc_drv_data {
>  	u32 num_banks;
>  	unsigned long *bitmap;
>  	int ecc_irq;
> +	bool ecc_irq_configured;
>  	u32 version;
>  };
>  
> -- 
> 2.34.1
> 

