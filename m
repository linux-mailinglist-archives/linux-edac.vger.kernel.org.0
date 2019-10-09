Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD99D0CD6
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2019 12:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfJIKay (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Oct 2019 06:30:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50658 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfJIKay (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 9 Oct 2019 06:30:54 -0400
Received: from zn.tnic (p200300EC2F0C2000748A0C0E5F7566F5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2000:748a:c0e:5f75:66f5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC0051EC0B4D;
        Wed,  9 Oct 2019 12:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570617048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9QzIbZs72YPsTIo4Vd0pO6gwDsewGwA3j8c4/32IiKs=;
        b=Jb5jjtqgHsw4Yf4V71tBCl25o/Kih41BX7zEjGnub7jkWhrqAiWX2AF6UU9jy4T48p/LBs
        KNImIGOt/Sk0KqclzRJs2aVJasb9yTR+13LQI3kZ3/2hDTK6gYQCWtpfAPSxeYhUfEP/73
        J9fdwG5/8QCSfodupcsxPzaA2qiuGWs=
Date:   Wed, 9 Oct 2019 12:30:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jeff God <jfgaudreault@gmail.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
Message-ID: <20191009103041.GC10395@zn.tnic>
References: <CAEVokG7TeAbmkhaxiTpsxhv1pQzqRpU=mR8gVjixb5kXo3s2Eg@mail.gmail.com>
 <20190924092644.GC19317@zn.tnic>
 <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
 <20191007071502.GA24289@zn.tnic>
 <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
 <20191008115041.GD14765@zn.tnic>
 <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
 <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 08, 2019 at 07:08:20PM -0400, Jeff God wrote:
> I also wanted to apologise for the text emails line wrapping, I
> haven't found a viable email client alternative...

https://www.kernel.org/doc/html/latest/process/email-clients.html

> I did not see anything in dmesg, and all status files remained 0
> (except flag which was hw)

Nothing here either but my machine is

vendor_id       : AuthenticAMD
cpu family      : 23
model           : 1
model name      : AMD EPYC 7251 8-Core Processor
stepping        : 2

so I'm guessing it needs something else for injection to work on those
models...

> The memory controller banks are 17 (channel 0) and 18 (channel 1) on Family
> 17h Model 7Xh, and these are managed by CPU 0.

Btw, Yazen, we probably need to have an easy way to find out
how the bank mapping is now on SMCA machine when wanting to do
injection. I know we talked about having some of that info in
/sys/devices/system/machinecheck/machinecheckX...

> And even this:
> [  609.681714] mce: [Hardware Error]: Machine check events logged
> [  609.681716] [Hardware Error]: Corrected error, no action required.
> [  609.681720] [Hardware Error]: CPU:0 (17:71:0)
> MC17_STATUS[-|CE|MiscV|AddrV|-|SyndV|CECC|-|-|Scrub]:
> 0x9c2041000000011b
> [  609.681723] [Hardware Error]: Error Addr: 0x000000006d3d483b
> [  609.681724] [Hardware Error]: IPID: 0x0000000000000000, Syndrome:
> 0x0000000000000000
> [  609.681726] [Hardware Error]: Unified Memory Controller Ext. Error
> Code: 0, DRAM ECC error.
> [  609.681743] ------------[ cut here ]------------
> [  609.681748] WARNING: CPU: 4 PID: 2447 at
> drivers/edac/edac_mc.c:1238 edac_mc_handle_error+0x5a6/0x6d0

You can ignore that for now. That's a sanity-check for a driver supplying a 0
for grain.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
