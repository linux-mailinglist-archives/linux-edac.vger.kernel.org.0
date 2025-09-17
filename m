Return-Path: <linux-edac+bounces-4823-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E832B8132B
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 19:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01841465D60
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A792F9C37;
	Wed, 17 Sep 2025 17:36:17 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397C2FC007;
	Wed, 17 Sep 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130577; cv=none; b=mVgqUa1VqUbpT+tNNJKHS1X/o8Kgtc2yaWtrWHM5CH962ZpwKnueDeihlFxOwTvRokiMHvkyQCOtt0LC7XSjZjQIjYVfvOs4ZPITYsZAAGPk8aWHwy6RuLkA6iGFYBUqz0qU8pyaxfRyqartFhTDOs9ZlRBJYvoa3uo6SrCr36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130577; c=relaxed/simple;
	bh=1gdwDRT1UTOogG/U/LHEN622jIYbtX7zSDpE1hMC/d8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuA7GMxyHT0or5rBO7e9KzQOmLyNry14afqGS6SZ1h2nhsNQllAhzvfH/xqcktovuTBt17PybEYDKflpVR7Hl1ISbHtbHfswOKJajO1VikgcWRbdjUm6Xw6roe8RKF9I9Folgyr7k6d1TkCCeIhTi/zOS2hmOy6VKqzhaJtG4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRm820x5Cz6M5Jd;
	Thu, 18 Sep 2025 01:33:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 084C9140114;
	Thu, 18 Sep 2025 01:36:11 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 19:36:09 +0200
Date: Wed, 17 Sep 2025 18:36:08 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: Shiju Jose <shiju.jose@huawei.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, Linuxarm <linuxarm@huawei.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"Roberto Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20250917183608.000038c4@huawei.com>
In-Reply-To: <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
 <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
 <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
 <9433067c142b45d583eb96587b929878@huawei.com>
 <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 17 Sep 2025 18:22:53 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Sep 15, 2025 at 11:50:16AM +0000, Shiju Jose wrote:
> > This has been added as suggested by Jonathan considering the interleaved NUMA node.
> > Link to the related discussion in V11:
> > https://lore.kernel.org/all/20250821100655.00003942@huawei.com/#t  
> 
> Sorry, this doesn't work this way.
> 
> If something in the code is being done which is not obvious and trivial, then
> the reason for it is written down in a prominent place so that it is clear to
> people.
> 
> Not pointing to a discussion or some funky place on the web where someone
> might've said something.
> 
> Your patch submission should contain that info and not have reviewers ask for
> it.
> 
> > | node 0 | node 1 | node 0 |   PA address map.
> > Can you give your suggestion what we should do about it?  
> 
> I don't know what the problem is to begin with...
> 
> > I think Option (2) seems better?  If so, can the EDAC scrub interface  be
> > updated to include attributes for publishing the supported PA range for the
> > memory device to scrub?  
> 
> The memory ranges should already be available somewhere in the NUMA/mm code or
> so and for starters, we should start a scrub for all ranges and do the
> single-range only when there really is a good reason for it.
> 
> Also, you don't have to expose any ranges to userspace in order to start
> a scrub activity - you can simply start the scrub in the affected range
> automatically.
> 
> Like I preached the last time, your aim should be to make as much of the
> variables that control the scrub automatic and not expose everything to
> userspace so that some userspace tool decides. The tool should simply start
> the scrub and the kernel should DTRT.

This 'first contiguous range' is an attempt to DTRT in a corner
case that is real but where there is not an obvious right thing due to spec limitations.

The problem is the ACPI specification ties a controller to a NUMA / _PXM but
then controls it via a single memory range with rules on whether that range can
include holes (that are actually covered by a different controller).  There
is no way to discover if two disconnected ranges may be scanned at once other
that trying that.

Without resolving this corner, there is no way we could come up with for the kernel
to DTRT.

Aim is to automatically establish the range that can be scrubbed. The corner
case is the hole problem.  Alternative as discussed in earlier versions of
this series was ignore holes.

The options discussed in earlier versions of this patch
=======================================================

So with Node / PA mapping (happens because people want low memory addresses
near to CPUs in different sockets - I simplified it here somewhat).

| Node 0 | Node 1 | Node 0 | Node 2|

1. Hole skipping approach
Have control parameters default to
|       Node 0             |
         | Node 1 |
                           | Node 2|
2. Present part of range that is at least not including a hole where it might
look like we were controlling memory scrub that we were not.
| Node 0 |
         | Node 1 |
                           | Node 2|

3. Just don't present anything and leave it up to general mm interfaces
   to provide what 'should' be set.
|
All 3 here, 0 size.

Whilst nice to support, I'm not seeing 'default' as a key use case and
changing scrub from a kernel driver without policy from userspace to
me would be a wrong thing to do. (I'm not sure if you are suggesting this)

The scrub should always be running pre linux (true today on all systems that I'm
aware of, but maybe not as universal as I think?).  If there is a need for
a default scrub setting on boot of Linux, then sure we can add it.

This interface all about tweaking the settings not defaults (unlike the CXL
case which does need the setting of defaults as well because of hotplug of
the devices and lack of firmware involvement in that).

We are fine with any of the options above.

This was an attempt to respond to review feedback from Daniel - it was not
something Huawei needs.

https://lore.kernel.org/all/547ed8fb-d6b7-4b6b-a38b-bf13223971b1@os.amperecomputing.com/

After a discussion of why 0, 0 defaults give an unexpected result...

"Proposed Solution:
What we propose, is to instead of zeroing out the base and size after an error,
use the full range of the current NUMA node. We believe that a superset of a
currently active scrub range can properly report all the relevant and correct
information."

The above Numa node pattern in PA space |0|1|0|2| etc is a thing
that happens on real systems so if was the best that had come up in earlier
discussion as an approximation of what Daniel asked for that should allow the
right values to be queried.

I'm not entirely sure this even matters now they have resolved the shared
PCC interface issue on their platforms.  Felt nice to provide meaningful
defaults but maybe this is a problem we don't need to solve and can go back to
just using 0, 0 until told to do something else.

Daniel, perhaps you can provide more info?

Thanks,

Jonathan



> 
> > This returns error on the first failure.
> > 
> > What if there was a success before? Does that aux_device need to be removed?
> > 
> > If not, then why return failure at all? Why not just try to add all devices? Some may fail and some may succeed.
> > ============================= 
> > 
> > We thought second option is a better because a successfully added aux dev for a memory device and corresponding
> > EDAC interface continue exist and support the scrub/a memory feature. 
> > We do not mind doing stop on a failure adding an aux_device and free previously crated aux devices, though
> > it may require some additional dynamically allocated memory space to store the successfully created aux devices
> > so that free them on a failure later. Hope that is acceptable?  
> 
> So how are you going to present to people a subset of devices loaded? And what
> is the point at all? 
> 
> Is there a valid use case where you can use only a subset of the devices to
> even try to support such nonsense?
> 


