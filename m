Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB05522EC83
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 14:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgG0Mr5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 08:47:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37343 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbgG0Mr5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 08:47:57 -0400
Received: from [IPv6:2601:646:8600:3281:d01e:b6c6:1a24:9007] ([IPv6:2601:646:8600:3281:d01e:b6c6:1a24:9007])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 06RCld9F2000589
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 27 Jul 2020 05:47:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 06RCld9F2000589
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020072401; t=1595854060;
        bh=b/MbukGZ+eI0XVt9S5a/NGcdwRTF+jS52qb9kmCntAI=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=EYw1AKGLNbVEbStA6TEh9RjsHv6gSZ0zkozm804UOkcjLpklp7JL3KIh0122M+YXT
         FkuAutJ8P1r/87ZdWQQPikfsMhu2aF1gbRmshwLSQ6K+uONYWnPiUCA5WXioQQS7ML
         RDxhpt3D5opU4My56wXdaWqQheqIDWahpyyXxc450ojeyWFtru7FlMhCaC95UVOnqz
         ZV+J3A4zoNLLeqvgCSLdixRoVGrbnuYuyAVubCWxyUSZE5OKZHbzUjHb7LMTgS6nHP
         1UaP7/cXmVWin5WoFdbgFdb2DuZV/9uGKhar9EfwE02iOsmcjuI6H4pAGlZcvg6NJV
         /fGYjgHiHZQ3w==
Date:   Mon, 27 Jul 2020 05:47:32 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20200727082003.GD119549@hirez.programming.kicks-ass.net>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com> <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com> <20200727082003.GD119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
To:     peterz@infradead.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <2A0D15F3-BAF2-47CE-AF5F-DB681793D07D@zytor.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On July 27, 2020 1:20:03 AM PDT, peterz@infradead=2Eorg wrote:
>On Sun, Jul 26, 2020 at 09:31:32PM -0700, Ricardo Neri wrote:
>> +static inline void serialize(void)
>> +{
>> +	asm volatile("=2Ebyte 0xf, 0x1, 0xe8");
>> +}
>
>Can we pretty please have a comment with the binutils version that has
>the mnomic? Such that when we increase the required binutils version we
>can grep for this=2E

It also needs : : : "memory" to be a barrier=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
