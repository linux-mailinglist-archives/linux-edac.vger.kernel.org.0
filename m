Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25D3505F27
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 23:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347947AbiDRVQ1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Apr 2022 17:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbiDRVQ0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Apr 2022 17:16:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E508A2CCBB;
        Mon, 18 Apr 2022 14:13:46 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58fe329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58fe:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E8E751EC04D6;
        Mon, 18 Apr 2022 23:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650316421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kNgT3g7hZWr4L1MacL0M4zuzvv4T8Jt/QpST8Er4IZM=;
        b=gPt9RlH7iaDq4qO0X02NbLmNo1Osv7wwJMGEXgYVBZ85QjgItXneHUk4Gg9nYeekB6ujvI
        Q5IovE9huXF72e7p8yZu+AW0/2V31GAXASCAwfW7d6uflj0nNFhP4I3ZW39lZtmOARR986
        YqmaDAFfz9oOsa2WMMLrFnNyfsB3y+0=
Date:   Mon, 18 Apr 2022 23:13:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, Lei Wang <lewan@microsoft.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Message-ID: <Yl3UgPtVV3t4pzVe@zn.tnic>
References: <YeRkGvestiloCAUV@zn.tnic>
 <20220118152816.GA89184@sequoia>
 <Yeb4sK+ZmSHjWPWL@zn.tnic>
 <20220118195401.GB89184@sequoia>
 <YecrXidqecoYI/xg@zn.tnic>
 <YefXQHXNlsxk8yUc@kroah.com>
 <Yefb7zO9p1iPF3Jm@zn.tnic>
 <YefnuCPwMq5V2lgl@kroah.com>
 <20220404215640.GA626436@sequoia>
 <20220418204029.GA31854@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220418204029.GA31854@sequoia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 18, 2022 at 03:40:29PM -0500, Tyler Hicks wrote:
> > The API argument seems to have fizzled out in v2:
> > 
> >  https://lore.kernel.org/lkml/20220212201631.12648-1-s.shtylyov@omp.ru/

I don't see those two upstream yet, on a quick glance. Perhaps in Greg's tree?

Greg, what's the latest with that platform_get_*_optional() fun?

Also, the second of those two patches above has:

+ * Return: non-zero IRQ number on success, 0 if IRQ wasn't found, negative error
+ * number on failure.
  */
 int platform_get_irq_byname_optional(struct platform_device *dev,

and your patch does:

+		irq = platform_get_irq_byname_optional(pdev, dmc520_irq_configs[idx].name);
 		irqs[idx] = irq;

so on failure, it would still write the negative error value in
irqs[idx].

How can that be right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
