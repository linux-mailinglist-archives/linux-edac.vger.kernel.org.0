Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8539BEB0
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jun 2021 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFDR2z (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Jun 2021 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFDR2z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Jun 2021 13:28:55 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F8CC061766
        for <linux-edac@vger.kernel.org>; Fri,  4 Jun 2021 10:27:09 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i67so10080837qkc.4
        for <linux-edac@vger.kernel.org>; Fri, 04 Jun 2021 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=HIc6Y60arbh4Mw+q4ThUryQTRUIJXZaUhtHstKudjnw=;
        b=MkHYdHyvLimb+IpZp2lOGpJGVECk/H/U++UJllB66ExYMmfFjgL2m23eB7OEM82qo7
         /ybc0ffqLORZ30WNX0JR+jgwptRXZKDpJ5Csy7KPgKes9vo9rjI2Djm9ppWkazDTYfkR
         m38B1BDuj/1ncex+83hh54GLFWqrxXOltzwv95s35KoDiww6kIoEE8813YyM4ZvOGdNf
         DDEFNVg5QWv3AHauky9S6J10vBKZ7wg/ob624oJsVq0ow2uLQK99O+K7P+AkQ2RE6FZx
         4ut1VZe0VjqcV0sB4txuBiaG2QnXtpoRIvzLuUL77ga554EfjdqjnLupsxvRqAEkU0hW
         u5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=HIc6Y60arbh4Mw+q4ThUryQTRUIJXZaUhtHstKudjnw=;
        b=bLdfpEtAvhux4Rfgp0dmx6DnIv+U1UsVeEJLTJC5XCGdG/uM+GoGxRU4Qm1Px1CbcB
         vAvEQ95Rf0SmKAlQq0XL2NfwmHOgKuzhkeEdduhLbHu7C51Y5+f3npEyQUxJ0gQLQDRu
         C4Ukva7AesW43uG1FHBXJYrItrczZd2MRWxYZGtd0h3ttn6afH2kiEPVlN6KZ7mk0KaU
         h9GcihBGzckzDCpJuWlDw278GZVSKHfOefuXQPohWZ+VmnCO4gclPz29cWG8k9PDmCnH
         6U6HzKQPBiTX2tXp9aBh5L9rAkiP3voN6IijjGC+f2JsmkO1/5u3Ze5CdA+HiK8NJCOv
         Fa+Q==
X-Gm-Message-State: AOAM533kp77qrReoQWVpro1qyWRhv7xz1WpXZXswppHpE13Yjoln7MoG
        ZA7m5Czl/++zXihXAFB/Hr43euJ+T4fROeb/dh9JnBzMtz0=
X-Google-Smtp-Source: ABdhPJzdp5cshLvazzDpZoez/vxwqYYeoKzYnc7bYxoaQokKd0oTNosReDSJ6u+3gD8f1cTusr//ffV0nS+TN/lgdDQ=
X-Received: by 2002:a05:620a:e0d:: with SMTP id y13mr5497320qkm.240.1622827628117;
 Fri, 04 Jun 2021 10:27:08 -0700 (PDT)
MIME-Version: 1.0
Reply-To: raydude@gmail.com
From:   Brian McKee <raydude@gmail.com>
Date:   Fri, 4 Jun 2021 10:26:57 -0700
Message-ID: <CAPYVV1fJR+CzCY056y2J1J73M+F8RXbk1GJM6YHXbwjuRCYbTw@mail.gmail.com>
Subject: [BUG?] Issue with ARMv7 EDAC SCRUB on SOCFPGA
To:     linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello everyone,

If you've seen this already, sorry, I had forgotten about the no html
rule to the list and the first email bounced.

Thanks for taking the time to read this.

I sent this to the general edac list because there wasn't an ARM EDAC
listing in the MAINTAINERS file.

I'm working on socfpga with kernel 5.11, which in my case is an ARMv7
SOC from 2013 timeframe. Specifically, it's a Cyclone V SX SOC from
Altera intel.

I have 40 bits of memory and ECC is up and running. The Cyclone V has
no method to inject errors into the ECC pipeline so I'm using the old
"short a data bit to ground" trick to verify hardware correction and
linux detection.

However, when I short D1 to ground, the kernel goes OOPS.

I have traced the issue to the memory scrub inline assembly found in
the arm specific edac.h:

static inline void edac_atomic_scrub(void *va, u32 size)
{
#if __LINUX_ARM_ARCH__ >= 6
unsigned int *virt_addr = va;
unsigned int temp, temp2;
unsigned int i;

printk("EDAC: Scrubbing 0x%08x to 0x%08x\n", (int) va, (int) (va+size));

for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
/* Very carefully read and write to memory atomically
* so we are interrupt, DMA and SMP safe.
*/
__asm__ __volatile__("\n"
"1: ldrex %0, [%2]\n"
" strex %1, %0, [%2]\n"
" teq %1, #0\n"
" bne 1b\n"
: "=&r"(temp), "=&r"(temp2)
: "r"(virt_addr)
: "cc");
}
#endif
}

Here is an example of the oops: (Note: the top line is from a printk I
added to the edac code to see what was up.)

[ 1299.870164] EDAC: [226 Correctable errors @ 0x000E33C4]
[ 1299.876892] EDAC MC0: 184 CE soc:sdramedac on mc#0csrow#0channel#0
(csrow:0 channel:0 page:0x6a3 offset:0xb9c grain:8 syndrome:0x0)
[ 1299.891822] Unable to handle kernel paging request at virtual
address c06a3b9c
[ 1299.899021] pgd = b6c6b929
[ 1299.901724] [c06a3b9c] *pgd=0061940e(bad)
[ 1299.905736] Internal error: Oops: 80d [#1] SMP ARM
[ 1299.910515] Modules linked in:
[ 1299.913567] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.11.0-wtec #5
[ 1299.919903] Hardware name: Altera SOCFPGA
[ 1299.923900] PC is at edac_raw_mc_handle_error
(./arch/arm/include/asm/edac.h:26 drivers/edac/edac_mc.c:816
drivers/edac/edac_mc.c:938 drivers/edac/edac_mc.c:1010)
[ 1299.929301] LR is at __kmap_local_page_prot (mm/highmem.c:542)
[ 1299.934344] pc : lr : psr: 000f0193
[ 1299.940587] sp : c0e01b70  ip : c0e01b58  fp : c0e01bd4
[ 1299.945792] r10: 00000000  r9 : c0e01c10  r8 : ef7f9000
[ 1299.950998] r7 : 00000000  r6 : 000006a3  r5 : 00000b9c  r4 : 00000008
[ 1299.957500] r3 : c06a3b9c  r2 : c06a3ba4  r1 : ebfb755f  r0 : c06a3000
[ 1299.964003] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[ 1299.971201] Control: 10c5387d  Table: 02b0004a  DAC: 00000051
[ 1299.976924] Process swapper/0 (pid: 0, stack limit = 0x10d9740f)
[ 1299.982911] Stack: (0xc0e01b70 to 0xc0e02000)

As I understand it, the virtual memory address being found by the EDAC
scrub code is not valid and so the processor is trapping on the
assembly code's access to the first memory location that needs to be
scrubbed.

I'm a hardware engineer by profession. I'm not a kernel virgin (I run
gentoo & have modified drivers) but this stuff is way out of my
bailiwick.

I'm hoping you guys could suggest how I can track this down because it
seems like a real kernel bug. Since the Arm EDAC hasn't changed since
the early 20 teens, I suspect the kernel grew beyond the ARM EDAC
ability to deal with actual failures and needs to be brought up to
date. Or something like that, anyway.

Any hints, clues, or ideas would be greatly appreciated.

Brian
