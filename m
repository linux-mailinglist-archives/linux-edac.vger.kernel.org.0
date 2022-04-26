Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412A5510133
	for <lists+linux-edac@lfdr.de>; Tue, 26 Apr 2022 16:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbiDZPBf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Apr 2022 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242873AbiDZPBe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Apr 2022 11:01:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3D3B1A85;
        Tue, 26 Apr 2022 07:58:24 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCDC91EC04A6;
        Tue, 26 Apr 2022 16:58:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650985098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=huE9l2xeCAZTTmW3YvsVXEyz0aYX0tkv096G9fcKNMs=;
        b=kZ9cgchnykOJBP/Zraue/GbX4prLLK6JNadhlLnybF3BCGEnF1Lyv139yO2WqIULBsUVBu
        nE9boKRV3r1d8b52vIqgI43dG/xJ9DU9KmGt2hXxLH7sgnMbvULzkhP47l4+0/yFRY3QBw
        usaHAgyb9fNDhU43KDmJaoV8b10Ia9I=
Date:   Tue, 26 Apr 2022 16:58:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Shubhrajyoti.datta@xilinx.com" <Shubhrajyoti.datta@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 2/2] EDAC: synopsys: re-enable the interrupts in
 intr_handler for V3.X Synopsys EDAC DDR
Message-ID: <YmgIiPzvgO3CdlqF@zn.tnic>
References: <20220421015313.5747-1-sherry.sun@nxp.com>
 <20220421015313.5747-3-sherry.sun@nxp.com>
 <YmEerhSXM0L8cUuj@zn.tnic>
 <AS8PR04MB8404243437B78FA6B1E46F3092F69@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8404243437B78FA6B1E46F3092F69@AS8PR04MB8404.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Apr 23, 2022 at 07:03:45AM +0000, Sherry Sun wrote:
> My fix patches are based on Dinh's patch: f7824ded4149
> ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR"),
> as this patch was introduced since L5.17, it's quite new, so I think
> we don't need to backport them to the stable kernels.

What do you mean, quite new?

There are 5.17.x stable releases so they will need those fixes too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
