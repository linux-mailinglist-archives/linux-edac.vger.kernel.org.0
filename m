Return-Path: <linux-edac+bounces-2309-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5865F9B1432
	for <lists+linux-edac@lfdr.de>; Sat, 26 Oct 2024 04:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9692E2834ED
	for <lists+linux-edac@lfdr.de>; Sat, 26 Oct 2024 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FEE524B0;
	Sat, 26 Oct 2024 02:36:01 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253B38BEE;
	Sat, 26 Oct 2024 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729910161; cv=none; b=PkEjNf37uW6otQMpSIHRH5Gc8iwg84RjlbcS/Ynz0F5qzPHAcFouZO2zMAgLQgPKVkezfMrXYmoEdng3koN1WDDkS9ZzUf5Pd650Keq6JEY4PnNCBaSOc2zSVfIg3LPtXrKFAR5VHUoBaOBBLQl0oojOghmK7n0i1LJu1ifSjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729910161; c=relaxed/simple;
	bh=5VzqQYiFTqWdVR/BEz9nBahuRpJ2t95mYX1tQTP1yZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h5KTcx+mB683y+38/dsTuBNwOtA2VU+hZu0gHD67l+fV+rtWhXVkiLXm/ROF9EUCoWRxG2eT1ac75oVVhNEcW8YPusn0z7uI/LTCUvRtckjSKEqIbhvNT0KSat2etvz8QEAmRS9WOF9hwlB097ZFvakpaaDZV3d/35MXiAlUK2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 49Q2XVCU030871;
	Fri, 25 Oct 2024 21:33:32 -0500
Message-ID: <7080ee37ce53d5559ba85f72a0ff59b4bc5a083d.camel@kernel.crashing.org>
Subject: Re: WARNING in lmce_supported() during reboot.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Hansen <dave.hansen@intel.com>,
        Kuniyuki Iwashima
 <kuniyu@amazon.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen
	 <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Alex Graf
	 <graf@amazon.de>
Date: Sat, 26 Oct 2024 13:33:30 +1100
In-Reply-To: <e1c50570-1b5b-40d2-bab3-05e9ead51a57@intel.com>
References: <20241025231320.45417-1-kuniyu@amazon.com>
	 <e1c50570-1b5b-40d2-bab3-05e9ead51a57@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-25 at 16:58 -0700, Dave Hansen wrote:
>=20
> Hi Folks,
>=20
> We really do need it to be reproduced on mainline.=C2=A0 At the very leas=
t,
> it would be greatly appreciated if you could summarize what your fork is
> doing and why you don't think it is responsible.
>=20
> But I don't see how this could be timing related.=C2=A0 That MSR gets loc=
ked
> early from what I can tell, long before the system would be rebooting.
>=20
> Your best bet is going to be getting a handle on what
> MSR_IA32_FEAT_CTL's value was after the CPU was brought up and when this
> reboot was attempted.=C2=A0 If those values differ, when it got changed.
>=20
> I'd _suspect_ some kind of BIOS sleep/wakeup wonkiness where something
> forgot to re-lock the MSR.

So far we just happened to notice it in the serial console while doing
other things, I told Kuniyuki to forward it to you in case it rings a
bell. We can definitely do some more systematic attempts at reproducing
but that might take a while.

For me it happened once while rebooting a c5d.4xlarge instance, and not
since (I tried a few reboots), so it could well be something BIOS related
(CC'ing Alex).

This is a KVM/Nitro guest, so the CPU is somewhat virtualized, but
/proc/cpuinfo says: Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00GHz

Cheers,
Ben.

