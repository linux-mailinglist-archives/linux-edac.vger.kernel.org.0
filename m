Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5D83336DA
	for <lists+linux-edac@lfdr.de>; Wed, 10 Mar 2021 09:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhCJIBj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 10 Mar 2021 03:01:39 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:47226 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229828AbhCJIBL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Mar 2021 03:01:11 -0500
X-AuditID: 0a580155-20dff7000005482e-38-604875472f08
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 9E.D3.18478.74578406; Wed, 10 Mar 2021 15:29:11 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 10 Mar
 2021 16:01:08 +0800
Date:   Wed, 10 Mar 2021 16:01:07 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>, <sunhao2@kingsoft.com>
Subject: Re: [PATCH v2] mm,hwpoison: return -EBUSY when page already
 poisoned
Message-ID: <20210310160107.7383a6f4@alex-virtual-machine>
In-Reply-To: <20210309082824.GA1793@hori.linux.bs1.fc.nec.co.jp>
References: <20210305093016.40c87375@alex-virtual-machine>
        <20210305093656.6c262b19@alex-virtual-machine>
        <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
        <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
        <3690ece2101d428fb9067fcd2a423ff8@intel.com>
        <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
        <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
        <20210309100421.3d09b6b1@alex-virtual-machine>
        <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
        <20210309143534.6c1a8ec5@alex-virtual-machine>
        <20210309082824.GA1793@hori.linux.bs1.fc.nec.co.jp>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCFcGooOte6pFgMP0dm8Wc9WvYLD5v+Mdm
        8XX9L2aLaRvFLS6camCyuLxrDpvFvTX/WS0uHVjAZHGx8QCjxZlpRRabN01ltnhz4R6LxY8N
        j1kdeD2+t/axeCze85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83
        yXmcaPnCGsAdxWWTkpqTWZZapG+XwJWxc887xoLFohVXnx9ga2DcJ9DFyMkhIWAiseDrHaYu
        Ri4OIYHpTBJr5x9hgXBeMUq0PV3CDlLFIqAq8fbWDzYQmw3I3nVvFiuILSKQJLF49lewbmaB
        7ywSrcdvgRUJC/hL/HnwF6yIV8BK4vGcSWA2p4CDxI2rjawQG86xSEza0c8CkuAXEJPovfKf
        CeIme4m2LYsYIZoFJU7OfAJWwyygKdG6/Tc7hK0tsWzha2YQW0hAUeLwkl/sEL1KEke6Z7BB
        2LESy+a9Yp3AKDwLyahZSEbNQjJqASPzKkaW4tx0o02MkBgM3cE4o+mj3iFGJg7GQ4wSHMxK
        Irx+x90ShHhTEiurUovy44tKc1KLDzFKc7AoifPuPeaaICSQnliSmp2aWpBaBJNl4uCUamA6
        V1qseLlQpFaeafafTs5mCcUk9TPB+TLbPlVe8Au9ZvnGasPOu0KrY3kYa/7JqZobzm21VfF4
        u07g9lR9z2P80ldOJUkarVF8Fv8iVMkqah/fo1b2q7saVnh+EpVpnbDpWUwW/0X/fdK3V3ex
        vb7TvSlE7FrhFOlD+szVZslFPW2sGw8vLzM7s2NCxKvKSN5mMaOneZrrZDxlvoZd9Io4r2DS
        rLmEf3n1mv+Klw3FpyT255iX8XVw77JqWfH50Erua+l6ru9nexzVsvus7yEga8t2/kH3T/fH
        XJtS5Jao9Kr7PJ0euZrfsvvAdUXXw+3/tjCuv2lx6IX0PZWN/JnnXr727Xu77uHFpRYiB5VY
        ijMSDbWYi4oTAfVKR04wAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 9 Mar 2021 08:28:24 +0000
HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> On Tue, Mar 09, 2021 at 02:35:34PM +0800, Aili Yao wrote:
> > When the page is already poisoned, another memory_failure() call in the
> > same page now return 0, meaning OK. For nested memory mce handling, this
> > behavior may lead to mce looping, Example:
> > 
> > 1.When LCME is enabled, and there are two processes A && B running on
> > different core X && Y separately, which will access one same page, then
> > the page corrupted when process A access it, a MCE will be rasied to
> > core X and the error process is just underway.
> > 
> > 2.Then B access the page and trigger another MCE to core Y, it will also
> > do error process, it will see TestSetPageHWPoison be true, and 0 is
> > returned.
> > 
> > 3.The kill_me_maybe will check the return:
> > 
> > 1244 static void kill_me_maybe(struct callback_head *cb)
> > 1245 {
> > 
> > 1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> > 1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> > 1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,
> > p->mce_whole_page);
> > 1257                 sync_core();
> > 1258                 return;
> > 1259         }
> > 
> > 1267 }
> > 
> > 4. The error process for B will end, and may nothing happened if
> > kill-early is not set, The process B will re-excute instruction and get
> > into mce again and then loop happens. And also the set_mce_nospec()
> > here is not proper, may refer to commit fd0e786d9d09 ("x86/mm,
> > mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages").
> > 
> > For other cases which care the return value of memory_failure() should
> > check why they want to process a memory error which have already been
> > processed. This behavior seems reasonable.  
> 
> Other reviewers shared ideas about the returned value, but actually
> I'm not sure which the best one is (EBUSY is not that bad).
> What we need to fix the reported issue is to return non-zero value
> for "already poisoned" case (the value itself is not so important). 
> 
> Other callers of memory_failure() (mostly test programs) could see
> the change of return value, but they can already see EBUSY now and
> anyway they should check dmesg for more detail about why failed,
> so the impact of the change is not so big.
> 
> > 
> > Signed-off-by: Aili Yao <yaoaili@kingsoft.com>  
> 
> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Thanks,
> Naoya Horiguchi

Thanks!

And I found my mail was lost in mailist!

-- 
Thanks!
Aili Yao
