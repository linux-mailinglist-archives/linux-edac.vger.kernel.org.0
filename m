Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681313075CE
	for <lists+linux-edac@lfdr.de>; Thu, 28 Jan 2021 13:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhA1MST convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 28 Jan 2021 07:18:19 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:41180 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231555AbhA1MSL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 28 Jan 2021 07:18:11 -0500
X-Greylist: delayed 948 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 07:18:02 EST
X-AuditID: 0a580155-6fbff700000550c6-25-6012a164fcc0
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 13.F6.20678.461A2106; Thu, 28 Jan 2021 19:35:00 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 28 Jan
 2021 20:01:28 +0800
Date:   Thu, 28 Jan 2021 20:01:28 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <tony.luck@intel.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <james.morse@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <yangfeng1@kingsoft.com>,
        <CHENGUOMIN@kingsoft.com>
Subject: Re: [PATCH v2] Dump cper error table in mce_panic
Message-ID: <20210128200128.6f022993.yaoaili@kingsoft.com>
In-Reply-To: <20201120102422.GA712@zn.tnic>
References: <20201104065057.40442-1-yaoaili126@163.com>
        <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
        <20201118124538.GI7472@zn.tnic>
        <20201119134057.37ca2c19.yaoaili@kingsoft.com>
        <20201119174508.GE3769@zn.tnic>
        <20201120172235.620eb826.yaoaili@kingsoft.com>
        <20201120102422.GA712@zn.tnic>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsXCFcGooJuyUCjBYOdNEYvPG/6xWdzft5zJ
        YufDt2wWy/f1M1pcONXAZHHm9CVWizcX7rE4sHt8b+1j8Vgzbw2jx+I9L5k8Nq3qZPPYcrWd
        xePzJrkAtigum5TUnMyy1CJ9uwSujLmnrQquyVWcWNfJ0sA4X6KLkZNDQsBEYtmH/+xdjFwc
        QgLTmSQu3L/MCOG8YJS49bOTGaSKRUBVYtqJeWA2G5C9694sVhBbREBJ4uuiuUwgDcwC5xkl
        +hqusoAkhAWsJJ5ueANm8wLZa6ddAWvgFNCW6Jnzkwliw3omifaHu4AcDg5+ATGJVw3GECfZ
        Szz/e5YZoldQ4uTMJ2BzmAU0JVq3/2aHsLUlli18DVYjJKAocXjJL3aIXiWJI90z2CDsWIll
        816xTmAUnoVk1Cwko2YhGbWAkXkVI0txbrrRJkZIXITuYJzR9FHvECMTB+MhRgkOZiUR3rdz
        hBKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ85Y78CUICaQnlqRmp6YWpBbBZJk4OKUamMwLjtQH
        SU5dYxz9rHVWd1f3q+kOe5mZ8g8b6AufmlxdGSrwsF5sR2Uw6wVt6aLZnJGP7i7vd9199+ui
        +Rzz7m0Mj6y/fSK4pv9Psr30Dl8TpqKJvFWWDcdEN92c9lkjp/fMvIV9glpn1L4sFVLcseLJ
        3B3Bt12ufVApO/vZsTbpa6C+Q1bilh/X+20zrEu+vO0TOHa0huFf6pxJZ4ucNTPXadR3S6bG
        8idIOH7S0rzTqr7s84yCXUqCDlyBea9zvCY5fDr1kf2Eztt9Mekzu0/9qM3b+KTuh/0sednZ
        c+cdtONeer8/xHRXZPf0eJ/3j02+nvT/ZJvntENNxok/aWvM/m1L7be/6XH2W9C3T4mlOCPR
        UIu5qDgRAC9wxqP6AgAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


> On Fri, Nov 20, 2020 at 05:22:35PM +0800, Aili Yao wrote:
> > Hi, This test result if from tip/master, previous is upstream latest.  
> 
> Thanks for doing those, now let's see.
> 
> With rc4 you have the MCE error in the first kernel:
> 
> [  106.956286] Disabling lock debugging due to kernel taint
> [  106.962373] mce: [Hardware Error]: CPU 18: Machine Check Exception: 5 Bank 7: be00000001010091
> [  106.962377] mce: [Hardware Error]: RIP !INEXACT! 10:<ffffffffac58472a>
> [  106.996488] {acpi_idle_do_entry+0x4a/0x60}
> [  107.001057] mce: [Hardware Error]: TSC ae4b410af0b8 ADDR 314d193000 MISC 200400c008002086
> [  107.010283] mce: [Hardware Error]: PROCESSOR 0:50657 TIME 1605843017 SOCKET 1 APIC 40 microcode 5000021
> [  107.020767] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
> [  107.031295] mce: [Hardware Error]: Machine check: Processor context corrupt
> [  107.039065] Kernel panic - not syncing: Fatal machine check
> 
> Now the kdump kernel fires and there's an error record in the CPER
> thing.
> 
> > [    6.280390] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> > [    6.288655] ACPI: Power Button [PWRF]
> > [    6.292961] ERST: Error Record Serialization Table (ERST) support is initialized.
> > [    6.301295] pstore: Registered erst as persistent store backend
> > [    6.307912] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
> > [    6.308886] {1}[Hardware Error]: event severity: fatal
> > [    6.308886] {1}[Hardware Error]:  Error 0, type: fatal
> > [    6.308886] {1}[Hardware Error]:  fru_text: Card03, ChnB, DIMM0
> > [    6.308886] {1}[Hardware Error]:   section_type: memory error
> > [    6.308886] {1}[Hardware Error]:   error_status: 0x0000000000000000  
> 
> And this error_status is all clear. I wonder why.
> 
> Looking at the ÜFI spec "Section O: Error Status" it defines a couple
> of bits there: whether it was an address or control bits error, who
> detected the error (responder, requestor), whether it was the first
> error, etc, etc.
> 
> And none of those bits are set.
> 
> Which makes me not trust that error record a whole lot but that's a
> given, since it is firmware and firmware is an unfixable piece of crap
> by definition.
> 
> So then one could probably say that if none of those error status bits
> are set, then the error being reported is not something, let's say
> "fresh". This is doubly the case considering that it gets detected when
> the GHES driver probes:
> 
>         /* Handle any pending errors right away */
>         spin_lock_irqsave(&ghes_notify_lock_irq, flags);
>         ghes_proc(ghes);
>         spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
> 
> so *maybe*, just *maybe* one could say here:
> 
> If the error_status doesn't have any valid bits *and* it has been
> detected on driver init - i.e., the error has been there before the
> driver probed, then even if the error is fatal, GHES should not call
> __ghes_panic().
> 
> The even better way to detect this is to be able to check whether this
> is the kdump kernel and whether it got loaded due to a fatal MCE in the
> first kernel and then match that error address with the error address of
> the error which caused the first panic in the mce code. Then the second
> kernel won't need to panic but simply log.
> 
> However, I think that second way to check is probably hard and the first
> heuristic is probably good enough...
> 
> Tony, thoughts?
> 

Long away from this issue, any feedback?
From kexec-tool, the hest_disable parameter has been added to 2nd kernel, So
the kdump will not be affected by ghes errors.
But we still may lose the ghes error info, so i think this patch is still needed?

Thanks

-- 
Best Regards!

Aili Yao
