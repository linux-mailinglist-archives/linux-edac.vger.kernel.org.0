Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F0A3227F3
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 10:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhBWJny (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Feb 2021 04:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhBWJno (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Feb 2021 04:43:44 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4114C061574;
        Tue, 23 Feb 2021 01:43:03 -0800 (PST)
Received: from zn.tnic (p200300ec2f08d80090b9e94bbb8b58e7.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:d800:90b9:e94b:bb8b:58e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD30D1EC051F;
        Tue, 23 Feb 2021 10:43:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614073382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7UYWBH9e/QekT/yZ2j0MWpn9p1KqGykHuIn57/OJeYU=;
        b=ilBanSpDnzWgfk4q42R3rvCGMikfiL9OhTuGmGIsNrAnm+/9KBuiTQXutfgoPsoCv7eQfH
        Rprz4+o1jllfoKv38II0guZ1g5bvZ+Za3g0ylS/T5w/NM/UfRM5Jq6tqa4WrZyF52HTWGn
        mD/KFUXtElSsZaGc7vBhTKPWS4LGlkw=
Date:   Tue, 23 Feb 2021 10:43:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     tony.luck@intel.com, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangfeng1@kingsoft.com
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210223094300.GA26060@zn.tnic>
References: <20210222173109.7b7ac42a@alex-virtual-machine>
 <20210222100356.GB29063@zn.tnic>
 <20210222180819.3998fe33@alex-virtual-machine>
 <20210222102206.GC29063@zn.tnic>
 <20210222192146.76ffec84@alex-virtual-machine>
 <20210222201723.0fcec589@alex-virtual-machine>
 <20210222122241.GA10880@zn.tnic>
 <20210222203549.0e54c26f@alex-virtual-machine>
 <20210222124550.GB10880@zn.tnic>
 <20210223102755.13cbdffd@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223102755.13cbdffd@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 23, 2021 at 10:27:55AM +0800, Aili Yao wrote:
> When Guest access one address with UE error, it will exit guest mode,
> the host will do the recovery job, and then one SIGBUS is send to
> the VCPU and qemu will catch the signal, there is only address and
> error level no RIPV in signal, so qemu will assume RIPV is cleared and
> inject the error into guest OS.

Lemme see:

void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)

    /* If we get an action required MCE, it has been injected by KVM
     * while the VM was running.  An action optional MCE instead should
     * be coming from the main thread, which qemu_init_sigbus identifies
     * as the "early kill" thread.
     */
    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);

    ...

	kvm_mce_inject(cpu, paddr, code);

in that function:

    if (code == BUS_MCEERR_AR) {
        status |= MCI_STATUS_AR | 0x134;
        mcg_status |= MCG_STATUS_EIPV;
    } else {
        status |= 0xc0;
        mcg_status |= MCG_STATUS_RIPV;
    }

That looks like a valid RIP bit to me. Then cpu_x86_inject_mce() gets
that mcg_status and injects it into the guest.

So I can't follow your claim - qemu does handle RIPV just fine, it
seems.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
