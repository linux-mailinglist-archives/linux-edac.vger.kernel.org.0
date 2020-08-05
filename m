Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08C723C4ED
	for <lists+linux-edac@lfdr.de>; Wed,  5 Aug 2020 07:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgHEFMw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Aug 2020 01:12:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53135 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgHEFMw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 Aug 2020 01:12:52 -0400
Received: from [IPv6:2601:646:8600:3281:4d47:1bf:1c0:ca78] ([IPv6:2601:646:8600:3281:4d47:1bf:1c0:ca78])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 0755AV731344388
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 4 Aug 2020 22:10:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 0755AV731344388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020072401; t=1596604231;
        bh=9mqOS6RNAraQiHKEtxREY8I8rwz6Kyg/eHWTnjLyUwE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=FG2VCEsKz9kEVGxIgEwB1tK2lmtTvgeODXqDe9q3HM8LRX2bu5TGi6UoMSvXSorTu
         5ZGXx3usLhVO/VlSx7mAP1wj3ttXL4MO358JAyc7iuyk375HFxqYlOkuF9h6w6LEbb
         HMzYCsCr+iqVRrtapBxil0xbkK7ItXV/W6krqNheu7zV94fooKhJT63wPuOUipO85C
         umTQ22XzKp9hyt0hMwJ9RTEJGr61r7hQtw/z1HpmwEt79oqptvUadw9uT4XMXJ0mRJ
         8HL4DeMFmXf24o4UTjuVYVtcEh8JgocQ2Dx5oAjLDIk3JE0xVScDKO02yOQtSfiHtY
         q23EWnv9PVziA==
Date:   Tue, 04 Aug 2020 22:10:22 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20200805050808.GC9127@nazgul.tnic>
References: <20200805021059.1331-1-ricardo.neri-calderon@linux.intel.com> <20200805044840.GA9127@nazgul.tnic> <47A60E6A-0742-45FB-B707-175E87C58184@zytor.com> <20200805050808.GC9127@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] x86/cpu: Use SERIALIZE in sync_core() when available
To:     Borislav Petkov <bp@alien8.de>
CC:     Borislav Petkov <bp@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Message-ID: <2511352F-5D28-4337-A4A2-1B54073F1F72@zytor.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On August 4, 2020 10:08:08 PM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Tue, Aug 04, 2020 at 09:58:25PM -0700, hpa@zytor=2Ecom wrote:
>> Because why use an alternative to jump over one instruction?
>>
>> I personally would prefer to have the IRET put out of line
>
>Can't yet - SERIALIZE CPUs are a minority at the moment=2E
>
>> and have the call/jmp replaced by SERIALIZE inline=2E
>
>Well, we could do:
>
>	alternative_io("=2E=2E=2E IRET bunch", __ASM_SERIALIZE,
>X86_FEATURE_SERIALIZE, =2E=2E=2E);
>
>and avoid all kinds of jumping=2E Alternatives get padded so there
>would be a couple of NOPs following when SERIALIZE gets patched in
>but it shouldn't be a problem=2E I guess one needs to look at what gcc
>generates=2E=2E=2E

I didn't say behind a trap=2E IRET is a control transfer instruction, and =
slow, so putting it out of line really isn't unreasonable=2E Can even do a =
call to a common handler=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
