Return-Path: <linux-edac+bounces-4306-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B8AF77A0
	for <lists+linux-edac@lfdr.de>; Thu,  3 Jul 2025 16:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240B3483FC8
	for <lists+linux-edac@lfdr.de>; Thu,  3 Jul 2025 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8D52EA730;
	Thu,  3 Jul 2025 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="dQkmCEKn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C602EE26B
	for <linux-edac@vger.kernel.org>; Thu,  3 Jul 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553235; cv=none; b=j7bn8e0bGqnfgIXE8uG7qbCLiZhIVRovjOy21FCVNa3nADhHeeq52+P714tfn+yda5gwdsp/Rkv80CHOuFNyvU6JWTli80N2zvNKRxj9D0UNFdZxy4ohFhV5w+LqHB12j1TuM61yOHluBakbsYFbNsK++aGyfx6t1zRoPy9gwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553235; c=relaxed/simple;
	bh=7SERIWSBv4WQ77wc9R0LAcvGvloEOnJz8GNffoue04E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tC1MBw0O3vKTmmYn4G+T+nYTSGhDRe+rCMCpinepnblnl7H3kJXaqDPmMVN9iuj2VAJSepuVadUN3kjIxiHA/sUtijsn6PSkE8iqzAyGjGdfdU9fR7OXn3F904GgHxXZbSqTB9lg/lya01vYWXLldXmXymbGclw+U6buvUfx03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch; spf=pass smtp.mailfrom=protonmail.ch; dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b=dQkmCEKn; arc=none smtp.client-ip=109.224.244.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1751553226; x=1751812426;
	bh=YQZFJwsGVlFIn6WOJaEQ2Dz0AO+3ykf1TlA6gzkfRRs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dQkmCEKnqhpbgq0LJx3gkf3R4E+K1EXZrCAU0ujRVz4e16lvmRxakFlJjzt1HalWU
	 q3M6CxMH+LYr5QXgcPRoLM7yYzIV+s23n7/bhmwohtiQK5DFoGm/m7sozc0mgWMB6Y
	 4/zI1H4s7s5mG8mIM1W90/O1h8m04B9Ncp9XyedOi9rAHrwsAJ8+tXg+xSIfnWeVzw
	 hFY7OhKKdn9G0NI2du0hXCtCv5HGASWPvclIQd7urlt4vUB9cy5e6hISyoYeveX8N+
	 HRSxTYAFkjlXBxT50HG3F+YSWMCfwAgO+0fUP/Y7k/3CqaxtXwbyLTHrYiATE7QIFm
	 8LIbdG5gIEs1Q==
Date: Thu, 03 Jul 2025 14:33:42 +0000
To: "Naik, Avadhut" <avadnaik@amd.com>
From: James Blake <jamesedblake@protonmail.ch>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, "tony.luck@intel.com" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: amd64_edac fails to detect DIMM with only one ECC UDIMM installed (works with two)
Message-ID: <aslwygWCw5z_nOMYqQhOKIA-Q5ULLr8kyjFw2l2N5w2A335UbSHKWfdlwBC0eejJCy7Lan5Hzp-4rOirHr0qhL37XFVo5Y5ZAS0wfeZZCLA=@protonmail.ch>
In-Reply-To: <7c2641be-5de0-4dca-9e19-d95338a4528b@amd.com>
References: <WWtcG6KurPUuwF9vO6BrD2SXUmU20OYqRPPpbGD9Oxp9ZmB8KvHdFELQ9zURHvcXiF5WE2UdhZwbGlvxVQV82Srwl7B9bMKvxFhBQyPTET0=@protonmail.ch> <20250528164459.GDaDc9i5ngUZlWECaU@fat_crate.local> <c1a5dbb5-3498-4ac3-a278-dfde3f005e6e@amd.com> <20250528175819.GGaDdOuwb-nzE6FfYs@fat_crate.local> <Y2t3NVJDekt0_ZKiu49pm_CcUtPa_2P5J7nfX2pDyU6d86s654OzT0-HkAe70ADRKjkQWPTVEeRxe_D1LKBfGWi2bm4rRkN6r4oxN62GMn8=@protonmail.ch> <ICqp-rWBvFH6C8JZr5ejYGojRAJBq4aDTIQxeZ4CpJJClm0ORSvW9QjbrefiVG3Sryws_xpBujUiznDwE0UQ5ETrued4QW9i09uxszKcp-I=@protonmail.ch> <7c2641be-5de0-4dca-9e19-d95338a4528b@amd.com>
Feedback-ID: 7806751:user:proton
X-Pm-Message-ID: 922494d3758dc77f0d60634ea1688eccd7f14949
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I also apologize for the delayed response, I completely missed your
last message. The patch you linked has been added into stable if I'm
not mistaken and I tested it right now on 6.15.4. EDAC's output in
dmesg has now changed to this:

    EDAC MC: UMC0 chip selects:
    EDAC amd64: MC: 0:     0MB 1:     0MB
    EDAC amd64: MC: 2:  8192MB 3:  8192MB
    EDAC MC: UMC1 chip selects:
    EDAC amd64: MC: 0:     0MB 1:     0MB
    EDAC amd64: MC: 2:  8192MB 3:  8192MB
    EDAC MC: UMC2 chip selects:
    EDAC amd64: MC: 0:     0MB 1:     0MB
    EDAC amd64: MC: 2:  8192MB 3:  8192MB
    EDAC MC: UMC3 chip selects:
    EDAC amd64: MC: 0:     0MB 1:     0MB
    EDAC amd64: MC: 2:  8192MB 3:  8192MB

If I understood this correctly, it's now reporting 4 dual rank DIMMs
with 16GB per DIMM (8GB per rank) instead of 32GB. It's also reporting
4 channels while the motherboard has dual channel memory, not quad
channel. Am I correct?

Thanks,
James

