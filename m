Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0273F2F4829
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jan 2021 11:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbhAMKA7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Jan 2021 05:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbhAMKA7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Jan 2021 05:00:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00B7C061575;
        Wed, 13 Jan 2021 02:00:18 -0800 (PST)
Received: from zn.tnic (p200300ec2f0b5c00b2d62b1c55c494d5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5c00:b2d6:2b1c:55c4:94d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5EB081EC0373;
        Wed, 13 Jan 2021 11:00:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610532016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bwXUgqm+T5Hm2apmjjzcl3Q/EJPSeMebtTylU7D0IPM=;
        b=S/AxnRkx4uD8Hpul/XNm2pKELEPL/XjKvGveGL9E3vtrrLbdwA5CT039hEQIp3oA1ZRC3k
        fBvXcAixZ7vIqoYufjd7oTdYPH0ZSiM8fDN4pouBzhxgkXfqR8K/yJ3MtGq1OlyCov7Mjh
        0aR8aCpYVr9aw9K23eq0XvSkA4Yxgj4=
Date:   Wed, 13 Jan 2021 11:00:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210113100009.GA16960@zn.tnic>
References: <20210113015053.GA21587@agluck-desk2.amr.corp.intel.com>
 <EAA1BF13-3C3C-443C-8BF2-A52B5FFB68DE@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EAA1BF13-3C3C-443C-8BF2-A52B5FFB68DE@amacapital.net>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 12, 2021 at 08:15:46PM -0800, Andy Lutomirski wrote:
> So I’m sort of at a loss as to what we can do.

I think you guys have veered off into the weeds with this. The current
solution - modulo error messages not destined for humans :) - is not soo
bad, considering the whole MCA trainwreck.

Or am I missing something completely unacceptable?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
