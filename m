Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC85A672097
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jan 2023 16:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjARPIy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Jan 2023 10:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjARPIx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Jan 2023 10:08:53 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D71F3C21
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:08:52 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f3so24715804pgc.2
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SKmSPzWqZ8ALeqBUAuKuTur5DqPtQNtoVkZGVtUKqkc=;
        b=SEB1fd7t26dvqJ6O9uhv8Lq/OAzXBLBnnzcNMfGa0vrE61hl7P3K8rUjbUxbeFiCTM
         qBoNJwKVW+Mb5qc/2OQADOVnzVrt6w8bRRLXdOAtK7dPGEEuVLr1StSF0N5QMUNo8wSN
         Eg3C8C9QxHdlnqxGw3laUnLCQRX2zLuH38fMQpBEb0Fd2H5Nupo7MEfko1abDxzSsUO5
         VbBC7oXB+sRc9b0zl5r1nCz4VNMkPScd0/yA+WJsTwq/jumhXW18EQLZsygpnyma3h38
         YJCYHcAulTneVgauNe8+x021oODQ4WD7DljhJ2FMsUy1AiVQd6VlbDaND6FmOeveGaay
         Ss6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKmSPzWqZ8ALeqBUAuKuTur5DqPtQNtoVkZGVtUKqkc=;
        b=AtdxgbBgdXmy5BTB5IUb+5d8p6KnA5d5p11tkVXUkOCDTjmHg2Ib9aMRo7NXNALLww
         knqA+tRV+8+LQLgW6W/qQL6YtSat9iYdBqJ6ZR3V508ssd1hDWZDpqLE7p6b9uxrTeRY
         f6tGzL+o6AB6kdwviYmyF/lLD1QlLt8DbbRhooqzQr5l/klGhmGKhKzh9vCANaRSlTRE
         aqZkrc1rOCv7RNn2ljXkhKzxIqGGrOlqCmR0ezVkLLbqnznjirTk7T/vJ84zt9goxUSK
         fUCwEtvm9nWebNYLHvQU5DLSJqeE+7OShPKnzcgg5qJzqjAwzig7BxXbThxBe1z7udFG
         GNHQ==
X-Gm-Message-State: AFqh2kqGHO9LBBii52kwj/XfRs8sToASze/pY2RmEMkAr7KL5rmM0yU7
        hsDNBE3t9K+sL5KTgveGbS43
X-Google-Smtp-Source: AMrXdXu94e9EBaH7QPB/HyWRyS4Rsufzb4HDL+QkHGMa7jn5NgIhx74pF99ENGwO2XLSyADrPs7hUw==
X-Received: by 2002:aa7:874c:0:b0:57f:f2cd:6180 with SMTP id g12-20020aa7874c000000b0057ff2cd6180mr7572104pfo.0.1674054531780;
        Wed, 18 Jan 2023 07:08:51 -0800 (PST)
Received: from thinkpad ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id y1-20020aa79e01000000b005809a3c1b6asm5835524pfq.201.2023.01.18.07.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:08:50 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:38:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony.luck@intel.com,
        quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v5 16/17] qcom: llcc/edac: Support polling mode for ECC
 handling
Message-ID: <20230118150844.GB4690@thinkpad>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
 <20221228084028.46528-17-manivannan.sadhasivam@linaro.org>
 <Y8Kv0GIk69MhcOjT@zn.tnic>
 <20230115040825.GB6568@thinkpad>
 <Y8Up1kjaIRLlxemH@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8Up1kjaIRLlxemH@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 16, 2023 at 11:41:26AM +0100, Borislav Petkov wrote:
> On Sun, Jan 15, 2023 at 09:38:25AM +0530, Manivannan Sadhasivam wrote:
> > > You need to request the IRQ first and then set edac_op_state above. I.e., this
> > > devm_request_irq() needs to move in the if (ecc_irq > 0) branch above.
> > 
> > May I know why? I also checked other drivers, most of them are doing the same.
> 
> If the others do it, that doesn't mean it is clean.
> 
> What happens to edac_op_state if devm_request_irq() fails?
> 
> I know I know, the probe function will fail and the driver won't load but still,
> this is sloppy. And it could come down to bite us later, when someone
> reorganizes that function.
> 

OK. I just wanted to know the reasoning behind it.

Thanks,
Mani

> So, do all the error checking method determination - polling or interrupt - in
> one place.  Something like this (totally untested ofc, pasting here the whole
> thing to show what I mean):
> 
> static int qcom_llcc_edac_probe(struct platform_device *pdev)
> {
>         struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
>         struct edac_device_ctl_info *edev_ctl;
>         struct device *dev = &pdev->dev;
>         int ecc_irq;
>         int rc;
> 
>         rc = qcom_llcc_core_setup(llcc_driv_data->bcast_regmap);
>         if (rc)
>                 return rc;
> 
>         /* Allocate edac control info */
>         edev_ctl = edac_device_alloc_ctl_info(0, "qcom-llcc", 1, "bank",
>                                               llcc_driv_data->num_banks, 1,
>                                               NULL, 0,
>                                               edac_device_alloc_index());
> 
>         if (!edev_ctl)
>                 return -ENOMEM;
> 
>         edev_ctl->dev = dev;
>         edev_ctl->mod_name = dev_name(dev);
>         edev_ctl->dev_name = dev_name(dev);
>         edev_ctl->ctl_name = "llcc";
>         edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
> 
>         /* Check if LLCC driver has passed ECC IRQ */
>         ecc_irq = llcc_driv_data->ecc_irq;
>         if (ecc_irq > 0) {
>                 rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
>                                       IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
>                 if (!rc) {
>                         edac_op_state = EDAC_OPSTATE_INT;
>                         goto irq_done;
>                 }
>         }
> 
>         /* Fall back to polling mode otherwise */
>         edev_ctl->poll_msec = ECC_POLL_MSEC;
>         edev_ctl->edac_check = llcc_ecc_check;
>         edac_op_state = EDAC_OPSTATE_POLL;
> 
> irq_done:
>         rc = edac_device_add_device(edev_ctl);
>         if (rc) {
>                 edac_device_free_ctl_info(edev_ctl);
>                 return rc;
>         }
> 
>         platform_set_drvdata(pdev, edev_ctl);
> 
>         return rc;
> }
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
மணிவண்ணன் சதாசிவம்
