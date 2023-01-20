Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88B675993
	for <lists+linux-edac@lfdr.de>; Fri, 20 Jan 2023 17:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjATQKk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Jan 2023 11:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjATQKj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Jan 2023 11:10:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE4BC4E91;
        Fri, 20 Jan 2023 08:10:29 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB2051EC04DA;
        Fri, 20 Jan 2023 17:10:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674231027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+Uv2qYI/Acdi8YQFtUpIZmkuRZJh/qURv6bPGDHtKxI=;
        b=IlgRb9IqZibsZVsRONdfAdjTJZyU4XJwavWqV1N3/+bTTHCfVgdVNdlpY+tpLhYivZTFkn
        IBklpJFY9uzz+NQnP5XBoS61Q0go4d+mSCDkx37B3BVykoontsC8MX6LWmBCtWayspS2Fo
        OkeunDqKOQA+jz/fV7kwhyaZdMiIoW0=
Date:   Fri, 20 Jan 2023 17:10:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony.luck@intel.com,
        quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v6 02/17] EDAC/qcom: Add platform_device_id table for
 module autoloading
Message-ID: <Y8q87Yvy/uLYqSZ5@zn.tnic>
References: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
 <20230118150904.26913-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230118150904.26913-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 18, 2023 at 08:38:49PM +0530, Manivannan Sadhasivam wrote:
> Add a device ID table so that the driver loads automatically when the
> associated platform_device gets registered.
> 
> Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/edac/qcom_edac.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
