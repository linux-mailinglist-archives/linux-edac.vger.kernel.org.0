Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9988E6969E8
	for <lists+linux-edac@lfdr.de>; Tue, 14 Feb 2023 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjBNQj4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Feb 2023 11:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjBNQja (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Feb 2023 11:39:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540B02C67E;
        Tue, 14 Feb 2023 08:38:57 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ACED71EC072E;
        Tue, 14 Feb 2023 17:38:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676392735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jN+gT+FJIz779Sj865bJgIneG1lAlFolCGrR66aWtEk=;
        b=NL2wkTCtLcfwDipURL4tDYqN5u+XawepQ8kgZ3RzxFPFJI4U3JkhBUdm0o77ppAXKNeL4f
        vb/K/2iNIyxAyWzgLfT3zQ4qu9Iotetq/xqmU3S5lopqoqhW042FR/OrLE8JNynN8057qj
        fYhAUDdGnSLR4tBsfdSKjn/MmKiK0JE=
Date:   Tue, 14 Feb 2023 17:38:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, Tom Rix <trix@redhat.com>,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Shut up an -Werror,-Wsometimes-uninitialized
 clang false positive
Message-ID: <Y+u5GytbjF1be9sw@zn.tnic>
References: <20230213191510.2237360-1-trix@redhat.com>
 <Y+qZthCMRL1m0p4B@yaz-fattaah>
 <Y+qcU2M5gchfzbky@zn.tnic>
 <Y+qdVHidnrrKvxiD@dev-arch.thelio-3990X>
 <03b91ce8-c6d0-63e7-561c-8cada0ece2fe@redhat.com>
 <Y+q1mhrAKTobp3fa@yaz-fattaah>
 <Y+q2pXYI02qAje8N@dev-arch.thelio-3990X>
 <Y+tapzerW7h9vMvp@zn.tnic>
 <Y+ubhHlWFv4ifmGn@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+ubhHlWFv4ifmGn@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 14, 2023 at 07:32:36AM -0700, Nathan Chancellor wrote:
> So I disagree with the characterization that clang is "overeager to
> report false positives" and I think the opinionated parts of the commit
> message could be replaced with some of the technical analysis that Tom
> and I did to show why this is a false positive but not one clang can
> reason about with the way the code is structured (since the warning does
> not perform interprocedural analysis).

I'm sure you can create all kinds of cases like this one if
interprocedural analysis or aggressive inlining doesn't happen. So I'm
rather surprised that this is the first false positive to happen. But
whateva.

And since we're disagreeing with things: I don't mind if this is a false
positive - I don't care. What I don't agree with is having -Werror fail
the build because of it and forcing us to "wag the dog", so to speak.

And you can imagine that this has been happening for a while now. And it
can explain my reaction to yet another compiler fix.

But ok, we've wasted enough time on this, lemme tone down the commit
message and commit it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
