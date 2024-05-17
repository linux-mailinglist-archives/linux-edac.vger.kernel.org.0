Return-Path: <linux-edac+bounces-1067-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6BA8C8564
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2024 13:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3368A1C20C2E
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11EF3CF73;
	Fri, 17 May 2024 11:16:03 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188B200DD;
	Fri, 17 May 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944563; cv=none; b=V+Sx+Oqh3jv8303HBxN/Zpwzje2Rd/sOmfQvyll1aCAFQriqwEQRWtJ0vwROlmJNMPKMuRK/kYkY3wwDP30sev4I5yBJKqTRKkioT8tdrmQH9IQDB7zOYwx1CUE6N0vkwAbIHqFU88F5i1oDo43goWT1z+G4hS3w0mkBTFkx+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944563; c=relaxed/simple;
	bh=VxSDOGPhBpR+noSDaZ9gn1Vm4yDGRV5HNg3mi/hKtuU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAs0Dc6pUuQfHhctma88Y6ACPlFoMwywvwfQRUD3k53aoqQHipjns4oQRE583U0vPHb/EXU+UyeDfWjXn0K8J2HhVtjDzwAgkYvtMMaci1bITDLPulkttLLk6uBPnt/TZKx5My4Tbm5Zn8+NeCIK0nJLWGX+pn6xkzIzZpT3Jkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vgknq1Jnvz6JBHH;
	Fri, 17 May 2024 19:12:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E417140A70;
	Fri, 17 May 2024 19:15:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 May
 2024 12:15:55 +0100
Date: Fri, 17 May 2024 12:15:54 +0100
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
Message-ID: <20240517121554.000031d4@Huawei.com>
In-Reply-To: <20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
References: <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
	<20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
	<20240509101939.0000263a@Huawei.com>
	<D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
	<20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
	<663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
	<20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
	<663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
	<20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
	<663e55c59d9d_3d7b429475@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240511101705.GAZj9FoVbThp7JUK16@fat_crate.local>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


Focusing on just one bit.

> > Now, the question of how many legacy scrub interfaces should be
> > considered in this design out of the gate is a worthwhile discussion. I
> > am encouraged that this ABI is at least trying to handle more than 1
> > backend, which makes me feel better that adding a 3rd and 4th might not
> > be prohibitive.  
> 
> See above.
> 
> I'm perfectly fine with: "hey, we have a new scrub API interfacing to
> RAS scrub capability and it is *the* thing to use and all other hw scrub
> functionality should be shoehorned into it.
> 
> So this thing's design should at least try to anticipate supporting
> other scrub hw.
> 
> Because there's EDAC too. Why isn't this scrub thing part of EDAC? Why
> isn't this scrub API part of edac_core? I mean, this is all RAS so why
> design a whole new thing when the required glue is already there?
> 
> We can just as well have a
> 
> 	/sys/devices/system/edac/scrub/
> 
> node hierarchy and have everything there.

A few questions about this. It seems an unusual use fake devices and a bus
so I'm trying to understand how we might do something that looks more standard
but perhaps also fit within the existing scheme.  I appreciate this stuff
has evolved over a long time, so lots of backwards compatibility concerns.

If I follow this right the current situation is:

/sys/devices/system/edac is the 'virtual' device registered on the edac bus.

> 
> Why does it have to be yet another thing?
> 
> And if it needs to be separate, who's going to maintain it?
> 
> > Which matches what I reacted to on the last posting:
> > 
> >    "Maybe it is self evident to others, but for me there is little in these
> >     changelogs besides 'mechanism exists, enable it'"
> > 
> > ...and to me that feedback was taken to heart with much improved
> > changelogs in this new posting.  
> 
> Ok.
> 
> > This init time feature probing discussion feels like it was born from a
> > micommunication / misunderstanding.  
> 
> Yes, it seems so, thanks for clarifying things.
> 
> I still am unclear on the usecases and how this is supposed to be used
> and also, as mentioned above, we have a *lot* of RAS functionality
> spread around the kernel. Perhaps we should start unifying it instead of
> adding more...
> 
> So the big picture and where we're headed to, needs to be clarified first.
> 
> Thx.
> 


