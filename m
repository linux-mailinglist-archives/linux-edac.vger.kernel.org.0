Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2E58DCEB
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 19:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiHIRPv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 13:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiHIRPu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 13:15:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B0825FA;
        Tue,  9 Aug 2022 10:15:49 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9800329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1295A1EC0554;
        Tue,  9 Aug 2022 19:15:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660065344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qYCIERlVU5uYY2QgYl+2fvUl3A85yoSNYStCUb+X3TA=;
        b=IT6BilTWrRbJf9BlHfmtWVItWzJSO6RYSs1B76KNZmFbc0ychnLMX4aV6Sc155uveh2aCF
        UqSA8Fq/UQHrVy7Q1hlBVAJ82OYZEio43OH4iRqvXsjsBldP0rh2s+u0xCFoqLVuv2t0eA
        wBoBeSxUWiWQ8ygl7xfOXVmLnsfJNVM=
Date:   Tue, 9 Aug 2022 19:15:43 +0200
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
Message-ID: <YvKWP2BcAh/+YKXM@zn.tnic>
References: <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF4p01WJGGUwIJC@zn.tnic>
 <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
 <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvIPf/m3hU46S9Ik@zn.tnic>
 <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvJB5cxSldpigw1g@zn.tnic>
 <DBBPR08MB453870FA5C5D26AADFDF05C7F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DBBPR08MB453870FA5C5D26AADFDF05C7F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 09, 2022 at 04:51:45PM +0000, Justin He wrote:
> Let me summarize it before sending v2 (maybe tomorrow):
> 1. implement a ghes_edac_driver_is_preferred() to replace the old ghes_edac_register()
> and move it to ghes.c together with plat_list

No, not replace.

In ghes.c:

- add ghes_edac_driver_is_preferred()
- remove ghes_edac_register() and _unregister() calls from there. Make them proper module
init/exit functions.
- Make ghes_edac.c a proper module - i.e., get rid of this thing:

config EDAC_GHES
        bool "Output ACPI APEI/GHES BIOS detected errors via EDAC"
        depends on ACPI_APEI_GHES && (EDAC=y)
				     ^^^^^^^^

> 2. save the ghes and dev to a global structure and pass it to the new module_init

Not at all...

> 3.move the remain logic of old ghes_edac_register() to a new XX_init() which is under the
> module_init path.
> 4. introduce a stub ghes_edac_driver_is_preferred() for sb_edac, skx_edac and amd64_edac
> to check.
> 5. add the check condition in the XXX_init of sb_edac, skx_edac and amd64_edac
> 
> Please let me know if I missed anything above.

Yes, I think you do. Lemme write something and you can finish it/test
it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
