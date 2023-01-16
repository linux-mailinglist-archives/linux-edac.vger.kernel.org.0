Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9344666BC08
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jan 2023 11:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjAPKn5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Jan 2023 05:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjAPKnD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Jan 2023 05:43:03 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381031A974;
        Mon, 16 Jan 2023 02:41:32 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80CE51EC05BC;
        Mon, 16 Jan 2023 11:41:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673865690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yEQvkWHdGtRI1RMZOOmWGxvfPmeNlATkYgahQimwKSM=;
        b=USy4JWwxnyoxCDfKgh1VCFgGGj8GNEYkrDkNHGM4qiHTLPijXA11LEogNKFQCz8rcpBkxA
        4etIob4nAFGkoxhaflzuO8rUzpMNAQwQYQId+LjrusBTmZlz4HUyojN9CPW+xODSKjj29X
        FoCADdEP6h13o0GQt+SIo/gVhxyg/e0=
Date:   Mon, 16 Jan 2023 11:41:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony.luck@intel.com,
        quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v5 16/17] qcom: llcc/edac: Support polling mode for ECC
 handling
Message-ID: <Y8Up1kjaIRLlxemH@zn.tnic>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
 <20221228084028.46528-17-manivannan.sadhasivam@linaro.org>
 <Y8Kv0GIk69MhcOjT@zn.tnic>
 <20230115040825.GB6568@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230115040825.GB6568@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jan 15, 2023 at 09:38:25AM +0530, Manivannan Sadhasivam wrote:
> > You need to request the IRQ first and then set edac_op_state above. I.e., this
> > devm_request_irq() needs to move in the if (ecc_irq > 0) branch above.
> 
> May I know why? I also checked other drivers, most of them are doing the same.

If the others do it, that doesn't mean it is clean.

What happens to edac_op_state if devm_request_irq() fails?

I know I know, the probe function will fail and the driver won't load but still,
this is sloppy. And it could come down to bite us later, when someone
reorganizes that function.

So, do all the error checking method determination - polling or interrupt - in
one place.  Something like this (totally untested ofc, pasting here the whole
thing to show what I mean):

static int qcom_llcc_edac_probe(struct platform_device *pdev)
{
        struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
        struct edac_device_ctl_info *edev_ctl;
        struct device *dev = &pdev->dev;
        int ecc_irq;
        int rc;

        rc = qcom_llcc_core_setup(llcc_driv_data->bcast_regmap);
        if (rc)
                return rc;

        /* Allocate edac control info */
        edev_ctl = edac_device_alloc_ctl_info(0, "qcom-llcc", 1, "bank",
                                              llcc_driv_data->num_banks, 1,
                                              NULL, 0,
                                              edac_device_alloc_index());

        if (!edev_ctl)
                return -ENOMEM;

        edev_ctl->dev = dev;
        edev_ctl->mod_name = dev_name(dev);
        edev_ctl->dev_name = dev_name(dev);
        edev_ctl->ctl_name = "llcc";
        edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;

        /* Check if LLCC driver has passed ECC IRQ */
        ecc_irq = llcc_driv_data->ecc_irq;
        if (ecc_irq > 0) {
                rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
                                      IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
                if (!rc) {
                        edac_op_state = EDAC_OPSTATE_INT;
                        goto irq_done;
                }
        }

        /* Fall back to polling mode otherwise */
        edev_ctl->poll_msec = ECC_POLL_MSEC;
        edev_ctl->edac_check = llcc_ecc_check;
        edac_op_state = EDAC_OPSTATE_POLL;

irq_done:
        rc = edac_device_add_device(edev_ctl);
        if (rc) {
                edac_device_free_ctl_info(edev_ctl);
                return rc;
        }

        platform_set_drvdata(pdev, edev_ctl);

        return rc;
}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
