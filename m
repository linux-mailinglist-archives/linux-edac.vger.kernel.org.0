Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F4332178A
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 13:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBVMtn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 07:49:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41860 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231560AbhBVMqg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 22 Feb 2021 07:46:36 -0500
Received: from zn.tnic (p200300ec2f0402008ca1f4f712cbc8cf.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:200:8ca1:f4f7:12cb:c8cf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A8671EC04DF;
        Mon, 22 Feb 2021 13:45:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613997951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=31aR5SmeNWKzmknO5BmzvlMZt/XF1kSn8FQK2ndz1gY=;
        b=CR4sY/solpVu3FGOCwN77RSvpi7NPfYKjsxIQvulkvyDeg/5olTohtaYKfm1d/cXYs89Hz
        eWkB5B9D6ZvARsAM0BsfFBhIicmk7yhAT/QFOCj+uolESi+3Vh4HF7T/lc+HXg0XYMFH+6
        UFjw290QPcwnoAg8AaUT+SAFDvp2ECI=
Date:   Mon, 22 Feb 2021 13:45:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     tony.luck@intel.com, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangfeng1@kingsoft.com
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210222124550.GB10880@zn.tnic>
References: <20210222115007.75b7de9b@alex-virtual-machine>
 <20210222092403.GA29063@zn.tnic>
 <20210222173109.7b7ac42a@alex-virtual-machine>
 <20210222100356.GB29063@zn.tnic>
 <20210222180819.3998fe33@alex-virtual-machine>
 <20210222102206.GC29063@zn.tnic>
 <20210222192146.76ffec84@alex-virtual-machine>
 <20210222201723.0fcec589@alex-virtual-machine>
 <20210222122241.GA10880@zn.tnic>
 <20210222203549.0e54c26f@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222203549.0e54c26f@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 22, 2021 at 08:35:49PM +0800, Aili Yao wrote:
> Guest VM, the qemu has no way to know the RIPV value, so always get it
> cleared.

What does that mean?

The guest VM will get the MCE signature it gets from the host kernel so
the host kernel most definitely knows the RIPV value.

It looks like you're testing how guests will handle MCEs which the host
has caught and wants to inject into the guest for further handling. What
is your exact use case? Please explain in detail how I can reproduce it
step-by-step locally.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
