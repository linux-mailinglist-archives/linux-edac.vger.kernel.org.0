Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E3E500AD1
	for <lists+linux-edac@lfdr.de>; Thu, 14 Apr 2022 12:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiDNKSW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Apr 2022 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242187AbiDNKSH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Apr 2022 06:18:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08085468D;
        Thu, 14 Apr 2022 03:15:42 -0700 (PDT)
Received: from zn.tnic (p2e55d808.dip0.t-ipconnect.de [46.85.216.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2EF031EC05ED;
        Thu, 14 Apr 2022 12:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649931337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tcvILpawoy/EPkGkLSEhvv0Kdz440+lEpC25Pt/VCcQ=;
        b=BKlCWqNGE/Ep1cvt/qOcZSftYkpVpT+iOaYR+yPMnEQ2cHucqhZKpKdJv8W07gJQDPVYvY
        Dr8UoJLd4dHuOT55Ag1YvyTF/N5fAIOfsrgpfRzbWwcDBRa3ipPH5RrN/IQk8hzgpR6BuV
        4zWAZ+lq9tJFmmI4yxAiLuAR+/7If2o=
Date:   Thu, 14 Apr 2022 12:15:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Medad Young <medadyoung@gmail.com>, rric@kernel.org,
        James Morse <james.morse@arm.com>, tony.luck@intel.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] EDAC: nuvoton: Add NPCM memory controller driver
Message-ID: <Ylf0Sc7fqv25Ay05@zn.tnic>
References: <20220322030152.19018-1-ctcchien@nuvoton.com>
 <20220322030152.19018-4-ctcchien@nuvoton.com>
 <a06441fc-85cf-9386-e362-4a90e855aa19@molgen.mpg.de>
 <CAHpyw9fQVbS1Cpv0ULQc2=vK8LsG6n7tgP+J9AboUupDAPT27Q@mail.gmail.com>
 <YlfeXVSkUC2B4xH2@zn.tnic>
 <14d07709-07ef-21a8-ad74-0f56447cf6dd@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14d07709-07ef-21a8-ad74-0f56447cf6dd@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 14, 2022 at 10:56:43AM +0200, Paul Menzel wrote:
> No idea, why you had to ask this question, while you statement before
> already made the point.

You've told Medad one thing. I told him the complete opposite. Medad as
new submitter gets confused. And I don't want patch submitters to get
confused by review.

So, if you're unsure about a review feedback, don't give it pls.

> Sorry I do not get your point. Would you elaborate on the debug message so
> it’s more useful?

Just think of the big picture: is my error message useful enough for
debugging or would I have to go and add more info to it so that I can
debug an issue?

Example:

There is

	edac_dbg(3, "InterruptStatus : 0x%x\n", intr_status);

now.

Now, how about this?

        edac_dbg(3, "dev: %s, id: %s: IRQ: %d, interrupt status: 0x%x\n",
                 mci->dev_name, mci->ctl_name, irq, intr_status);

Which one, do you think, is more helpful to a person trying to debug any
potential issue with the interrupt handler and the ECCs it is supposed
to issue?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
