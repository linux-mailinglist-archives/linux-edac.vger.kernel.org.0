Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30C32FD0B9
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jan 2021 13:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhATMuo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jan 2021 07:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389672AbhATMTE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jan 2021 07:19:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1536C0613C1;
        Wed, 20 Jan 2021 04:18:20 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bb0007fac97ee58c503f0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b000:7fac:97ee:58c5:3f0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B40A1EC02FE;
        Wed, 20 Jan 2021 13:18:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611145099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1XfKvTlUd9M2I3j5DZ6ix3W+3HI+vf6zvmLqPMZR2eE=;
        b=HXNQWzSWiBIqaFIUkL5enVXRU801d3U+sN0n5ZOaG0O8ii7YtMc62jYpy3DQLo6OKZxCtD
        W98w3yO72RcqY66K04zMxBxY22EfiWLALoxd9sFXJfyH4prxRLRDI4r58t+MzZPI0HcFSb
        7NCjTCF82FAgOEhE54yIxGv8j5s3jgc=
Date:   Wed, 20 Jan 2021 13:18:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210120121812.GF825@zn.tnic>
References: <20210111214452.1826-1-tony.luck@intel.com>
 <20210115003817.23657-1-tony.luck@intel.com>
 <20210115152754.GC9138@zn.tnic>
 <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
 <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
 <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
 <20210119105632.GF27433@zn.tnic>
 <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 19, 2021 at 03:57:59PM -0800, Luck, Tony wrote:
> But the real validation folks took my patch and found that it has
> destabilized cases 1 & 2 (and case 3 also chokes if you repeat a few
> more times). System either hangs or panics. Generally before 100
> injection/conumption cycles.

Hmm, that mce_count increment and check stuff might turn out to be
fragile in the face of a race condition. But I don't see it...

> So if you see anything obviously broken, let me know. Otherwise I'll
> be poking around at the patch to figure out what is wrong.

Yah, some printk sprinkling might be a good start. But debugging in that
atomic context is always nasty. ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
