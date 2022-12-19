Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5C0650CD8
	for <lists+linux-edac@lfdr.de>; Mon, 19 Dec 2022 14:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiLSNu7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Dec 2022 08:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiLSNu4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Dec 2022 08:50:56 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75455BC87
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 05:50:54 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x66so6274878pfx.3
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 05:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4OfVkgFyuWv/O4DNg94sdS/FVSa58FzsgxawIIgMVAU=;
        b=f3kZod/t7t8SqcZUISMQbdv1VhlpJa1QyhSoACz09KLwbNQAdocCQpOsIX2t+EweoE
         Px7Z9oC1FOIqu0oo09e6CofisZFFyu/s4GZfBIPg6yGDfJQKzKmnAN8VABf3UNloFgGL
         A+yagwpTYmaNcrjYh1kIfad/jgFdwo5L1F/Pr2+UNeCipax5rbosxgMANTFK4Y1Zt+DD
         oXsp0nSf3ZPRRUIl9+J50cUpM467kgbXZFj6xtGhpnqlqbK4ZRj3QFmXuOhA2xw/RN9S
         zGmPs59gCTdTsgloyUjlJy53Y7rhB+LZ2LiTGeCX7G92IORgmxP0xk25n9WqE6UyjLIY
         t/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OfVkgFyuWv/O4DNg94sdS/FVSa58FzsgxawIIgMVAU=;
        b=BZGW/vsMX1YE3rZIejBLVfRfEUOoKcrYQxfUrqEpCO4dPj7GGbW30U7z8HuakGlbzy
         79Wm7YRocJYVz/Rjas737BLroy+20Pq+OxjWfAUai2GyOItMqq9zop3Lb9tmHO31oplf
         Jl4FtA3ypFgvktBdnRQWrUSsKKCK+we+iypHbnS7SJfCJF5FzSUMMGFculH4sDBuxNUc
         h3MPgHvoykJ726KK7AcohKA7crxKW+PwJXIttIePFlgzyKYkfISTKvN09p8i8fkLm/1J
         CK3qegJRM3qwubtCYVYbsGbgCr+oiyYXqW2+tPkduKUPUsKihl9TayPa8pcioimV3Ar8
         ffMQ==
X-Gm-Message-State: ANoB5pkPhcLq4Mg/l/gWieCXflvksjLfUXVxUspAbAzBDAC1ZGbAhMM6
        QjL3uNWfY7Ngl1Ig1pEfbS23
X-Google-Smtp-Source: AA0mqf58zwHfVYBpkQxITdhQuWuLqWHMIDAGkGzKVhO9isGzw/+AhzSj+zJSau1B797hbuYXyPOtww==
X-Received: by 2002:a62:3896:0:b0:576:1c37:5720 with SMTP id f144-20020a623896000000b005761c375720mr37603975pfa.4.1671457853797;
        Mon, 19 Dec 2022 05:50:53 -0800 (PST)
Received: from thinkpad ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id 193-20020a6218ca000000b0056ba6952e40sm6619076pfy.181.2022.12.19.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 05:50:52 -0800 (PST)
Date:   Mon, 19 Dec 2022 19:20:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bp@alien8.de, tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com
Subject: Re: [PATCH v2 00/13] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Message-ID: <20221219135046.GA126558@thinkpad>
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212192340.evgtbpzmw7hcdolb@halaney-x13s>
 <20221213052802.GB4862@thinkpad>
 <ec64e3a0-085d-7830-fd4e-6969c1c9bbdf@linaro.org>
 <20221213175738.GI4862@thinkpad>
 <195a55f1-76e7-3f00-da1f-4ae84f7943c0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <195a55f1-76e7-3f00-da1f-4ae84f7943c0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 13, 2022 at 07:47:17PM +0100, Krzysztof Kozlowski wrote:
> On 13/12/2022 18:57, Manivannan Sadhasivam wrote:
> > On Tue, Dec 13, 2022 at 05:54:56PM +0100, Krzysztof Kozlowski wrote:
> >> On 13/12/2022 06:28, Manivannan Sadhasivam wrote:
> >>> On Mon, Dec 12, 2022 at 01:23:40PM -0600, Andrew Halaney wrote:
> >>>> On Mon, Dec 12, 2022 at 06:02:58PM +0530, Manivannan Sadhasivam wrote:
> >>>>> The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> >>>>> accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> >>>>> This offset only works for some SoCs like SDM845 for which driver support
> >>>>> was initially added.
> >>>>>
> >>>>> But the later SoCs use different register stride that vary between the
> >>>>> banks with holes in-between. So it is not possible to use a single register
> >>>>> stride for accessing the CSRs of each bank. By doing so could result in a
> >>>>> crash with the current drivers. So far this crash is not reported since
> >>>>> EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> >>>>> driver extensively by triggering the EDAC IRQ (that's where each bank
> >>>>> CSRs are accessed).
> >>>>>
> >>>>> For fixing this issue, let's obtain the base address of each LLCC bank from
> >>>>> devicetree and get rid of the fixed stride.
> >>>>>
> >>>>> This series affects multiple platforms but I have only tested this on
> >>>>> SM8250 and SM8450. Testing on other platforms is welcomed.
> >>>>>
> >>>>
> >>>> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
> >>>>
> >>>
> >>> Thanks!
> >>>
> >>>> I took this for a quick spin on the qdrive3 I've got access to without
> >>>> any issue:
> >>>>
> >>>>     [root@localhost ~]# modprobe qcom_edac
> >>>>     [root@localhost ~]# dmesg | grep -i edac
> >>>>     [    0.620723] EDAC MC: Ver: 3.0.0
> >>>>     [    1.165417] ghes_edac: GHES probing device list is empty
> >>>>     [  594.688103] EDAC DEVICE0: Giving out device to module qcom_llcc_edac controller llcc: DEV qcom_llcc_edac (INTERRUPT)
> >>>>     [root@localhost ~]# cat /proc/interrupts | grep ecc
> >>>>     174:          0          0          0          0          0          0          0          0     GICv3 614 Level     llcc_ecc
> >>>>     [root@localhost ~]#
> >>>>
> >>>> Potentially stupid question, but are users expected to manually load the
> >>>> driver as I did? I don't see how it would be loaded automatically in the
> >>>> current state, but thought it was funny that I needed to modprobe
> >>>> myself.
> >>>>
> >>>> Please let me know if you want me to do any more further testing!
> >>>>
> >>>
> >>> Well, I always ended up using the driver as a built-in. I do make it module for
> >>> build test but never really used it as a module, so didn't catch this issue.
> >>>
> >>> This is due to the module alias not exported by the qcom_edac driver. Below
> >>> diff allows kernel to autoload it:
> >>>
> >>> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> >>> index f7afb5375293..13919d01c22d 100644
> >>> --- a/drivers/edac/qcom_edac.c
> >>> +++ b/drivers/edac/qcom_edac.c
> >>> @@ -419,3 +419,4 @@ module_platform_driver(qcom_llcc_edac_driver);
> >>>  
> >>>  MODULE_DESCRIPTION("QCOM EDAC driver");
> >>>  MODULE_LICENSE("GPL v2");
> >>> +MODULE_ALIAS("platform:qcom_llcc_edac");
> >>
> >> While this is a way to fix it, but instead of creating aliases for wrong
> >> names, either a correct name should be used or driver should receive ID
> >> table.
> >>
> > 
> > I'm not sure how you'd fix it with a _correct_ name here. 
> 
> Hm, I assumed that it would be enough if driver name would match device
> name. Currently these two are not in sync. Maybe it's not enough when
> built as module?
> 

Right, for module it is not enough and that's why we need id_table/alias.

> > Also, the id table is
> > an overkill since there is only one driver that is making use of it. And
> > moreover, there is no definite ID to use.
> 
> Every driver with a single device support has usually ID table and it's
> not a problem...
> 

Are you referring to OF/ACPI ID table? Or something else?

Thanks,
Mani

> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
