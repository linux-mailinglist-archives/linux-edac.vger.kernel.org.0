Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8758FAF7
	for <lists+linux-edac@lfdr.de>; Thu, 11 Aug 2022 12:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiHKKxh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Aug 2022 06:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHKKxg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Aug 2022 06:53:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3AC9352A;
        Thu, 11 Aug 2022 03:53:35 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9854329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9854:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C5DA1EC063F;
        Thu, 11 Aug 2022 12:53:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660215210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hiSEN+Zh8reclUVp4OU5TllqlGYD9cAoOWRjyF0EZDE=;
        b=ZK0kakkCQnpy8iNukkbPTl7HdPXGMUq27qOAY/pJXYIituVpxA+uCCbIT/wcAJB5qL8EDZ
        qSfMNJwb73JAf3iU4ILpYbOk7URgBVQiGWF3jw9hl+EUzvo6G3qKEPr9QQe8WVqjkJGcFL
        Qv345YYfhoURhe5ReKye0aV2Qeou8r0=
Date:   Thu, 11 Aug 2022 12:53:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, ckadabi@quicinc.com,
        vnkgutta@quicinc.com, mchehab@kernel.org, james.morse@arm.com,
        rric@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Channagoud Kadabi <ckadabi@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: Re: [PATCH 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Message-ID: <YvTfqg0q/8kIMY91@zn.tnic>
References: <20220811100924.79505-1-manivannan.sadhasivam@linaro.org>
 <YvTehUOIqJGqXgXY@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvTehUOIqJGqXgXY@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 11, 2022 at 12:48:37PM +0200, Borislav Petkov wrote:
> On Thu, Aug 11, 2022 at 03:39:22PM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series fixes the crash seen on the Qualcomm SM8450 chipset with the
> > LLCC/EDAC drivers. The problem was due to the Qcom EDAC driver using the
> > fixed LLCC register offsets for detecting the LLCC errors.
> 
> I see you've CCed the QCOM maintainers using different email addresses:
> 
> $ ./scripts/get_maintainer.pl -f drivers/edac/qcom_edac.c
> Channagoud Kadabi <ckadabi@codeaurora.org> (maintainer:EDAC-QCOM)
> Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org> (maintainer:EDAC-QCOM)
> 
> Does MAINTAINERS need updating?

No, it doesn't. The email addresses you used, bounce:

Delivery has failed to these recipients or groups:

vnkgutta@quicinc.com<mailto:vnkgutta@quicinc.com>
The email address you entered couldn't be found. Please check the recipient's email address and try to resend the message. If the problem continues,
+please contact your email admin.


ckadabi@quicinc.com<mailto:ckadabi@quicinc.com>
The email address you entered couldn't be found. Please check the recipient's email address and try to resend the message. If the problem continues,
+please contact your email admin.

In the future, when you wonder who to Cc and how,

scripts/get_maintainer.pl

is your friend.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
