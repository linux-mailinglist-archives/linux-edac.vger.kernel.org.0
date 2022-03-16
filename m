Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0F4DAE01
	for <lists+linux-edac@lfdr.de>; Wed, 16 Mar 2022 10:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355085AbiCPKAx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Mar 2022 06:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350398AbiCPKAw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Mar 2022 06:00:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D3B64BEA;
        Wed, 16 Mar 2022 02:59:39 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD53B1EC0559;
        Wed, 16 Mar 2022 10:59:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647424773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VUu4K7ChRXMrGrQNt35Wg5IFslzzJNsQ6i3cXSvywX0=;
        b=cTP4t0cmk01+BLf6UFg+bpwxcO66DyZMVbQyk5uCYG+L3u6I7B2553sBMA/GzxEmD97VvS
        CsUlGiw9HbEF/ZNKEnGPPMyod2cXod+pHS/mwhH/1ups1kVKeOWeZFIIwzFnM0MRVyzA+G
        NUC/jmIJtg6fSUnGDMi+FkFNT62Ayts=
Date:   Wed, 16 Mar 2022 10:59:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     niravkumar.l.rabara@intel.com
Cc:     dinguyen@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: altera: Add SDRAM ECC check for U-Boot
Message-ID: <YjG1AbShZZrJdTbE@zn.tnic>
References: <20220305014118.4794-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220305014118.4794-1-niravkumar.l.rabara@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Mar 05, 2022 at 09:41:18AM +0800, niravkumar.l.rabara@intel.com wrote:
> From: Rabara Niravkumar L <niravkumar.l.rabara@intel.com>
> 
> A bug in legacy U-Boot causes a crash during SDRAM boot if ECC
> is not enabled in the bitstream but enabled in the Linux config.
> 
> Memory mapped read of the ECC Enabled bit was only enabled
> if U-Boot determined ECC was enabled in the bitstream.
> 
> The Linux driver checks the ECC enable bit using a memory map
> read. In the ECC disabled bitstream case, U-Boot didn't
> enable ECC register memory map reads and since they are not
> allowed this results in a crash.
> 
> This patch always reads the ECC Enable register through a

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

I've removed it now but pls pay attention for the future.

> SMC call which is always allowed and it works with legacy
> and current U-Boot.
> 
> Signed-off-by: Rabara Niravkumar L <niravkumar.l.rabara@intel.com>
> ---
>  drivers/edac/altera_edac.c | 40 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
