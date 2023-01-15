Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3912166AF3B
	for <lists+linux-edac@lfdr.de>; Sun, 15 Jan 2023 05:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjAOEBi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 14 Jan 2023 23:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjAOEBc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 14 Jan 2023 23:01:32 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0D3E3B3
        for <linux-edac@vger.kernel.org>; Sat, 14 Jan 2023 20:01:30 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v3so17488637pgh.4
        for <linux-edac@vger.kernel.org>; Sat, 14 Jan 2023 20:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SuDvT5hmb/A4H609Biiti+oUVjkMg6vyt3CXcv7bITM=;
        b=ONA0f5oadq1CpdYP94iQuneIo9uM0M8EtQIYtvbMqXt6Ki77NgAy1BV2HVfqTcAV1m
         lOx8XVEZBn9QIWNZsahLl9Xhjg40qE+R3mbnDgXmpwj6w9YewXp5A5XNozMUyBnL+NOY
         gP4vpht6UnI9tRGboj7CdLmzGLwaejV2Yt1jM/Tn6SLUyHT9vx9tgLFJOLCHpAndEloY
         +79cm+Bc6KEEgZM1Yir8MILhfXWYeFYvOQkbzwSSRuonXlVt30HaRJFiH/zf91jwrepU
         NG8mG7rgceBXWV59OLUPWcuVtC5ZskpyHmDP1ecXxkTJExU+E/LYpRlBTc6tJGD4ZNgt
         QY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuDvT5hmb/A4H609Biiti+oUVjkMg6vyt3CXcv7bITM=;
        b=qyvKEc93s5Vso0Vg+1pJpvRjyYw5Oeduuhy/FLEbWUBztO2fSlRdFLP4jcZY0pe+wk
         fYn8zo1aG3CeEh9ZScvhf8P2QW0k9H3DJ0Cr36Ayu6tbJfGB4WaF+X/lcNk874UbX4KH
         6TCvQOWGeeGI1Rvh9aUmzwVHEes4Y4P0WcADN964J3ghizcPz3k+YWsKU+Z4F+YVB4ul
         2R/TFyNKzD/rg+p10DZIDbR7EKez8R3MioIUDDvq85cwaOmLnVopUlTbXluwkah1HK53
         xYaV2j7qXE05XSzeNyy/1Du15Toc0NhWfutcyrtely+V6PTwVNALA65SqXM+2Vyu5Y/X
         olZg==
X-Gm-Message-State: AFqh2kpKWB/xIsn1nTp/TaglZ+ZmRillYkNOogQER68wd8hMjbT/o5x4
        NlWS5LkvDFMPgAVQ5ui93nl6
X-Google-Smtp-Source: AMrXdXuAd5v6lcA2+isRhKDhIA2LynTJ8MptZ0S7s/aC6lNT7PfD7tvKI2UJ7LxASF9dgNA88LRFwA==
X-Received: by 2002:aa7:910c:0:b0:58a:c289:feb6 with SMTP id 12-20020aa7910c000000b0058ac289feb6mr16563229pfh.17.1673755290157;
        Sat, 14 Jan 2023 20:01:30 -0800 (PST)
Received: from thinkpad ([220.158.159.143])
        by smtp.gmail.com with ESMTPSA id w11-20020a627b0b000000b0058b59c81a29sm7495779pfc.220.2023.01.14.20.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 20:01:29 -0800 (PST)
Date:   Sun, 15 Jan 2023 09:31:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony.luck@intel.com,
        quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v5 15/17] qcom: llcc/edac: Fix the base address used for
 accessing LLCC banks
Message-ID: <20230115040122.GA6568@thinkpad>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
 <20221228084028.46528-16-manivannan.sadhasivam@linaro.org>
 <Y8Kt1uKAIPyl0y+d@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8Kt1uKAIPyl0y+d@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Jan 14, 2023 at 02:27:50PM +0100, Borislav Petkov wrote:
> On Wed, Dec 28, 2022 at 02:10:26PM +0530, Manivannan Sadhasivam wrote:
> > The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
> > accessing the (Control and Status Registers) CSRs of each LLCC bank.
> > This stride only works for some SoCs like SDM845 for which driver
> > support was initially added.
> > 
> > But the later SoCs use different register stride that vary between the
> > banks with holes in-between. So it is not possible to use a single register
> > stride for accessing the CSRs of each bank. By doing so could result in a
> > crash.
> 
> If this patch fixes a crash, then it should be
> 
> Cc: <stable@kernel.org>
> 
> If there are prerequisites to it, they should be CC:stable too.
> 

That's what I did in previous revision but then Krzysztof reported that
backporting would break old DTs. See discussion on v2:
https://lore.kernel.org/lkml/20221212123311.146261-1-manivannan.sadhasivam@linaro.org/

Thanks,
Mani

> So looking at the urgent stuff: patches 1, 3, I'm thinking I can take them
> through the EDAC tree and send them to Linus now, after you've addressed the
> review comments.
> 
> This one can go through some other tree, I presume, but since it fixes a crash
> it should go in now too...
> 
> > For fixing this issue, let's obtain the base address of each LLCC bank from
> > devicetree and get rid of the fixed stride. This also means, we no longer
> 
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
> 
> Personal pronouns are ambiguous in text, especially with so many
> parties/companies/etc developing the kernel so let's avoid them please.
> 
> > need to rely on reg-names property and get the base addresses using index.
> > 
> > First index is LLCC bank 0 and last index is LLCC broadcast. If the SoC
> > supports more than one bank, then those needs to be defined in devicetree
> 
> s/needs/need/
> 
> > for index from 1..N-1.
> > 
> > Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> > Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> > Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
> > Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> With the above addressed, for the EDAC bits:
> 
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
மணிவண்ணன் சதாசிவம்
