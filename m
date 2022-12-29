Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8677D658C72
	for <lists+linux-edac@lfdr.de>; Thu, 29 Dec 2022 12:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiL2LzH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Dec 2022 06:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiL2Lyk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Dec 2022 06:54:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5DB13F37;
        Thu, 29 Dec 2022 03:54:39 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 323C01EC052A;
        Thu, 29 Dec 2022 12:54:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672314878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gNxqtzX2InN3wXWaN0Gi+XlNilpsZ6f9kbafeCoRqOs=;
        b=IBCSNfWHoh41q06mBf4XKcHHng5hjb8qwji368HubzrTtf/zXTlbW4iPP9V85NzqS2n0aT
        MhJNLskTC8FS2wb0ol+kZNHoSJC2k3RBz3aWz35WYe88ToFLn+oNcD3LrbHZoKcUPYnnHe
        RxofTRp0NcPTLTfT5UbpzF/kbnaLG/8=
Date:   Thu, 29 Dec 2022 12:54:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mce: fix missing stack-dumping in mce_panic()
Message-ID: <Y61/+V47qH/8OVxp@zn.tnic>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
 <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Dec 03, 2022 at 10:19:32AM +0800, Miaohe Lin wrote:
> So I think it's better to have at least one stack dumps. Also what the commit
> 6e6f0a1f0fa6 ("panic: don't print redundant backtraces on oops") and commit
> 026ee1f66aaa ("panic: fix stack dump print on direct call to panic()") want
> to do is avoiding nested stack-dumping to have the original oops data being
> scrolled away on a 80x50 screen but to have *at least one backtraces*. So
> this patch acts more like a BUGFIX to ensure having at least one backtraces
> in mce_panic().

So which commit broke this?

One of the two above or

004429956b48 ("handle recursive calls to bust_spinlocks()")

or

d896a940ef4f ("x86, mce: remove oops_begin() use in 64bit machine check")

or...?

By looking at their dates, they're pretty much too old so that this can
go to *all* stable kernels.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
