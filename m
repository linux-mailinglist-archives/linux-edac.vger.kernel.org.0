Return-Path: <linux-edac+bounces-5178-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EBBC0533A
	for <lists+linux-edac@lfdr.de>; Fri, 24 Oct 2025 10:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65C704FD63D
	for <lists+linux-edac@lfdr.de>; Fri, 24 Oct 2025 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3BF3064B1;
	Fri, 24 Oct 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePRmMW7/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36A2D9EF9
	for <linux-edac@vger.kernel.org>; Fri, 24 Oct 2025 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295740; cv=none; b=blsVv8FrtLa2NbsEC9l/rR2QmPGqYm8GSCS12snq44iBnLSfJmwAzJtLJpEI+skKv0VNDRdDFxVur9ZZrv528q8vVzZ5Vl9DIM5hny9YeehwjMqWj/kS1bph0HL0VgpzrGrwFxu1nH9jdJ675ktlPMvd6CD66qnwbR6zIMEPHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295740; c=relaxed/simple;
	bh=ztHIOhEiiaqBoopvTIXqOUqJUfk2HMRNxwUoONlyffU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k53Co5VsY/niypBdPD14kG/yHVipYSM8p6IsDbvJ5s9EehIlzC/ittOzlHOCkKocpR0G0fKnaoT7uR8kDg/myL5/6f5xmK2yBVNhyZs+i3L0rqzghE6i9R9C6NKL36+vE41dRy3PLMLwykt/c8sKXJvcoob562N7dmR6VI+TJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePRmMW7/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-378de7d3057so14298861fa.1
        for <linux-edac@vger.kernel.org>; Fri, 24 Oct 2025 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761295736; x=1761900536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4kJQLU7HkQQtlqv3b3bm8HqvzrF9H7Chbd+Noruans=;
        b=ePRmMW7/EJ3T5kaynQgUdTh/i2uC22RIqoPAFXDGZlwofd4XUy0p/6v3MQ+o0SInzI
         Cvp8KK6C48u5s8Dx1WERvhtxR9heJtx+YOXPK34AyRjNq/kEUbeoWX41PDrWIHI3yuGZ
         YANelvWiJcZ2qlIVlnuX41GmQ1yPGoOq8eFO3+FGK9uqfS235r7mg3uwtpsDRuATos+7
         04dNIw3OiMj/xeD4uL5cWCxyPbraVB6g3pLXyARo7AzDEPuDCOXWeCOy5USm+0sJXBgN
         r2+Rdpz9/cDwBogHV+a/Lul+j2Vd+KtNuaw/ZzZrcQZu90OHsUuM3DESbtMsc092sAzY
         dqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295736; x=1761900536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4kJQLU7HkQQtlqv3b3bm8HqvzrF9H7Chbd+Noruans=;
        b=sDapSq1UmUT07mwEz9P+9itogRam3fw5y5HzV6WMA6suTXXgbAGRDOpXMXDUF39lPW
         kwLV6sEppMkogNgqC+XlguWRvtTDMsfOXhXd47ZwELlyYIR63BeGeIxY/jdSykZcH7fz
         9AcXwiCp0w4yql9Y0yW9qaw5H6ih/3Qz7mei9O4eExVqoV0GELK1uAUV8LjSDFsYBY9a
         k7Y7sgr7ocfMNQBE6SRsPyS0zRYJgHU6JxZWscxVYV7gR9ZHQF+7gsQLhgTFF4u4RwGG
         OYGiQm//qz4na5Wa2S7WAJr/GHMCbmI1PKD9LsO2IBzdS+HjBPiKrIrSIXDu7e25NLU7
         f0AA==
X-Forwarded-Encrypted: i=1; AJvYcCURqRkpGXGU/LmfpqaHHsA25bEYWqbBN4k0hxVblGKn1sNb6jgma7Tr6riY75oNGN5z5liPwaElyCcS@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVLoojetI0F9SjHUaIsY/4MBkgmP+a+6bskC1LiV3+Tal93D3
	cmFuHFWL038UeF62ylcBO1v1xAWVzSxa4SCZuIxzzc8a0V164UlRHnoq
X-Gm-Gg: ASbGncu2h9rl9z8JoZuJkKJZpEQ97nSHvzBP9JULVFBgR04eUSp6+BBl27k4fDv4rI6
	DIx+0RaP1Ou11/J2N9047oDhdF5sck+W+6cnx2dPqxymLjxdojqY61JbD5GivaQ5hv0PK/NjZWu
	85Tyu3YYHAChoKMFhNPepbkbRh4NumGBSBQK3t1wX9lNa0G39AqUdPZVg3m4J3woZ9y1AFQKL3T
	UmB4iD4tOJdGmIuc6t3Ib8fEj2SrIZPnhFUvQuL16DEXJwk248lHdCImXysp8yA6oc9ajwx5O+V
	IlcxhJbnjzTtlR3w6qLwM8nlCCRiCp2sRd5Off+VCGuuUFv/niPxeyf2JIhaq6/BSr1Yc00zkQX
	mNI8nwyuZNuUNYDFsgxvILWeEYdJI9h/j6lqOVTActcPOk1HgBU6KxJsw+vAq7yQUyqLOvBo3Fc
	i0GFpvdiTW05Grwo4fim34/+pIIpmcG1CzHX6iTg==
X-Google-Smtp-Source: AGHT+IESgU7Y4+mcfFfkHpukwGwbt1gtrw7F8TBkSlObe6I2/8SHRwyJCnz9Y0OqCyB02ZUjj1l7Gw==
X-Received: by 2002:a05:651c:1545:b0:378:d65a:9ceb with SMTP id 38308e7fff4ca-378d65aaa18mr14578941fa.24.1761295736186;
        Fri, 24 Oct 2025 01:48:56 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378e8b6d2dcsm769061fa.23.2025.10.24.01.48.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Oct 2025 01:48:55 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:48:51 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux@roeck-us.net, mario.limonciello@amd.com,
 naveenkrishna.chatradhi@amd.com, platform-driver-x86@vger.kernel.org,
 suma.hegde@amd.com, tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251024104851.4d3030b0.michal.pecio@gmail.com>
In-Reply-To: <20251023190901.GA840389@yaz-khff2.amd.com>
References: <20251022011610.60d0ba6e.michal.pecio@gmail.com>
	<20251022133901.GB7243@yaz-khff2.amd.com>
	<20251022173831.671843f4.michal.pecio@gmail.com>
	<20251022160904.GA174761@yaz-khff2.amd.com>
	<20251022181856.0e3cfc92.michal.pecio@gmail.com>
	<20251023135935.GA619807@yaz-khff2.amd.com>
	<20251023170107.0cc70bad.michal.pecio@gmail.com>
	<20251023160906.GA730672@yaz-khff2.amd.com>
	<20251023202503.72987338.michal.pecio@gmail.com>
	<20251023190429.GB796848@yaz-khff2.amd.com>
	<20251023190901.GA840389@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 15:09:01 -0400, Yazen Ghannam wrote:
> On Thu, Oct 23, 2025 at 03:04:29PM -0400, Yazen Ghannam wrote:
> > On Thu, Oct 23, 2025 at 08:25:03PM +0200, Michal Pecio wrote:  
> > > On Thu, 23 Oct 2025 12:09:06 -0400, Yazen Ghannam wrote:  
> > > > The kernel seems to think there are 6 CPUs on your system:
> > > > 
> > > > [    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs  
> > > 
> > > I wonder if this code doesn't break systems which actually support
> > > hotplug, when some sockets aren't populated at boot?  
> > 
> > I don't know about other vendors, but we don't do physical CPU
> > hotplug. CPU hotplug, in this case, is there are physical CPUs
> > already in the system, but they are not enabled for whatever policy
> > decision. They could be disabled in BIOS, and so the MADT entries
> > will reflect that. Or they can be disabled by kernel parameters.

Thanks for the explanation. Looks like your patch is correct then
and we need to fix the topology somehow.

> Sorry for the rapid emails. Here's another interesting commit:
> f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")

I have this commit on 6.12 but it doesn't help.

As I understand, APIC ID is a bitfield of the form:

[package ID] ... [core ID] [thread ID]

In my case, per debugfs:

domain: Thread     shift: 0 dom_size:     1 max_threads:     1
domain: Core       shift: 2 dom_size:     4 max_threads:     4
domain: Module     shift: 2 dom_size:     1 max_threads:     4
domain: Tile       shift: 2 dom_size:     1 max_threads:     4
domain: Die        shift: 2 dom_size:     1 max_threads:     4
domain: DieGrp     shift: 2 dom_size:     1 max_threads:     4
domain: Package    shift: 2 dom_size:     1 max_threads:     4

So my phantom APICs simply look like another package with weird
non-sequential ID. (Probably not an ACPI spec violation yet?)

f0551af02130 only rejects disabled APICs in the same packages as
enabled ones. An earlier proposal in that thread was to reject all
disabled APICs on bare metal unless explicitly "online capable":

https://lore.kernel.org/all/87sf15ugsz.ffs@tglx/

This clearly goes against fed8d8773b8e and it seems to go against
what you wrote about AMD BIOSes potentially marking CPUs as disabled
in MADT and presumably allowing OS to wake them up with ACPI?

You asked elsewhere what happens if I online CPU5/6. I don't have
directories for them in /sys/, so not sure if I need any extra steps
to make them appear, or the kernel considers those CPUs bogus for
some reason and amd_nb could do the same?

Bitmaps from /sys/:
/sys/devices/system/cpu/enabled:0-3
/sys/devices/system/cpu/kernel_max:5
/sys/devices/system/cpu/offline:4-5
/sys/devices/system/cpu/online:0-3
/sys/devices/system/cpu/possible:0-5
/sys/devices/system/cpu/present:0-3

I tried 6.18-rc2 and it's same thing, except EDAC and GART don't work.
On both kernels, possible_cpus=4 fixes it:

[    0.072066] CPU topo: Limiting to 4 possible CPUs
[    0.072074] CPU topo: CPU limit of 4 reached. Ignoring further CPUs
[    0.072082] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
[    0.072084] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.072086] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.072089] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.072090] ACPI: HPET id: 0x8300 base: 0xfed00000
[    0.072097] CPU topo: Max. logical packages:   1
[    0.072097] CPU topo: Max. logical dies:       1
[    0.072098] CPU topo: Max. dies per package:   1
[    0.072103] CPU topo: Max. threads per core:   1
[    0.072105] CPU topo: Num. cores per package:     4
[    0.072105] CPU topo: Num. threads per package:   4
[    0.072106] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
[    0.072107] CPU topo: Rejected CPUs 2

