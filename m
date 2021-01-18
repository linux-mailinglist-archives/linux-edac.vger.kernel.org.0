Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED7D2FA4FA
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jan 2021 16:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393467AbhARPke (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Jan 2021 10:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393474AbhARPka (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Jan 2021 10:40:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0900C061574;
        Mon, 18 Jan 2021 07:39:49 -0800 (PST)
Received: from zn.tnic (p200300ec2f069f009291f9f4a50f0191.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9f00:9291:f9f4:a50f:191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 445BA1EC04F0;
        Mon, 18 Jan 2021 16:39:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610984388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RzHd1xNl9QC5sTnjUIzkxqrURiWyyH0SsnXWur2agWQ=;
        b=ReASYQRviTwk2Oz0omPg5AaPzLdaKZMDCFMmuXmfjdiCEaDtlk4b3lpo2OLC823dl/5QCl
        PHWX4op3lR0ASByj0t1RBRP+vHTX/n+RXYFKMsJFWvC5/ogbUXoGq5BqDVag1zY8euFQna
        EOU9NwQ9xWa5zukG8TL/V4HLmfQoJuQ=
Date:   Mon, 18 Jan 2021 16:39:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210118153939.GC30090@zn.tnic>
References: <20210111214452.1826-1-tony.luck@intel.com>
 <20210115003817.23657-1-tony.luck@intel.com>
 <20210115152754.GC9138@zn.tnic>
 <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 15, 2021 at 11:34:35AM -0800, Luck, Tony wrote:
> In the user mode case we should only bump mce_count to "1" and
> before task_work() gets called.

Ok, right, it should not be possible to trigger a second MCE while
queue_task_work() runs when it is a user MCE. The handler itself won't
touch the page with the hw error so our assumption is that it'll get
poisoned.

If it doesn't, I guess the memory failure code will kill the process
yadda yadda...

> It shouldn't hurt to do the same checks. Maybe it will catch something
> weird - like an NMI handler on return from the machine check doing a
> get_user() that hits another machine check during the return from this
> machine check.

Eww.

> AndyL has made me extra paranoid. :-)

Yeah, he comes up with the nuttiest scenarios. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
