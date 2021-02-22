Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3521C32162D
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 13:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBVMTI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 07:19:08 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:45010 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230195AbhBVMSU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 07:18:20 -0500
X-AuditID: 0a580157-f39ff7000005df43-c8-60339aa058a0
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id FB.89.57155.0AA93306; Mon, 22 Feb 2021 19:50:56 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 22 Feb
 2021 20:17:24 +0800
Date:   Mon, 22 Feb 2021 20:17:23 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <tony.luck@intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210222201723.0fcec589@alex-virtual-machine>
In-Reply-To: <20210222192146.76ffec84@alex-virtual-machine>
References: <20210222113124.35f2d552@alex-virtual-machine>
        <20210222115007.75b7de9b@alex-virtual-machine>
        <20210222092403.GA29063@zn.tnic>
        <20210222173109.7b7ac42a@alex-virtual-machine>
        <20210222100356.GB29063@zn.tnic>
        <20210222180819.3998fe33@alex-virtual-machine>
        <20210222102206.GC29063@zn.tnic>
        <20210222192146.76ffec84@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsXCFcGooLtglnGCwbJbwhafN/xjs5i2Udzi
        wqkGJovLu+awWVw6sIDJYvOmqcwWby7cY7H4seExqwOHx/fWPhaPxXteMnlsWtXJ5vHu3Dl2
        j/f7rrJ5fN4k53Gi5QtrAHsUl01Kak5mWWqRvl0CV8bqXR/YCp7xVVw5IdHA+Ji7i5GTQ0LA
        ROJe82vmLkYuDiGB6UwSZ7atYIdwXjFK9GyfytjFyMHBIqAq8XIDWAMbkLnr3ixWEFtEQEni
        66K5TCD1zAKHGCUOn3vBDFIvLBAqsWRaIUgNr4CVxJoFLSwgNqeAtcTGX/9YIOY/Z5JY//4/
        O0iCX0BMovfKfyaIi+wl2rYsYoRoFpQ4OfMJWDOzgI7EiVXHmCFseYntb+eA2UICihKHl/xi
        h+hVkjjSPYMNwo6VWDbvFesERuFZSEbNQjJqFpJRCxiZVzGyFOemG25ihMRJ+A7GeU0f9Q4x
        MnEwAv3Gwawkwst21yhBiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+YI1+CkEB6YklqdmpqQWoR
        TJaJg1OqganzwKIQ167F25mPl2rtUMw13luzULPnAB9vsuoJYR7tyYWn3X8f1+Yu7GfmZzl2
        9DZvYeIVP8YSu0ktXl9urpfeG3vj3wrb5bez54TP/Pq7tVJwvYpXdcjToKJ+8XMMbjd9jrA+
        4WoRn8jp+HfOXueJ+w+paiR/yqs4EHfmyI/fm7x/HBW6PFs55v+l2fwbjilGbomaurfi2vIp
        s/8bXvz9L704X6dHwaXBJo5pq8XFfhXmwtyNRjtYnNUzVHIezrTwfRJav/3MtsVHZ7c9Tgza
        8yfKn8GIfbVzwfn9l+02KU9zr+FrVwxLX3l2lrLHhHU815cFVQW5rrjB2yCu6MY6Y02wKMOp
        JrHz4t0JzEosxRmJhlrMRcWJAKO1awkCAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 22 Feb 2021 19:21:46 +0800
Aili Yao <yaoaili@kingsoft.com> wrote:

> On Mon, 22 Feb 2021 11:22:06 +0100
> Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Mon, Feb 22, 2021 at 06:08:19PM +0800, Aili Yao wrote:  
> > > So why would intel provide this MCG_STATUS_RIPV flag, it's better to
> > > remove it as it will never be set, and all the related logic for this
> > > flag is really needed ?    
> > 
> > Why would it never be set - of course it will be. You don't set it. If
> > you wanna inject errors, then make sure you inject *valid* errors which
> > the hardware *actually* generates, not some random ones.
> >   
> 
> As far as I know, Most of RAS related tests are faked, not real errors, and it's really meaningful.
> 
> You should better reproduce the issue I tried to fix, or at least read the code more detailly and you will
> know if it's random and invalid
> 
I See this in sdm 325462:

AR (Action Required) flag, bit 55 - Indicates (when set) that MCA error code specific recovery action must be
performed by system software at the time this error was signaled. This recovery action must be completed
successfully before any additional work is scheduled for this processor. 
-------------------
When the RIPV flag in the IA32_MCG_STATUS is clear, an alternative execution stream needs to be provided; 
------------------
when the MCA error code
specific recovery specific recovery action cannot be successfully completed, system software must shut down
the system. When the AR flag in the IA32_MCi_STATUS register is clear, system software may still take MCA
error code specific recovery action but this is optional; system software can safely resume program execution
at the instruction pointer saved on the stack from the machine check exception when the RIPV flag in the
IA32_MCG_STATUS register is set.

Best Regards!
Aili Yao

