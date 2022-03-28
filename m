Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32574E98E3
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 16:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243609AbiC1OGR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 10:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243606AbiC1OGR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 10:06:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FE01AF01;
        Mon, 28 Mar 2022 07:04:36 -0700 (PDT)
Received: from zn.tnic (p200300ea9715611f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:611f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 128971EC0554;
        Mon, 28 Mar 2022 16:04:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648476271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8PvL2NBkYmWn7Kv5lbwoJ37q4vTsHm2ZlegzleFZA5Y=;
        b=YxFF5HkLkezSY99cI85f2qcDDV8Tupqk8jvyP69SrNmy6C01KmfR/lYVrN15QhvLdIB1Z7
        GulMmOuj43BPSBDM+pJnNdRFR0GxAerdA8Xe53DBry5v6C8F0upTIvx8/O2oVfgsZdOB3F
        8y81jIzARdu6wZCmk/329yNnceLGKvI=
Date:   Mon, 28 Mar 2022 16:04:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH 0/2] x86/mce: Grade new machine errors for AMD MCEs and
 include messages for panic cases
Message-ID: <YkHAcIZDpZER9knA@zn.tnic>
References: <20220328134131.736572-1-carlos.bilbao@amd.com>
 <YkG+SFCYMoAXrqJ3@zn.tnic>
 <299368f0-a3f3-c252-ab98-7dd324dbd3c5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <299368f0-a3f3-c252-ab98-7dd324dbd3c5@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Mar 28, 2022 at 08:57:04AM -0500, Carlos Bilbao wrote:
> Just fixed a typo in the first patch -I should have included a change log.

Well, we have the merge window open currently:

Merge window
^^^^^^^^^^^^

Please do not expect large patch series to be handled during the merge
window or even during the week before.  Such patches should be submitted in
mergeable state *at* *least* a week before the merge window opens.
Exceptions are made for bug fixes and *sometimes* for small standalone
drivers for new hardware or minimally invasive patches for hardware
enablement.

During the merge window, the maintainers instead focus on following the
upstream changes, fixing merge window fallout, collecting bug fixes, and
allowing themselves a breath. Please respect that.

The release candidate -rc1 is the starting point for new patches to be
applied which are targeted for the next merge window.

---

and since you're new to this, I'd suggest you take the
time to read Documentation/process/ and especially
Documentation/process/submitting-patches.rst while waiting.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
