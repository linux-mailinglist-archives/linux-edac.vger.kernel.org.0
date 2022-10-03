Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC35F2E6B
	for <lists+linux-edac@lfdr.de>; Mon,  3 Oct 2022 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiJCJsE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Oct 2022 05:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiJCJrt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Oct 2022 05:47:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ECC284;
        Mon,  3 Oct 2022 02:45:46 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e749329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e749:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F1FA1EC05F1;
        Mon,  3 Oct 2022 11:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664789569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5s0SE+iY5aacQ0MUhNDUW6YKLiEsUhJw6ulQbkcA9WA=;
        b=F4gVw7/eC5plRXV6f4290NPR7wkbRztLIHLjtX9L1YwRYgutGF0N0WfX5RHEt1+qHknYFl
        y4ozZV0xtsCYCTonLvxrp7k2Wmth+XB0yi5UMVtuK4cMBPdOHR5sjZmzPmbSixq7+z8Im9
        UPYo14EbSbGc1POunCG+xQBo4dZrHKE=
Date:   Mon, 3 Oct 2022 11:32:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, mchehab@kernel.org,
        james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [PATCH v3 0/5] Fix crash when using Qcom LLCC/EDAC drivers
Message-ID: <YzqsQD3EFGzCEQJf@zn.tnic>
References: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
 <20221003070415.GC5398@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221003070415.GC5398@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 03, 2022 at 12:34:15PM +0530, Manivannan Sadhasivam wrote:
> Since the LLCC patches are already merged, can we get the EDAC patches to be
> merged for v6.1?

It is too late for 6.1. I'll take a look at them after the merge window closes.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
