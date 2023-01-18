Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3B3672260
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jan 2023 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjARQD5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Jan 2023 11:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjARQDg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Jan 2023 11:03:36 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C72577F0
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:59:29 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id d10so24796129pgm.13
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TkK91UFziEYA9a0PZy5wDygMUGAdbCISJG9fWIp70W4=;
        b=B3LhbX+uC9VzWniTeiFC79j4cyksKvOBeF4ERJMLzjJAJ0kBEKMPqSqRjrT/PPOBoE
         ki9tKLE3N6oMuvkXouwydXttMR+4yu7mmc6xcUF7WUSNjprswDMU8YQMaTaV4C7gfcYg
         NW8z8gOLN9N748d7ZTV73rnDaILNR13zUo13778t0tYnUz/dsVTjywUqPRcCI6BiW+mP
         kvmxVQXOdOFUATNJTmHZjTdUK59QSwidGlSvz29HDI02oR2C9i9v7v9vBYMvFke9dgis
         NPPEe/vGhaXRoxy2WsWSCENrwZIj3rZU8NlD2AJ41cgl1FjCoqLGBN1ESYJNX4whhMY+
         V8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkK91UFziEYA9a0PZy5wDygMUGAdbCISJG9fWIp70W4=;
        b=eYyiNpe1yFCKhlyMjfml9lMa1QklLfkwLpfVOgGokGzHujjayJY7AHSJVUoxwi0Kg+
         CQw//NGQx6r8mKFL/vzc9c9a29te9hjm3UgeMuZc5vHbqgy42odw13d6GQ8L6LJbGPLA
         LqWASq8s21Sy75nHUzeE/91nCsdmGtfEGWh8YmU9g0dad03XImCQsGjQhJSlvNFNtppA
         fcCXEvzLgyNkUiPt9q6ixVxqptg2PVHkDU6+uBfdC9lnDszWtMdjfJJieHyT1JPOMlWn
         dGA7odS3BOO8QqbiUiUOgTWNUbv2OWpByM2vMXgh3F6LPQhKHJPJnYg+OVA7ya1q/Jf+
         O8aQ==
X-Gm-Message-State: AFqh2kpHkh/zoovCZLEYGH4QPn3mzUR44AVOelZZ6EKiklD+9+rSZvDs
        tIzYLQ+0K+oCqIr7nq8/EGi2
X-Google-Smtp-Source: AMrXdXs1YhdyWPpUeoWW8QBJn7XDi2Fy1FHiKv4FDAWn2Ny4J26ydTlpU1GMFDCzrstItkpN1RREqQ==
X-Received: by 2002:aa7:9614:0:b0:58b:b9cc:5724 with SMTP id q20-20020aa79614000000b0058bb9cc5724mr21956409pfg.15.1674057568997;
        Wed, 18 Jan 2023 07:59:28 -0800 (PST)
Received: from thinkpad ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b0057ef155103asm20699260pfb.155.2023.01.18.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:59:28 -0800 (PST)
Date:   Wed, 18 Jan 2023 21:29:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 17/17] soc: qcom: llcc: Do not create EDAC platform
 device on SDM845
Message-ID: <20230118155919.GD4690@thinkpad>
References: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
 <20230118150904.26913-18-manivannan.sadhasivam@linaro.org>
 <d3cd9b7a-6286-a140-d205-6d4b6ca8092d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3cd9b7a-6286-a140-d205-6d4b6ca8092d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 18, 2023 at 04:37:29PM +0100, Krzysztof Kozlowski wrote:
> On 18/01/2023 16:09, Manivannan Sadhasivam wrote:
> > The platforms based on SDM845 SoC locks the access to EDAC registers in the
> > bootloader. So probing the EDAC driver will result in a crash. Hence,
> > disable the creation of EDAC platform device on all SDM845 devices.
> > 
> > The issue has been observed on Lenovo Yoga C630 and DB845c.
> > 
> > Cc: <stable@vger.kernel.org> # 5.10
> > Reported-by: Steev Klimaszewski <steev@kali.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/soc/qcom/llcc-qcom.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> > index 7b7c5a38bac6..8d840702df50 100644
> > --- a/drivers/soc/qcom/llcc-qcom.c
> > +++ b/drivers/soc/qcom/llcc-qcom.c
> > @@ -1012,11 +1012,18 @@ static int qcom_llcc_probe(struct platform_device *pdev)
> >  
> >  	drv_data->ecc_irq = platform_get_irq_optional(pdev, 0);
> >  
> > -	llcc_edac = platform_device_register_data(&pdev->dev,
> > -					"qcom_llcc_edac", -1, drv_data,
> > -					sizeof(*drv_data));
> > -	if (IS_ERR(llcc_edac))
> > -		dev_err(dev, "Failed to register llcc edac driver\n");
> > +	/*
> > +	 * The platforms based on SDM845 SoC locks the access to EDAC registers
> > +	 * in bootloader. So probing the EDAC driver will result in a crash.
> > +	 * Hence, disable the creation of EDAC platform device on SDM845.
> > +	 */
> > +	if (!of_device_is_compatible(dev->of_node, "qcom,sdm845-llcc")) {
> 
> Don't spread of_device_is_compatible() in driver code. You have driver
> data for this.
> 

Yeah, but there is no ID to in the driver data to identify an SoC. I could add
one but is that really worth doing so? Is using of_device_is_compatible() in
drivers discouraged nowadays?

Thanks,
Mani

> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
