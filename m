Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A88F66A9EB
	for <lists+linux-edac@lfdr.de>; Sat, 14 Jan 2023 08:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjANHPo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 14 Jan 2023 02:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjANHPW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 14 Jan 2023 02:15:22 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECF44492
        for <linux-edac@vger.kernel.org>; Fri, 13 Jan 2023 23:14:41 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y1so25580796plb.2
        for <linux-edac@vger.kernel.org>; Fri, 13 Jan 2023 23:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HKhsOpuLCnUuYKrGdOWev0LYhiTTdn6iHDmtsGs2Ux8=;
        b=AmGUofFetaWzoo2KC8zrI9glVMtwv3ZaJJYX52VcuNzaSlp8egzzuqY+h2svNTe08d
         LPz9qGza1qZDc5Q/nXSTb1gk8ck5E2JTaJQ3X6pudFs1fd9MHzis9ng3sNO+HMJtO7cM
         6gkwjl4x5B8Dyxzj+uoCsMUjek80sgojbIZmSqSgqaIlXEQc2RoAc72iylT29vCgl5ZY
         sLyEX7+vI78Lo+U3smtLcp9k8QsiX5PWumSxsy4c0UBCqHLk0s88kqTsxTtno+qfnQQX
         5+cS46uGBNi47DZ2O38pK6JLJOruC8/oBgImk40wA0UeMNpKwNCjBvr4DYZBctKH/ZV4
         P0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKhsOpuLCnUuYKrGdOWev0LYhiTTdn6iHDmtsGs2Ux8=;
        b=xJeweo9jKLP8yWCn7zcehPAhBWRf8L3NZqlwi5HKHu9gDJwLMgBrC2L9k+L16RZn+O
         eNd+HFz9knWWYVIrJChWxVq9IKIYBF2+QmB5NraW46qVj43bvGWripFYxN51uOk49w25
         Mzh6WHcSSJF3k/KNUTguKEd4VlhLAynaJI2GYRolmuwQ6haLDwZS/y9TnNykHFCucyZt
         1/wPK6avrt1Wd/Vd1ujkELTFi9k/Ha/mYwmelD92XkblRBg5DQ9QKGnJtZUvM8L/63L9
         lFEshWxjmZ03PQzirxNYaY2BUMMyTUT22hs19AMfpRK4xheL9L8PrNEyF+DBCTyNqhJ1
         waOQ==
X-Gm-Message-State: AFqh2koxOKTKsg8EMcTkcoe7rIz9PHIbLLxUUVFPdZlms+eM80zP0ZJO
        Prt4LeAhAX95rN+fS0r0P9m+
X-Google-Smtp-Source: AMrXdXutymROCDuMWqKfdPQf8P4TIrVJVnRl21JTtVs0PshY3E82TsfhCzBOD+5ziEqkZtxyfB866Q==
X-Received: by 2002:a05:6a21:788c:b0:b2:5fcb:8e00 with SMTP id bf12-20020a056a21788c00b000b25fcb8e00mr126916453pzc.29.1673680481209;
        Fri, 13 Jan 2023 23:14:41 -0800 (PST)
Received: from thinkpad ([220.158.159.156])
        by smtp.gmail.com with ESMTPSA id y14-20020a634b0e000000b00476c2180dbcsm12355537pga.29.2023.01.13.23.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:14:40 -0800 (PST)
Date:   Sat, 14 Jan 2023 12:44:36 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com
Subject: Re: [PATCH v5 0/3] Fix crash when using Qcom LLCC/EDAC drivers
Message-ID: <20230114071436.GC6992@thinkpad>
References: <20221129071201.30024-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221129071201.30024-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 29, 2022 at 12:41:58PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series fixes the crash seen on the Qualcomm SM8450 chipset with the
> LLCC/EDAC drivers. The problem was due to the Qcom EDAC driver using the
> fixed LLCC register offsets for detecting the LLCC errors.
> 
> This seems to have worked for SoCs till SM8450. But in SM8450, the LLCC
> register offsets were changed. So accessing the fixed offsets causes the
> crash on this platform.
> 
> So for fixing this issue, and also to make it work on future SoCs, let's
> pass the LLCC offsets from the Qcom LLCC driver based on the individual
> SoCs and let the EDAC driver make use of them.
> 
> This series has been tested on SM8450 based dev board.
> 

Ping! Since there is another LLCC/EDAC series under review, it would be good to
merge both into a single tree (which is qcom one I believe).

Thanks,
Mani

> Thanks,
> Mani
> 
> Changes in v5:
> 
> * Added fixes tag and CCed stable mentioning the dependency
> * Added a patch to fix the build error with COMPILE_TEST
> 
> Changes in v4:
> 
> * Dropped the patches that were already applied
> * Rebased on top of v6.1-rc5
> 
> Changes in v3:
> 
> * Instead of using SoC specific register offset naming convention, used
>   LLCC version based as suggested by Sai
> * Fixed the existing reg_offset naming convention to clearly represent
>   the LLCC version from which the offsets were changed
> * Added Sai's Acked-by to MAINTAINERS patch
> * Added a new patch that removes an extra error no assignment
> 
> Changes in v2:
> 
> * Volunteered myself as a maintainer for the EDAC driver since the current
>   maintainers have left Qualcomm and I couldn't get hold of them.
> 
> Manivannan Sadhasivam (3):
>   soc: qcom: Select REMAP_MMIO for LLCC driver
>   EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()
>   EDAC/qcom: Get rid of hardcoded register offsets
> 
>  drivers/edac/qcom_edac.c           | 119 ++++++++++++++---------------
>  drivers/soc/qcom/Kconfig           |   1 +
>  include/linux/soc/qcom/llcc-qcom.h |   6 --
>  3 files changed, 60 insertions(+), 66 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
