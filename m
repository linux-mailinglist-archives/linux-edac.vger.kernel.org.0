Return-Path: <linux-edac+bounces-1087-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F18CBDFC
	for <lists+linux-edac@lfdr.de>; Wed, 22 May 2024 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595311C2119B
	for <lists+linux-edac@lfdr.de>; Wed, 22 May 2024 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4380C1C;
	Wed, 22 May 2024 09:40:30 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2FC54720;
	Wed, 22 May 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716370830; cv=none; b=ZIuzrVm9Eu3I4KswqAR+ExWxeinukhk3B8HrTkbF9LBHh5sR0GFy5eZNhdD2dtS83ZXAxS3wuX25unLEb+vgVHmM8C3HBQGf5qwQYxqpDemexUXVoR9M2qqgGamDO8OEgu2JMmgfe+QASz9bUdi/Pa+aYtvzYqKWElyA8hUTlnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716370830; c=relaxed/simple;
	bh=dI4/Xlum3q54/48w5qXC2mpJ/wMnduDUMS+A4zFT9kU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A97shix0rZ8Ctogn+HDCuokrPgwtMEXnVsHSa73SymeXyCuRFEbkEJqkqmq6UEVNCMbRguaSSpPiRHygioyfyTFVrwjX3M6WahGkmxsHiCauc8+PwrAarHcstKndEp7qQHxelKN5D2DGbpafDVMAJoqj3zlrrgAA96utBcRFZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VkmQw2rK4z6J9Sj;
	Wed, 22 May 2024 17:36:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 44E6D140A70;
	Wed, 22 May 2024 17:40:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 22 May
 2024 10:40:18 +0100
Date: Wed, 22 May 2024 10:40:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: Dan Williams <dan.j.williams@intel.com>, Shiju Jose
	<shiju.jose@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240522104017.00003904@Huawei.com>
In-Reply-To: <20240521080621.GBZkxV_ZWnbbrq-yV_@fat_crate.local>
References: <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
	<20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
	<663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
	<20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
	<663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
	<20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
	<663e55c59d9d_3d7b429475@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
	<20240517121554.000031d4@Huawei.com>
	<20240517124418.00000b48@Huawei.com>
	<20240521080621.GBZkxV_ZWnbbrq-yV_@fat_crate.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 21 May 2024 10:06:21 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, May 17, 2024 at 12:44:18PM +0100, Jonathan Cameron wrote:
> > Given we are talking about something new, maybe this is an opportunity
> > to not perpetuate this?
> > 
> > If we add scrub in here I'd prefer to just use the normal bus registration
> > handling rather than creating a nest of additional nodes.  So perhaps we
> > could consider
> > /sys/bus/edac/device/scrub0 (or whatever name makes sense, as per the
> > earlier discussion of cxl_scrub0 or similar).  
> 
> Yes, my main worry is how this RAS functionality is going to be all
> organized in the tree. Yes, EDAC legacy methods can die but the
> user-visible part can't so we might as well use it to concentrate stuff
> there.

Understood.

> 
> > Could consider moving the bus location of mc0 etc in future to there with
> > symlinks to /sys/bus/edac/device/mc/* for backwards compatibility either
> > via setting their parents or more explicit link creation.  
> 
> You can ignore the mc - that's the memory controller representation EDAC
> does and that's also kind of semi-legacy considering how heterogeneous
> devices are becoming. Nowadays, scrubbing functionality can be on
> anything that has memory and that's not only a memory controller.
> 
> So it would actually be the better thing to abstract that differently
> and use .../edac/device/ for the different RAS functionalities. I.e.,
> have the "device" organize it all.

I'm not sure I follow this. Definitely worth ensuring we are thinking
the same thing wrt to layout before we go further,

Do you mean keep it similar to the existing device/mc device/pci
structure so /sys/bus/edac/devices/scrub/cxl_mem0_scrub etc?
This would rely on symlinks to paper over the dev->parent not being
the normal parent. Hence would be similar to /sys/bus/edac/devices/pci in
edac_pci_create_sysfs() or equivalent in edac_device_create_sysfs().

Or is the ../edac/device bit about putting an extra device under edac/devices/?
e.g.
/sys/bus/edac/devices/cxl_memX/scrub
/sys/bus/edac/devices/cxl_memX/other_ras_thing
which would be fairly standard driver model stuff.

This would sit alongside 'legacy'
/sys/bus/edac/devices/mc/mcX
/sys/bus/edac/devices/pci/pciX etc

I'd prefer this second model as it's very standard and but grouping is per
providing parent device, rather than functionality. However, it is rather
different from the existing edac structure.

Where I've used the symlink approach in the past, it has always
been about keeping a legacy interface in place, not where I'd start
with something new.   Hence I think this is a question of how far
we 'breakaway' from existing edac structure.



> 
> > These scrub0 would have their dev->parent set to who ever actually
> > registered them providing that reference cleanly and letting all the
> > normal device model stuff work more simply.  
> 
> Ack.

This suggests the second option above, but I wanted to confirm as Shiju
and I read this differently.

> 
> > If we did that with the scrub nodes, the only substantial change from
> > a separate subsystem as seen in this patch set would be to register
> > them on the edac bus rather than a separate class.
> > 
> > As you pointed out, there is a simple scrub interface in the existing
> > edac memory controller code. How would you suggest handling that?
> > Have them all register an additional device on the bus (as a child
> > of the mcX devices) perhaps?  Seems an easy step forwards and should
> > be no backwards compatibility concerns.  
> 
> Well, you guys want to control that scrubbing from userspace and those
> old things probably do not fit that model? We could just not convert
> them for now and add them later if really needed. I.e., leave sleeping
> dogs lie.

Ok. There is an existing is the minimal sysfs existing interface but I'm
fine with ignoring it for now.
 
> 
> > It absolutely doesn't as long as we can do it fairly cleanly within
> > existing code. I wasn't sure that was possible, but you know edac
> > a lot better than me and so I'll defer to you on that!  
> 
> Meh, I'm simply maintaining it because no one else wants to. :)

*much sympathy!*  As we ramp up more on this stuff, we'll try and
help out where we can.

> 
> > Several options for that, but fair question - bringing (at least some of)
> > the RAS mess together will focus reviewer bandwidth etc better.  
> 
> Review is more than appreciated, as always.
> 
> > I'm definitely keen on unifying things as I agree, this mixture of different
> > RAS functionality is a ever worsening mess.  
> 
> Yap, it needs to be unified and reigned into something more
> user-friendly and manageable.

Hopefully we all agree on a unified solution being the target.

Feels like we are converging. Now we are down to the details :)

Thanks,

Jonathan

> 
> Thx.
> 


