Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996604D5465
	for <lists+linux-edac@lfdr.de>; Thu, 10 Mar 2022 23:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244576AbiCJWOt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 17:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbiCJWOt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 17:14:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4747262127;
        Thu, 10 Mar 2022 14:13:43 -0800 (PST)
Received: from zn.tnic (p200300ea97193878e79a34f2fb5add4f.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:e79a:34f2:fb5a:dd4f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 75D331EC0432;
        Thu, 10 Mar 2022 23:13:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646950417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4jApLr5h3MOaJR8HuPKksowRenJ+ECkFPNCumJIL5gg=;
        b=fPcC7LKb6FEKoOPPuIoeYnIjVFnCCwhS1hvVH+uji3gXrXfxOxhPleLn+o/VOXs5Nsgqno
        gFGwF1XE2u0OTG/Mi1kZS6wD8sGPPtdKB5i5QptvgPfh/eQiEc9CfyzjtA31zZUgWgYQNy
        Qz/ZbBd0RgnhZlFYuWT65edUYAEjJYs=
Date:   Thu, 10 Mar 2022 23:13:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH] x86/mce: Cover grading of AMD machine error checks
Message-ID: <Yip4EV69+lElCuPM@zn.tnic>
References: <20220309174107.6113-1-carlos.bilbao@amd.com>
 <Yijz7dA1U0AMcYPZ@zn.tnic>
 <4a345de2-6a2c-fe26-c55c-34ce6ea431d4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a345de2-6a2c-fe26-c55c-34ce6ea431d4@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 10, 2022 at 12:24:08PM -0600, Carlos Bilbao wrote:
> We will cover grading of MCEs like deferred memory scrub errors, attempts 
> to access poisonous data, etc. I could list all new covered cases in the 
> commit message if you think that'd be positive.

So no actual use case - you want to grade error severity for all types
of MCEs.

> Hope that helps clarify,

Yes, it does a bit.

It sounds to me like you want to do at least two patches:

1. Extend the severity grading function with the new types of errors

2. Add string descriptions of the error types mce_severity_amd() looks
at, so that mce_panic() issues them.

I.e., you want to decode the fatal MCEs which panic the machine.

In general, what would help is if you think about what you're trying to
achieve and write it down first. How to achieve that we can figure out
later.

What happens now is you send me a patch and I'm trying to decipher from
the code why you're doing what you're doing. Which is kinda backwards if
you think about it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
