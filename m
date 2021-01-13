Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194CF2F5133
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jan 2021 18:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbhAMRgC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Jan 2021 12:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbhAMRgC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Jan 2021 12:36:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9451C061575;
        Wed, 13 Jan 2021 09:35:21 -0800 (PST)
Received: from zn.tnic (p200300ec2f0b5c0053dfdcdd1c139e2a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5c00:53df:dcdd:1c13:9e2a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 232D51EC0423;
        Wed, 13 Jan 2021 18:35:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610559320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/3T6QFfwHjFkS46R1R7ZQPZXm5mIVSC76XwFoUlM36E=;
        b=Ruy7bE1qzP/kf7ID5j82Bj7qJHGCYr4k2b+4Oj1HWXno6L1i3A7livpduIr648LIBtQySu
        LqeOAwQdfhTIN6lao7YG/4t/jDFMH8/f3/y59YvXclHgo8vsUuwPxY7tJdnj4GvdOh0r/6
        lAYxrWdWz2WkBtJgh3CW3ZInID4y2tk=
Date:   Wed, 13 Jan 2021 18:35:15 +0100
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
Message-ID: <20210113173515.GF16960@zn.tnic>
References: <20210113015053.GA21587@agluck-desk2.amr.corp.intel.com>
 <EAA1BF13-3C3C-443C-8BF2-A52B5FFB68DE@amacapital.net>
 <20210113100009.GA16960@zn.tnic>
 <8c4cd08e82884518b607f392523dd70b@intel.com>
 <20210113161933.GE16960@zn.tnic>
 <b6ba39266301475b8565142585943fec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6ba39266301475b8565142585943fec@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 13, 2021 at 04:32:54PM +0000, Luck, Tony wrote:
> I'll work on it. We tend not to have essay length messages as panic() strings. But I can
> add a comment in the code there so that people who grep whatever panic message
> we choose can get more details on what happened and what to do.

I did not mean to write an essay but to simply make it more palatable
for "normal" users. Something like:

"PANIC: Second machine check exception while accessing user data."

or along those lines to explain *why* the machine panics.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
