Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193AB322861
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 11:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhBWJ7a (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Feb 2021 04:59:30 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:45142 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231143AbhBWJ51 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Feb 2021 04:57:27 -0500
X-AuditID: 0a580157-f21ff7000005df43-8c-6034cb1eb985
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 5A.56.57155.E1BC4306; Tue, 23 Feb 2021 17:30:06 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 23 Feb
 2021 17:56:40 +0800
Date:   Tue, 23 Feb 2021 17:56:40 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <tony.luck@intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft>
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210223175640.5708c7ed@alex-virtual-machine>
In-Reply-To: <20210223094300.GA26060@zn.tnic>
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
        <20210223094300.GA26060@zn.tnic>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsXCFcGooCt32iTBYMZHFovPG/6xWUzbKG5x
        4VQDk8XlXXPYLC4dWMBksXnTVGaLNxfusVj82PCY1eLHxR9sDpwe31v7WDwW73nJ5LFpVSeb
        x9O+d4we786dY/d4v+8qm8fnTXIeJ1q+sAZwRHHZpKTmZJalFunbJXBlbJy0lK2gk7vie/9R
        5gbGbo4uRk4OCQETia8LV7B3MXJxCAlMZ5JYe3kvE4TzilGi9/4iFpAqFgFVie9TL7GC2GxA
        9q57s8BsEQElia+L5oI1MAtcY5RY9moWWxcjB4ewQKjEkmmFIDW8AlYS717NAKvnFNCVaGzd
        yghiCwncY5Z40eoLYvMLiEn0XvnPBHGRvUTblkWMEL2CEidnPgG7gVlAR+LEqmPMELa8xPa3
        c5gh5ihKHF7yix2iV0niSPcMNgg7VmLZvFesExiFZyEZNQvJqFlIRi1gZF7FyFKcm264iRES
        PeE7GOc1fdQ7xMjEwXiIUYKDWUmEl+2uUYIQb0piZVVqUX58UWlOavEhRmkOFiVx3sBtJglC
        AumJJanZqakFqUUwWSYOTqkGpsKDGks/3LFXEFh29uOlGZ9PdD24l2VxiPv36fz54Y2vNeq2
        XM/Y/2Ixh98Wc+bQn/H8M298dlr9S17ctzQ5XnuTUsO0TdfvrGh44tkcOEPr3+nCJAV9e31X
        detc5sv1NrNef5u0Vv3rtN+nKxzsIiTeh8lFz1X7ZXvmttyNJ0enex7cMFG9o3BWulF5lPhc
        Ja2TSxlKrFw4v4d8T7r82/pMLQeX9fcLAY035v7svlp1sOdb1fmHu3PXigToCqRoHJVce2uJ
        4frzGb27hH+zeN8U7w5ULb5+6nBTudnFk/YXtbl5xHM76ldxeV2d6GMVMXfzInbJr+pFK1Wa
        qld8uClfyZjoM7nkaqb+mYle75RYijMSDbWYi4oTATpAkHQNAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 23 Feb 2021 10:43:00 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Feb 23, 2021 at 10:27:55AM +0800, Aili Yao wrote:
> > When Guest access one address with UE error, it will exit guest mode,
> > the host will do the recovery job, and then one SIGBUS is send to
> > the VCPU and qemu will catch the signal, there is only address and
> > error level no RIPV in signal, so qemu will assume RIPV is cleared and
> > inject the error into guest OS.  
> 
> Lemme see:
> 
> void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> 
>     /* If we get an action required MCE, it has been injected by KVM
>      * while the VM was running.  An action optional MCE instead should
>      * be coming from the main thread, which qemu_init_sigbus identifies
>      * as the "early kill" thread.
>      */
>     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
> 
>     ...
> 
> 	kvm_mce_inject(cpu, paddr, code);
> 
> in that function:
> 
>     if (code == BUS_MCEERR_AR) {
>         status |= MCI_STATUS_AR | 0x134;
>         mcg_status |= MCG_STATUS_EIPV;
>     } else {
>         status |= 0xc0;
>         mcg_status |= MCG_STATUS_RIPV;
>     }
> 
> That looks like a valid RIP bit to me. Then cpu_x86_inject_mce() gets
> that mcg_status and injects it into the guest.

What i inject is AR error, and I don't see MCG_STATUS_RIPV flag.

Tks
Aili Yao


