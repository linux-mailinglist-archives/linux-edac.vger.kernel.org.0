Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E24A2BA761
	for <lists+linux-edac@lfdr.de>; Fri, 20 Nov 2020 11:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgKTKYx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Nov 2020 05:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgKTKYv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 20 Nov 2020 05:24:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845EEC0613CF;
        Fri, 20 Nov 2020 02:24:51 -0800 (PST)
Received: from zn.tnic (p200300ec2f11ba00f868c244b2fbf8c0.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:ba00:f868:c244:b2fb:f8c0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F30F61EC04E4;
        Fri, 20 Nov 2020 11:24:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605867888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ns4sFxrUSiLCZMnEiVFD5tWKOkMLV8Js5L0ESPn0UgM=;
        b=qdd6XizVaJklLEA6MR/6kvLxm5Ai0wVGte6WdS0Bb4V2Z4K+rVhXFaTZtETjFQcmi1n6BZ
        JC65ZytGfhuIiddgFKevpr1UiPOF5BCXsfSJZ4JGkpHE5tfpcaGy9UC8F/ndxLXWm0FmjO
        I+WiAAX4jxDKK2oPRyC41XigCPR0eF0=
Date:   Fri, 20 Nov 2020 11:24:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Aili Yao <yaoaili@kingsoft.com>, tony.luck@intel.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        yangfeng1@kingsoft.com, CHENGUOMIN@kingsoft.com
Subject: Re: [PATCH v2] Dump cper error table in mce_panic
Message-ID: <20201120102422.GA712@zn.tnic>
References: <20201104065057.40442-1-yaoaili126@163.com>
 <20201117175804.39bbbdc3.yaoaili@kingsoft.com>
 <20201118124538.GI7472@zn.tnic>
 <20201119134057.37ca2c19.yaoaili@kingsoft.com>
 <20201119174508.GE3769@zn.tnic>
 <20201120172235.620eb826.yaoaili@kingsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201120172235.620eb826.yaoaili@kingsoft.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Nov 20, 2020 at 05:22:35PM +0800, Aili Yao wrote:
> Hi, This test result if from tip/master, previous is upstream latest.

Thanks for doing those, now let's see.

With rc4 you have the MCE error in the first kernel:

[  106.956286] Disabling lock debugging due to kernel taint
[  106.962373] mce: [Hardware Error]: CPU 18: Machine Check Exception: 5 Bank 7: be00000001010091
[  106.962377] mce: [Hardware Error]: RIP !INEXACT! 10:<ffffffffac58472a>
[  106.996488] {acpi_idle_do_entry+0x4a/0x60}
[  107.001057] mce: [Hardware Error]: TSC ae4b410af0b8 ADDR 314d193000 MISC 200400c008002086
[  107.010283] mce: [Hardware Error]: PROCESSOR 0:50657 TIME 1605843017 SOCKET 1 APIC 40 microcode 5000021
[  107.020767] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
[  107.031295] mce: [Hardware Error]: Machine check: Processor context corrupt
[  107.039065] Kernel panic - not syncing: Fatal machine check

Now the kdump kernel fires and there's an error record in the CPER
thing.

> [    6.280390] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [    6.288655] ACPI: Power Button [PWRF]
> [    6.292961] ERST: Error Record Serialization Table (ERST) support is initialized.
> [    6.301295] pstore: Registered erst as persistent store backend
> [    6.307912] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
> [    6.308886] {1}[Hardware Error]: event severity: fatal
> [    6.308886] {1}[Hardware Error]:  Error 0, type: fatal
> [    6.308886] {1}[Hardware Error]:  fru_text: Card03, ChnB, DIMM0
> [    6.308886] {1}[Hardware Error]:   section_type: memory error
> [    6.308886] {1}[Hardware Error]:   error_status: 0x0000000000000000

And this error_status is all clear. I wonder why.

Looking at the ÜFI spec "Section O: Error Status" it defines a couple
of bits there: whether it was an address or control bits error, who
detected the error (responder, requestor), whether it was the first
error, etc, etc.

And none of those bits are set.

Which makes me not trust that error record a whole lot but that's a
given, since it is firmware and firmware is an unfixable piece of crap
by definition.

So then one could probably say that if none of those error status bits
are set, then the error being reported is not something, let's say
"fresh". This is doubly the case considering that it gets detected when
the GHES driver probes:

        /* Handle any pending errors right away */
        spin_lock_irqsave(&ghes_notify_lock_irq, flags);
        ghes_proc(ghes);
        spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);

so *maybe*, just *maybe* one could say here:

If the error_status doesn't have any valid bits *and* it has been
detected on driver init - i.e., the error has been there before the
driver probed, then even if the error is fatal, GHES should not call
__ghes_panic().

The even better way to detect this is to be able to check whether this
is the kdump kernel and whether it got loaded due to a fatal MCE in the
first kernel and then match that error address with the error address of
the error which caused the first panic in the mce code. Then the second
kernel won't need to panic but simply log.

However, I think that second way to check is probably hard and the first
heuristic is probably good enough...

Tony, thoughts?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
