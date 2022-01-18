Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEFB492C56
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jan 2022 18:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347238AbiARR2Q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Jan 2022 12:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347244AbiARR2P (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Jan 2022 12:28:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A50C061574;
        Tue, 18 Jan 2022 09:28:15 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E28B31EC03AD;
        Tue, 18 Jan 2022 18:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642526890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x8Zd56PpE7LdDoZhdhHLGkkLVqn49NkveL20PwSonmc=;
        b=Rn+Wfku2YrEQlVmJEf8/F+QsAUgc7eXqVpzlE0hPuR5O3AR7oxGsOfbT9ovlpIfs1wR2Zh
        nJiZAwki7PWQ1Tisb12NeuxRaAsbivPg9TLmcKjabQAaLes+nd/EBynOzEC/mOkN6YLqiV
        NKBdk3S30uqvzjtXGzd7Vg6Q70QymoU=
Date:   Tue, 18 Jan 2022 18:28:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Lei Wang <lewan@microsoft.com>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Message-ID: <Yeb4sK+ZmSHjWPWL@zn.tnic>
References: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
 <YeRkGvestiloCAUV@zn.tnic>
 <20220118152816.GA89184@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220118152816.GA89184@sequoia>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 18, 2022 at 09:28:16AM -0600, Tyler Hicks wrote:
> KERN_ERR messages trip log scanners and cause concern that the
> kernel/hardware is not configured or working correctly. They also add a
> little big of ongoing stress into kernel maintainer's lives, as we
> prepare and test kernel updates, since they show up as red text in
> journalctl output that we have to think about regularly. Multiple
> KERN_ERR messages, 8 in this case, can also be considered a little worse
> than a single error message.

It sounds to me like you wanna read

Documentation/process/stable-kernel-rules.rst

first.

> I feel like this trivial fix is worth taking into stable rather than
> suppressing these errors (mentally and in log scanners) for years.

Years? 

In any case, sorry, no, I don't consider this stable material.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
