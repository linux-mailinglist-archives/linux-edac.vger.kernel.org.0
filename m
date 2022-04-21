Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3643B509B9A
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 11:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387072AbiDUJBK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Apr 2022 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387044AbiDUJBI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Apr 2022 05:01:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7C820F75;
        Thu, 21 Apr 2022 01:58:18 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58ed329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58ed:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C0A81EC0494;
        Thu, 21 Apr 2022 10:58:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650531493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K6LjJUiqWP9JmAH5pCtbEbi7a1uZ4YBTwFyxQHdf9Lg=;
        b=Tujmid+xug5U5uZ16FWxKvjXm88Ez25HZB78FyF8+JEjZPHMRmRVh85xENutF6BN6j4sD+
        HZbhBY8cixey6jD/WnGze8qIsSHA1Ic3364igLmUaZeogZKdgBEXUGIRYS30cY+2g7+SOV
        jMNv1zGhX4M2PbqZiBbiT6FcB/U1Hgs=
Date:   Thu, 21 Apr 2022 10:58:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     michal.simek@xilinx.com, Shubhrajyoti.datta@xilinx.com,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] EDAC: synopsys: Add disable_intr support for V3.X
 Synopsys EDAC DDR
Message-ID: <YmEcoIj63goth+aU@zn.tnic>
References: <20220421015313.5747-1-sherry.sun@nxp.com>
 <20220421015313.5747-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421015313.5747-2-sherry.sun@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Subject: Re: [PATCH V2 1/2] EDAC: synopsys: Add disable_intr support for V3.X Synopsys EDAC DDR

EDAC tree subject prefixes are of the format:

EDAC/<driver name>: Bla...

where "Bla starts with a capital letter".

What is "disable_intr support"?

I can figure it out when looking at the code but you need to make this
human-readable. For example

"Disable the error interrupt on Synopsys EDAC v3.x hardware"

Also, is it all caps V3.X or is it simply v3.x?

On Thu, Apr 21, 2022 at 09:53:12AM +0800, Sherry Sun wrote:
> V3.X Synopsys EDAC DDR doesn't have the QOS Interrupt register, need
> to change to use the ECC Clear Register to disable the interrupts.

Not "need to change" but "change".

From Documentation/process/submitting-patches.rst:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

Please have a look at that document.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
