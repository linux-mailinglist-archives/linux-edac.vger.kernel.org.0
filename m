Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1746F3216D5
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 13:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhBVMhN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 07:37:13 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:45014 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230174AbhBVMgi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 07:36:38 -0500
X-AuditID: 0a580157-f39ff7000005df43-fb-60339ef12a50
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id F2.B9.57155.1FE93306; Mon, 22 Feb 2021 20:09:21 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 22 Feb
 2021 20:35:50 +0800
Date:   Mon, 22 Feb 2021 20:35:49 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <tony.luck@intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210222203549.0e54c26f@alex-virtual-machine>
In-Reply-To: <20210222122241.GA10880@zn.tnic>
References: <20210222113124.35f2d552@alex-virtual-machine>
        <20210222115007.75b7de9b@alex-virtual-machine>
        <20210222092403.GA29063@zn.tnic>
        <20210222173109.7b7ac42a@alex-virtual-machine>
        <20210222100356.GB29063@zn.tnic>
        <20210222180819.3998fe33@alex-virtual-machine>
        <20210222102206.GC29063@zn.tnic>
        <20210222192146.76ffec84@alex-virtual-machine>
        <20210222201723.0fcec589@alex-virtual-machine>
        <20210222122241.GA10880@zn.tnic>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXCFcGooPtxnnGCwcV/1hafN/xjs5i2Udzi
        wqkGJovLu+awWVw6sIDJYvOmqcwWby7cY7H4seExqwOHx/fWPhaPxXteMnlsWtXJ5vHu3Dl2
        j/f7rrJ5fN4k53Gi5QtrAHsUl01Kak5mWWqRvl0CV8bHo49ZCx5xVfy8O5m1gfEoRxcjJ4eE
        gInE6i/rGbsYuTiEBKYzSVzZuIkNwnnFKPHz0jY2kCoWAVWJZZtuMYPYbED2rnuzWEFsEQEl
        ia+L5jKBNDALHGKUOHzuBVARB4ewQKjEkmmFICavgJXE3PsVIOWcAroSr49NZYGYv5tZouXW
        R7A5/AJiEr1X/jNBXGQv0bZlESOIzSsgKHFy5hMWEJtZQEfixKpjzBC2vMT2t3PAbCEBRYnD
        S36xQ/QqSRzpnsEGYcdKLJv3inUCo/AsJKNmIRk1C8moBYzMqxhZinPTDTcxQiIlfAfjvKaP
        eocYmTgYgV7jYFYS4WW7a5QgxJuSWFmVWpQfX1Sak1p8iFGag0VJnFfMkS9BSCA9sSQ1OzW1
        ILUIJsvEwSnVwMQ0b9IagU1WX++0vVJzK/y7lXGHo4TwIrENE/3s03NrcurcmPY+S9qR8M2G
        a+dvRU//xrVJKhtfzVXZHRrwrSam6n7deY1pTizyZ7/smtpXdWpD6vcbLT8zHP6t7HzkclH+
        /YZe/tUnVPfdiJf7+NRJaKFph6+2k+XSe0++t/XuW6CYtn+91/XYnG13Vn7aMlv8+erL2wwu
        c606Xfekif+r9K8NhUph37tFn6ceMYr9sH7liiZ/74kCf/WX3HC87H58svORoN6rxzWXz2xN
        LNdkvPeD9QpfgCLnxKfPnDJ1132uVAicrhq60EOicFua3hOlcMOySM73HoevmBis2xn+p1R5
        re+uLbfVVW4473+lxFKckWioxVxUnAgAUYvM3wMDAAA=
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 22 Feb 2021 13:22:41 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Feb 22, 2021 at 08:17:23PM +0800, Aili Yao wrote:
> > AR (Action Required) flag, bit 55 - Indicates (when set) that MCA
> > error code specific recovery action must be...  
> 
> Give me the *exact* MCE signature you're injecting please.
> 
> Thx.
> 

Guest VM, the qemu has no way to know the RIPV value, so always get it cleared.

Hardware event. This is not a software error.
MCE 0
CPU 9 BANK 9 TSC 103d511e68c
RIP 33:401270
MISC 8c ADDR 10e91d000
TIME 1613974147 Mon Feb 22 01:09:07 2021
MCG status:EIPV MCIP LMCE
MCi status:
Uncorrected error
Error enabled
MCi_MISC register valid
MCi_ADDR register valid
SRAR
MCA: Data CACHE Level-0 Data-Read Error
STATUS bd80000000000134 MCGSTATUS e
MCGCAP 900010a APICID 9 SOCKETID 9
MICROCODE 1
CPUID Vendor Intel Family 6 Model 85 Step 7

Host:
Hardware event. This is not a software error.
MCE 0
CPU 1 BANK 1 TSC 1ee4f074462
RIP 33:4013a6
MISC 86 ADDR 10ed608000
TIME 1613985132 Mon Feb 22 17:12:12 2021
MCG status:RIPV EIPV MCIP LMCE
MCi status:
Uncorrected error
Error enabled
MCi_MISC register valid
MCi_ADDR register valid
SRAR
MCA: Data CACHE Level-0 Data-Read Error
STATUS bd80000000100134 MCGSTATUS f
MCGCAP f000c14 APICID 2 SOCKETID 0
MICROCODE 5000021
CPUID Vendor Intel Family 6 Model 85
