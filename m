Return-Path: <linux-edac+bounces-4027-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA9DAC73E8
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 00:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9E84E6FAF
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 22:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C038522156A;
	Wed, 28 May 2025 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="fAExKK0q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6322127B
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748470970; cv=none; b=JLxO5LDfb4CfNBFMqlwgjAYS0es0N8XWuxQt03GoK9Km4obm9x3HQYLUgPOhuJD7T8i7xZGB7t7Lu1viYPKcjZf8dHQ11CCmizsWNC2Qo1YcuatY511OAUsVvPB0wIHIioYWTwZmB0yTmd0r+pcPKmUZNUn/dW5hMVRdcVDeY78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748470970; c=relaxed/simple;
	bh=dAYHfQ5ru5UuATgqK7RweIbaHUr9eLZmWvT94xTxoKM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQ3UaluNFHO2RJHQpIsmN1FORHKM0QlcBLwMe93VIJxgHPK22h+3mDOf3Wd1a84+efnHYW0DN3PB7UKUOwTSwc74Ma/SWGzHoIA5yciqsiHaworfX/vxcPaIPgO37QQ2o6oawDtEROaUQ6HZm6jqGxSe3wRV6U44aXH1tf242OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch; spf=pass smtp.mailfrom=protonmail.ch; dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b=fAExKK0q; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1748470958; x=1748730158;
	bh=I7UuwqVfWduJJ9gdI9SObqErEA8S/4oK/jrO6xyK0XY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fAExKK0qTXjHTWrCjyeZgUT0m5QN9RSWgfsQJG1ZEeWJu+i4LGoSY1GKOicj5FPaE
	 y28XQVYftCUblbq/97AZgx7cfsC1A5G5gH2lon/JgYf6nQvn4n1GvzJZPKO/RItay4
	 A14jp02mAvyhQnh0Ht4d9nvpCzekb/1JjJoUCkMNV5dPrvU3ogvUESM3KTSTN1Y+yk
	 cBacww+BXuVn9XKs9Eh9P/boqPAf7J3FMwBQ32CS0O67DN8amEQhkMozpSUbXQaKdP
	 t//oplL0mT0yGKhnJMvRXSBJG2fKvqTWVM5V0PFIy+9ryvZ1L7EBnri6bo3TIcUWVI
	 HxY9o2H645wFw==
Date: Wed, 28 May 2025 22:22:33 +0000
To: Avadhut Naik <avadhut.naik@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, "Naik, Avadhut" <avadnaik@amd.com>, Borislav Petkov <bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>
From: James Blake <jamesedblake@protonmail.ch>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: amd64_edac fails to detect DIMM with only one ECC UDIMM installed (works with two)
Message-ID: <ICqp-rWBvFH6C8JZr5ejYGojRAJBq4aDTIQxeZ4CpJJClm0ORSvW9QjbrefiVG3Sryws_xpBujUiznDwE0UQ5ETrued4QW9i09uxszKcp-I=@protonmail.ch>
In-Reply-To: <Y2t3NVJDekt0_ZKiu49pm_CcUtPa_2P5J7nfX2pDyU6d86s654OzT0-HkAe70ADRKjkQWPTVEeRxe_D1LKBfGWi2bm4rRkN6r4oxN62GMn8=@protonmail.ch>
References: <WWtcG6KurPUuwF9vO6BrD2SXUmU20OYqRPPpbGD9Oxp9ZmB8KvHdFELQ9zURHvcXiF5WE2UdhZwbGlvxVQV82Srwl7B9bMKvxFhBQyPTET0=@protonmail.ch> <20250528164459.GDaDc9i5ngUZlWECaU@fat_crate.local> <c1a5dbb5-3498-4ac3-a278-dfde3f005e6e@amd.com> <20250528175819.GGaDdOuwb-nzE6FfYs@fat_crate.local> <Y2t3NVJDekt0_ZKiu49pm_CcUtPa_2P5J7nfX2pDyU6d86s654OzT0-HkAe70ADRKjkQWPTVEeRxe_D1LKBfGWi2bm4rRkN6r4oxN62GMn8=@protonmail.ch>
Feedback-ID: 7806751:user:proton
X-Pm-Message-ID: e57e0f9ca7af27c0542851232f252b224a7e1f28
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Just wanted to add something I just noticed.

The `dmesg` output from when both DIMMs were installed showed this:

    EDAC MC: UMC0 chip selects:
    EDAC amd64: MC: 0:     0MB 1:     0MB
    EDAC amd64: MC: 2:  8192MB 3:  8192MB
    EDAC MC: UMC1 chip selects:
    EDAC amd64: MC: 0:     0MB 1:     0MB
    EDAC amd64: MC: 2:  8192MB 3:  8192MB

but both installed DIMMs are 32GiB dual-rank, so I expected 16GB per
rank, not 8GB. EDAC is only showing 8GB per rank, totaling 16GB per
DIMM.

So even with both DIMMs present, the driver seems to undercount
capacity. Could this be related to the issue with single-DIMM setup
not being detected at all?

Let me know if I can test anything else or collect more data.

Thanks,
James

