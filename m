Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E04675D99
	for <lists+linux-edac@lfdr.de>; Fri, 20 Jan 2023 20:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjATTEy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Jan 2023 14:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjATTEr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Jan 2023 14:04:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545E215C99;
        Fri, 20 Jan 2023 11:04:35 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D3A351EC0682;
        Fri, 20 Jan 2023 20:04:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674241473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hr1g/BJhTPnJidEpcjn51EqyWhnzDoJlGF/gBnCc6tk=;
        b=T35ws5CToBF0tKj07/fmG/eDvot8DEpEYbJBLtGMMEXrMz6BjQ1CWQ/UGk8hTqZssicQlD
        aLLM64KkAsB4aVKgD4iJWtjh/hGA+rMgLMoCL4c60wnwFVfhcogabzK6sYd6J0HbC9UBLs
        Z2HMle78LjkQHR8eDQp1MCPOGYu8r5c=
Date:   Fri, 20 Jan 2023 20:04:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony.luck@intel.com,
        quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v6 16/17] qcom: llcc/edac: Support polling mode for ECC
 handling
Message-ID: <Y8rlwX6iZpnaKMfX@zn.tnic>
References: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
 <20230118150904.26913-17-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230118150904.26913-17-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 18, 2023 at 08:39:03PM +0530, Manivannan Sadhasivam wrote:
> Not all Qcom platforms support IRQ mode for ECC handling. For those
> platforms, the current EDAC driver will not be probed due to missing ECC
> IRQ in devicetree.
> 
> So add support for polling mode so that the EDAC driver can be used on all
> Qcom platforms supporting LLCC.
> 
> The polling delay of 5000ms is chosen based on Qcom downstream/vendor
> driver.
> 
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/edac/qcom_edac.c     | 50 +++++++++++++++++++++---------------
>  drivers/soc/qcom/llcc-qcom.c | 13 +++++-----
>  2 files changed, 35 insertions(+), 28 deletions(-)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
