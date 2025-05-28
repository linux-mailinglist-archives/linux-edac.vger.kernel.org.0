Return-Path: <linux-edac+bounces-4025-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CBAAC711D
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 20:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBE3164936
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F85528E568;
	Wed, 28 May 2025 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="ZKRNnYxC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C328DF44
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457784; cv=none; b=KAO8uE0r2phqZob/3ZLNOoPo+jem7xK+8Ic8k38jKw32IwiJRDzxcyyFTvfs1ACm0sN+DdrhuczgM7C1h3l4rPiFCtwEwoqfXT8C5dd+fX8DAp0r+MGNksS4/RDYF9M7rlptP2VpTpA7RHUK2wkgN4CwuoC014qOhOT0tJjepj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457784; c=relaxed/simple;
	bh=jntVLKTM3Z8zsdQeFsvyPHs6pmCJ6uSt3SsCwkKzrOg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVwO7DyqP+OMgCuEHdgevas28yOn+hKNpEm9ZU059EPVZhxoplPF/0AUHCaiw+NEY6uHIUfoJiXpKMCC67ukJD4pCgpIimqHAh+ysTp5JOGYKz8iBL7wz7DjsKfPD1FfdfEx7oBFxSRDr7I1aQKp8AME6Le6Jk2xKT7jNCmSC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch; spf=pass smtp.mailfrom=protonmail.ch; dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b=ZKRNnYxC; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1748457767; x=1748716967;
	bh=jntVLKTM3Z8zsdQeFsvyPHs6pmCJ6uSt3SsCwkKzrOg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ZKRNnYxCkGW3J5G/1K9805mSnqKCRn55nnnFmgiY5Pq+U+Gs5b8lPH0WIA9FMidNt
	 jhNneAlvSUTbFwcUokIL14VcbA7o/pTHERXJxSKiNbU5RJad/QoAmQUYxACwReCh7M
	 9L1BTMNdkX7dG6OxtS5FvakWW3tQZZPAwHh1SXeGv7am6BDWprWAzh4CeKkV35i5L8
	 iec1PU495w2I9Ig95omkP4YnFd8ml0/fCcU4zQRLs9/q9aAXVCzd9iAk922BC2sSIV
	 60DMm7DN5Ih8ABhhpeOwkE4cRGeqCqO3QmrBWbIBJp7z8y0OLbmlD2+OvI1BXp2CvR
	 ubrN9sEys/cjw==
Date: Wed, 28 May 2025 18:42:41 +0000
To: Avadhut Naik <avadhut.naik@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, "Naik, Avadhut" <avadnaik@amd.com>, Borislav Petkov <bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>
From: James Blake <jamesedblake@protonmail.ch>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: amd64_edac fails to detect DIMM with only one ECC UDIMM installed (works with two)
Message-ID: <Y2t3NVJDekt0_ZKiu49pm_CcUtPa_2P5J7nfX2pDyU6d86s654OzT0-HkAe70ADRKjkQWPTVEeRxe_D1LKBfGWi2bm4rRkN6r4oxN62GMn8=@protonmail.ch>
In-Reply-To: <20250528175819.GGaDdOuwb-nzE6FfYs@fat_crate.local>
References: <WWtcG6KurPUuwF9vO6BrD2SXUmU20OYqRPPpbGD9Oxp9ZmB8KvHdFELQ9zURHvcXiF5WE2UdhZwbGlvxVQV82Srwl7B9bMKvxFhBQyPTET0=@protonmail.ch> <20250528164459.GDaDc9i5ngUZlWECaU@fat_crate.local> <c1a5dbb5-3498-4ac3-a278-dfde3f005e6e@amd.com> <20250528175819.GGaDdOuwb-nzE6FfYs@fat_crate.local>
Feedback-ID: 7806751:user:proton
X-Pm-Message-ID: 590847f9baff2701894cc489254ee0635e2b921e
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I just tried building the patched `amd64_edac.c` and loading it with `insmo=
d`. In both cases it seems to behave the same as the original. With two DIM=
Ms it works properly and with a single DIMM I get `EDAC amd64: Node 0: No D=
IMMs detected.`.

I also tried putting a single DIMM in the A2 slot instead (where I would ad=
d the second DIMM) and then it does work with the unpatched module. I put i=
t in the B2 slot before since that's the recommended configuration in the m=
otherboard manual.

