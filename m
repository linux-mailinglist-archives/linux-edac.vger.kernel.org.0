Return-Path: <linux-edac+bounces-1743-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C97963ECB
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 10:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CA01C21B2C
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3101F181328;
	Thu, 29 Aug 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AUhNEcMt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D433D6A;
	Thu, 29 Aug 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920801; cv=none; b=jAM5HOe1pxIGDh2x5vZ6y630VWf5u97w8SggaO4EEtCmtMBw6o2A3y16zESv7rnC8YwpVSvzznzCkIO5F/5vQjYzNJPe5ASVnUUdLQUC37Yn53/ofm88o14RDaddYnMJSex2H7PvmYSSPklNf1iidjFpfTwRvMnJgZUSuUxA2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920801; c=relaxed/simple;
	bh=FyjX4kcH5LavAMmhOmNvR8SALI7vKJuOwonjdbQiaLU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aMrHwsF0LqdkcOcG/v/joJovKqdRL7LfVuDPU1+RaTvE2Xwv5O3+jpmUQTm1LQeBzqg7rzfpcpnBiLgc9aTVxmRIaspFaMIqmzUR/kmr+XsQ9Ckr2LlcLU8Q6m9OpYJxG9vkAsaEtQMI5VD82Z8JI13g8i/YmlA4mITlwc7t7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AUhNEcMt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2D99D40E0184;
	Thu, 29 Aug 2024 08:39:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ITKrumJMBXou; Thu, 29 Aug 2024 08:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724920793; bh=tqRMih8maOqhgAUQosY7U14hqRXwiLtPrj0M9xoEAXM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=AUhNEcMtcPtYT++FFWUCR2JVvFBPPnytDRBwzSx0y/pXWKtybnWe6pSkSrB0F4fWz
	 3EhbGD/grLQjmAZY4ATWshzZ4NNMS2JSWIOs6/SPRn8ulOy47grVfKNXj295QfxuCQ
	 5OWEd2o1/h5ang6FzaXQNwYJIuRaGeOpxk3UPlfKTN9fyj/02vIk3thHafp/EnBJpD
	 ulGZNxYu2EJc7Yx8jp96KGLBifjDg0DOfxiIH+hPBQEr6KyTZA+qWZ0zuQWDyixrZg
	 buUQwCUTaYLvOF1SzfcbJsBG4CPYm3BCt2z55sGOGYep+QWPGdj5dMvH/3ASb5kmCy
	 JG4C8Nj5hVdTCsd6m5We7DBAQtDK3QS2CglE9YKs0iuyYR/ltxqn9FrJeBmR2WZ8V0
	 fssdOVSQabXjy1hENJL46oOrp3EmzMVC0M+2mhT6AKzlkMha8m1zHi4HwgLVIcQiF+
	 q7y7hB0RmM3VA9E1sGTxu8HtPh/lTwFJbRRO6XRUSosg73IHDmCuBje8gGUgrM6+fd
	 8pGIOeMrpQcnAbtHnVMMn6Kti/y2PfzQeyr3kLoAPTRBMr6ceJeafkM8KXNB7zy5IM
	 zlRC3njZScFO0Qx67SlOlws3BVImF4Zy00qt6yXk/pIryJvq+J1pkrsrMEATjZSbT9
	 SVghbv6oJSzXXuFNOQWLWTX4=
Received: from [127.0.0.1] (business-24-134-159-81.pool2.vodafone-ip.de [24.134.159.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36B4840E025E;
	Thu, 29 Aug 2024 08:39:43 +0000 (UTC)
Date: Thu, 29 Aug 2024 10:39:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com, boris.ostrovsky@oracle.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/MCE=3A_Prevent_CPU_offl?=
 =?US-ASCII?Q?ine_for_SMCA_CPUs_with_non-core_banks?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240827134706.GA719384@yaz-khff2.amd.com>
References: <20240821140017.330105-1-yazen.ghannam@amd.com> <87jzg4g8dm.ffs@tglx> <20240826132057.GA449322@yaz-khff2.amd.com> <9D26E333-B33C-4FD4-9A8F-6F9DC1EC6527@alien8.de> <20240827134706.GA719384@yaz-khff2.amd.com>
Message-ID: <7D571DAA-E399-4580-98B3-8A6E7085CB54@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 27, 2024 3:47:06 PM GMT+02:00, Yazen Ghannam <yazen=2Eghannam@amd=
=2Ecom> wrote:
>On Tue, Aug 27, 2024 at 02:50:40PM +0200, Borislav Petkov wrote:
>> On August 26, 2024 3:20:57 PM GMT+02:00, Yazen Ghannam <yazen=2Eghannam=
@amd=2Ecom> wrote:
>> >On Sun, Aug 25, 2024 at 01:16:37PM +0200, Thomas Gleixner wrote:
>> >> On Wed, Aug 21 2024 at 09:00, Yazen Ghannam wrote:
>> >> > Logical CPUs in AMD Scalable MCA (SMCA) systems can manage non-cor=
e
>> >> > banks=2E Each of these banks represents unique and separate hardwa=
re
>> >> > located within the system=2E Each bank is managed by a single logi=
cal CPU;
>> >> > they are not shared=2E Furthermore, the "CPU to MCA bank" assignme=
nt
>> >> > cannot be modified at run time=2E
>> >> >
>> >> > The MCE subsystem supports run time CPU hotplug=2E Many vendors ha=
ve
>> >> > non-core MCA banks, so MCA settings are not cleared when a CPU is
>> >> > offlined for these vendors=2E
>> >> >
>> >> > Even though the non-core MCA banks remain enabled, MCA errors will=
 not
>> >> > be handled (reported, cleared, etc=2E) on SMCA systems when the ma=
naging
>> >> > CPU is offline=2E
>> >> >
>> >> > Check if a CPU manages non-core MCA banks and, if so, prevent it f=
rom
>> >> > being taken offline=2E
>> >>=20
>> >> Which in turn breaks hibernation and kexec=2E=2E=2E
>> >>
>> >
>> >Right, good point=2E
>> >
>> >Maybe this change can apply only to a user-initiated (sysfs) case?
>> >
>> >Thanks,
>> >Yazen
>> >
>>=20
>> Or, you can simply say that the MCE cannot be processed because the use=
r took the managing CPU offline=2E=20
>>
>
>I found that we can not populate the "cpuN/online" file=2E This would
>prevent a user from offlining a CPU, but it shouldn't prevent the system
>from doing what it needs=2E
>
>This is already done for CPU0, and other cases I think=2E
>
>> What is this actually really fixing anyway?
>
>There are times where a user wants to take CPUs offline due to software
>licensing=2E And this would prevent the user from unintentionally
>offlining CPUs that would affect MCA handling=2E
>
>Thanks,
>Yazen

If the user offlines CPUs and some MCEs cannot be handled as a result, the=
n that's her/his problem, no?

- Why does it hurt when I do this?=20
- Well, don't do that then=2E
--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

