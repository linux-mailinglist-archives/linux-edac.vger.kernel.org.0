Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63719325BCD
	for <lists+linux-edac@lfdr.de>; Fri, 26 Feb 2021 04:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBZDAD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Feb 2021 22:00:03 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:45527 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229508AbhBZDAA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Feb 2021 22:00:00 -0500
X-AuditID: 0a580157-f39ff7000005df43-98-60385db523a9
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 0D.82.57155.5BD58306; Fri, 26 Feb 2021 10:32:21 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 26 Feb
 2021 10:59:15 +0800
Date:   Fri, 26 Feb 2021 10:59:15 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, "Luck, Tony" <tony.luck@intel.com>
CC:     Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210226105915.6cf7d2b8@alex-virtual-machine>
In-Reply-To: <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
References: <20210224151619.67c29731@alex-virtual-machine>
        <20210224103105.GA16368@linux>
        <20210225114329.4e1a41c6@alex-virtual-machine>
        <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
        <20210225113930.GA7227@localhost.localdomain>
        <20210225123806.GA15006@hori.linux.bs1.fc.nec.co.jp>
        <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com>
        <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsXCFcGooLs11iLBYH+/scWc9WvYLD5v+Mdm
        8XX9L2aLaRvFLS6camCyuLxrDpvFvTX/WS0uHVjAZHGx8QCjxZlpRRabN01ltnhz4R6LxY8N
        j1kdeD2+t/axeCze85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83
        yXmcaPnCGsAdxWWTkpqTWZZapG+XwJUx/8ls5oJP7BVzjv5mbGCcw9bFyMkhIWAi0fK8jbmL
        kYtDSGA6k8ThN19YIJxXjBLLtp4Dq2IRUJVYseYaO4jNBmTvujeLFaRIRKCNUWL9mvNsIA6z
        wEIWiU8LdjGBVAkLeEl8ub+WEcTmFbCSuHajGaibg4NTwFHizOVckLCQwFxmiTVLlEFsfgEx
        id4r/5kgTrKXaNuyCKpVUOLkzCcsIDazgI7EiVXHmCFseYntb+cwQ8xRlDi85Bc7RK+SxJHu
        GVCvxUosm/eKdQKj8Cwko2YhGTULyagFjMyrGFmKc9MNNzFCIjB8B+O8po96hxiZOBgPMUpw
        MCuJ8G7+Z5ogxJuSWFmVWpQfX1Sak1p8iFGag0VJnFeKzTxBSCA9sSQ1OzW1ILUIJsvEwSnV
        wMQVLhhwqkt/TYjYp46XupYaUouKgtpZ7nP0cLfa7pqnrpmT3mIYX/SjjnlyQRrTiupvZ6M5
        EkR36W3UCltbzNF2aoKD7mKdNAlRE7eSf62+PCFlx+ou3Ti8gHPeR+lzH9yP7r5TlCqknu1x
        1Wf1xJN9ux491/UWF2fi7pDWllFWj568bqt1aa1W59XUFqUrmdq7F5VZdri4Ht2pk5Ddm77/
        m2vUpjmllnybpc07bZaWHzf8/XuvreTKEqPNgvUHRGeYys1VuskiHRiwiXFj0g8dtUvftnYL
        JydrlgndY7fntbrz5PsalnM3zkvLazjnHz27Pru8W/XA5hdTH01VeaLRvF6T8Xxr0pTM3ypK
        LMUZiYZazEXFiQBuLmVkLwMAAA==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi naoya, tony:
> > 
> > Idea for what we should do next ... Now that x86 is calling memory_failure()
> > from user context ... maybe parallel calls for the same page should
> > be blocked until the first caller completes so we can:
> > a) know that pages are unmapped (if that happens)
> > b) all get the same success/fail status  
> 
> One memory_failure() call changes the target page's status and
> affects all mappings to all affected processes, so I think that
> (ideally) we don't have to block other threads (letting them
> early return seems fine).  Sometimes memory_failure() fails,
> but even in such case, PG_hwpoison is set on the page and other
> threads properly get SIGBUSs with this patch, so I think that
> we can avoid the worst scenario (like system stall by MCE loop).
> 
I agree with naoya's point, if we block for this issue, Does this change the result
that the process should be killed? Or is there something other still need to be considered?

Thanks!
Aili Yao  
