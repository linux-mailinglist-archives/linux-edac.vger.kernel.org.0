Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7903F32C667
	for <lists+linux-edac@lfdr.de>; Thu,  4 Mar 2021 02:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355467AbhCDA2p (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 Mar 2021 19:28:45 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:46049 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1843057AbhCCKZH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 3 Mar 2021 05:25:07 -0500
X-AuditID: 0a580157-f39ff7000005df43-14-603f44bd783d
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id B2.CB.57155.DB44F306; Wed,  3 Mar 2021 16:11:41 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Mar 2021
 16:39:12 +0800
Date:   Wed, 3 Mar 2021 16:39:12 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
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
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210303163912.3d508e0f@alex-virtual-machine>
In-Reply-To: <20210303115710.2e9f8e23@alex-virtual-machine>
References: <20210224151619.67c29731@alex-virtual-machine>
        <20210224103105.GA16368@linux>
        <20210225114329.4e1a41c6@alex-virtual-machine>
        <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
        <20210225113930.GA7227@localhost.localdomain>
        <20210225123806.GA15006@hori.linux.bs1.fc.nec.co.jp>
        <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com>
        <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
        <20210226105915.6cf7d2b8@alex-virtual-machine>
        <20210303033953.GA205389@agluck-desk2.amr.corp.intel.com>
        <20210303115710.2e9f8e23@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXCFcGooLvXxT7BYHaLkcWc9WvYLD5v+Mdm
        8XX9L2aLaRvFLS6camCyuLxrDpvFvTX/WS0uHVjAZHGx8QCjxZlpRRabN01ltnhz4R6LxY8N
        j1kdeD2+t/axeCze85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83
        yXmcaPnCGsAdxWWTkpqTWZZapG+XwJXxvHMte8Et8YojX34wNjCuFupi5OSQEDCReDplFmMX
        IxeHkMB0Jokl0zcxgiSEBF4ySmzf5g1iswioSFyZ+5ANxGYTUJXYdW8WK4gtIqAmcWnxA2aQ
        ZmaB2awSpyafZQZJCAt4SXy5vxZsEK+AlcSDN91MXYwcHJwC1hLTDvpAzN/NInG7tQbE5hcQ
        k+i98p8J4iB7ibYti6BaBSVOznzCAmIzC+hInFh1jBnClpfY/nYOM8QcRYnDS36xQ/QqSRzp
        nsEGYcdKLJv3inUCo/AsJKNmIRk1C8moBYzMqxhZinPTDTcxQqIvfAfjvKaPeocYmTgYDzFK
        cDArifCKv7RNEOJNSaysSi3Kjy8qzUktPsQozcGiJM7b4mSfICSQnliSmp2aWpBaBJNl4uCU
        amBqfTJD8vP2G72bu4LDN6fcK1y8O3rm3OTzvDd22qX+4J78QuEQ8664Jy9uLnv9yn7D46LA
        nbN4NaXiA05veBWW1jq7Wu2DBkcH14LV0tfY3gXoNj+uD+Di3D6nuofzBE/S5RbzNa7b7si9
        fP3Nx+pFSO5dKYeu+umBL/d+PCh5cItOPFvdl997BcK+Pk+x/bDT4q+S9Lrtu2O26fvvfr92
        u61YN0PPRq5rUsqTDtvJTbR4rpa16M1+sc27vfZ/OMnP/utq8J/2bVu/BbdFxU6a5TObRSjq
        kY49x4cw3hlxIZOlSza90Jwad9agfsfkUwt9SuZNXVg5T2v7IY53j22rdv3a//t9ot6P5hsZ
        0pXn85VYijMSDbWYi4oTAQ4ONl0tAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi tony:

> On Tue, 2 Mar 2021 19:39:53 -0800
> "Luck, Tony" <tony.luck@intel.com> wrote:
> 
> > On Fri, Feb 26, 2021 at 10:59:15AM +0800, Aili Yao wrote:  
> > > Hi naoya, tony:    
> > > > > 
> > > > > Idea for what we should do next ... Now that x86 is calling memory_failure()
> > > > > from user context ... maybe parallel calls for the same page should
> > > > > be blocked until the first caller completes so we can:
> > > > > a) know that pages are unmapped (if that happens)
> > > > > b) all get the same success/fail status      
> > > > 
> > > > One memory_failure() call changes the target page's status and
> > > > affects all mappings to all affected processes, so I think that
> > > > (ideally) we don't have to block other threads (letting them
> > > > early return seems fine).  Sometimes memory_failure() fails,
> > > > but even in such case, PG_hwpoison is set on the page and other
> > > > threads properly get SIGBUSs with this patch, so I think that
> > > > we can avoid the worst scenario (like system stall by MCE loop).
> > > >     
> > > I agree with naoya's point, if we block for this issue, Does this change the result
> > > that the process should be killed? Or is there something other still need to be considered?    
> > 
> > Ok ... no blocking ... 

I do think about blocking method and the error address issue with sigbus,here is my opinion, maybe helpful:

For blocking, if we block here, there are some undefine work i think should be done.
As we don't know the process B triggering this error again is early-kill or not, so the previous memory_failure() call may 
not add B on kill_list, even if B is on kill_list, the error level for B is not proper set, as B should get an AR SIGBUS;

So we can't just wait, We must have some logic adding the process B to kill list, and as this is an AR error
another change should be done to current code, we need more logic in kill_proc or some other place.

Even if all the work is done right. There is one more serious scenario though, we even don't know the current step the previous memory_failure() is on,
So previous modification may not be usefull at all; When this scenario happens, what we can do?  block or return ?
if finally we return, an error code should be taken back; so we have to go to error process logic and a signal without right address will be sent;

For error address with sigbus, i think this is not an issue resulted by the patch i post, before my patch, the issue is already there.
I don't find a realizable way to get the correct address for same reason --- we don't know whether the page mapping is there or not when
we got to kill_me_maybe(), in some case, we may get it, but there are a lot of parallel issue need to consider, and if failed we have to fallback
to the error brach again, remaining current code may be an easy option;

Any methods or patchs can solve the issue in a better way is OK to me, i want this issue fixed and in more complete way!

-- 
Thanks!
Aili Yao
