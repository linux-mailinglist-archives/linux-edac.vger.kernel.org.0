Return-Path: <linux-edac+bounces-4160-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F732ADDE2A
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 23:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2C57AC08B
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 21:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A2E19F424;
	Tue, 17 Jun 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5I9rQ3v"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619303F9D2;
	Tue, 17 Jun 2025 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750196893; cv=none; b=m3geFX3Ez2X3FfGNXhNvg9L3tKGF4OAmfrQKcjEP3tG3+gekEy+6UuPzvxhwcANKVWs1YJO3ISk/oUdfCxCIhtYIfsyQhMpR6ueRWLtjN7BqQ+HhtRlQ0vTheWKdWN7+cYmfkjX3srU3JJl7dOJXUoTK0Ej/rGDAjlHhkot0JzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750196893; c=relaxed/simple;
	bh=aj/Wy7evYX9v7Wv54ccnGDYJ2AbAnwlQRzYR8DDqeq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5r6XucZXYMxxbB329l81tVZ4vm6PNZp2MSQ8l/+Xg+rIcx5LmdvaHVqmrjOnlM/VL/auwuWKvDi54u/8t/dleKjXTF2IkjJ+NBLJgzGf/y4togEq4S+OtdBiUW4kgU4g3+HhfkplABIYDGIijmfNZuBc2AMduUfqrAqur74l4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5I9rQ3v; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b271f3ae786so4605975a12.3;
        Tue, 17 Jun 2025 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750196892; x=1750801692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ3vllYy11hbEH9SlsLjL7SUHq59yOigX87yktj+ViE=;
        b=X5I9rQ3v7tp3r0PU2R+AI2vxx3mBFk+AzTlLEj1JfkpdNSOUxaK+j1Wxf41zyoZn3n
         R0VOW2pRmK2UrLrbLWjNcGSoTBW0RfTVHXqHIMzVGwkCczxNc98ZKhx7ZShSPqtahGmT
         4jQV4uIRqLrE8p+1edDaV9Ztx8kaLdUwlPP5/q+ucPQervahC9Ag9yitZyXV+vEvb4Hu
         k/gRbV/64ZQSc68aY3e6RDyAlj7fHUbEZhTQBMZpNpr+6YBUnkFWYM5qJlA1fIklsrfp
         qpA0C93jwGfAy+FQc152TVlEEepnEfU19mLbHZ2bDnwmvabtIvKq+mFayEiT3A5UHpbu
         dVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750196892; x=1750801692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJ3vllYy11hbEH9SlsLjL7SUHq59yOigX87yktj+ViE=;
        b=FQ46JidmX5B3YKpdN5ITnxH40SqyMsL+HpmqBL/IojJsHz2kZUZP9NYycc7eQckMsF
         SeamLGDYxqWO7qQSyJM1ELhCUQjiEiOH03Dm4K/DpUc/v/KkPFtIxbrafqNH+RJq646v
         ihYYm0uM+ewqiYDXur41hPqdpbeidv4P5zYJAZ/qM1Rz9PEvcETencgdkerzpNHibG1r
         nbNu4zkfwHxq3Cl/g7W+xv0KP/Ko8BoG4Vf8aihWQx8R3/BxyPHX6CbbN5flGjt7ZDRI
         xBsMW63e4Ho4jCQYVljm4ERTplhTNg8MrnjDJub9h+i4UdiHdBQdAHr7gipQnC8jWMOJ
         s0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6EP7bIAJ3dREzvG3IkszHVueSyIMn3snLO6YyxPT7OwN24/T0CdNiVcOlLJPOVHKTNz49VcFVHIVzHcsH@vger.kernel.org, AJvYcCXtUgOW4roW+X9TOgXJlZFjnWN69Rn3qb6bQVtliHlYeJVcxXqeIhyT/knLwB9jprmQDfrGOCXApk7N@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1HTk4W4FeRLz9bDSSn16pt95Pr42HXPvPA2tmKRm8Werxvx+
	bc939PctfrdiRiYRsbi88F9pQU4Vq6d75RxFH9p8aEY0aa1S+nadufOI
X-Gm-Gg: ASbGnctA9sJi5OU2WbWs0uo0RWpf0fBioj51GJX2Txtgctfbqm8Yr9su/pdAtYis7ht
	wOcTH/WEke5FMR3pSr3gPecmFQHfq0bBUovMxyGa6ihbhNvNfGdFL4jvzgHvxyK8xSDdA9jHrTj
	1s/1iKbSe5NGjFYQBPlYim8bFPyn/lQbYhEIxhdGK6dnFci7VbOaCJp+Eh1AJZsFz9xTSKWJR/M
	562p+9aV6WEhoEXTz8/gPbMNlykS9o7JVLbKym1y+VrzRj6R4DGw0Kqj4LqF3WEydKnaLni/jLo
	76Mri74bnGG9dTSpeFVMQ+YbSnBTxQrfJ7P1YoYwlSr3APopq+d4c91y7SCSdtz1mhYyfYYPiQ7
	+hhy24oRyjXvkwA==
X-Google-Smtp-Source: AGHT+IEDw2iGWX2b5gw8FTy4FhzKLFo936hcr3OjS6yoh5w9bvnKliafJqtqiSlNqfSMVKHqxChefw==
X-Received: by 2002:a17:903:943:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-2366afc485bmr225397205ad.1.1750196891558;
        Tue, 17 Jun 2025 14:48:11 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([2601:648:8100:3b5:c6ef:bbff:fec0:9e95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea890asm85694445ad.143.2025.06.17.14.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:48:09 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tony.luck@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	aijay@meta.com
Cc: x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] mce: include cmci during intel feature clearing
Date: Tue, 17 Jun 2025 14:47:52 -0700
Message-ID: <20250617214752.178263-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was found that after a kexec on an intel CPU, MCE reporting was no
longer active. The root cause has been found to be that ownership of CMCI
banks is not cleared during the shutdown phase. As a result, when CPU's
come back online, they are unable to rediscover these occupied banks. If we
clear these CPU associations before booting into the new kernel, the CMCI
banks can be reclaimed and MCE reporting will become functional once more.

The existing code does seem to have the intention of clearing MCE-related
features via mcheck_cpu_clear(). During a kexec reboot, there are two
sequences that reach a call to mcheck_cpu_clear(). They are:

1) Stopping other (remote) CPU's via IPI:
native_machine_shutdown()
	stop_other_cpus()
		smp_ops.stop_other_cpus(1)
		x86 smp: native_stop_other_cpus(1)
			apic_send_IPI_allbutself(REBOOT_VECTOR)

...IPI is received on remote CPU's and IDT sysvec_reboot invoked:
	stop_this_cpu()
		mcheck_cpu_clear(this_ptr_cpu(&cpu_info))

2) Seqence of stopping the active CPU (the one performing the kexec):
native_machine_shutdown()
	stop_other_cpus()
		smp_ops.stop_other_cpus(1)
		x86 smp: native_stop_other_cpus(1)
			mcheck_cpu_clear(this_ptr_cpu(&cpu_info))

In both cases, the call to mcheck_cpu_clear() leads to the vendor specific
call to intel_feature_clear():

mcheck_cpu_clear(this_ptr_cpu(&cpu_info))
	__mcheck_cpu_clear_vendor(c)
		switch (c->x86_vendor)
		case X86_VENDOR_INTEL:
			mce_intel_feature_clear(c)

Now looking at the pair of functions mce_intel_feature_{init,clear}, there
are 3 MCE features setup on the init side:

mce_intel_feature_init(c)
	intel_init_cmci()
	intel_init_lmce()
	intel_imc_init(c)

On the other side in the clear function, only one of these features is
actually cleared:

mce_intel_feature_clear(c)
	intel_clear_lmce()

Just focusing on the feature pertaining to the root cause of the kexec
issue, there would be a benefit if we additionally cleared the CMCI feature
within this routine - the banks would be free for acquisition on the boot
up side of a kexec. This patch adds the call to clear CMCI to this intel
routine.

Reported-by: Aijay Adams <aijay@meta.com>
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 arch/x86/kernel/cpu/mce/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index efcf21e9552e..9b149b9c4109 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -478,6 +478,7 @@ void mce_intel_feature_init(struct cpuinfo_x86 *c)
 void mce_intel_feature_clear(struct cpuinfo_x86 *c)
 {
 	intel_clear_lmce();
+	cmci_clear();
 }
 
 bool intel_filter_mce(struct mce *m)
-- 
2.47.1


