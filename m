Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C5958DADE
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243623AbiHIPO1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Aug 2022 11:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiHIPO0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Aug 2022 11:14:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7889764DE;
        Tue,  9 Aug 2022 08:14:25 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9800329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 968A21EC050F;
        Tue,  9 Aug 2022 17:14:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660058059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+4HOfvI8mVF1+tfbZd5grdz8bB0WUV7y3pbiY6D96l4=;
        b=GAiuYPtQszC+SezMFQ0/c4DL1Vbmtgto8fOOxmA7JP6/07so846IkZrNJME8/ijneQt68c
        E7bVud7bhAlOn5Xovl1kC2wuT1ndF8xs/DZN8iQ6o/yIr0ty1Xg7lJEd3Ao0sqvEJsgg6W
        t0MTHX17qVEMx3i0tgKiDrlcIglIFrI=
Date:   Tue, 9 Aug 2022 17:14:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     Justin He <Justin.He@arm.com>,
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
Message-ID: <YvJ5xxsDxC4q3fJB@zn.tnic>
References: <YvFX9vTilqMpsF9u@zn.tnic>
 <PH7PR84MB1838379B8C2DF488DE729A9182639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF4p01WJGGUwIJC@zn.tnic>
 <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
 <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvIPf/m3hU46S9Ik@zn.tnic>
 <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvJB5cxSldpigw1g@zn.tnic>
 <PH7PR84MB18380596CA00597E9D5D18DF82629@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR84MB18380596CA00597E9D5D18DF82629@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 09, 2022 at 02:36:33PM +0000, Kani, Toshi wrote:
> The logic needs to be latched on ghes presence, i.e., the condition is

If GHES is not enabled, there'll of course be a stub which returns
false.

> Agree that changing all edac drivers to check with GHES is an option.

Not all - all relevant drivers for your - HPE - use case. We don't load
ghes_edac on anything else. Known-good platforms only, remember?

> In this approach, though, they will need to check with foo_preferred()
> when a new FW interface FOO is introduced.

I'm afraid I don't understand what you mean here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
