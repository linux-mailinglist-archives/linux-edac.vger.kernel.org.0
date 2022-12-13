Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B8464BB6D
	for <lists+linux-edac@lfdr.de>; Tue, 13 Dec 2022 18:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiLMR5v (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Dec 2022 12:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiLMR5s (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Dec 2022 12:57:48 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2877065FB
        for <linux-edac@vger.kernel.org>; Tue, 13 Dec 2022 09:57:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c13so2741520pfp.5
        for <linux-edac@vger.kernel.org>; Tue, 13 Dec 2022 09:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=opAga5NytnN90LYH/jNZqiNTmgPT7NfAYJd2Euocw8U=;
        b=h5lH2SaAjfj5nZRgT3MlmV0bU4ktCOBs1Us5zj/vVE/eHkYdKdWHa9z2rOsNxE23Zp
         AvEASOnPtLEGudWCQE2Aou29D4FLJKnsu8EZ177IllFGVSqEu88pq6wR1wfudFu21/47
         OXkLOZuGm7c4zCDnCT810zUnH9DkhWZIWgnc66Dm8lfmKyuDURNCgk+c7dmSxzcNZ+4i
         oh8tnabQghXCOI02SQFz71NmJW92BfTj7hd3S3yjUXxwS4WXoIb5awcV9blzVnKSW4YR
         PIvNcH1iQ/Pz02G6EBxYZYFx1Jgrbe6lx5w/Q1W3Y9QDzoVOS8/JoRtc+iQAN1PYzxcB
         bLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opAga5NytnN90LYH/jNZqiNTmgPT7NfAYJd2Euocw8U=;
        b=31w3EGOAmk+O5n8O/jB/t0B59Zl4i2JaSB5i5L87JwpgDbW9EctraIZl6vM9s9PTes
         PVmgDIW/GiwECWukfxkcarFEHiergaxgN3dCLYcecXo5ceQK2MsrW+eE285xaj0HGX7X
         hipZ93THXyXRks2gdEcH5tM5azVwelx51BBSoPwjemlfEZxXCDTzE3jKike9BMoTCn/Y
         yOIaEqqqU3HA6oLLh/OEwl6xfxnhSxSNGqYt7bnGezrnA1Eo12xdGr2cqZ7RDA/5KEcU
         n1T6J9B6Qx5oPTtpxJH0Rk3CoOWkL/6wU3pzUY1X1AxlsVbbEWr1acguLrHIeCcMnSuJ
         FwPg==
X-Gm-Message-State: ANoB5pk1ESii9/KZdURqwB6JQz0mnQga92LKlodpiOaUSu3V9pVKc4/+
        0ab0SnU/t8iV8CNFWE3PjWnX/Gce6FgA2c8=
X-Google-Smtp-Source: AA0mqf6pTOvUT+TVngBCj6bDScNP+fRE5DB00eZbQPooYfnBCOCmTI1M7ZZsxiAv4tRky/H9QIHriw==
X-Received: by 2002:aa7:828d:0:b0:574:9a46:6306 with SMTP id s13-20020aa7828d000000b005749a466306mr21729213pfm.20.1670954265596;
        Tue, 13 Dec 2022 09:57:45 -0800 (PST)
Received: from thinkpad ([27.111.75.5])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79ac8000000b0056da63c8515sm8179465pfp.91.2022.12.13.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:57:44 -0800 (PST)
Date:   Tue, 13 Dec 2022 23:27:38 +0530
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
Message-ID: <20221213175738.GI4862@thinkpad>
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212192340.evgtbpzmw7hcdolb@halaney-x13s>
 <20221213052802.GB4862@thinkpad>
 <ec64e3a0-085d-7830-fd4e-6969c1c9bbdf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec64e3a0-085d-7830-fd4e-6969c1c9bbdf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 13, 2022 at 05:54:56PM +0100, Krzysztof Kozlowski wrote:
> On 13/12/2022 06:28, Manivannan Sadhasivam wrote:
> > On Mon, Dec 12, 2022 at 01:23:40PM -0600, Andrew Halaney wrote:
> >> On Mon, Dec 12, 2022 at 06:02:58PM +0530, Manivannan Sadhasivam wrote:
> >>> The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> >>> accessing the (Control and Status Regsiters) CSRs of each LLCC bank.
> >>> This offset only works for some SoCs like SDM845 for which driver support
> >>> was initially added.
> >>>
> >>> But the later SoCs use different register stride that vary between the
> >>> banks with holes in-between. So it is not possible to use a single register
> >>> stride for accessing the CSRs of each bank. By doing so could result in a
> >>> crash with the current drivers. So far this crash is not reported since
> >>> EDAC_QCOM driver is not enabled in ARM64 defconfig and no one tested the
> >>> driver extensively by triggering the EDAC IRQ (that's where each bank
> >>> CSRs are accessed).
> >>>
> >>> For fixing this issue, let's obtain the base address of each LLCC bank from
> >>> devicetree and get rid of the fixed stride.
> >>>
> >>> This series affects multiple platforms but I have only tested this on
> >>> SM8250 and SM8450. Testing on other platforms is welcomed.
> >>>
> >>
> >> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
> >>
> > 
> > Thanks!
> > 
> >> I took this for a quick spin on the qdrive3 I've got access to without
> >> any issue:
> >>
> >>     [root@localhost ~]# modprobe qcom_edac
> >>     [root@localhost ~]# dmesg | grep -i edac
> >>     [    0.620723] EDAC MC: Ver: 3.0.0
> >>     [    1.165417] ghes_edac: GHES probing device list is empty
> >>     [  594.688103] EDAC DEVICE0: Giving out device to module qcom_llcc_edac controller llcc: DEV qcom_llcc_edac (INTERRUPT)
> >>     [root@localhost ~]# cat /proc/interrupts | grep ecc
> >>     174:          0          0          0          0          0          0          0          0     GICv3 614 Level     llcc_ecc
> >>     [root@localhost ~]#
> >>
> >> Potentially stupid question, but are users expected to manually load the
> >> driver as I did? I don't see how it would be loaded automatically in the
> >> current state, but thought it was funny that I needed to modprobe
> >> myself.
> >>
> >> Please let me know if you want me to do any more further testing!
> >>
> > 
> > Well, I always ended up using the driver as a built-in. I do make it module for
> > build test but never really used it as a module, so didn't catch this issue.
> > 
> > This is due to the module alias not exported by the qcom_edac driver. Below
> > diff allows kernel to autoload it:
> > 
> > diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> > index f7afb5375293..13919d01c22d 100644
> > --- a/drivers/edac/qcom_edac.c
> > +++ b/drivers/edac/qcom_edac.c
> > @@ -419,3 +419,4 @@ module_platform_driver(qcom_llcc_edac_driver);
> >  
> >  MODULE_DESCRIPTION("QCOM EDAC driver");
> >  MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:qcom_llcc_edac");
> 
> While this is a way to fix it, but instead of creating aliases for wrong
> names, either a correct name should be used or driver should receive ID
> table.
> 

I'm not sure how you'd fix it with a _correct_ name here. Also, the id table is
an overkill since there is only one driver that is making use of it. And
moreover, there is no definite ID to use.

Thanks,
Mani

> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
