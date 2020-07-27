Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96C22EC8B
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgG0Mtn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 08:49:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44583 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbgG0Mtn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 08:49:43 -0400
Received: from [IPv6:2601:646:8600:3281:d01e:b6c6:1a24:9007] ([IPv6:2601:646:8600:3281:d01e:b6c6:1a24:9007])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 06RCnamc2000926
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 27 Jul 2020 05:49:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 06RCnamc2000926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020072401; t=1595854177;
        bh=vqJmEWTLIAFzkX9WqOPjctwd6uSnDgeS6aq26YK3uHw=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=DHZId3PfHW7adFBQlkx07EAPJj0i99u0/lZgeMGbEOQOLOY2y3eUG24zclNKQ49N6
         U6Q9We1ne+4bqiyKC2QCK4Cd9dOiiJJCaOYK6vZYns/h494qbqiN/VPuk/4dkGRMUe
         riQwxOMPJR4A9Ch/aQTRIvQ3IpZwdNLjp3+7X+tUF8Ehve92rkIxiorzOTnaArikqw
         MpDE0clQIJMsU9nZXXCJyGr6VeEzkG86jubXjeOpNgov1KxfyMah/qcGOn50CNUA7S
         J/Aq0iiNVowx68QPx+9eqQIpBH4/VbHKyeMaQFs/Kq8YTYpwFvaGlXvrI07p49GWt6
         bLYufSNj/qGnQ==
Date:   Mon, 27 Jul 2020 05:49:28 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20200727083619.GF119549@hirez.programming.kicks-ass.net>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com> <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com> <D51F2DC3-3C56-44E6-A1F2-434E7D27133C@zytor.com> <20200727083619.GF119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
To:     peterz@infradead.org
CC:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <49251CFA-8AC3-462D-A60F-0337593BE9CD@zytor.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On July 27, 2020 1:36:19 AM PDT, peterz@infradead=2Eorg wrote:
>On Sun, Jul 26, 2020 at 10:55:15PM -0700, hpa@zytor=2Ecom wrote:
>> For a really overenginered solution, but which might perform
>> unnecessary poorly on existing hardware:
>>=20
>> asm volatile("1: =2Ebyte 0xf, 0x1, 0xe8; 2:"
>>                         _ASM_EXTABLE(1b,2b));
>
>Ha! cute, you take an #UD ?
>
>We could optimize the #UD exception handler for this I suppose, but
>that
>makes it an even worse hack=2E The simple alternative() seems like a much
>simpler approach=2E

If this is in any way performance critical, then no :) Taking the #UD has =
the cute property that we end up IRET on the way back, so we don't even nee=
d a fix-up path=2E


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
