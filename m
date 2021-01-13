Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9FD2F4FC5
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jan 2021 17:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbhAMQUU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Jan 2021 11:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbhAMQUU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Jan 2021 11:20:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0775BC061786;
        Wed, 13 Jan 2021 08:19:40 -0800 (PST)
Received: from zn.tnic (p200300ec2f0b5c000beb6f45064fc5e6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5c00:beb:6f45:64f:c5e6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63EAC1EC0423;
        Wed, 13 Jan 2021 17:19:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610554778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eVu6NTzQCbZz8vK7G6SGItsBTLYbKoEYIb4z/KFByVs=;
        b=a5f4xecG0yBOEpwuzvLoInAieudYWctDOPEHLxFhQrYhpuUpi92wpClEA5qmLF/vay7J93
        pYqFOwenhraD/2goJJBwZrOdQLhmjLkkt8ALrL5FciHn40wLtyA01nUoeT1f8A1rOC6Pws
        pee4Jm8N5F0h+6argliebmolMXRvsek=
Date:   Wed, 13 Jan 2021 17:19:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210113161933.GE16960@zn.tnic>
References: <20210113015053.GA21587@agluck-desk2.amr.corp.intel.com>
 <EAA1BF13-3C3C-443C-8BF2-A52B5FFB68DE@amacapital.net>
 <20210113100009.GA16960@zn.tnic>
 <8c4cd08e82884518b607f392523dd70b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c4cd08e82884518b607f392523dd70b@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 13, 2021 at 04:06:09PM +0000, Luck, Tony wrote:
> Maybe the other difference in approach between Andy and me is whether to
> go for a solution that covers all the corner cases, or just make an incremental
> improvement that allows for recover in some useful subset of remaining fatal
> cases, but still dies in other cases.

Does that mean more core code surgery?

> I'm happy to replace error messages with ones that are more descriptive and
> helpful to humans.

Yap, that: "Multiple copyin" with something more understandable to users...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
