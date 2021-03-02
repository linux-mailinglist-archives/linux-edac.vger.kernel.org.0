Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF0432B175
	for <lists+linux-edac@lfdr.de>; Wed,  3 Mar 2021 04:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhCCBu1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Mar 2021 20:50:27 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:45931 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1576816AbhCBEcy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Mar 2021 23:32:54 -0500
X-AuditID: 0a580157-f39ff7000005df43-4d-603db95d708e
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 50.37.57155.D59BD306; Tue,  2 Mar 2021 12:04:45 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 2 Mar 2021
 12:32:07 +0800
Date:   Tue, 2 Mar 2021 12:32:07 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Oscar Salvador <osalvador@suse.de>,
        "HORIGUCHI =?UTF-8?B?TkFPWUE=?=( =?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, "david@redhat.com" <david@redhat.com>,
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
Message-ID: <20210302123207.0217e5c4@alex-virtual-machine>
In-Reply-To: <20210226175837.GA184397@agluck-desk2.amr.corp.intel.com>
References: <20210224151619.67c29731@alex-virtual-machine>
        <20210224103105.GA16368@linux>
        <20210225114329.4e1a41c6@alex-virtual-machine>
        <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
        <20210225113930.GA7227@localhost.localdomain>
        <20210226105250.3a15e35c@alex-virtual-machine>
        <20210226175837.GA184397@agluck-desk2.amr.corp.intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXCFcGooBu70zbBYF67gMWc9WvYLD5v+Mdm
        8XX9L2aLaRvFLS6camCyuLxrDpvFvTX/WS0uHVjAZHGx8QCjxZlpRRabN01ltnhz4R6LxY8N
        j1kdeD2+t/axeCze85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83
        yXmcaPnCGsAdxWWTkpqTWZZapG+XwJXxd9EVtoI93BX7Pps3MH7i6GLk5JAQMJF4PmElcxcj
        F4eQwHQmiZ5b75lBEkICLxkllm8oBLFZBFQk9nUtZwex2QRUJXbdm8UKYosIqElcWvwArJlZ
        YA6rxNeZ85lAEsICXhJf7q9lBLF5BawkVkx5B2ZzCrhJnN71kR1i2wMmiV3HZ4Nt4xcQk+i9
        8p8J4iR7ibYti6CaBSVOznzCAmIzC+hInFh1jBnClpfY/nYO1KWKEoeX/GKH6FWSONI9gw3C
        jpVYNu8V6wRG4VlIRs1CMmoWklELGJlXMbIU56YbbmKExF/4DsZ5TR/1DjEycTAeYpTgYFYS
        4T352TJBiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+wi02CkEB6YklqdmpqQWoRTJaJg1OqgWn7
        LKVHvm81N8i2/b3hO9VHdcaT1MuaXwoMp1z1spd5c8nzWCOHqMRR+8X3nObyqPcJHzfN+7iG
        UchHe+WMgwuS8n7xJ0k9zrpwb0r/ygoXrxWr2T5d0vLO+H33dkTAl/XFhyy1Mq7Jfq4+oFG6
        cUqeNpeXfEtiOnOq/5Ubff6cVWK/43aIR9p5+Sqs3vyHq/d9tV1UwRKPuYu3l8pOWZSp072z
        +rlZxHrXHN+Hj2sll8Ul3L+zmbs38kXvrvSenc/2NNS8kb2bsrH8hqACy+qsV2+uCKz5X3o/
        VzQu+Mi+7iPOJ5c8XROjl+DWKdFzQdl7wfy5wkWvVeY0/nRqc3A7YtXemlbOcGcO6xPFMCWW
        4oxEQy3mouJEAGhR4eguAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 26 Feb 2021 09:58:37 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> On Fri, Feb 26, 2021 at 10:52:50AM +0800, Aili Yao wrote:
> > Hi naoya,Oscar,david:  
> > >   
> > > > We could use some negative value (error code) to report the reported case,
> > > > then as you mentioned above, some callers need change to handle the
> > > > new case, and the same is true if you use some positive value.
> > > > My preference is -EHWPOISON, but other options are fine if justified well.    
> > > 
> > > -EHWPOISON seems like a good fit.
> > >   
> > I am OK with the -EHWPOISON error code, But I have one doubt here:
> > When we return this -EHWPOISON error code, Does this means we have to add a new error code
> > to error-base.h or errno.h? Is this easy realized?  
> 
> The page already poisoned isn't really an error though. Just the result
> of a race condition.  What if we added an extra argument to memory_failure()
> so it can tell the caller that the specific reason for the early successful
> return is that the page was already poisoned?
> 

It may be not an error, Is it reasonable to return a positive value like MF_HWPOISON, it seems the 0
return code donesn't tell the whole story. 

Your patch seems more safer, But I don't know if it's worth such multi module modifications for this case.
It really should be referenced to other maintainers and reviewers and thet can give more expert suggestions.

Thanks!
Aili Yao
