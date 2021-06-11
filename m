Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934B43A3D58
	for <lists+linux-edac@lfdr.de>; Fri, 11 Jun 2021 09:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFKHlY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Jun 2021 03:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFKHlY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Jun 2021 03:41:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC85C061574;
        Fri, 11 Jun 2021 00:39:27 -0700 (PDT)
Received: from zn.tnic (p2e584d18.dip0.t-ipconnect.de [46.88.77.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B0F81EC0528;
        Fri, 11 Jun 2021 09:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623397165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bM7mdRbMEwkDpmgRTLq6Xee0t4hAfl6e7oZsXY8E5uU=;
        b=BWC0hvouGlPlGW//MlEtUhm5fJCs+K10N34ujCxtDnWkdW/AOZN0rmnvKIeyxQe9CAoM53
        P9jwl7ne0RMwHae7MjL2kq/0nZkzR/bsXDGSpr/y7ZlT79O6fqYFbtidrdoCTXRxnqbEjm
        R5yL4Q6d1WAo2uUYBwljoPa6WTP7j8w=
Date:   Fri, 11 Jun 2021 09:37:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli Channabasappa <skoralah@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Youquan Song <youquan.song@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/mce: Add support for Extended Physical Address
 MCA changes
Message-ID: <YMMSqS0Knb0Pk8GF@zn.tnic>
References: <20210608221012.223696-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210608221012.223696-3-Smita.KoralahalliChannabasappa@amd.com>
 <YMH9wqUnjudiAVlr@zn.tnic>
 <1c21d3c5-8a5a-31cf-6d84-0905a0c508da@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c21d3c5-8a5a-31cf-6d84-0905a0c508da@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 10, 2021 at 10:36:44PM -0500, Smita Koralahalli Channabasappa wrote:
> The idea of defining a new struct was to keep SMCA specific stuff separate.
> Thought, it would be costly to include in existing struct mce_bank[] as it will be
> unnecessarily defined for each cpu and each bank across all vendors even if they
> aren't using it and would be a problem if they are constraint on resource and space.

That's very considerate of you to think about the other vendors - I wish
everyone would do that...

However, our mce_banks_array is defined unconditionally on all vendors
already. So it is there even now. So I wouldn't lose a single second of
sleep about adding an u64 bitfield there.

> Also, in the future we can use this newly defined struct smca_config[] to cache
> other MCA_CONFIG feature bits for different use cases if they are per bank and per
> cpu.

You can use other bits in that bitfield. I hope 64 are enough. :)

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
