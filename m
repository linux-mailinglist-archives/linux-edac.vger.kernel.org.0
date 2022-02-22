Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB75B4C039C
	for <lists+linux-edac@lfdr.de>; Tue, 22 Feb 2022 22:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiBVVQE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Feb 2022 16:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiBVVQE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Feb 2022 16:16:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAF1F1ADF;
        Tue, 22 Feb 2022 13:15:38 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 19CAF1EC053F;
        Tue, 22 Feb 2022 22:15:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645564533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FY7rk9icL2QjQP9h0uce+oJPCClSEf6T3glXPW4y6A0=;
        b=hRsf68l4Ok7Fg3MYi/GsyvKGo/21fJlMNCXpTP2YOdJpmWSfqLjknZbukSQqcemfq4wmTV
        IZCEi6XduLIlJG33HfzEFmYe8Em7j/1/6aQEpSAlHdLgF2AiOcARzD8yTBWcQ/uVYnUgH2
        R0P4XTxz5DZmTtWFQC2KTmhnYGIsX/w=
Date:   Tue, 22 Feb 2022 22:15:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v3 3/4] x86/mce, EDAC/mce_amd: Cache MCA_CONFIG[McaX] in
 struct mce_bank
Message-ID: <YhVSecR7DqhNvFod@zn.tnic>
References: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220211223442.254489-4-Smita.KoralahalliChannabasappa@amd.com>
 <YhUC1wW0mxC/Dmpv@zn.tnic>
 <66a6cc6e-55fa-45c4-1387-ff9d055eec23@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66a6cc6e-55fa-45c4-1387-ff9d055eec23@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 22, 2022 at 02:47:44PM -0600, Koralahalli Channabasappa, Smita wrote:
> But what do you think of severity? Will this make an impact when handling
> panic severity levels? .. mce_severity_amd_smca().

Well, look at the code: severity grading gets called when either polling
or #MC handler gets to log an MCE. Reading an MSR costs a couple of
hundred cycles. The whole MCE logging path costs maybe a couple of
*orders* of magnitude more so that MSR read is in the noise when you
have a 4GHz CPU executing 4 billion cycles per second.

Now, that's for a single MCE.

If it were more, say 10s, 100s, 1000s MCEs, then the MSR read is the
least of your problems.

But this is me conjecturing - I'm always interested in a real proof
where it shows or it does not.

I guess what I'm trying to say is, yeah, sure, speed is mostly a good
argument. But you always need to consider at what cost you'd get that
speed. And if at all. There are other important things like keeping the
code base maintainable, readable and able to accept modifications for
new features.

So there's always this question of balance that needs to be asked...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
