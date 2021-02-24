Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA03235D5
	for <lists+linux-edac@lfdr.de>; Wed, 24 Feb 2021 03:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhBXCkM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Feb 2021 21:40:12 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:12208 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBXCkK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Feb 2021 21:40:10 -0500
X-AuditID: 0a580157-f21ff7000005df43-5a-6035b61ade2a
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 43.CE.57155.A16B5306; Wed, 24 Feb 2021 10:12:42 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 24 Feb
 2021 10:39:21 +0800
Date:   Wed, 24 Feb 2021 10:39:21 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210224103921.3dcf0b65@alex-virtual-machine>
In-Reply-To: <9232988079334ab8801cccec6557f9c3@intel.com>
References: <20210222180819.3998fe33@alex-virtual-machine>
        <20210222102206.GC29063@zn.tnic>
        <20210222192146.76ffec84@alex-virtual-machine>
        <20210222201723.0fcec589@alex-virtual-machine>
        <20210222122241.GA10880@zn.tnic>
        <20210222203549.0e54c26f@alex-virtual-machine>
        <20210222124550.GB10880@zn.tnic>
        <20210223102755.13cbdffd@alex-virtual-machine>
        <20210223094300.GA26060@zn.tnic>
        <20210223175640.5708c7ed@alex-virtual-machine>
        <20210223100538.GB26060@zn.tnic>
        <20210223192711.0b517745@alex-virtual-machine>
        <9232988079334ab8801cccec6557f9c3@intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsXCFcGooCu1zTTBYMlHGYvPG/6xWUzbKG5x
        4VQDk8XlXXPYLC4dWMBksXnTVGaLNxfusVj82PCY1YHD43trH4vH4j0vmTw2repk83h37hy7
        x/t9V9k8Pm+S8zjR8oU1gD2KyyYlNSezLLVI3y6BK+NcU33BGu6KJ8+6mBsY33J0MXJySAiY
        SJx8fJyli5GLQ0hgOpPEzq8rGCGcV4wS1478Z+9i5OBgEVCVODrNFKSBDcjcdW8WK4gtIqAm
        cWnxA2aQemaBdmaJA1fOM4PUCwuESiyZVghSwytgJXHzyxE2kDCngKXEkdcKEOP3sUhsWnOO
        BaSGX0BMovfKfyaIg+wl2rYsYoToFZQ4OfMJWA2zgI7EiVXHmCFseYntb+eA2UICihKHl/xi
        h+hVkjjSPYMNwo6VWDbvFesERuFZSEbNQjJqFpJRCxiZVzGyFOemG25ihERJ+A7GeU0f9Q4x
        MnEwHmKU4GBWEuFlu2uUIMSbklhZlVqUH19UmpNafIhRmoNFSZw3cJtJgpBAemJJanZqakFq
        EUyWiYNTqoHJXFRDif1i4tHvc7mr7789f2Eaw6X8xU/eKFn3L47UY2TOl747XcvjwN0rh3uu
        P9c8tVvTn+Ne259P27/wlnCVXTc+unfui/qVgXYbzh87GhlsP/OpFr+tUR/L3ChptWtPgj2/
        K0QFN/958OPfwy/aAoJhL9eYHjvYq/itKmX+qmfc24TPX/621LHB0HVvUG5ukvWSi4bRVyxM
        /s5YcZltX4B16ln/UyYPrj50qf+fGV4foubRn+9WeFJ944qabdV/PleqVN2c/Lpqkc17g9aa
        OZXibnYqXvsnfdrnkm2xoEz8XumWqTn2YjGe4t4/6ty5mScfm9h9pHHOIa+T/Z8ay76oRTD8
        NNasSTF3OiegxFKckWioxVxUnAgARQPFMwEDAAA=
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 23 Feb 2021 16:12:43 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> > What I think is qemu has not an easy to get the MCE signature from host or currently no methods for this
> > So qemu treat all AR will be No RIPV, Do more is better than do less.  
> 
> RIPV would be important in the guest in the case where the guest can fix the problem that caused
> the machine check and return to the failed instruction to continue.
> 
> I think the only case where this happens is a fault in a read-only page mapped from a file (typically
> code page, but could be a data page). In this case memory-failure() unmaps the page with the posion
> but Linux can recover by reading data from the file into a new page.
> 
> Other cases we send SIGBUS (so go to the signal handler instead of to the faulting instruction).
> 
> So it would be good if the state of RIPV could be added to the signal state sent to qemu. If that
> isn't possible, then this full recovery case turns into another SIGBUS case.

This KVM and VM case of failing recovery for SRAR is just one scenario I think,
If Intel guarantee that when memory SRAR is triggered, RIPV will always be set, then it's the job of qemu to
set the RIPV instead.
Or if When SRAR is triggered with RIPV cleared, the same issue will be true for host.

And I think it's better for VM to know the real RIPV value, It need more work in qemu and kernel if possible.

Thanks
Aili Yao
