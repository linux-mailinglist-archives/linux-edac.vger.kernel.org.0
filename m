Return-Path: <linux-edac+bounces-2850-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7104CA07152
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 10:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB361882D56
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2025 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A005215063;
	Thu,  9 Jan 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hKgpMKJ2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87F20409B;
	Thu,  9 Jan 2025 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414416; cv=none; b=PeQMqtQaArYsRqPkpueIWCIrOKKMaFwCYiXjdEvSEcyY5fy7kqu336O481pH9gcDiDA7Zg1+7dLknf9PkHz4avQy03AyC2DPKIAJxxsv16YU9a2LxyH6WlfWtrmXC7LhT4v3KdRODv5dLeEhkGFXccnLhzGJWYrfAaFBJvcnAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414416; c=relaxed/simple;
	bh=DSekVNnU9bNNLJoMnzH7oBnrcvwVSWUmhIFOwagR6qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2xBCHWOCB5cpvTLhlkbn2nm4lOKMORDhJn8gxrfYwEgO34G8Y0gpcQhml2gW06+7WQaclxUJ8mf4KOrIyCyKcWPeRNpISL0nUUKGfD0m6WEQW7uUxIAYl+s5I591rBdyCPj3ZB7gHHLxP6U0xBIr0CfnB+EEiA8htZVHo4XM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hKgpMKJ2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BEAEB40E0289;
	Thu,  9 Jan 2025 09:20:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l-d59qMPqdD8; Thu,  9 Jan 2025 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1736414405; bh=LD6Fod+6Pr95sk9Mi4pDaHYRb4hj3jfrssJ789s5mN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKgpMKJ2nNwD+QLd9aQPpp2hi/PyZjEg14CxdVWJCaSEaeSXnOR8USnWk5GrJOTC5
	 dexMAGS/rpcQT1WLSPHx93W+k2hZ9hHW6JR3vY/Okxq6ZOVZaoLETIkCXJl7NMOgf6
	 jhFdnrARkqoaC6pqm+BcTMAdJ/zyNzxhDbFDfXhsBdw0ztoGYY4pbgwzfxIDWUbcUq
	 +B6/icQkLUwmgkuJGqULBRouhIXbilK3SNlO2aWW5jTAvAK9zOO10sW3jsS1CRZHyU
	 mcWFnMgUPvOq+A8Gd1DOsdFQt/m+2WSPSgS7P6bIMbKHcTWKZLqrxiziHtQgsXNQSg
	 UwNGv9C66DpAlE095fu1ZECkV80rddlpErX4eJm0eV7dDd2vE+tdavqghKTydY82vy
	 IYJncSGhprtrUNB08V9WE1DpPTtZqwHK3C/1Yqzo17SY6RR7GNDwYN81graPzon8Bj
	 kvl1w/5Q/z8TJgajQUHStgeXjartB/+lnAWLYpbqTYYhikK+I9WhQH8H+WFqHqs7kz
	 bpB3/4RHyMaX2ewh5aoGk/UcIboxAh5dF0Y3/cJrXE7CBbKeJDUx8PcE6+LYex4f7K
	 7gjP8S6v3WVjIXS5tqszGKip43wgfhp5jja6UT4SIzLQomtjqY0nKk2OCMsh3lZSLO
	 Q7NXVdDO10VcMT1lCc+Matb8=
Received: from zn.tnic (p200300ea971f938f329c23fFFea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:938f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D30E740E01F9;
	Thu,  9 Jan 2025 09:19:21 +0000 (UTC)
Date: Thu, 9 Jan 2025 10:19:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-5-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106121017.1620-5-shiju.jose@huawei.com>

On Mon, Jan 06, 2025 at 12:10:00PM +0000, shiju.jose@huawei.com wrote:
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_hpa
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_dpa
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_nibble_mask
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_bank_group
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_bank
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_rank
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_row
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_column
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_channel
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/min_sub_channel
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_hpa
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_dpa
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_nibble_mask
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_bank_group
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_bank
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_rank
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_row
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_column
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_channel
> +What:		/sys/bus/edac/devices/<dev-name>/mem_repairX/max_sub_channel

So this is new. I don't remember seeing that when I looked at your patches
the last time.

Looks like you have all those attributes and now you've decided to add a min
and max for each one, in addition. And UI-wise it is a madness as there are
gazillion single-value files now.

"Attributes should be ASCII text files, preferably with only one value per
file. It is noted that it may not be efficient to contain only one value per
file, so it is socially acceptable to express an array of values of the same
type."

So you don't need those - you can simply express each attribute as a range:

echo "1:2" > /sys/bus/edac/devices/<dev-name>/mem_repairX/bank

or if you wanna scrub only one bank:

echo "1:1" > /sys/bus/edac/devices/<dev-name>/mem_repairX/bank

What is the use case of that thing?

Someone might find it useful so let's add it preemptively?

Pfff.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

