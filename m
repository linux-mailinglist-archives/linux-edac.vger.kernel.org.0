Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736674BFFD1
	for <lists+linux-edac@lfdr.de>; Tue, 22 Feb 2022 18:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiBVRL0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Feb 2022 12:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiBVRL0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Feb 2022 12:11:26 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C4BD108B;
        Tue, 22 Feb 2022 09:10:59 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C89841EC02DD;
        Tue, 22 Feb 2022 18:10:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645549853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8YaQ8iKI54dCaW6u6I31MuR6mZ01H1YEV/Ji5Q6H3K4=;
        b=D9uqZ50wHD5MIYSMfdxhrhqo3177ttxb52pXnALYgQ5EUhSHFWx4a+2VF0af1kl01SNou7
        4j1buSrPpsNycOlgqsYG4+hmBIR6wo+7I7gqvNaOY9MVhJBiRuWNiFGOGuVat4n17UJfy3
        dMACtaC8KyIUWpQoE3TFGEQeRsQHonw=
Date:   Tue, 22 Feb 2022 18:10:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     tony.luck@intel.com, yazen.ghannam@amd.com,
        Smita.KoralahalliChannabasappa@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Simplify CPU vendor checks for AMD/Hygon and
 Intel/Zhaoxin
Message-ID: <YhUZISFZRaBLbJ31@zn.tnic>
References: <20220222155857.276286-1-carlos.bilbao@amd.com>
 <YhUK87H4PQ22rpLw@zn.tnic>
 <4e638a79-8b2e-291c-3b91-57677ffcc1fa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e638a79-8b2e-291c-3b91-57677ffcc1fa@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On Tue, Feb 22, 2022 at 10:42:25AM -0600, Carlos Bilbao wrote:
> the point is to simplify the code (as the patch stated).

But it doesn't simplify the code - it makes it obscure.

Also, your "simplification" breaks the moment you need to do something
for the one vendor but *not* for the other.

Because in such cases you'll have to do

	if (mce_flags.amd_compatible && m->cpuvendor != X86_VENDOR_HYGON)

which makes me go, "huh what?!"

So no, that's not better.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
