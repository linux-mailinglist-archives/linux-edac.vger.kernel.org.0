Return-Path: <linux-edac+bounces-2334-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF1E9B533A
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 21:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE9F1C2273E
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 20:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E412076B8;
	Tue, 29 Oct 2024 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WtrXCNON"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E1192B74;
	Tue, 29 Oct 2024 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233070; cv=none; b=NtMCCzoQOTyJ+eSjnWKX2km6PxQ47jRMBbmPagFP8jWe0Eu1iPgNTbVI4qgxrhHYrLwhyZAid6PJ3eYXZsluanFWDDqf3w7OBoEH0zydh8F/Oj2kGT/joRvFFfJ473ern+eduWcsohR5okd+6sOXBvOw8SNCQheXudnO1Pdn6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233070; c=relaxed/simple;
	bh=lpF1FH5htYFOXY/Idzz1zLDZrJhZzRcJYJ0Ick8zjHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnxc3HDh2lNfdB5ueAyICcN1sqKKyGfxvPCyE7I57teKPlkEcgK7AD+u8c1A+t97VyFwU6Wjbv11oagNq7318tNbVsOKAa/XKeGcq/u7guZF2rc/qTB1m+xNs7xJgGYspg0PjSzQNSfKWU2B5KBqRQcK6KSmNtRwRFBUBzW9HvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WtrXCNON; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C4F1340E019C;
	Tue, 29 Oct 2024 20:17:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sqKU2Tb99XT3; Tue, 29 Oct 2024 20:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730233061; bh=0uW2zlC1ihYtO0OcF3C3xiKfjDd5F42y2TO4oXhNm2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtrXCNONB3NiWGHSz87nT5Rv42GflySaMbL/0xtL7RXSFsYxGdERFlTWU7ugPdy3D
	 8fv8E/2NGeB0gExiGRZlf3kFqr6NA1tekfK6Hii04Io9JEBi8a6nNJy40hHUWP/yw0
	 FXr9RET8xWpum1JgLx/FBeB3r0vFXcTJjrucOLXWitcdyFKRoCrUfRkh9R+vHm5IOP
	 KwWhttm0JTekc4scNgt4tCuDFa622K4T0tfbppk4F6j97xHE2/wPImKa+HHPW4VH3i
	 HB5zC2un/SoOp6UZe1qTi2Lm/ph7h+HbKw2cLPhybrsrzVBgfqBRhd9rWi2Bo0jWE0
	 pGr3UyjoXcGvThSbFkSWZi2jkAvrcUtVtBkNWpKKBX2jrZJOZTDOZZHBj4KrZ/otk7
	 PqwF+l+LdtSrve8O7UbIQltIbiKv17tk7YigsF23+i4hA2l9cWA+yLSNTbtJi8oxgM
	 nhuCXIJ91uQcOXupyLfN6IQyRupRmZjSFSYA3gyMM72rMMnHb+Cu1uWoKXvjQPDxP6
	 cMF7/yfY1CFU5tcnRA8c1rjsh+5d9GZgwy2d8ThCV6dq3QIzvRR6t4hLkf52V0OfLU
	 y/rwOSqswya8dGL3yGzKTbuRNzV0pScWlpfaiA8S84+Mzoi7euigRx/XY++qkqyDMi
	 gxhQXIDidioyOk5zmSHiYMg0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A418940E015E;
	Tue, 29 Oct 2024 20:16:54 +0000 (UTC)
Date: Tue, 29 Oct 2024 21:16:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, gregkh@linuxfoundation.org,
	sudeep.holla@arm.com, jassisinghbrar@gmail.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH v14 07/14] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Message-ID: <20241029201653.GBZyFCtVpb3V4CcgKe@fat_crate.local>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
 <20241025171356.1377-8-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025171356.1377-8-shiju.jose@huawei.com>

On Fri, Oct 25, 2024 at 06:13:48PM +0100, shiju.jose@huawei.com wrote:
> +:Original Reviewers:
> +
> +- Written for: 6.13
> +- Updated for:

What are those supposed to mean?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

