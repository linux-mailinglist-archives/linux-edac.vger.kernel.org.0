Return-Path: <linux-edac+bounces-2897-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D90A1076B
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 14:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D27168CF5
	for <lists+linux-edac@lfdr.de>; Tue, 14 Jan 2025 13:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBF32361E9;
	Tue, 14 Jan 2025 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1nx/w9r"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B922361D9;
	Tue, 14 Jan 2025 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860233; cv=none; b=Cgg1VQMcFZMmUT3dA1FLeuWh1P8U3TZQvSGCAGOOx0v5Qx1N9rHXcguWoK5soRaFonqtTN6pufrR5RDTWANmG35MbTPBChfqkSSkyGvnz69YUwzMjYgPXxJ/xdCRC4uAqQqBiZnIypS0EZu71/7msf/JmT8gM+ZcoepA4iDToQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860233; c=relaxed/simple;
	bh=vqMiHaYxo1OeV6vuFiLAKJFsyBYwVvIm77cJVle1WJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erMRqfwXpqyw9MbykNZU+2BmXzQ4L+mv5CHdImrmOlc69CJOgTRAQFrCKe3io7sTK6FBwhoOsc/esQ7GtPjNlBK1NVD1LrzEpguUuJJ4oOiqWTxG4izRmn0ofsvAVn97KDbdnHKpJQGGKu17GzBVEH3JIc1+93ks6eIzB1olJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1nx/w9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B11C4CEDD;
	Tue, 14 Jan 2025 13:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736860232;
	bh=vqMiHaYxo1OeV6vuFiLAKJFsyBYwVvIm77cJVle1WJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l1nx/w9rZaUlfUPPBU47utVetUTnVL9ZexeuxPhebI4q9xOwKJB8QsH47uS2NgLHE
	 kAZWXffsH5/p35zg8G1Wq3RbXzkrvqU7kVVq8mGf2F/olQvWByKXsi7S7/GrpG4Voa
	 VvBgg9qe79KdwzK/nV30u5dqZYsiwRaCjJzTejZsJHkniACy98wD4emz4ZadTlhvcJ
	 gobdeWehypQ5eW5l4w0NMcXhSYhLvQyliQPrA3ROUhqP+ReivN07AfVjV11Hz1m51G
	 IU9uKWJ8M/PiSGRBEy7Iy98LL5wVIY6fYcJO3P4aGmvKdtc3knrQDy/+3r4lQbSLYp
	 sQhGV9ki860XQ==
Date: Tue, 14 Jan 2025 14:10:21 +0100
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
Message-ID: <20250114141021.0b6f0856@foz.lan>
In-Reply-To: <20250109183448.000059ec@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
	<20250106121017.1620-5-shiju.jose@huawei.com>
	<20250109091915.GAZ3-Uk3rkuh38cQyy@fat_crate.local>
	<3b2d4275d1d24dbeacee0f192ac4d69b@huawei.com>
	<20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
	<20250109160159.00002add@huawei.com>
	<20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
	<20250109183448.000059ec@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 9 Jan 2025 18:34:48 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Thu, 9 Jan 2025 17:19:02 +0100
> Borislav Petkov <bp@alien8.de> wrote:

> > 
> > But then why do you even need the interface at all?
> > 
> > Why can't the kernel automatically collect all those attributes and start the
> > scrubbing automatically - no need for any user interaction...?

Implementing policies at Kernelspace is a very bad idea.

See, to properly implement scrubbing and memory sparing policies, one
needs to have knowledge not only about the current Kernel lifetime (which
may be a recent boot due to a Kernel upgrade), but also for events that 
happened in the past months/years.

On other words, a database is needed to know if a memory error
was just a random issue due to high cosmic ray activities (so, a
soft PPR would be used - just in case), or if it is due to some memory
region that it is known to have past problems, probably an indication
of a a hardware issue - in which case a hard PPR would be used instead.

If this were meant to be done automatically, CXL wouldn't need to send
events about that to the OSPM.

Also, different usecases may require different policies. So, better
to let an userspace daemon to handle policies, and use sysfs for
such daemon to to setup the hardware.

Thanks,
Mauro

