Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D75064AF51
	for <lists+linux-edac@lfdr.de>; Tue, 13 Dec 2022 06:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiLMF2M (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Dec 2022 00:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiLMF2L (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Dec 2022 00:28:11 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A1ABC0F
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 21:28:09 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 36so2784796pgp.10
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 21:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iYoYQhWJou1xY1HILvG4sxk2kvaHAyApw8QYJCywc2w=;
        b=GYoAsi06rrW5fX9uclJQ/U+KcRh994V7NNddvGeQgqaJsIShMY16lqpMQcmkI94N0e
         aXmTcJ49MbnwIobDFBLBR+Oq5Jg9ADxXk1qH2L3pl2tfMq1aQgTwHbrjfmmH/M2Hp8sz
         EK2B8VbkVfZlVGlXpFuJ21ssVb3qa5kF47JoFU56F+vKWXzlh3l3GvjdhLDuYVpT5Ndg
         kbx9gp7N78U6sffwrjRQoTCHhKYqBhmE/TDH0QpIHH3lD5H7fHrQ7x20NwGzSNPpevWC
         hXbXKCS3T17oWNBvzZsNoZovgOwwntIEfWwI9M5sF0/CHraxIT1Lz209ych8BLRjk9k5
         Z/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYoYQhWJou1xY1HILvG4sxk2kvaHAyApw8QYJCywc2w=;
        b=slevrM+yNG30hXy/WJc0XdvcFjJne1c9olliayBHSENv5gc/PvqDDHz3z4eRQvpUUk
         D3XAahk4AQ7oPaU5BSQPs33DgGw8D81GYjrg+8y7qbvd0dJ8iZJVnZQ1d1O7xs0S9gbV
         5bpi+asWAMYDp5oH31SNDGjmOuh4xbHiOROkCBw/VgylRNZZmmMTcFlfZG/unIPyrOFg
         DgnN4jZNYDAUtnbEBIL9s78cWdD63egucwO62evUm4boR8f4pdtv8rE992Oi8q78SZH2
         X+XmcdI5resLhN/ipGeSE8sqQUeK/FypqPqMCQTBm5xU28NWgSZpH8tBSugspJxsOMAD
         bWuw==
X-Gm-Message-State: ANoB5pmOhCk9WrYrfriDGGZ8A8XvIu/dDHg9WXRbhjP1L7mP/PsbaeWS
        oMvumgVfo9ORHQeRrfCGGIUM
X-Google-Smtp-Source: AA0mqf4LHRNZwtxKRfKFXi7Own+x57zRKuhgTPc0qGBE3kpBEnjgCc5OBnfMufu1S7lqqDn6XmcS3A==
X-Received: by 2002:a62:cd0c:0:b0:577:2a9:96ef with SMTP id o12-20020a62cd0c000000b0057702a996efmr21025176pfg.28.1670909289300;
        Mon, 12 Dec 2022 21:28:09 -0800 (PST)
Received: from thinkpad ([220.158.158.136])
        by smtp.gmail.com with ESMTPSA id z13-20020aa79e4d000000b005779110635asm6715221pfq.51.2022.12.12.21.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 21:28:08 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:58:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com
Subject: Re: [PATCH v2 00/13] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Message-ID: <20221213052802.GB4862@thinkpad>
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212192340.evgtbpzmw7hcdolb@halaney-x13s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212192340.evgtbpzmw7hcdolb@halaney-x13s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 12, 2022 at 01:23:40PM -0600, Andrew Halaney wrote:
> On Mon, Dec 12, 2022 at 06:02:58PM +0530, Manivannan Sadhasivam wrote:
> > The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> > accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> > This offset only works for some SoCs like SDM845 for which driver support
> > was initially added.
> >
> > But the later SoCs use different register stride that vary between the
> > banks with holes in-between. So it is not possible to use a single register
> > stride for accessing the CSRs of each bank. By doing so could result in a
> > crash with the current drivers. So far this crash is not reported since
> > EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> > driver extensively by triggering the EDAC IRQ (that's where each bank
> > CSRs are accessed).
> >
> > For fixing this issue, let's obtain the base address of each LLCC bank from
> > devicetree and get rid of the fixed stride.
> >
> > This series affects multiple platforms but I have only tested this on
> > SM8250 and SM8450. Testing on other platforms is welcomed.
> >
> 
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
> 

Thanks!

> I took this for a quick spin on the qdrive3 I've got access to without
> any issue:
> 
>     [root@localhost ~]# modprobe qcom_edac
>     [root@localhost ~]# dmesg | grep -i edac
>     [    0.620723] EDAC MC: Ver: 3.0.0
>     [    1.165417] ghes_edac: GHES probing device list is empty
>     [  594.688103] EDAC DEVICE0: Giving out device to module qcom_llcc_edac controller llcc: DEV qcom_llcc_edac (INTERRUPT)
>     [root@localhost ~]# cat /proc/interrupts | grep ecc
>     174:          0          0          0          0          0          0          0          0     GICv3 614 Level     llcc_ecc
>     [root@localhost ~]#
> 
> Potentially stupid question, but are users expected to manually load the
> driver as I did? I don't see how it would be loaded automatically in the
> current state, but thought it was funny that I needed to modprobe
> myself.
> 
> Please let me know if you want me to do any more further testing!
> 

Well, I always ended up using the driver as a built-in. I do make it module for
build test but never really used it as a module, so didn't catch this issue.

This is due to the module alias not exported by the qcom_edac driver. Below
diff allows kernel to autoload it:

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index f7afb5375293..13919d01c22d 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -419,3 +419,4 @@ module_platform_driver(qcom_llcc_edac_driver);
 
 MODULE_DESCRIPTION("QCOM EDAC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:qcom_llcc_edac");

Please test and let me know. I will add this as a new patch in next version.

Thanks,
Mani

> Thanks,
> Andrew
> 

-- 
மணிவண்ணன் சதாசிவம்
