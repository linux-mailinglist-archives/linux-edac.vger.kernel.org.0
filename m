Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B3B58D7E6
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 13:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiHILP7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 07:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiHILP6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 07:15:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D230193C5;
        Tue,  9 Aug 2022 04:15:55 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9800329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 147AE1EC03B9;
        Tue,  9 Aug 2022 13:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660043750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MIjfxB31faRlyNlM6lmpdYiamFIJbK6PbTWIDNiIw7M=;
        b=HU7gmif1TzStx3TWOsiA1v/TvaoPgCr8Xg648DYMGzon1j+fFER8H29IXFqADgIztjlJr9
        VeAEOz4C4BGU27dsnINa24jX+S6x3SgFBxs9JcfHxCwMXO9bwz9ALkvVu7z1dCKWOTmZEz
        JncVL534Imc6BcvmQawCI2EIqRSpCxA=
Date:   Tue, 9 Aug 2022 13:15:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Justin He <Justin.He@arm.com>
Cc:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFDUEk=?= =?utf-8?Q?=3A?= APEI:
 move edac_init ahead of ghes platform drv register
Message-ID: <YvJB5cxSldpigw1g@zn.tnic>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
 <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF4p01WJGGUwIJC@zn.tnic>
 <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
 <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvIPf/m3hU46S9Ik@zn.tnic>
 <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 09, 2022 at 09:24:33AM +0000, Justin He wrote:
> If no, what is the detail logic of ghes_edac_driver_is_preferred()?

That should be moved from ghes_edac.c to ghes.c:

/*
 * Known systems that are safe to enable this module.
 */
static struct acpi_platform_list plat_list[] = {
        {"HPE   ", "Server  ", 0, ACPI_SIG_FADT, all_versions},
        { } /* End */
};

and then

bool ghes_edac_driver_is_preferred()
{
	if (IS_ENABLED(CONFIG_X86)) {
                /* Check if safe to enable on this system */
                idx = acpi_match_platform_list(plat_list);
	} else if (ARM) {
		/* insert ARM logic here */
	}
}

That function should be called by the EDAC modules which compete with
ghes_edac.

In the x86 case, that's sb_edac, skx_edac and amd64_edac, I guess.

It all depends on what platforms Toshi wants to load it - I'm guessing
HPE has both Intel and AMD platforms where they prefer ghes_edac.

On ARM, that's up to ARM folks.

> Because I notice that lots of other edac drivers are probing like:
> ...
>         owner = edac_get_owner();
>         if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
>                 return -EBUSY;

No, that's a silly mechanism to allow a single EDAC driver to load on
the system. But your test will go before it, at the very beginning of
the init function.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
