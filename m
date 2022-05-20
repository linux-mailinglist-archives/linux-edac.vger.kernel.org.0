Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5EE52EB92
	for <lists+linux-edac@lfdr.de>; Fri, 20 May 2022 14:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbiETMJf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 May 2022 08:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbiETMJc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 May 2022 08:09:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE6514FC8F;
        Fri, 20 May 2022 05:09:31 -0700 (PDT)
Received: from zn.tnic (p200300ea974657be329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57be:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D61B1EC0432;
        Fri, 20 May 2022 14:09:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653048566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wAUEpaxcn1VjODERDlTBwD2l2P5Ti2X7RxSfo/FhO7g=;
        b=AqccEl2YFLgHBwWukfM15c26wLyTYp0BTcTwKa5inCPcJkkJ2RtctkhhZRtxbyPGKt3hqq
        Fe8H2STvPhOoTipdnMQQYblJR7q+zAcAMhK9FaKkyY+rLrq3bTZNJn0a1+j8kB+iUppIny
        oFERssQ2eEB/XA65/bk9GLDZJb0c+NQ=
Date:   Fri, 20 May 2022 14:09:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Medad Young <medadyoung@gmail.com>
Cc:     rric@kernel.org, James Morse <james.morse@arm.com>,
        tony.luck@intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v9 1/3] ARM: dts: nuvoton: Add memory controller node
Message-ID: <YoeE8cBhUkF3K44/@zn.tnic>
References: <20220510031056.1657-1-ctcchien@nuvoton.com>
 <20220510031056.1657-2-ctcchien@nuvoton.com>
 <YoUwe6Tj4Uh6ukc8@zn.tnic>
 <CAHpyw9fjThEP4NuU08aNJ_raHpq9-j9KgBb8YuZ_shXTjhm3JA@mail.gmail.com>
 <YoYPGWreQuF9QZzc@zn.tnic>
 <CAHpyw9es-n+bW9SsGBmmr3ghBFk8Q8E6ZTbE42BpU-6p8LfHtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHpyw9es-n+bW9SsGBmmr3ghBFk8Q8E6ZTbE42BpU-6p8LfHtw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 20, 2022 at 10:31:05AM +0800, Medad Young wrote:
> for the second warning, I did upadate my .git/config according to your
> advise. but I thought I met orthe problem, I will try to fix it

You need to do "git commit --amend" on the patch so that it updates the
author.

> for the first warning, did I really need to fix it?

Yes, you need to fix both.

Again, before you send, run checkpatch on your patches, one by one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
