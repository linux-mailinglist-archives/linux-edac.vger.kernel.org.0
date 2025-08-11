Return-Path: <linux-edac+bounces-4548-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E56AB21070
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 17:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E996668507E
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA7F2E54DE;
	Mon, 11 Aug 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lZC6zGWj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7672E54D3;
	Mon, 11 Aug 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926140; cv=none; b=Q2QAHQDjmfA92JvtaDs3xu7td6Yasm3WpgyLQiujqioqEv/IuqRxFzJtDXB7clamT78sc0oFWP3VDHOlAiGHqWI961ybnlf/VNpoUaNAdLlt9BEbNLzGdN2PoQKJPmQaCE/aPWtyRiF7q5ERDfkF/bY64zkc6it0NDNjoz5s0oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926140; c=relaxed/simple;
	bh=k/m6lvsrhx66tVmA9oNvvHDSs/6d366lIs2hxoW219A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nspge/inuqo1fqo7s/i77DL/PV+xzuy+RI0X6oX5ZWY02dw6t5qbw/oB5sR+ez12qcFKCc+xyrbGcvssaq1XIKdBk/v4DUX4G1rjrE611DO/Gf9HtPgfgzsmjctmErYml5JU0tzyXkUaP9cw/AMHoRehs8ykll1jy5DTY3uBsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lZC6zGWj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1018140E0217;
	Mon, 11 Aug 2025 15:28:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xeBqMQ4xZ56G; Mon, 11 Aug 2025 15:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754926127; bh=lAb2hlkPZfqAZ5oWuzo7LQdnJ5lfu4VxJv8CxW4eSIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZC6zGWjMEAOrzyuS+/HRWJJ1Y5enmj8JYL1MKqrjAIrKXnhRlg2pks3w1t1dsm8s
	 VgQX7hQzICo+PlFDtKKfkpeYervMPLDU1LhRUmdYbCvFGkaKprxvff3Mny9tP0tK2v
	 jFLzfDeVcj09bsLeiYZW3ydDPvhP0bOf0qjbjebHvZeEEdxpYt9w+BNODv0evjjCfd
	 qu2Gmm/t8q07TtzWK3Hcx8ljbaxBs6vOK6SnBsavBpWB46ACbgdiCECq9RKYMeT6Yu
	 Rv6X4mZl0SjClJac/fpdhQUjKJWTGsmK3wIQsEIhVRqgtjS+sXYS6s4h0cRPaZjzB2
	 pNr1bPmpciuI3xNvSgW/dh223zY92QujuDd0lBtF/D1tu0iCfgwLJVJDlGAEaZKUAy
	 qnJlAojA8dd2jiRnG3g52vs5QkI3tnJ5ImVf/utDnXdsOqcHcsdTwGsgmCpCL3w6kF
	 aYsQW7HTUQC+mNq/ySVjmhhEGcv9t0QWKVbSs97sbSzHcemNCpgivFTEyEWpPGoJZ3
	 PRsCJ7tZ27OiTfdgQHeKb5EUbHLX4AdEkqkM/5y/BpenmCMbmeZSbPbI5PJOKvtyB+
	 NDA8ZPylW9J5ncjOHY3xdti3LjniPgMVCo9TpAU5cT4tmQNkN2NImOEP0Ndd8yyN8r
	 bCYs0gIfNWAyVOOWrYpT03oQ=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 561AA40E023B;
	Mon, 11 Aug 2025 15:28:11 +0000 (UTC)
Date: Mon, 11 Aug 2025 17:28:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jonathan.cameron@huawei.com, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v10 1/3] mm: Add node_to_range lookup facility to
 numa_memblks
Message-ID: <20250811152805.GQaJoMBecC4DSDtTAu@fat_crate.local>
References: <20250801172040.2175-1-shiju.jose@huawei.com>
 <20250801172040.2175-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801172040.2175-2-shiju.jose@huawei.com>

On Fri, Aug 01, 2025 at 06:20:27PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Lookup facility to retrieve memory phys lowest continuous range for
			
A commit message is not code. Please write it for humans.

> a NUMA node is required in the numa_memblks for the ACPI RAS2 memory
> scrub use case.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  include/linux/numa.h         | 10 ++++++++++
>  include/linux/numa_memblks.h |  2 ++
>  mm/numa.c                    | 10 ++++++++++
>  mm/numa_memblks.c            | 23 +++++++++++++++++++++++
>  4 files changed, 45 insertions(+)

...

> +static int nid_to_meminfo(struct numa_meminfo *mi, int nid, u64 *start, u64 *end)

This function name sounds like it converts a node ID to meminfo. But it
doesn't do that.

> +{
> +	int i;
> +
> +	if (!numa_valid_node(nid))
> +		return -EINVAL;
> +
> +	for (i = 0; i < mi->nr_blks; i++) {
> +		if (mi->blk[i].nid == nid) {
> +			*start = mi->blk[i].start;
> +			*end = mi->blk[i].end;

It looks like it returns the start and end range of a node ID.

> +			return 0;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +int node_to_phys_lowest_continuous_range(int nid, u64 *start, u64 *end)
> +{
> +	return nid_to_meminfo(&numa_meminfo, nid, start, end);

Where is the "lowest" thing here?

And where is the "continuous" thing?

This thing simply hides the struct numa_meminfo from the exported interface.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

