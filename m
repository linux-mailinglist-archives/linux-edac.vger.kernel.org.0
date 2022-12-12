Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A8264A4A4
	for <lists+linux-edac@lfdr.de>; Mon, 12 Dec 2022 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiLLQQQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Dec 2022 11:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiLLQQO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Dec 2022 11:16:14 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61415120A6
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 08:16:12 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-14449b7814bso8969330fac.3
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 08:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QwyU+vog2X8+88FLCitziFDJsiNyNVqviVu4YNxzWhA=;
        b=fvsojd5uPuW1sVKC2t09PmNc9dUArcYdabQpt/0gpPl44SKQTVZAHf6tnYHW5q65Ch
         pgK7uV9ZqVBGN9ableCg9wBPxNPcb3Dd9UZBoHjEoswlMdjnA591zi047/wf28vmo7oM
         n7aDK8UR7Gz8qhW+Z2rNjGaEUo7MPdaFp4JutCd5Sk+PIPWlTUsTlV9cvdmuEkl1Z7sy
         ZiAvmrUpTdGOdk4sInfoBGPtKNsP6krjHIx2fi/YILoztKOnjMcF/1B+cglyYuXO4HHV
         PiSidEwEBe+h+xv7HKpRcjoB77iT4aqU83+/VvCSG4wGdh8aLBPZC1t+pon+6z0UUWWJ
         +rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwyU+vog2X8+88FLCitziFDJsiNyNVqviVu4YNxzWhA=;
        b=ddUZtPyZCOsPDhPBMmPJ79ihftIPZpAf4rfPLn1UfX+fNLUSQ7sU5WKm/a3f1fm8+B
         Dll/oFDFBpiP3si1h3z6/xeM7zR7azr+squC5F35i9LW4mvpOqPyU2qvDCX6EWsTempY
         7d6nkaKAPBg77SOTtjRtes69JS2Yt54nPS9R+4FqedDCxk6bmT9YMmE3i2mFITQTwUHn
         7pkHnZ3pnkBjLa0HrsQQDlZNXfo36MRvlPW8K9F1W1BQ4qZoM+abkn0ExjLmnH+nBBfo
         yAh1NxS4O5HIRfvnNSxmMIryO4y6Rthg5E51fQKTBBKLlQWE2KKMxOKzetXzpB1yFCO+
         Y6+g==
X-Gm-Message-State: ANoB5pmTOSskeKKAjrO/vboWJi6vL3a85fqKkWGz7x2gDzzC8ZLvV/al
        /s4W5Xzm/g08mq5tTM190EiT
X-Google-Smtp-Source: AA0mqf4jECA6+WrYPxmdo3NUAL8rdtdjiwMHPdw5qDGbK/O81VmLwSgVRLdL5QKtH6Zx5cDoQDomsg==
X-Received: by 2002:a05:6358:bb9b:b0:e0:23fa:d4c3 with SMTP id df27-20020a056358bb9b00b000e023fad4c3mr1216964rwb.31.1670861771531;
        Mon, 12 Dec 2022 08:16:11 -0800 (PST)
Received: from thinkpad ([103.197.115.108])
        by smtp.gmail.com with ESMTPSA id mp20-20020a17090b191400b00218ae9916c4sm5668820pjb.35.2022.12.12.08.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:16:10 -0800 (PST)
Date:   Mon, 12 Dec 2022 21:46:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com
Subject: Re: [PATCH v2 13/13] qcom: llcc/edac: Support polling mode for ECC
 handling
Message-ID: <20221212161604.GE20655@thinkpad>
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212123311.146261-14-manivannan.sadhasivam@linaro.org>
 <COZYL8MWN97H.MROQ391BGA09@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <COZYL8MWN97H.MROQ391BGA09@otso>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 12, 2022 at 04:53:49PM +0100, Luca Weiss wrote:
> Hi Manivannan,
> 
> On Mon Dec 12, 2022 at 1:33 PM CET, Manivannan Sadhasivam wrote:
> > Not all Qcom platforms support IRQ mode for ECC handling. For those
> > platforms, the current EDAC driver will not be probed due to missing ECC
> > IRQ in devicetree.
> >
> > So add support for polling mode so that the EDAC driver can be used on all
> > Qcom platforms supporting LLCC.
> >
> > The polling delay of 5000ms is chosed based on Qcom downstream/vendor
> > driver.
> 
> I think it does work for me on SM6350, I get this in dmesg:
> 
> [    0.054608] EDAC MC: Ver: 3.0.0
> [    0.273913] EDAC DEVICE0: Giving out device to module qcom_llcc_edac controller llcc: DEV qcom_llcc_edac (POLLED)
> 
> What I've noticed though is that the 5000ms poll you defined in the
> driver doesn't seem to be reflected at runtime? Or am I looking at
> different things?
> 
> / # cat /sys/devices/system/edac/qcom-llcc/poll_msec 
> 1000
> 

Oops... Looks like the interval is hardcoded in edac_device driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/edac/edac_device.c#n449

This clearly needs to be fixed. Will do so in next version.

Thanks a lot for testing the series. I will also consider this as your t-b tag
for SM6350 and driver patches.

Thanks,
Mani

> Regards
> Luca
> 
> >
> > Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/edac/qcom_edac.c     | 37 +++++++++++++++++++++++++-----------
> >  drivers/soc/qcom/llcc-qcom.c | 13 ++++++-------
> >  2 files changed, 32 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> > index 5be93577fc03..f7afb5375293 100644
> > --- a/drivers/edac/qcom_edac.c
> > +++ b/drivers/edac/qcom_edac.c
> > @@ -76,6 +76,8 @@
> >  #define DRP0_INTERRUPT_ENABLE           BIT(6)
> >  #define SB_DB_DRP_INTERRUPT_ENABLE      0x3
> >  
> > +#define ECC_POLL_MSEC			5000
> > +
> >  enum {
> >  	LLCC_DRAM_CE = 0,
> >  	LLCC_DRAM_UE,
> > @@ -283,8 +285,7 @@ dump_syn_reg(struct edac_device_ctl_info *edev_ctl, int err_type, u32 bank)
> >  	return ret;
> >  }
> >  
> > -static irqreturn_t
> > -llcc_ecc_irq_handler(int irq, void *edev_ctl)
> > +static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
> >  {
> >  	struct edac_device_ctl_info *edac_dev_ctl = edev_ctl;
> >  	struct llcc_drv_data *drv = edac_dev_ctl->pvt_info;
> > @@ -328,6 +329,11 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
> >  	return irq_rc;
> >  }
> >  
> > +static void llcc_ecc_check(struct edac_device_ctl_info *edev_ctl)
> > +{
> > +	llcc_ecc_irq_handler(0, edev_ctl);
> > +}
> > +
> >  static int qcom_llcc_edac_probe(struct platform_device *pdev)
> >  {
> >  	struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
> > @@ -356,22 +362,31 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
> >  	edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
> >  	edev_ctl->pvt_info = llcc_driv_data;
> >  
> > +	/* Check if LLCC driver has passed ECC IRQ */
> > +	ecc_irq = llcc_driv_data->ecc_irq;
> > +	if (ecc_irq > 0) {
> > +		/* Use interrupt mode if IRQ is available */
> > +		edac_op_state = EDAC_OPSTATE_INT;
> > +	} else {
> > +		/* Fall back to polling mode otherwise */
> > +		edac_op_state = EDAC_OPSTATE_POLL;
> > +		edev_ctl->poll_msec = ECC_POLL_MSEC;
> > +		edev_ctl->edac_check = llcc_ecc_check;
> > +	}
> > +
> >  	rc = edac_device_add_device(edev_ctl);
> >  	if (rc)
> >  		goto out_mem;
> >  
> >  	platform_set_drvdata(pdev, edev_ctl);
> >  
> > -	/* Request for ecc irq */
> > -	ecc_irq = llcc_driv_data->ecc_irq;
> > -	if (ecc_irq < 0) {
> > -		rc = -ENODEV;
> > -		goto out_dev;
> > -	}
> > -	rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
> > +	/* Request ECC IRQ if available */
> > +	if (ecc_irq > 0) {
> > +		rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
> >  			      IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
> > -	if (rc)
> > -		goto out_dev;
> > +		if (rc)
> > +			goto out_dev;
> > +	}
> >  
> >  	return rc;
> >  
> > diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> > index a29f22dad7fa..e044e6756415 100644
> > --- a/drivers/soc/qcom/llcc-qcom.c
> > +++ b/drivers/soc/qcom/llcc-qcom.c
> > @@ -1011,13 +1011,12 @@ static int qcom_llcc_probe(struct platform_device *pdev)
> >  		goto err;
> >  
> >  	drv_data->ecc_irq = platform_get_irq_optional(pdev, 0);
> > -	if (drv_data->ecc_irq >= 0) {
> > -		llcc_edac = platform_device_register_data(&pdev->dev,
> > -						"qcom_llcc_edac", -1, drv_data,
> > -						sizeof(*drv_data));
> > -		if (IS_ERR(llcc_edac))
> > -			dev_err(dev, "Failed to register llcc edac driver\n");
> > -	}
> > +
> > +	llcc_edac = platform_device_register_data(&pdev->dev,
> > +					"qcom_llcc_edac", -1, drv_data,
> > +					sizeof(*drv_data));
> > +	if (IS_ERR(llcc_edac))
> > +		dev_err(dev, "Failed to register llcc edac driver\n");
> >  
> >  	return 0;
> >  err:
> > -- 
> > 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
