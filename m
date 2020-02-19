Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B881644ED
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2020 14:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSNEB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Feb 2020 08:04:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49948 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgBSNEB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 19 Feb 2020 08:04:01 -0500
Received: from zn.tnic (p200300EC2F095500AC4EBF6CAFE7BFD1.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5500:ac4e:bf6c:afe7:bfd1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B9201EC0216;
        Wed, 19 Feb 2020 14:03:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582117439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rvGK9TWc5VQzzfElldcN9WbR6raRibrDQlfQVR2ux0U=;
        b=IAFwokmEabnjoZRjjrIL2p1e19VOt69CshgSD0FL+9iSI4y8Oh0HdeBKIrLAlaXv99hlW9
        PuCWBdk9EQFG8p5BWhUYnkbvVFNwkFpIwov3UlI9y4l2skXGC180p8FdDWpaghq8FxswUf
        /aQvWNZr3cHpbXmYwElgfOO8Rc1sezc=
Date:   Wed, 19 Feb 2020 14:03:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Krupp <centos@akr.yagii.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] x86/mce: Do not log spurious corrected mce errors
Message-ID: <20200219130353.GC30966@zn.tnic>
References: <20200217130659.15895-1-prarit@redhat.com>
 <20200218161319.GG14449@zn.tnic>
 <894a39cb-21e7-3e43-1907-cae390537ccf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <894a39cb-21e7-3e43-1907-cae390537ccf@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Feb 19, 2020 at 07:25:59AM -0500, Prarit Bhargava wrote:
> When I submitted this patch I looked at other commits in the kernel near
> top-of-tree and they have Signed-off-by followed by Co-developed-by, and also
> took your suggestion of not using a Signed-off-by for Alexander.  That's why I

I said:

"This is not how this is expressed. Either you write that in free text in
the commit message or you use Co-developed-by. More details in

Documentation/process/submitting-patches.rst"

> I'm now thoroughly confused as to what the correct format is.  It seems like
> checkpatch.py is telling me to include a Signed-off-by in addition to the
> Co-developed-by for Alexander but you explicitly told me not to.
>
> > See Documentation/process/submitting-patches.rst for more detail.

You need to start reading my replies in their entirety and finally read that
document I've pointed to twice:

"Co-developed-by: states that the patch was co-created by multiple developers;
it is a used to give attribution to co-authors (in addition to the author
attributed by the From: tag) when several people work on a single patch.  Since
									  ^^^^^
Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
followed by a Signed-off-by: of the associated co-author."
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I.e., basically what checkpatch is saying.

So you either

a) write in free text in the commit message something like

"This is based on a patch submitted to RH bugzilla by Alexander Krupp
<centos@akr.yagii.de>"

OR

b) use

Co-developed-by: Alexander Krupp <centos@akr.yagii.de>
Signed-off-by: Alexander Krupp <centos@akr.yagii.de>

Either a) XOR b).

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
