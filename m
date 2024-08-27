Return-Path: <linux-edac+bounces-1736-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB7960B12
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2024 14:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6591F2419F
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2024 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66BF1BD029;
	Tue, 27 Aug 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SyxMgUxj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331B1BC9FA;
	Tue, 27 Aug 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763063; cv=none; b=UzaoCt5MY69PKlBhqSuJNFIisax5Hh+/6vsflej0lQYmGZWOj/clZxe2YCvgGHEbRGYQuJcb528d0JOuz9OouHOeQqcezG5i336w5Quii6+9FMmjbBx43jAxk0wUcmuuOBgMS825GeittZUUFVYjqwZh+WxR9bnizc/qPTd4Bvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763063; c=relaxed/simple;
	bh=sqnTVEDnRJOP0pwQdekLrXyA2ncK+DJnutBDsjhfh+8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CvEzyh3EAIzCfCDEUE9nRzGbqcEG5xQcdRJbxbASaotwWkhVn3P623OQCXpxcolHsYeU6/PSKWcEejkolNCRhgj28Xgqr6JbkighHt7minG29WAQplOp8GyArxaZ7UjtythEqwGqFtr1QeHn+GVPE5ZdG1gApm1UZuBF/PPRREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SyxMgUxj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B555140E0263;
	Tue, 27 Aug 2024 12:50:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jbj84ci89aka; Tue, 27 Aug 2024 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724763053; bh=f+MJK/7XcvBcccpfuS0K+qJ4/ZCKMDNN5UCT4vyoVng=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SyxMgUxjSQknx49TPdkpDmp24wR5qUaKTijvoHAsE2ra19IJUtYlFdPhT5q7/xgQm
	 /RITRqV+iGjgwiOtOGUY/xm6lMkfn0ii/YJQPAlrdbVkN8wLyKrSjjc0QdwBb02/Sd
	 JLzhBHxDkt1P4YGZ9jsvuokr5JKk1++I4R03C1VCYFKclhNC7DJ/A4t6ZBCyNIay2r
	 UZiIJ3tYIegUjgTVr473xy9YFIR7TaNYIHRiySt1BuqbCjSgh7Bjre/zxfHCGsedFR
	 1Qyfeo6pxTwuruk6z4hny90YkXr9OTcqn3ojCKGcqWdXsVu8UO6Da6jVgSPJo4au7u
	 Mk4ZoJi7yjz+yFtwgm6A4DOrqXmZsvSXAI0lAATLbSCY6RVUp7/NlXLGF8efIAjUeW
	 CROWXshKKf8NcXaKXTWkofSHUUR0rZHba1YunzeUMSnhpxwqz+WuqJoHjUHgGewrXL
	 YjJ4ZyBB6nZQQoG11m3vT32uQFtnMFAr3OID2CzBE5qt5r6GcujYKexxXiYBIFBmQX
	 FPmGNKqAZdEU398iUruebmhB1a+KfMfp8tVxrXcAWwln/OBSGRJq5qYsebHu3RYmc/
	 I+0AA/+1s65qT5TsMi5VnpM4xIcF1Jl4s9pU7etHXTK8Zc/KxhSz/R9cDJtzI79qHs
	 BhAGexCmTg7wU5dpde6lJN3w=
Received: from [127.0.0.1] (business-24-134-159-81.pool2.vodafone-ip.de [24.134.159.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8240340E01A2;
	Tue, 27 Aug 2024 12:50:43 +0000 (UTC)
Date: Tue, 27 Aug 2024 14:50:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>, Thomas Gleixner <tglx@linutronix.de>
CC: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, tony.luck@intel.com,
 x86@kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 boris.ostrovsky@oracle.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/MCE=3A_Prevent_CPU_offl?=
 =?US-ASCII?Q?ine_for_SMCA_CPUs_with_non-core_banks?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240826132057.GA449322@yaz-khff2.amd.com>
References: <20240821140017.330105-1-yazen.ghannam@amd.com> <87jzg4g8dm.ffs@tglx> <20240826132057.GA449322@yaz-khff2.amd.com>
Message-ID: <9D26E333-B33C-4FD4-9A8F-6F9DC1EC6527@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 26, 2024 3:20:57 PM GMT+02:00, Yazen Ghannam <yazen=2Eghannam@amd=
=2Ecom> wrote:
>On Sun, Aug 25, 2024 at 01:16:37PM +0200, Thomas Gleixner wrote:
>> On Wed, Aug 21 2024 at 09:00, Yazen Ghannam wrote:
>> > Logical CPUs in AMD Scalable MCA (SMCA) systems can manage non-core
>> > banks=2E Each of these banks represents unique and separate hardware
>> > located within the system=2E Each bank is managed by a single logical=
 CPU;
>> > they are not shared=2E Furthermore, the "CPU to MCA bank" assignment
>> > cannot be modified at run time=2E
>> >
>> > The MCE subsystem supports run time CPU hotplug=2E Many vendors have
>> > non-core MCA banks, so MCA settings are not cleared when a CPU is
>> > offlined for these vendors=2E
>> >
>> > Even though the non-core MCA banks remain enabled, MCA errors will no=
t
>> > be handled (reported, cleared, etc=2E) on SMCA systems when the manag=
ing
>> > CPU is offline=2E
>> >
>> > Check if a CPU manages non-core MCA banks and, if so, prevent it from
>> > being taken offline=2E
>>=20
>> Which in turn breaks hibernation and kexec=2E=2E=2E
>>
>
>Right, good point=2E
>
>Maybe this change can apply only to a user-initiated (sysfs) case?
>
>Thanks,
>Yazen
>

Or, you can simply say that the MCE cannot be processed because the user t=
ook the managing CPU offline=2E=20

What is this actually really fixing anyway?
--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

