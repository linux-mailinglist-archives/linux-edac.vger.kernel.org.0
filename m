Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25FED26C6
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 11:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbfJJJyU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 05:54:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39888 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfJJJyU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 05:54:20 -0400
Received: from zn.tnic (p200300EC2F0A6300C5CFCA1B921AC096.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6300:c5cf:ca1b:921a:c096])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BCEAC1EC0819;
        Thu, 10 Oct 2019 11:54:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570701258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YTwsF8CH9qwv8uBzIXFZmtHBWSs04tgLKHi8GnDgFDk=;
        b=r3CpaSG0o1JNaTT26d5x5bbspY3sj7j0PE/p71Zfdo5ufC16BytLWa0/1lIbF5z9X1V7tc
        io3pgWRH3j29z6aVxTOBGjfLtrtzXZMTrrlzKUnL6VoZg++Rvbrkc3MrDbNmLUGJd9Mje6
        0LqKjDlJVe6f1Q71Q5Kzes9GJaHMcp0=
Date:   Thu, 10 Oct 2019 11:54:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Jeff God <jfgaudreault@gmail.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
Message-ID: <20191010095409.GB7658@zn.tnic>
References: <CAEVokG7TeAbmkhaxiTpsxhv1pQzqRpU=mR8gVjixb5kXo3s2Eg@mail.gmail.com>
 <20190924092644.GC19317@zn.tnic>
 <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
 <20191007071502.GA24289@zn.tnic>
 <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
 <20191008115041.GD14765@zn.tnic>
 <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
 <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
 <20191009103041.GC10395@zn.tnic>
 <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 09, 2019 at 08:31:26PM +0000, Ghannam, Yazen wrote:
> Please let me know if this works or not for you. I'll need to do some more
> debug if it doesn't work.

Yah, that did it, thx:

[  166.317498] mce: Machine check injector initialized
[  171.734222] mce: do_inject: CPU0, toggling...
[  175.808430] mce: [Hardware Error]: Machine check events logged
[  175.808612] [Hardware Error]: Corrected error, no action required.
[  175.808708] [Hardware Error]: CPU:0 (17:1:2) MC18_STATUS[-|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]: 0x9c2040000000011b
[  175.808831] [Hardware Error]: Error Addr: 0x0000000000000000
[  175.808920] [Hardware Error]: IPID: 0x000000ff03830400, Syndrome: 0x0000000000000000
[  175.809023] [Hardware Error]: Platform Security Processor Ext. Error Code: 0, An ECC or parity error in a PSP RAM instance.
[  175.809143] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: RD

> I've seen this too, and I'm looking into it. I'm doing some research to find
> the correct (or at least sane) value for current and legacy systems.

/**
 * struct edac_raw_error_desc - Raw error report structure
 * @grain:                      minimum granularity for an error report, in bytes

I'm guessing 1 on AMD as the error address reported is on a byte
granularity. Or?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
