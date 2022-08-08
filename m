Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064C458CF71
	for <lists+linux-edac@lfdr.de>; Mon,  8 Aug 2022 22:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbiHHU50 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Aug 2022 16:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiHHU5Z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Aug 2022 16:57:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D1B15FDE;
        Mon,  8 Aug 2022 13:57:24 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F33D1EC0324;
        Mon,  8 Aug 2022 22:57:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659992238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=p0Nu/U4H8SmixYd5feGWYPr4UgnChBbHs5iDPvH3yWI=;
        b=ZqNVh2bzSe9ugQMduDliBm/D6gtyRvcD9lshalZwzblLAwOSiw++v3PvvFI5UTiDaKeB1C
        hY0a1bfABftejmpxJ8DtII7t3CEF2oJ3elghXxJSnC28CdjWginuoRFpt6NtuXxP9fr+2q
        Rv/CKyy7VpkanZnUc7QBhsqm3ogaCkk=
Date:   Mon, 8 Aug 2022 22:57:11 +0200
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
Message-ID: <YvF4p01WJGGUwIJC@zn.tnic>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
 <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 08, 2022 at 08:40:18PM +0000, Kani, Toshi wrote:
> This allows ghes_edac_register() to run before edac_init(), and sets
> edac_mc_owner to prevent chipset-specific edac driver

So this is the important part: how does it get decided which EDAC driver
to load? The chipset-specific one or the FW glue one?

User, policy, etc?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
