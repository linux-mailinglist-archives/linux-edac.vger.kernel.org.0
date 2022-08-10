Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01B558E8BC
	for <lists+linux-edac@lfdr.de>; Wed, 10 Aug 2022 10:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiHJI2l (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Aug 2022 04:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiHJI2l (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Aug 2022 04:28:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39B061D95;
        Wed, 10 Aug 2022 01:28:39 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9800329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DD9F1EC0380;
        Wed, 10 Aug 2022 10:28:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660120114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1s5KkfNqTz8/ZlXcXp/qDi3y0LrVX0jvXxjDnHobf2U=;
        b=L32kBcKYCI4V/+ihY7ehc4SLXTECULeJA5TlDcepyWdTHrZcyQXDypSlq0zscN32uMIB6f
        9wun/WBJ1414yYBCb+XmLUbEuinrzI+2aOOXBuMvDGcSah4WNRH2qe9ovMEDd9DYbgKm7t
        06wddpmE1REq2FzOo1h6BfX3wirACJ4=
Date:   Wed, 10 Aug 2022 10:28:29 +0200
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
Message-ID: <YvNsLViKcduXz5px@zn.tnic>
References: <PH7PR84MB1838492812F5ABAA4BB54D9982639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvF+J/dfyOEVSbSQ@zn.tnic>
 <PH7PR84MB1838BF4F8B56EF1E24FCF1DC82639@PH7PR84MB1838.NAMPRD84.PROD.OUTLOOK.COM>
 <YvIPf/m3hU46S9Ik@zn.tnic>
 <DBBPR08MB4538A5C080B09A96A77CCDA9F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvJB5cxSldpigw1g@zn.tnic>
 <DBBPR08MB453870FA5C5D26AADFDF05C7F7629@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <YvKWP2BcAh/+YKXM@zn.tnic>
 <YvKrfqAsVLUqW5PN@zn.tnic>
 <DBBPR08MB4538F9C5F3EAC189722F8F61F7659@DBBPR08MB4538.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DBBPR08MB4538F9C5F3EAC189722F8F61F7659@DBBPR08MB4538.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 10, 2022 at 06:00:49AM +0000, Justin He wrote:
> Is this strange or any other side effects?

This is no different than what we do now on x86 MCA.

If the logging machinery is modules, they consume error records only
when loaded.

> IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended
> recipient, please notify the sender immediately and do not disclose
> the contents to any other person, use it for any purpose, or store or
> copy the information in any medium. Thank you.

Btw, pls get rid of this if you want to be posting on public mailing
lists. You can ask your other ARM colleagues how they solved it. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
