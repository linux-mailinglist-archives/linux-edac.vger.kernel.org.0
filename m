Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F13CDC4D
	for <lists+linux-edac@lfdr.de>; Mon,  7 Oct 2019 09:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfJGHRA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Oct 2019 03:17:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55138 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfJGHRA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 7 Oct 2019 03:17:00 -0400
Received: from zn.tnic (p200300EC2F064200604F0F8C9F77D256.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:4200:604f:f8c:9f77:d256])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 24EA51EC027B;
        Mon,  7 Oct 2019 09:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570432614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EnZMwcUNiZNAU7Y16tJi3Av/6Z+UIYJ+V0m0/RhgJFM=;
        b=r80m7p8hbn7FDRd9VPQKbxtGmp09uUXXuXqgq+jrqKh1KL4rzEBGDJMFxfck9O3HGk4Cg3
        F8+/MyNeJfkZV56sTcmWE8lRtZyWgN/5P0E6ZzSlPYmkWC4g64Yyxadn/1RcEtk0ezRB+S
        MmPpks4dkkIe/AMHZUhzjOWGLHH8TKA=
Date:   Mon, 7 Oct 2019 09:16:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jeff God <jfgaudreault@gmail.com>
Cc:     linux-edac@vger.kernel.org
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
Message-ID: <20191007071502.GA24289@zn.tnic>
References: <CAEVokG7TeAbmkhaxiTpsxhv1pQzqRpU=mR8gVjixb5kXo3s2Eg@mail.gmail.com>
 <20190924092644.GC19317@zn.tnic>
 <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Oct 05, 2019 at 12:52:15PM -0400, Jeff God wrote:
> * I tried different addr values that I believe are in valid range, all
> other values (cpu,...) were left to their default (0), I used bank 0
> to trigger the tests and tried different values briefly but always
> with the same results

Try this as root (the first command is cd-ing into the default debugfs
mountpoint - check whether that is the case on your system first).

# cd /sys/kernel/debug/mce-inject/
# echo 10 > /sys/devices/system/machinecheck/machinecheck0/check_interval
# echo 0x9c7d410092080813 > status; echo 0x000000006d3d483b > addr; echo 2 > cpu; echo hw > flags; echo 4 > bank

If you have this in your dmesg:

[    1.420991] RAS: Correctable Errors collector initialized.

then you need to boot with "ras=cec_disable" first.

> but it does not seem EDAC ever report any ce (or ue) ecc error even
> when they may be happening and corrected in background.

What does that mean?

You are getting ECCs or you simply want to test whether the ECC
reporting works on your machine?

P.S., Please do not top-post and see if you get another mail client -
gmail is linewrapping dmesg and is generally bad for pasting logs and
code in.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
