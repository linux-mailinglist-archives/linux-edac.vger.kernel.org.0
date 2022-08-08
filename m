Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CFD58CDBA
	for <lists+linux-edac@lfdr.de>; Mon,  8 Aug 2022 20:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiHHShx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Aug 2022 14:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243759AbiHHShw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Aug 2022 14:37:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C1DB4A8;
        Mon,  8 Aug 2022 11:37:51 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C0511EC02F2;
        Mon,  8 Aug 2022 20:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659983866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Gm75dV4vaxgEXtIynICvPrQ4BQCxKD/GAjPvUjjADp4=;
        b=VfokCVNxpzgsLJFTGBLbxabWb+0VonVp8CklMqYva2rBp/PXqR6NuKDle0GuY2ad74DDQE
        5m84vpdCcosdRIDIAWKF1ixCGhUZusc9vnfNYezkTiHznk2utf6+XPjQ0FhEnwQctCBNew
        9IgAbhcxIIvTHsafqDsWHXc8L+xSfJ0=
Date:   Mon, 8 Aug 2022 20:37:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] ACPI: APEI: move edac_init ahead of ghes platform drv
 register
Message-ID: <YvFX9vTilqMpsF9u@zn.tnic>
References: <20220805023200.154634-1-justin.he@arm.com>
 <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gUbKYaxRcZsYO6eq7vLgKdgfdLdoL_Hzmd6r-JczkVPg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+ Toshi.

On Mon, Aug 08, 2022 at 08:17:58PM +0200, Rafael J. Wysocki wrote:
> This effectively makes EDAC depend on GHES which may not be always
> valid AFAICS.

Yes, and this has been getting on my nerves since forever.

The GHES code which does collect all those errors *forces* the
registration of an EDAC module which does only the reporting.

Which cannot be any more backwards.

What should happen is, GHES inits and starts working on the errors.
Then, at some point later, ghes_edac loads and starts reporting whatever
it gets. If there's no EDAC module, it doesn't report them. The same way
MCA works.

That's it.

And then ghes_edac can be made a normal module again and we can get rid
of this insanity.

Jia, willing to try it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
