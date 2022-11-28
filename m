Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0119763B172
	for <lists+linux-edac@lfdr.de>; Mon, 28 Nov 2022 19:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiK1SgO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Nov 2022 13:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiK1Sfs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Nov 2022 13:35:48 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED42AA;
        Mon, 28 Nov 2022 10:35:16 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28B1A1EC06AC;
        Mon, 28 Nov 2022 19:35:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669660515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CPL0/XdCkWtaqvp46BBZU9txacOEESsYiBLgIoQ6JSg=;
        b=SQwBiajVddPo/95sigUvJJZ2ESbwLMbMVUOjt8bIyQ7wQln7gYaCxRJQYDxHjFKvG0frRs
        xb9D0gwr/CiKfNSKIG1QawzYswDU5SxKfFspzKa7AXmUmP8sVUuxkUzVB91VnvHIt4eOGE
        SSpTn2OMEIP/P4MTMb6HSPqU/S8Pefw=
Date:   Mon, 28 Nov 2022 19:35:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, mchehab@kernel.org,
        james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com
Subject: Re: [PATCH v4 1/2] EDAC/qcom: Get rid of hardcoded register offsets
Message-ID: <Y4T/YlDdDk7gVdfB@zn.tnic>
References: <20221116143352.289303-1-manivannan.sadhasivam@linaro.org>
 <20221116143352.289303-2-manivannan.sadhasivam@linaro.org>
 <Y4SmtfSzLbYea+f0@zn.tnic>
 <20221128181705.GP62721@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221128181705.GP62721@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Nov 28, 2022 at 11:47:05PM +0530, Manivannan Sadhasivam wrote:
> Well, yes but that would imply both LLCC and EDAC patches going together.
> Splitting them will break the build, which is worse.

Sounds like you need to check out:

Documentation/process/stable-kernel-rules.rst

first.

Hint: there are provisions in there how to specify dependencies between
commits.

> Sorry, it is because I only tried building for ARM64 architecture. The
> error you are seeing is for x86-64 and I could now reproduce it as
> well.

Yes, because arch doesn't matter here - the .config does.

Therefore, as requested:

"For the next version, you'd need to fix all possible Kconfig build
errors before sending."

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
