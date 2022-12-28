Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10674658566
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 18:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiL1Rz4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 12:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiL1Rzz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 12:55:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70DA12636;
        Wed, 28 Dec 2022 09:55:54 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC7381EC02F2;
        Wed, 28 Dec 2022 18:55:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672250152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GXsapaVt9cb+UaYSK9TeeC/RQRh6g9+A7ck0hbAxahE=;
        b=br8aEehqLnlzuhMvTg0hzlP+bE0HD9FqR6e8x1SEql8Mkd2wUZ/78eb0P3vQz92CPnUxhN
        /mB9ZSha31L4mvj5jbzUj5vn25JNYIJeIO0UJhbf9+wWMm+PoB/JC3AYOPMj6fmfYmdyl2
        FUUo14m4sMB5D26xktQFVYBDzX2bvDs=
Date:   Wed, 28 Dec 2022 18:55:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony.luck@intel.com,
        quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v5 00/17] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Message-ID: <Y6yDI43UZYfGDuOm@zn.tnic>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
 <Y6wcFjqpBUoxAkdk@zn.tnic>
 <20221228164711.GB256211@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221228164711.GB256211@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 28, 2022 at 10:17:11PM +0530, Manivannan Sadhasivam wrote:
> Well, some maintainers prefer to pick the independent patches through their
> tree. That's why I moved those patches to the start of the series.

Once some maintainers experience a crazy dependency hell between trees,
they would find routing it all through a single tree a lot easier the
next time.

> If you are fine with all patches going through qcom tree, I do not
> have any issue :)

I'm reviewing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
