Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD88F2EF61D
	for <lists+linux-edac@lfdr.de>; Fri,  8 Jan 2021 17:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbhAHQ6b (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Jan 2021 11:58:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60208 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbhAHQ6b (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 8 Jan 2021 11:58:31 -0500
Received: from zn.tnic (p200300ec2f0a31007b8134cbda999f41.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:3100:7b81:34cb:da99:9f41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98FD41EC0512;
        Fri,  8 Jan 2021 17:57:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610125069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W2Li9qcxBEGFG0Wh9wJ/nWlySMj6qKagC1h24cKe0KI=;
        b=XlpvZ3vVcCWljLf2/ggmO3urjDS9IO8tmFr/Ugl0fn/IpRn+0+5GR9JS0wQ5nBvqKJr1nO
        9KNGT3wEhrXCjhvtne/AF6VS20c9WF5QxL3ytW58kIEJbmMQ6FhrBVNytx2HR+lilen/ap
        B3zSjm/TF08x4mv/m0nnqQ84gOgheDk=
Date:   Fri, 8 Jan 2021 17:57:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        kernel-team@fb.com
Subject: Re: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Message-ID: <20210108165748.GE4042@zn.tnic>
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
 <20210106183244.GA24607@zn.tnic>
 <20210106191353.GA2743@paulmck-ThinkPad-P72>
 <20210107070724.GC14697@zn.tnic>
 <20210107170844.GM2743@paulmck-ThinkPad-P72>
 <20210108123156.GD4042@zn.tnic>
 <20210108145514.GS2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210108145514.GS2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 08, 2021 at 06:55:14AM -0800, Paul E. McKenney wrote:
> Looks good to me!  I agree that your change to the pr_emerg() string is
> much better than my original.

Well, the rest of the MCE code uses pr_emerg on that path so...

> And good point on your added comment, plus it was fun to see that my
> original "holdouts" wording has not completely vanished. ;-)

I had to leave it in seeing how you love that formulation. :-P

> Thank you very much!!!

Thanks too Paul!

/me queues.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
