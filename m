Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867D958CF98
	for <lists+linux-edac@lfdr.de>; Mon,  8 Aug 2022 23:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiHHVUv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Aug 2022 17:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiHHVUv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Aug 2022 17:20:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B64A10C6;
        Mon,  8 Aug 2022 14:20:50 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8CFD1EC0324;
        Mon,  8 Aug 2022 23:20:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659993644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VKz3TuJsbjKFpzwrCuzHBmcLaX5F/ZQS4dNV5XPuhTU=;
        b=LK/SakEYyTZPpnpc+0fMrGaJJQcTlHbuxHAD1E8BuOE2IMSraPzsdIrXX5PUN+FA3CCvRq
        FoKPFTD21QGSPTGE/zftq41h0GU4d9bAEUCbfMR/ESEhX2zmg3JvrKy0F/p1qyuwvp2JNc
        3yvj1GY+IyQLbswZQvzaVMT2xZZM+Uk=
Date:   Mon, 8 Aug 2022 23:20:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] ACPI: APEI: move edac_init ahead of ghes platform drv
 register
Message-ID: <YvF+J/dfyOEVSbSQ@zn.tnic>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
 <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF4p01WJGGUwIJC@zn.tnic>
 <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 08, 2022 at 09:11:52PM +0000, Kani, Toshi wrote:
> Whichever loaded first wins.

That I know.

The question is, which one *should* win each time.

IOW, on which platforms should ghes_edac load and on which the
chipset-one?

I'm guessing the answer is the plat_list...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
