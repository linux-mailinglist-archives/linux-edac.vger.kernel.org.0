Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08115CF8E1
	for <lists+linux-edac@lfdr.de>; Tue,  8 Oct 2019 13:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfJHLuv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Oct 2019 07:50:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53250 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730393AbfJHLuu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Oct 2019 07:50:50 -0400
Received: from zn.tnic (p200300EC2F0B5100F95346AC907D1965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5100:f953:46ac:907d:1965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68C0B1EC06F3;
        Tue,  8 Oct 2019 13:50:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570535449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=unXbuCnZfu9iQPrPf9LRoleK0gdnfC11gANu/Itf2aE=;
        b=aZ95+ThbnTaBu6CmbBcJOTCxcC5mSNyQquWk9/SvVlfSzkl48ylAwuiq/kPSaidMw0tfwg
        J2D3tAGVc9iS4H/DQuEVPqTSmzyirJlZGtiP4wym6KZ1NdWnvWk01dwrLzqVX4Rx7/C+Ia
        WjJwRusn3F0DkeZ4VNgPkc4/D7Sb/bg=
Date:   Tue, 8 Oct 2019 13:50:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jeff God <jfgaudreault@gmail.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
Message-ID: <20191008115041.GD14765@zn.tnic>
References: <CAEVokG7TeAbmkhaxiTpsxhv1pQzqRpU=mR8gVjixb5kXo3s2Eg@mail.gmail.com>
 <20190924092644.GC19317@zn.tnic>
 <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
 <20191007071502.GA24289@zn.tnic>
 <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 07, 2019 at 08:58:30AM -0400, Jeff God wrote:
> I want to test that the ECC reporting is working on my machine (so
> that when real errors will happen one day I will get notified)
> 
> The method I described previously to generate errors by overclocking
> memory was my initial method to generate real errors, which proved to
> work well on another system with a previous generation AMD Ryzen 2700x
> and similar motherboard and same memory, but on this system it does
> not report any error, although turning off ECC in the bios showed that
> memory corruption is happening fairly quickly in this case, hence the
> conclusion that error reporting was probably not working but the
> underlying memory error correction system may be working.

Yeah, if I inject an "sw" type here, I get immediately:

[  264.740840] [Hardware Error]: Corrected error, no action required.
[  264.740942] [Hardware Error]: CPU:2 (17:1:2) MC4_STATUS[-|CE|MiscV|AddrV|-|SyndV|CECC|-|-|Scrub]: 0x9c7d410092080813
[  264.741074] [Hardware Error]: Error Addr: 0x000000006d3d483b
[  264.741169] [Hardware Error]: IPID: 0x0000000000000000, Syndrome: 0x0000000000000000
[  264.741279] [Hardware Error]: Bank 4 is reserved.
[  264.741368] [Hardware Error]: cache level: L3/GEN, mem/io: MEM, mem-tx: RD, part-proc: SRC (no timeout)

but doing a hw injection seems to do all that it should do:

[  245.658175] mce: do_inject: CPIU2, toggling...
[  245.658375] mce: prepare_msrs
[  245.658507] mce: trigger_mce: CPU2

but nothing happens.

Yazen, are we missing something here?

See upthread for details - thread is on linux-edac@.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
