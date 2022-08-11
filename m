Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCBB58FB6B
	for <lists+linux-edac@lfdr.de>; Thu, 11 Aug 2022 13:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiHKLdt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Aug 2022 07:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbiHKLdZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Aug 2022 07:33:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C1395E6C;
        Thu, 11 Aug 2022 04:33:12 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9854329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9854:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DA501EC05DE;
        Thu, 11 Aug 2022 13:33:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660217586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sOPEiGrbo/i8Qwo9GZupZjnTAy1q/d3b5Tmd8QMUUXI=;
        b=mp+UlwjblKXO8jpz9VmqaavrWDjbzjVeNrvHuTiyUw6ch9FrVEFrj4tg/q1NxWRwGnbD+4
        Q/wlAsvboHrZUVMdhnBiyaVlv59PTgfsJRQW0hVWWTrirn02Op2WknnLQZDu2fWBGSrury
        DbFRZkfT4Irih2vyP5nH+GF3Q3uh26o=
Date:   Thu, 11 Aug 2022 13:33:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, ckadabi@quicinc.com,
        vnkgutta@quicinc.com, mchehab@kernel.org, james.morse@arm.com,
        rric@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Channagoud Kadabi <ckadabi@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: Re: [PATCH 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Message-ID: <YvTo8tE3DaHifrSp@zn.tnic>
References: <20220811100924.79505-1-manivannan.sadhasivam@linaro.org>
 <YvTehUOIqJGqXgXY@zn.tnic>
 <YvTfqg0q/8kIMY91@zn.tnic>
 <20220811112032.GB29799@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220811112032.GB29799@workstation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 11, 2022 at 04:50:32PM +0530, Manivannan Sadhasivam wrote:
> I know get_maintainer.pl :) But the problem is, Qualcomm recently
> switched their email domain from codeaurora.org to quicinc.com.

Great:

$ git grep codeaurora.org MAINTAINERS | wc -l
5

;-\

> So even if I use the maintainers codeaurora domain now, they will
> bounce.

Hmm, so the mails I sent with codeaurora on Cc didn't bounce back - I
got only the quicinc bounces. That doesn't mean that codeaurora actually
gets delivered...

> For that reason, I used their quicinc domain addresses. But since they
> are bouncing, it looks like the maintainers left Qualcomm :/

Hmm, is there some way to get in touch with those folks?

Or whoever is taking over those drivers?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
