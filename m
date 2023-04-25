Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F131E6EE6DC
	for <lists+linux-edac@lfdr.de>; Tue, 25 Apr 2023 19:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjDYRfb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Apr 2023 13:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjDYRfa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Apr 2023 13:35:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD9572A2;
        Tue, 25 Apr 2023 10:35:26 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A95CF1EC0441;
        Tue, 25 Apr 2023 19:35:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682444124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qpIvwicJKt8OA8HL56aQRgaj19rjjLtv4xh6BQSDau0=;
        b=Uubv8SkCLxaSp6HhzHBEC5B1bdkXXX+N79PguWtabwkfpFgMDa6SEmEn5xhmdAwfybQ59f
        v0qe/F4+/2vgx85D4uiXx37b34TRmHPdd8Ng9b97vd05hLMvWNCDgqPHr+5JyIdrlC2Oew
        v5ltaoMt7/+UaKNTxCGFToSD0ZyDRFg=
Date:   Tue, 25 Apr 2023 19:35:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC updates for v6.4
Message-ID: <20230425173520.GDZEgPWMmi7ZXrTLs2@fat_crate.local>
References: <20230424072836.GAZEYvpDGrV3bXx690@fat_crate.local>
 <CAHk-=wgrN-uPnNTamBwrxMgibBH9N9zX57nbDW7_hLdi4SstQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgrN-uPnNTamBwrxMgibBH9N9zX57nbDW7_hLdi4SstQw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 25, 2023 at 09:55:14AM -0700, Linus Torvalds wrote:
> So I'm not asking for surgical precision. I'm asking for "reasonable
> workflow", where people avoid doing pointlessly silly things.

As always, I really appreciate elaborating on the whole reasoning behind
this.

While we're on the topic: when we send you tip urgent fixes, we base
each branch off of the current -rc, put the urgent fixes ontop, test,
... and send them to you in a week's time, roughly.

Now, after you've pulled, we could fast-forward the urgent branch to the
next -rc where new fixes come - and I do that most of the time - or we
could not do that because of, as you say, if there's no really good
reason to fast-forward (important other fix, new functionality from the
newest -rc a patch needs, yadda yadda) then those urgent branches do not
necessarily have to be fast-forwarded but simply get more fixes applied
ontop.

Right, that makes sense.

Oh, and I'm sure if a branch is based on what looks like a random point
but there's a good explanation accompanying it why it is based on that
random point, then I guess that's perfectly fine too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
