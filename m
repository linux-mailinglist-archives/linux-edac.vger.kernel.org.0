Return-Path: <linux-edac+bounces-4647-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E750CB32FEF
	for <lists+linux-edac@lfdr.de>; Sun, 24 Aug 2025 14:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69F81B282F3
	for <lists+linux-edac@lfdr.de>; Sun, 24 Aug 2025 12:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7D62D97BD;
	Sun, 24 Aug 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyqoXjGA"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E12D8767;
	Sun, 24 Aug 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756039341; cv=none; b=riuuDgp8rzbLevAyPPdAgHbmUgTFgAfHZXr7QYw/A4us+wBSthUdu9PTF9gf6cWuOioF8HleKkEeESvAkfs08Zt31waAEn4zhhuZ9GuffsIYW2LC3LB61qzRTZ4bYxqS3ZHow8CI6rhF1hV426URD+/woYU2NozRzhH2zjAzq6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756039341; c=relaxed/simple;
	bh=fgE9N+AYCjPOSPrePisRrj1q6mfYGGRAmhs42H4A6SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpSeRN0kOeu8Sh/DeiTvodo0/9X+o5S8vt76iVuPtkgmR5XOpD6YaBKS3mnOvLuSQ5IEHv0EEej2RR6lGpI791Vk4Q6nvKuRFpyNlh0yQcHSZDpbONm2BpWoJh55Oa90pMGYq6wXGs9nb2fhJ1ezXJQAkz4BindB+BruGStJius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyqoXjGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDDDC4CEEB;
	Sun, 24 Aug 2025 12:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756039340;
	bh=fgE9N+AYCjPOSPrePisRrj1q6mfYGGRAmhs42H4A6SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EyqoXjGAqD7Ft2DTzF13ZUNQUS7p7ngkaULch92MqALZNzaXl2HYTjld3QG7MCa5Y
	 6Fokf1LN8QYy7rN93opIebIPDryYAtXagq7tMSonj6QETbaLmoXvnCMP/9RgWxkfNe
	 J+Ervf1uo8rhuATE7eudeoUatNmEQE9L6FD4/nV63eaDEtN4rYgo5PWfSMxCD5mPvu
	 WBpSpfz1lb6Xv0PDqfggAwK4DXHBJAjOt0Rj4Vp3ayPCKWa5NZFrb+UB+Sr7xgv9Pn
	 9atqld7wGCCme9dEfzhRSQBl1c46HiZjVoyB6WeYGaEGIMqgi1Fl+2RNycYdKqAng2
	 Hwt5j8L5H8Lew==
Date: Sun, 24 Aug 2025 15:41:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	Linuxarm <linuxarm@huawei.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	Somasundaram A <somasundaram.a@hpe.com>,
	"Aktas, Erdem" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH v11 1/3] mm: Add support to retrieve physical address
 range of memory from the node ID
Message-ID: <aKsIlFTkBsAF5sqD@kernel.org>
References: <20250812142616.2330-1-shiju.jose@huawei.com>
 <20250812142616.2330-2-shiju.jose@huawei.com>
 <20250819175420.00007ce6@huawei.com>
 <aKV6dVkPiBPw595T@kernel.org>
 <20250820095413.00003bd7@huawei.com>
 <964fc2721fb7499daa5f49eddfed54ff@huawei.com>
 <aKX_rk0DasbDgJrS@kernel.org>
 <20250821100655.00003942@huawei.com>
 <DS7PR11MB6077843C9E2FFA811971BAA7FC32A@DS7PR11MB6077.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR11MB6077843C9E2FFA811971BAA7FC32A@DS7PR11MB6077.namprd11.prod.outlook.com>

On Thu, Aug 21, 2025 at 04:16:02PM +0000, Luck, Tony wrote:
> > > I believe that's because on x86 the node 0 is really scrambled because of
> > > e820/efi reservations that never make it to memblock.
> >
> > Fun question of whether we should take any notice of those.
> > Would depend on whether anyone's scrub firmware gets confused if we scrub
> > them and they aren't backed by memory.  If they are we can rely on system
> > constraints refusing to scrub that stuff at an 'unsafe' level and if we
> > set it higher than it otherwise would be only possibility is we see earlier
> > error detections in those and have to deal with them.
> 
> Yes. On x86 the physical memory map below 4GB is a bunch of address
> ranges with varying properties:
> 
> 1) There's the "low" MMIO region (often 2G to very nearly 4G) where 32-bit
>    PCI devices have device BAR ranges mapped. Some of this isn't memory
>    at all. It's device registers that may have side effects when read. I don't think
>    the x86 patrol scrubbers can access this at all.
> 2) There's EFI allocated memory that is accessible to the OS (e.g. ACPI tables)
> 3) There's BIOS protected memory for use by SMI that the OS can't access at all
> 4) There are ranges listed in E820 or efi_memory_map that are usable by OS.

There is a slight problem here with getting the first contiguous range from
a node to seed the scrubber.
If we use PXM, the range for node 0 will usually cover the entire node
including types 1 and 3. And if we take it from memblock, it does not include
type 2, or anything reserved in e820/efi.
 
> What is the use case for OS control of the patrol scrubbers?
> 
> While you might want to specifically scrub some range to make sure there
> are no lurking problems before allocating to some important process/guest,
> I'd expect that you'd want to make sure that types 2 & 3 listed above still
> get a periodic scan to clean up single bit errors.
> 
> -Tony

-- 
Sincerely yours,
Mike.

