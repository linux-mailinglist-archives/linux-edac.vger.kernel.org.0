Return-Path: <linux-edac+bounces-1782-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4414E9699BC
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 12:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE321C22CFE
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 10:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24EE1AD25C;
	Tue,  3 Sep 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMwAti1/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17391A4E9D
	for <linux-edac@vger.kernel.org>; Tue,  3 Sep 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358093; cv=none; b=N+b+N/HzN80OqevBOGWc+KGO7EGmGkegQb5eKjzA56llF97+k3SfYQAy/0xjcNyxRGlL3ZPLCGwCK2hXBj4FZcqOSO/bCZRxcvp5rKnlsp1Wi8IKN15g+q1Wdkh3nUJitwVx5/gbpv0hKSy+2fn92XNTxu+FnPB8rzcn/RVuk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358093; c=relaxed/simple;
	bh=6bTRYQZHTglWTJC7wyHP20pyge5C84o1/IGAmWaRwf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3zV2jXRi5RiA4tapVALpkIvwLOT/duigECBXUSZLVj8ngyr23aynrU4LY30yiSGL02Rr17+OOTQiyrNYNEgFloH1Xnu36zAWbmgX4sB8F+yTJDvdz00CZHo9yRuB6zG1cjIVcZga+eq99d+4UGa9svGYJd35KJ9IQBDdzoFr+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jMwAti1/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso8903418e87.0
        for <linux-edac@vger.kernel.org>; Tue, 03 Sep 2024 03:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725358089; x=1725962889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0e+/bOJFRqb0nes1Q9jMToVP1YJTjUlu3i/U84Ta6UA=;
        b=jMwAti1/LOWzUL3x7sa8Uzvlk73tnuwpphcW0l6+fhlAQsajzZCbZsFKXLbwl0YRox
         5WJgljxViOHU7XnnGtj0JomxUXZCBr23hsBEZc6CmYLscfEGIOJSI+K9jDrT71A0Mqw9
         rQAHTNO6wKJaCcInKn1fH1QLjL1J5CJXaWgC+Cmr+usvDx9O7qRSB9u2EmOICDj3bBE4
         TkUviGfybJ6Ma1CF3cw08a1Ky2WUK7Q+ksfVHoGKQTbMbcrnt9/6iJiZJtSxioyMU6KR
         QIdkFaJB1wEQlJdaNrhSWrRh+9Zfr/csWhw/1P8o7O8MwGWK8VLjpCT+EXKOnDWrcFNx
         buhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725358089; x=1725962889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0e+/bOJFRqb0nes1Q9jMToVP1YJTjUlu3i/U84Ta6UA=;
        b=SsiNj+mHmeZVBTBU9YJDANYVwDVzA5zVigQ9A7OHWpw4hZzijSHlmeaFb9xF2K4Pxe
         jHtZ5Ahr/P01NzcOJuN958uEz/p7o94TtEgdagrAu7YR1jUaSPNHo1E8GjBxKo6rk3E3
         jCD2LKpxW5rh1YPilAXoko2rpMGw//59dzGRjXJYLBz0e2/IbKNQGaHZIBop+U8GfxjP
         T2yAxzJGXv2N2yRqhaLwHgqS875qVhiF0NvKCJ+oUM29dI68ikF9aCiIpNtQO0B114h+
         uiEoJ60SeaxiTvLxcR9Paqk1Xr+t2vpCTyInw1YGNOcOw9sRpmJ0akjnY74/4aMyYRRi
         /5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJtV3eyQYRwr4DGKUOckeCx802YVmyB6ObJoIaVu3CtaqAdfcEB78j8I+rCxfQAnTfF7ILqvUZzPv6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dpAVn99nzW/+U0sClsJYoX/KrNz8OfjAbahe5QzDylDv81gZ
	KYWphN18TviP9nww1DAWECv056xHhrp9k29Nd69iRWve4keum53iIbH3s/Nlti8=
X-Google-Smtp-Source: AGHT+IHURSxn8JuHtVJVvoiEiZTlTfhw8w8J8/Z7bW8FeSLPqZdVZHzr8ZEPh/23jMl+hcIYhPbHaA==
X-Received: by 2002:a05:651c:550:b0:2f5:11f6:1b24 with SMTP id 38308e7fff4ca-2f61e0562admr98342451fa.18.1725358088606;
        Tue, 03 Sep 2024 03:08:08 -0700 (PDT)
Received: from linaro.org ([84.232.173.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24b5ad63dsm3808995a12.80.2024.09.03.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 03:08:08 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:08:06 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rajendra Nayak <quic_rjendra@quicinc.com>, bp@alien8.de,
	tony.luck@intel.com, mchehab@kernel.org, rric@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	quic_sibis@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/qcom: Make irq configuration optional
Message-ID: <ZtbgBqYNDBr5d/fy@linaro.org>
References: <20240903060138.3191160-1-quic_rjendra@quicinc.com>
 <ZtbG9plGQfUqVvXo@linaro.org>
 <20240903082720.zcln2da4y6kxju5g@thinkpad>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903082720.zcln2da4y6kxju5g@thinkpad>

On 24-09-03 13:57:20, Manivannan Sadhasivam wrote:
> On Tue, Sep 03, 2024 at 11:21:10AM +0300, Abel Vesa wrote:
> > On 24-09-03 11:31:38, Rajendra Nayak wrote:
> > > On most modern qualcomm SoCs, the configuration necessary to enable the
> > > Tag/Data RAM realted irqs being propagated to the SoC irq controller is
> > 
> > Nitpick: s/realted/related/
> > 
> > > already done in firmware (in DSF or 'DDR System Firmware')
> > > 
> > > On some like the x1e80100, these registers aren't even accesible to the
> > > kernel causing a crash when edac device is probed.
> > > 
> > > Hence, make the irq configuration optional in the driver and mark x1e80100
> > > as the SoC on which this should be avoided.
> > > 
> > > Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
> > 
> > Not sure about this fixes tag though.
> > 
> 
> Because, this commit introduced LLCC node which triggers the probe of the EDAC
> driver leading to the crash.
> 

Fair enough.

> - Mani
> 
> > > Reported-by: Bjorn Andersson <andersson@kernel.org>
> > > Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> > > ---
> > >  drivers/edac/qcom_edac.c           | 8 +++++---
> > >  drivers/soc/qcom/llcc-qcom.c       | 3 +++
> > >  include/linux/soc/qcom/llcc-qcom.h | 2 ++
> > >  3 files changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> > > index d3cd4cc54ace..96611ca09ac5 100644
> > > --- a/drivers/edac/qcom_edac.c
> > > +++ b/drivers/edac/qcom_edac.c
> > > @@ -342,9 +342,11 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
> > >  	int ecc_irq;
> > >  	int rc;
> > >  
> > > -	rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
> > > -	if (rc)
> > > -		return rc;
> > > +	if (!llcc_driv_data->ecc_irq_configured) {
> > > +		rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > >  
> > >  	/* Allocate edac control info */
> > >  	edev_ctl = edac_device_alloc_ctl_info(0, "qcom-llcc", 1, "bank",
> > > diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> > > index 8fa4ffd3a9b5..b1c0ae9991d6 100644
> > > --- a/drivers/soc/qcom/llcc-qcom.c
> > > +++ b/drivers/soc/qcom/llcc-qcom.c
> > > @@ -139,6 +139,7 @@ struct qcom_llcc_config {
> > >  	int size;
> > >  	bool need_llcc_cfg;
> > >  	bool no_edac;
> > > +	bool irq_configured;
> > >  };
> > >  
> > >  struct qcom_sct_config {
> > > @@ -718,6 +719,7 @@ static const struct qcom_llcc_config x1e80100_cfg[] = {
> > >  		.need_llcc_cfg	= true,
> > >  		.reg_offset	= llcc_v2_1_reg_offset,
> > >  		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> > > +		.irq_configured = true,
> > >  	},
> > >  };
> > >  
> > > @@ -1345,6 +1347,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
> > >  	drv_data->cfg = llcc_cfg;
> > >  	drv_data->cfg_size = sz;
> > >  	drv_data->edac_reg_offset = cfg->edac_reg_offset;
> > > +	drv_data->ecc_irq_configured = cfg->irq_configured;
> > >  	mutex_init(&drv_data->lock);
> > >  	platform_set_drvdata(pdev, drv_data);
> > >  
> > > diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> > > index 9e9f528b1370..acad1f4cf854 100644
> > > --- a/include/linux/soc/qcom/llcc-qcom.h
> > > +++ b/include/linux/soc/qcom/llcc-qcom.h
> > > @@ -125,6 +125,7 @@ struct llcc_edac_reg_offset {
> > >   * @num_banks: Number of llcc banks
> > >   * @bitmap: Bit map to track the active slice ids
> > >   * @ecc_irq: interrupt for llcc cache error detection and reporting
> > > + * @ecc_irq_configured: 'True' if firmware has already configured the irq propagation
> > >   * @version: Indicates the LLCC version
> > >   */
> > >  struct llcc_drv_data {
> > > @@ -139,6 +140,7 @@ struct llcc_drv_data {
> > >  	u32 num_banks;
> > >  	unsigned long *bitmap;
> > >  	int ecc_irq;
> > > +	bool ecc_irq_configured;
> > >  	u32 version;
> > >  };
> > >  
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

