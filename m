Return-Path: <linux-edac+bounces-2895-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F1A1072F
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 13:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88A818867E4
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B1234CF9;
	Tue, 14 Jan 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUE/nr6Y"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B4229627;
	Tue, 14 Jan 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859476; cv=none; b=oshXOi4GvAsvHRlxcqBjxMj6rkwDYN2arI690tlHE1Df/m8HH2sjOoFJSjNBfh3W/rhb13rtCVRyQkozSD55S6y8Uw+hBJ3pVPnEcB425V82j1GJELwMwzAvvaAAXozCmFZgsOY9NMVxDabxTuJbyYYTmtCKcELHrW1NviNcJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859476; c=relaxed/simple;
	bh=TeCqkUf9U8u8664JbtiG8nCrJnAMZRQuIJXO6gvHTG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnjzpuTrHU5h+frigwtSYRA9dwMYohvZpbTW4I0zUsr3TKoAHXYuvWKWzVLd9v6sKqdQ3HMwXWJusKC2Rrez/g6VCRZ382MRXlBk8uMlrlR0ozFlRWEL5tEg7VrPb4g7HrTB/BRQDBKP49Z4Fx/H5XjKjhSE3i/K5+l4iY0g9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUE/nr6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D753C4CEE1;
	Tue, 14 Jan 2025 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736859475;
	bh=TeCqkUf9U8u8664JbtiG8nCrJnAMZRQuIJXO6gvHTG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OUE/nr6YzldIEWnOZDo3FD11hU+2ABvhuTXn26k54LAjHe+2eD19jR1ieGIeDMoGm
	 zZVCcKtE2IUzNaKFUC8yeug1HHThumd87gMXwbqRW4c8g3sJ7FtICsolEIiQzxozTE
	 O75ZvUMS2LS34DKAerd9VaCANiPeRSBqevyg2PfUWXhPjeWR5XFCS/EcGY7RIMrO79
	 opDu34gZLQvoK9MDvCtkZb4Ftn+fITxY2hkBOl4LFUXsskevDD7VWqR72QcH0Oft+e
	 4JAmTfLm5ZnFaejmSxCCi50iJDK/opVPjBFYMThuwpPdvAPIvP4RQfTLIYweqE59TL
	 OKJCxuVpE4/+A==
Date: Tue, 14 Jan 2025 13:57:44 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Borislav Petkov <bp@alien8.de>, Shiju Jose <shiju.jose@huawei.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "tony.luck@intel.com"
 <tony.luck@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
 <mchehab@kernel.org>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
 <alison.schofield@intel.com>, "vishal.l.verma@intel.com"
 <vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
 <Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
 <rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
 "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
 <naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
 <somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
 "pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
 <duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
 "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
 "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
 "wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
 <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
 <kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
 Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250114135738.2b79b73d@foz.lan>
In-Reply-To: <20250109160159.00002add@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
	<20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
	<3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
	<20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
	<20250109160159.00002add@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 9 Jan 2025 16:01:59 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:


> > My goal here was to make this user-friendly. Because you need some way of
> > knowing what valid ranges are and in order to trigger the repair, if it needs
> > to happen for a range.  

IMO, user-friendly is important, as it allows people to manually use the
feature. This is interesting for debugging purposes and also to test if
some hardware is doing the right thing.

Ok, in practice, production will use an userspace tool like rasdaemon,
and/or some scripts [1].

[1] I'd say that rasdaemon should have an initialization phase to
discover capabilities that can be discovered.

As an example, rasdaemon could, for instance, reserve some sparing
memory at init time, if the hardware (partially) supports it. For
instance, maybe a CXL device could not be able to handle
rank-mem-sparing, but it can handle bank-mem-sparing.

> In at least the CXL case I'm fairly sure most of them are not discoverable.
> Until you see errors you have no idea what the memory topology is.

Sure, but some things can be discovered in advance, like what CXL
scrubbing features are supported by a given hardware.

If the hardware supports detecting ranges for row/bank/rank sparing,
it would be nice to have this reported in a way that userspace can
properly set it at OS init time, if desired by the sysadmins.

> > Or, you can teach the repair logic to ignore invalid ranges and "clamp" things
> > to whatever makes sense.  
> 
> For that you'd need to have a path to read back what happened.

If sysfs is RW, you have it there already after committing the value set.

> > Again, I'm looking at it from the usability perspective. I haven't actually
> > needed this scrub+repair functionality yet to know whether the UI makes sense.
> > So yeah, collecting some feedback from real-life use cases would probably give
> > you a lot better understanding of how that UI should be designed... perhaps
> > you won't ever need the ranges, whow knows.
> > 
> > So yes, preemptively designing stuff like that "in the dark" is kinda hard.
> > :-)  
> 
> The discoverability is unnecessary for any known usecase.
> 
> Ok. Then can we just drop the range discoverability entirely or we go with
> your suggestion and do not support read back of what has been
> requested but instead have the reads return a range if known or "" /
> return -EONOTSUPP if simply not known?

It sounds to be that ranges are needed at least to setup mem sparing.

> I can live with that though to me we are heading in the direction of
> a less intuitive interface to save a small number of additional files.
> 
> Jonathan
> 
> >   
> 



Thanks,
Mauro

