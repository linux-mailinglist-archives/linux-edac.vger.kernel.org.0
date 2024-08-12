Return-Path: <linux-edac+bounces-1642-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC4994E920
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2024 11:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B701F20F35
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2024 09:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C53166F22;
	Mon, 12 Aug 2024 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=purdea.ro header.i=@purdea.ro header.b="lHmEDxLa"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17D1514C1
	for <linux-edac@vger.kernel.org>; Mon, 12 Aug 2024 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453363; cv=none; b=bYOZaj2hAn1eEvtPF1uwjJHDbZt8KCzclYI+wyKgpzuBMLj1gMsP1VoGkOvTq9LYSNjaEEEX47Yt8R0HqzsODmI7w9gBoKlyKDHZH0FVVHUr7THqYt3nzgmpsAqCbvtbSDNW6j0gbIWOSLTzQszni8ltMlOOi0DCOesIwlAJEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453363; c=relaxed/simple;
	bh=BZkGiYw/RcP1yrmKR2AdTcX/GXYKxSOtIm1AZRbFzcc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dYEh6G7J1L2b3bhcfhjtCoVSPeaX1nqDixzYmBKfBemu+gDMOp9ZKP31kykJaQ8iEh5135xS0x/wu2U1xS1wIbx8ijNn3psTjthPmN99YQikpy9oXnyaXtauL06qHr0HliHYX+Q0gzNjWXQUJ78UIW934xFTm6085zzqDugd1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=purdea.ro; spf=pass smtp.mailfrom=purdea.ro; dkim=pass (1024-bit key) header.d=purdea.ro header.i=@purdea.ro header.b=lHmEDxLa; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=purdea.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purdea.ro
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0ec934a1fdso1587583276.0
        for <linux-edac@vger.kernel.org>; Mon, 12 Aug 2024 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purdea.ro; s=google; t=1723453360; x=1724058160; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ghsP0JHuEJiPTmjPZJJORUAZJBzn1Ge74yblfGP1i30=;
        b=lHmEDxLah7tC7YtPkFPSxO0N5faV87nJtzTFiwdluKYLla4HQosdk1x+lrNlm7Otyq
         V793IZR6a9HB/TR4UXZ4cPy7UGEB7n3pQZb/C9jzZcenM3hhyVr/hCuVSxTSR/y/toVb
         L8hjA03uwHMACtuEPBaLJdY2Ym6eG4vvOMzG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453360; x=1724058160;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghsP0JHuEJiPTmjPZJJORUAZJBzn1Ge74yblfGP1i30=;
        b=PSRkU21A+XxnBkVVJ6zZttLQ5KKAufFxJl9jY7SkY3oalZW6fbXpHtN9W6jv/r3eNB
         ABmNpR/+1EMXnnPvTYehTypIA8Yls2sBywhymO8lNU3LSwvDX2cSSqPDYNge2npA2/CP
         oMgnODO3zKQY426ceavszBBLzCk7+mjDsRylRbxZxpHpvGft7MQl8LTwAaLEl5FmjLkW
         5b2dFUxgs9dm2oNvN9NqNa5P8PmLgDpPcGqZwubvnLWEna145D5qADUYZ4jrvuze+CN5
         WQ8ofYXN2neLiSc+qodpno4+/TEkYb/o7h/JmjULp2/IrD2YXZTxRFbO5eqR0TbBC39r
         swtw==
X-Gm-Message-State: AOJu0Ywfu+WkEcmXEo2suzOTwGmzGZf6FcicVozPylJjoYb64CBHENKC
	1E5VG+/ONUSdZqxp166cDsBZtxQD1Ypg55mH4As5nRDjzgGNYo7i4dUMyPuFk2OIolSsPitU+rq
	2yZvDX+BY8Vf4GaQmumOTxGh2Np+gRB1UOA/FH+Ezy5aM2jp3cQ==
X-Google-Smtp-Source: AGHT+IF+lz3rjsge6upnoRVIV8dj9ihYwZfHHQXT5j8s+5+oqHrasebRpBqjKIG54YIyccJisQJLmD89TQhC+CUJTRI=
X-Received: by 2002:a05:6902:1504:b0:e0b:6cd2:6d6c with SMTP id
 3f1490d57ef6-e0eb998247amr10132542276.32.1723453359877; Mon, 12 Aug 2024
 02:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrei Purdea <andrei@purdea.ro>
Date: Mon, 12 Aug 2024 09:02:29 +0000
Message-ID: <CA+mMEgddRSFN=CqbzPjVqqPkEOgxXh5Uw0qkM8usPDuHOGqoWQ@mail.gmail.com>
Subject: Memory not cleared by UEFI, causing spurious UE messages.
To: linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Let me describe a system I have been debugging:
1) Thinkpad P51, Xeon E3-1505M v6, EDAC handled by the ie31200_edac
kernel module. Latest UEFI firmware available (but also behaved the
same with a previous version)
2) If I boot normally, I'm getting many periodic UE EDAC reports in dmesg
3) I'm Experiencing no real errors (i.e. memtest86+ and userspace
memtester always passes)
4) If I boot with the kernel command line hacing "memtest=1", then I'm
not getting any spurious EDAC messages (the purpose is to touch every
memory location)
5) If I reboot with memtest=0 after first booting with memtest=1,
without power cycle, I am also not getting any spurious EDAC messages
6) However as soon as I power cyclem and boot with memtest=0, the
spurious EDAC messages are back
7) The spurious EDAC messages also go away if the system is up for a
while with memory heavy workloads, presumably because eventually it
does touch most memory locations.

So I think the above behavior can be explained perfectly by:
- the UEFI doesn't clear the memory
- there is no mechanism in the kernel to clear all memory after boot
(either all at once, or page by page as it's needed, or other block
size at a time)
- the computer performs partial writes, or perhaps there are some
caches that sometimes fetch uninitialized memory, or even there could
be applications reading uninitialized memory

So I think the first question I have is what's the official contract
between kernel/UEFI, is it expected that systems generally clear the
memory after initialisation? Is this put into writing somewhere, so I
can reference it if I try to contact Lenovo? (although I doubt they'll
build a new firmware, there's a big message on the support page saying
this device is at the end of development support)

On a different machine (ASRock Taichi motherboard), I have a UEFI
setting, that allows me to toggle Memory Clear for non-ECC memory, and
the description of the setting implies that Memory Clear is enforced
when ECC memory is in use. I did not find such a setting in the
Thinkpad P51 UEFI.

Other related things I found:
https://buttersideup.com/mediawiki/index.php/Uninitialized_ECC_bits
i.e. some Asus motherboards need "quick boot" to be disabled for the
same reason. In my UEFI there's a Boot Mode=Quick/Diagnostics
settings, however it has no effect.

That wiki page also mentions "Gigabyte GA-X48-DS" motherboard which
has no bios workaround, and requires the use of memtest=1. I found
this page after I spent many hours, and after I figured out on my own
what my actual problem was, and that memtest=1 can work around it.

I think irrespective of whether Lenovo can release a UEFI fix, we
could make the process a lot more frictionless for the end user:

1) We could have a workaround that's better than memtest=1. This takes
12 seconds on my 64GiB system, I bet it can be a lot faster if it
would only need to initialize memory. (Also, does memtest actually
cover _all_ memory? If any 64-bit word remains not-covered, maybe some
kernel memory, and it triggers an error for a user running with
edac_mc_panic_on_ue=1, it could cause a very rare kernel panic for no
reason). We don't actually need to initialize all memory, but we do
need to touch all memory, so if we're already using some areas we can
make sure they're ECC corrected by reading them before the edac
drivers start up.

2) We could have some kind of autodetected quirks to enable that
workaround automatically. I'm thinking autodetect motherboard and/or
UEFI version.

3) Maybe we could have a warning in dmesg, explaining the situation,
if random uninitialized memory is detected with ECC on. This could be
problematic to implement. And could fail if bootloader/uefi used some
memory area for storage, or in case of kexec, and I'm sure there's
other situations.
   - Alternatively perhaps the warning could be printed if the error
shows up very soon after boot
   - Or maybe on first error a reference to this wiki page could be
printed: https://buttersideup.com/mediawiki/index.php/WhyAmIgettingMemoryErrors
(again, I just found this page seconds ago, as I'm writing this email,
after spending many hours figuring out what's wrong. I'm not that bad
at googling.)  Maybe some of this info should be moved into the kernel
RAS documentation:
https://www.kernel.org/doc/html/v4.10/admin-guide/ras.html

Cheers,
Andrei

