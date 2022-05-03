Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B59518FDC
	for <lists+linux-edac@lfdr.de>; Tue,  3 May 2022 23:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiECVRr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 May 2022 17:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiECVRq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 May 2022 17:17:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864F63A1B4;
        Tue,  3 May 2022 14:14:12 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E02CE1EC0453;
        Tue,  3 May 2022 23:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651612446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ruAB55ZIvISsfAeVGDwXiQqs7sAbM7x1gmHct6nO5pU=;
        b=gE212RmcmdxogT27q94YzSwKg4sgRH0nQ6Ft+pnFvZy3oV7LdoSejNrbc7dH9AKGS/4qY3
        8bfOYHM9hdA254SgnK1H6vuy8UP4vsHmfgG18XzZAWy/MHjr+EpJjitafySlC1XOn9ebmO
        xQIntC0em4p97QTjozm8ddaYR8R6vn0=
Date:   Tue, 3 May 2022 23:14:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 1/2] x86/mce: Check for writes ignored in MCA_STATUS
 register
Message-ID: <YnGbHcMkLCsauzXF@zn.tnic>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yk267A1MKOo2AlXQ@zn.tnic>
 <6cda2827-af75-589d-3e43-a287d6683e7a@amd.com>
 <Yl/PupT3bAfc4IBW@zn.tnic>
 <5512261e-085b-65fa-605b-38692769f89c@amd.com>
 <YmXQBbCz2T/Opv5+@zn.tnic>
 <3fd01af5-c665-6dbb-4ed4-dfc39109d63a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fd01af5-c665-6dbb-4ed4-dfc39109d63a@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 02, 2022 at 08:28:47PM -0700, Smita Koralahalli wrote:
> I'm bit more inclined towards your previous approach of
> hw_injection_possible
> check in do_inject(). This seems better than doing it in flags_write().

If you don't do it in flags_write() then the user would do

   echo "hw" > flags

the command will succeed and the user will think that hw injection is
possible and then wonder why it fails later.

I even actually think that in the first run, when hw_injection_possible
is not determined yet, you should try to poke at MCi_STATUS of some
non-reserved bank - and we enumerate which those are at boot in
__mcheck_cpu_check_banks(), so you can pick a random, non-RAZ bank, save
its MCi_STATUS, try to write it and if it succeeds, restore it.

This way you'll determine whether hw injection is possible, store it
in the static hw_injection_possible and then query only that variable.
I.e., you'll have to poke that MCi_STATUS only once on driver init. And
this way it'll be the most optimal, methinks.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
